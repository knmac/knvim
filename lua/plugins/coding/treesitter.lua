-- Code parser generator for syntax highlighting
-- NOTE: `main` branch API (Neovim >= 0.12). Highlighting, folding, and indentation
-- are NOT enabled by the plugin -- they must be turned on per buffer (see below).
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- this plugin does not support lazy-loading
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({
            "bash", "c", "lua", "markdown", "markdown_inline", "python", "query", "vim", "vimdoc",
            "bibtex", "cmake", "cpp", "css", "git_config", "html", "javascript", "json", "latex",
            "regex", "scala", "sql", "toml", "typescript", "yaml", "typst", "norg", "scss",
            "svelte", "tsx", "vue",
        })

        -- Skip treesitter for large files and health buffers
        local function should_skip(buf)
            -- Respect snacks.bigfile's verdict. It renames the filetype to "bigfile",
            -- but by the time this runs the filetype is often re-resolved to the real
            -- one, so the heuristics below still need to stand on their own.
            if vim.bo[buf].filetype == "bigfile" then
                return true
            end

            local n_lines = vim.api.nvim_buf_line_count(buf)
            local max_n_lines = 50000
            if n_lines > max_n_lines then
                return true
            end

            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats then
                local max_filesize = 100 * 1024 -- 100 KB
                if stats.size > max_filesize then
                    return true
                end
                -- Minified files: small overall but huge average line length. Matches
                -- snacks.bigfile's `line_length` heuristic so the two agree.
                local max_line_length = 1000
                if n_lines > 0 and (stats.size - n_lines) / n_lines > max_line_length then
                    return true
                end
            end

            local bufname = vim.api.nvim_buf_get_name(buf)
            return vim.bo[buf].filetype == "checkhealth" or bufname:match("health://") ~= nil
        end

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("knvim_treesitter", { clear = true }),
            callback = function(args)
                local buf = args.buf
                if should_skip(buf) then
                    return
                end

                -- Highlighting (provided by Neovim)
                if not pcall(vim.treesitter.start, buf) then
                    return
                end

                -- Folding (provided by Neovim). Window-local, so only set it when
                -- this buffer is actually the one displayed in the current window.
                if vim.api.nvim_get_current_buf() == buf then
                    vim.wo[0][0].foldmethod = "expr"
                    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                end

                -- Indentation (provided by this plugin, experimental upstream)
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
