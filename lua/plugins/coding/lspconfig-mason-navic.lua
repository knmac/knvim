-- Neovim Language Server Protocol
-- Ref: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- Ref: https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
-- Ref: https://github.com/wookayin/dotfiles/blob/master/nvim/lua/config/lsp.lua
return {
    -- Mason
    {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        opts = {
            ui = {
                border = 'rounded',
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
                check_outdated_packages_on_open = true,
            }
        },
    },
    -- Navic
    {
        'SmiteshP/nvim-navic', -- statusline/winbar component using lsp
        dependencies = 'neovim/nvim-lspconfig',
        opts = {
            highlight = true,
            separator = ' › ',
            -- VScode-like icons
            icons = {
                File = ' ',
                Module = ' ',
                Namespace = ' ',
                Package = ' ',
                Class = ' ',
                Method = ' ',
                Property = ' ',
                Field = ' ',
                Constructor = ' ',
                Enum = ' ',
                Interface = ' ',
                Function = ' ',
                Variable = ' ',
                Constant = ' ',
                String = ' ',
                Number = ' ',
                Boolean = ' ',
                Array = ' ',
                Object = ' ',
                Key = ' ',
                Null = ' ',
                EnumMember = ' ',
                Struct = ' ',
                Event = ' ',
                Operator = ' ',
                TypeParameter = ' ',
            }
        },
    },
    -- UI improvement for vim.ui.select and vim.ui.input, good for rename prompt
    -- (appear at the variable location)
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
    },
    -- LSP config
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason-lspconfig.nvim', -- bridges mason.nvim and nvim-lspconfig
            opts = {
                -- Install the LSP servers automatically using mason-lspconfig
                ensure_installed = { 'pyright', 'bashls', 'clangd', 'vimls', 'lua_ls', 'ltex', 'texlab' },
                automatic_installation = true,
            },
        },
        config = function()
            -------------------------------------------------------------------------------
            -- Set up LSP servers
            -------------------------------------------------------------------------------
            local lspconfig = require('lspconfig')
            local telescope_ok, telescope = pcall(require, 'telescope.builtin')
            local navic_ok, navic = pcall(require, 'nvim-navic')

            -- Wrapper for keymapping with default opts
            local map = function(mode, lhs, rhs, desc)
                local opts = { noremap = true, silent = true, desc = 'LSP: ' .. desc }
                vim.keymap.set(mode, lhs, rhs, opts)
            end

            local bufmap = function(mode, lhs, rhs, bufnr, desc)
                local bufopts = { noremap = true, silent = true, buffer = bufnr, desc = 'LSP: ' .. desc }
                vim.keymap.set(mode, lhs, rhs, bufopts)
            end

            -- Mappings
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            map('n', '<leader>e', function() vim.diagnostic.open_float({ border = 'rounded' }) end,
                'Show diagnostics of the current line')
            map('n', '[e', function() vim.diagnostic.goto_prev({ float = { border = 'rounded' } }) end,
                'Go to the previous diagnostic')
            map('n', ']e', function() vim.diagnostic.goto_next({ float = { border = 'rounded' } }) end,
                'Go to the next diagnostic')
            if telescope_ok then
                map('n', '<leader>E', telescope.diagnostics, 'Show all diagnostics')
            else
                map('n', '<leader>E', function() vim.diagnostic.setloclist() end, 'Show all diagnostics')
            end

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                if telescope_ok then
                    bufmap('n', 'gd', telescope.lsp_definitions, bufnr, 'Go to definition')
                    bufmap('n', 'gi', telescope.lsp_implementations, bufnr, 'Go to implementation')
                    bufmap('n', 'gr', telescope.lsp_references, bufnr, 'Go to references')
                    bufmap('n', 'gt', telescope.lsp_type_definitions, bufnr, 'Go to type definition')
                else
                    bufmap('n', 'gd', vim.lsp.buf.definition, bufnr, 'Go to definition')
                    bufmap('n', 'gi', vim.lsp.buf.implementation, bufnr, 'Go to implementation')
                    bufmap('n', 'gr', vim.lsp.buf.references, bufnr, 'Go to references')
                    bufmap('n', 'gt', vim.lsp.buf.type_definition, bufnr, 'Go to type definition')
                end

                bufmap('n', 'gD', vim.lsp.buf.declaration, bufnr, 'Go to declaration')
                bufmap('n', 'K', vim.lsp.buf.hover, bufnr, 'Show docstring of the item under the cursor')
                bufmap('i', '<C-k>', vim.lsp.buf.signature_help, bufnr, 'Show signature help')

                bufmap('n', '<leader>rn', vim.lsp.buf.rename, bufnr, 'Rename variable under the cursor')
                bufmap('n', '<leader>ca', vim.lsp.buf.code_action, bufnr, 'Code action')
                bufmap('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, bufnr, 'Format the buffer')

                bufmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufnr, 'Add workspace')
                bufmap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufnr, 'Remove workspace')
                bufmap('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufnr,
                    'List workspaces')

                -- Enable vim-navic
                if navic_ok and client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end
            end

            local lsp_flags = {
                -- This is the default in Nvim 0.7+
                debounce_text_changes = 150,
            }

            -- Server-specific configs
            local server_cfgs = {
                lua_ls = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim', 'use', }
                        }
                    },
                },
                ltex = {
                    ltex = {
                        -- disable spell check
                        disabledRules = {
                            ['en']    = { 'MORFOLOGIK_RULE_EN' },
                            ['en-AU'] = { 'MORFOLOGIK_RULE_EN_AU' },
                            ['en-CA'] = { 'MORFOLOGIK_RULE_EN_CA' },
                            ['en-GB'] = { 'MORFOLOGIK_RULE_EN_GB' },
                            ['en-NZ'] = { 'MORFOLOGIK_RULE_EN_NZ' },
                            ['en-US'] = { 'MORFOLOGIK_RULE_EN_US' },
                            ['en-ZA'] = { 'MORFOLOGIK_RULE_EN_ZA' },
                            ['es']    = { 'MORFOLOGIK_RULE_ES' },
                            ['it']    = { 'MORFOLOGIK_RULE_IT_IT' },
                            ['de']    = { 'MORFOLOGIK_RULE_DE_DE' },
                        },
                    },
                },
            }

            -- Use a loop to conveniently call 'setup' on multiple servers and
            -- map buffer local keybindings when the language server attaches
            -- The servers are ensured to be installed by mason-lspconfig
            local servers = require('mason-lspconfig').get_installed_servers()
            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup({
                    on_attach = on_attach,
                    flags = lsp_flags,
                    settings = server_cfgs[lsp],
                })
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.offsetEncoding = { 'utf-16' }
            lspconfig.clangd.setup({ capabilities = capabilities })


            -------------------------------------------------------------------------------
            -- Setup UI for LSP
            -------------------------------------------------------------------------------
            -- Popped up window borders
            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover, {
                    border = 'rounded',
                }
            )
            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
                vim.lsp.handlers.signature_help, {
                    border = 'rounded',
                    close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
                }
            )

            -- Diagnostic signs
            vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
            vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
            vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
            vim.fn.sign_define('DiagnosticSignHint', { text = ' ', texthl = 'DiagnosticSignHint' })

            -- Config diagnostics
            vim.diagnostic.config({
                virtual_text = {
                    source = 'always', -- Or 'if_many'  -> show source of diagnostics
                    -- prefix = '■', -- Could be '●', '▎', 'x'
                },
                float = {
                    source = 'always', -- Or 'if_many'  -> show source of diagnostics
                },
            })
        end,
    },
}
