-- Code linter and formatter
return {
    -- Ensure install for linter and formatter
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
            ensure_installed = { 'cpplint', 'shellcheck', 'black', 'prettierd', },
        },
    },
    -- Linter
    {
        'mfussenegger/nvim-lint',
        config = function()
            require('lint').linters_by_ft = {
                sh = { 'shellcheck', },
                c = { 'cpplint', },
                cpp = { 'cpplint', },
            }

            vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter' }, {
                callback = function()
                    require('lint').try_lint()
                end,
            })
        end,
    },
    -- Formatter
    {
        'stevearc/conform.nvim',
        keys = {
            {
                '<leader>f',
                function() require('conform').format({ lsp_fallback = true }) end,
                desc = 'Format',
            },
        },
        opts = {
            formatters_by_ft = {
                python = { 'black' },
                javascript = { 'prettierd' },
                typescript = { 'prettierd' },
                html = { 'prettierd' },
                css = { 'prettierd' },
                yaml = { 'prettierd' },
            },
        },
    },
}
