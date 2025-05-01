-- Code linter and formatter
return {
    -- Ensure install for linter and formatter
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        -- event = { "BufReadPre", "BufNewFile" },
        -- event = "VeryLazy",
        opts = {
            ensure_installed = { "cpplint", "shellcheck", "prettier", "bibtex-tidy", "shfmt" },
        },
    },
    -- Linter
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("lint").linters_by_ft = {
                sh = { "shellcheck", },
                c = { "cpplint", },
                cpp = { "cpplint", },
            }

            -- Create autocommand which carries out the actual linting on the specified events.
            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    -- Only run the linter in buffers that you can modify in order to
                    -- avoid superfluous noise, notably within the handy LSP pop-ups that
                    -- describe the hovered symbol using Markdown.
                    if vim.opt_local.modifiable:get() then
                        require("lint").try_lint()
                    end
                end,
            })
        end,
    },
    -- Formatter
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            {
                "<leader>f",
                function() require("conform").format({ lsp_fallback = true }) end,
                desc = "LSP/Conform: Format the buffer",
            },
        },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    html = { "prettier" },
                    css = { "prettier" },
                    json = { "prettier" },
                    javascript = { "prettier" },
                    markdown = { "prettier" },
                    typescript = { "prettier" },
                    yaml = { "prettier" },
                    bib = { "bibtex-tidy" },
                    sh = { "shfmt" },
                },
            })
        end,
    },
}
