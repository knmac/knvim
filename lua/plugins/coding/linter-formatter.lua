-- Code linter and formatter
return {
    -- Ensure install for linter and formatter
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
            ensure_installed = { 'black', 'cpplint', 'shellcheck', 'prettierd', },
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
        config = function()
            local conform = require('conform')
            conform.setup({
                formatters_by_ft = {
                    python = { 'black' },
                    javascript = { 'prettierd' },
                    typescript = { 'prettierd' },
                    html = { 'prettierd' },
                    css = { 'prettierd' },
                    yaml = { 'prettierd' },
                },
            })

            vim.keymap.set('n', '<leader>F', function() conform.format() end,
                { noremap = true, silent = true, desc = 'Format using non-LSP formatter (conform)' }
            )
        end,
    },
}
