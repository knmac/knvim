-- Code parser generator for syntax highlighting
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({
            "bash", "c", "lua", "markdown", "markdown_inline", "python", "query", "vim", "vimdoc",
            "bibtex", "cmake", "cpp", "css", "dap_repl", "git_config", "html",
            "javascript", "json", "latex", "regex", "scala", "sql", "toml", "typescript", "yaml",
        })

        -- Disable treesitter for large files
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local buf = args.buf
                local max_n_lines = 50000
                if vim.api.nvim_buf_line_count(buf) > max_n_lines then
                    return
                end
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return
                end
                if vim.bo[buf].filetype == "checkhealth" or vim.api.nvim_buf_get_name(buf):match("health://") then
                    return
                end
                pcall(vim.treesitter.start)
            end,
        })
    end,
}

-- OLD CONFIG (master branch, incompatible with Neovim 0.12)
-- build = ":TSUpdate",
-- config = function()
--     require("nvim-treesitter.configs").setup({
--         ensure_installed = {
--             "bash", "c", "lua", "markdown", "markdown_inline", "python", "query", "vim", "vimdoc",
--             "bibtex", "cmake", "cpp", "css", "dap_repl", "git_config", "html",
--             "javascript", "json", "latex", "regex", "scala", "sql", "toml", "typescript", "yaml",
--         },
--         highlight = {
--             enable = true,
--             disable = function(_, buf)
--                 local max_n_lines = 50000
--                 if vim.api.nvim_buf_line_count(buf) > max_n_lines then
--                     return true
--                 end
--                 local max_filesize = 100 * 1024
--                 local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
--                 if ok and stats and stats.size > max_filesize then
--                     return true
--                 end
--                 local bufname = vim.api.nvim_buf_get_name(buf)
--                 return vim.bo[buf].filetype == "checkhealth" or bufname:match("health://")
--             end,
--         },
--         indent = {
--             enable = true,
--             disable = {},
--         },
--     })
-- end,
