-- Code linter and formatter
return {
    -- Ensure install for linter and formatter
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = { "cpplint", "shellcheck", "prettier", },
        },
    },
    -- Linter
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                sh = { "shellcheck", },
                c = { "cpplint", },
                cpp = { "cpplint", },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    -- Formatter
    {
        "stevearc/conform.nvim",
        keys = {
            {
                "<leader>f",
                function() require("conform").format({ lsp_fallback = true }) end,
                desc = "Format",
            },
        },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    css = { "prettier" },
                    html = { "prettier" },
                    javascript = { "prettier" },
                    markdown = { "prettier" },
                    typescript = { "prettier" },
                    yaml = { "prettier" },
                },
            })
        end,
    },
}
