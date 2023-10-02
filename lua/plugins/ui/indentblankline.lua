-- Show indent lines
return {
    'lukas-reineke/indent-blankline.nvim', -- show indent line
    main = 'ibl',
    config = function()
        local highlight = {
            'RainbowRed',
            'RainbowYellow',
            'RainbowBlue',
            'RainbowOrange',
            'RainbowGreen',
            'RainbowViolet',
            'RainbowCyan',
        }
        local hooks = require('ibl.hooks')
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#ED8796' })
            vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#EED49F' })
            vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#8AADF4' })
            vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#F5A97F' })
            vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#A6DA95' })
            vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C6A0F6' })
            vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#8BD5CA' })
        end)

        vim.g.rainbow_delimiters = { highlight = highlight }
        require('ibl').setup({
            indent = {
                char = '│',
            },
            exclude = {
                filetypes = {
                    'help', 'startify', 'make', 'NvimTree', 'neo-tree', 'neo-tree-popup',
                    'dashboard', 'lsp-installer', 'alpha', 'packer', 'Outline', 'mason',
                    'dap-float', 'dap-repl', 'dapui_scopes', 'dapui_breakpoints',
                    'dapui_stacks', 'dapui_watches', 'dapui_console', 'norg',
                    'lazy', 'lspinfo', 'null-ls-info', 'noice',
                },
                buftypes = {
                    'terminal', 'nofile', 'quickfix', 'prompt',
                },
            },
            scope = {
                -- enabled = false,
                highlight = highlight,
            },
        })

        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
}
