-- Code parser generator for syntax highlighting
return {
    "nvim-treesitter/nvim-treesitter", -- code parser generator for syntax highlighting
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                -- "bash", "c", "lua", "markdown", "markdown_inline", "python", "query", "vim", "vimdoc",
                "bibtex", "cmake", "cpp", "css", "dap_repl", "dockerfile", "git_config", "html",
                "javascript", "json", "latex", "regex", "scala", "sql", "toml", "typescript", "yaml",
            },
            highlight = {
                enable = true,
                -- disable = {},
                disable = function(_, bufnr)
                    -- Disable in large number of line
                    if vim.api.nvim_buf_line_count(bufnr) > 50000 then
                        return true
                    end

                    -- Disable in large buffer size
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
                    if ok and stats and stats.size > 100 * 1024 then
                        return true
                    end
                end,
            },
            indent = {
                enable = false, -- treesitter's indent is buggy
                disable = {},
            },
        })
    end,
}
