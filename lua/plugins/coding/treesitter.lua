-- Code parser generator for syntax highlighting
return {
    "nvim-treesitter/nvim-treesitter", -- code parser generator for syntax highlighting
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash", "c", "lua", "markdown", "markdown_inline", "python", "query", "vim", "vimdoc",
                "bibtex", "cmake", "cpp", "css", "dap_repl", "dockerfile", "git_config", "html",
                "javascript", "json", "latex", "regex", "scala", "sql", "toml", "typescript", "yaml",
            },
            highlight = {
                enable = true,
                -- disable = {},
                disable = function(_, buf) -- function(lang, buf)
                    -- Disable in large number of line
                    local max_n_lines = 50000
                    if vim.api.nvim_buf_line_count(buf) > max_n_lines then
                        return true
                    end

                    -- Disable in large buffer size
                    local max_filesize = 100 * 1024 -- 100 KB
                    ---@diagnostic disable-next-line: undefined-field
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end

                    -- Disable in checkhealth
                    local bufname = vim.api.nvim_buf_get_name(buf)
                    return vim.bo[buf].filetype == "checkhealth" or bufname:match("health://")
                end,
            },
            indent = {
                enable = true, -- treesitter's indent is buggy
                disable = {},
            },
        })
    end,
}
