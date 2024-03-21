-- Neovim Language Server Protocol
-- Ref: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- Ref: https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
-- Ref: https://github.com/wookayin/dotfiles/blob/master/nvim/lua/config/lsp.lua
return {
    -- Mason
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
                check_outdated_packages_on_open = true,
            }
        },
    },
    -- Ensure install for Mason's LSP
    {
        "williamboman/mason-lspconfig.nvim", -- bridges mason.nvim and nvim-lspconfig
        opts = {
            -- Install the LSP servers automatically using mason-lspconfig
            ensure_installed = {
                "pyright", "ruff_lsp", "bashls", "clangd", "vimls", "lua_ls", "texlab", "marksman",
                "tsserver", "gopls"
                -- 'ltex',
            },
            automatic_installation = true,
        },
    },
    -- LSP config
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- UI improvement for vim.ui.select and vim.ui.input
            -- Good for renaming prompt (appear at the variable location)
            {
                "stevearc/dressing.nvim",
                event = "VeryLazy",
            },
            -- statusline/winbar component using lsp
            "SmiteshP/nvim-navic",
        },
        config = function()
            ---------------------------------------------------------------------------------------
            -- Set up LSP servers
            ---------------------------------------------------------------------------------------
            -- Server-specific configs
            local lsp_settings = {
                lua_ls = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim", "use", }
                        }
                    },
                },
                -- ltex = {
                --     ltex = {
                --         -- disable spell check of ltex (use vim spellcheck instead)
                --         disabledRules = {
                --             ['en']    = { 'MORFOLOGIK_RULE_EN' },
                --             ['en-AU'] = { 'MORFOLOGIK_RULE_EN_AU' },
                --             ['en-CA'] = { 'MORFOLOGIK_RULE_EN_CA' },
                --             ['en-GB'] = { 'MORFOLOGIK_RULE_EN_GB' },
                --             ['en-NZ'] = { 'MORFOLOGIK_RULE_EN_NZ' },
                --             ['en-US'] = { 'MORFOLOGIK_RULE_EN_US' },
                --             ['en-ZA'] = { 'MORFOLOGIK_RULE_EN_ZA' },
                --             ['es']    = { 'MORFOLOGIK_RULE_ES' },
                --             ['it']    = { 'MORFOLOGIK_RULE_IT_IT' },
                --             ['de']    = { 'MORFOLOGIK_RULE_DE_DE' },
                --         },
                --     },
                -- },
            }

            local utf16_cap = vim.lsp.protocol.make_client_capabilities()
            utf16_cap.offsetEncoding = { "utf-16" }
            local lsp_capabilities = {
                clangd = { utf16_cap },
            }

            -- Use a loop to conveniently call 'setup' on multiple servers and
            -- map buffer local keybindings when the language server attaches
            -- The servers are ensured to be installed by mason-lspconfig
            local servers = require("mason-lspconfig").get_installed_servers()
            for _, lsp in ipairs(servers) do
                require("lspconfig")[lsp].setup({
                    settings = lsp_settings[lsp],
                    capabilities = lsp_capabilities[lsp],
                    on_attach = function(client, bufnr)
                        if lsp == "ruff_lsp" then
                            -- Turn off hover for ruff
                            client.server_capabilities.hoverProvider = false
                        else
                            -- Use navic for non-ruff
                            require("nvim-navic").attach(client, bufnr)
                        end
                    end,
                })
            end

            ---------------------------------------------------------------------------------------
            -- Set up key-bindings
            ---------------------------------------------------------------------------------------
            local telescope_ok, telescope = pcall(require, "telescope.builtin")

            -- Wrapper for keymapping with default opts
            local map = function(mode, lhs, rhs, desc)
                local opts = { noremap = true, silent = true, desc = "LSP: " .. desc }
                vim.keymap.set(mode, lhs, rhs, opts)
            end

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            map("n", "<leader>e", function() vim.diagnostic.open_float({ border = "rounded" }) end,
                "Show diagnostics of the current line")
            map("n", "[e",
                function() vim.diagnostic.goto_prev({ float = { border = "rounded" } }) end,
                "Go to the previous diagnostic")
            map("n", "]e",
                function() vim.diagnostic.goto_next({ float = { border = "rounded" } }) end,
                "Go to the next diagnostic")
            if telescope_ok then
                map("n", "<leader>E", telescope.diagnostics, "Show all diagnostics")
            else
                map("n", "<leader>E", function() vim.diagnostic.setloclist() end,
                    "Show all diagnostics")
            end

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    local bufmap = function(mode, lhs, rhs, desc)
                        local bufopts = {
                            noremap = true, silent = true, buffer = bufnr, desc = "LSP: " .. desc
                        }
                        vim.keymap.set(mode, lhs, rhs, bufopts)
                    end

                    -- Enable completion triggered by <c-x><c-o>
                    if client.server_capabilities.completionProvider then
                        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
                    end

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    if telescope_ok then
                        bufmap("n", "gd", telescope.lsp_definitions, "Go to definition")
                        bufmap("n", "gi", telescope.lsp_implementations, "Go to implementation")
                        bufmap("n", "gr", telescope.lsp_references, "Go to references")
                        bufmap("n", "gy", telescope.lsp_type_definitions, "Go to type definition")
                    else
                        bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
                        bufmap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
                        bufmap("n", "gr", vim.lsp.buf.references, "Go to references")
                        bufmap("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
                    end

                    bufmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                    bufmap("n", "K", vim.lsp.buf.hover, "Show docstring of the item under the cursor")
                    -- bufmap({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Show signature help")

                    bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename variable under the cursor")
                    bufmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")

                    -- if has conform, use the key binding with lsp_fallback in conform, otherwise
                    -- define keymap here
                    local has_conform, _ = pcall(require, "conform")
                    if not has_conform then
                        bufmap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end,
                            "Format the buffer")
                    end

                    bufmap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace")
                    bufmap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace")
                    bufmap("n", "<leader>wl",
                        function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
                        "List workspaces")
                end,
            })


            ---------------------------------------------------------------------------------------
            -- Setup UI
            ---------------------------------------------------------------------------------------
            -- -- Popped up window borders
            -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            --     vim.lsp.handlers.hover, {
            --         border = "rounded",
            --     }
            -- )
            -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            --     vim.lsp.handlers.signature_help, {
            --         border = "rounded",
            --         close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
            --     }
            -- )
            require("lspconfig.ui.windows").default_options.border = "rounded"

            -- Diagnostic signs
            vim.fn.sign_define("DiagnosticSignError", { text = "󰅚 ", texthl = "DiagnosticSignError" }) -- x000f015a
            vim.fn.sign_define("DiagnosticSignWarn", { text = "󰀪 ", texthl = "DiagnosticSignWarn" }) -- x000f002a
            vim.fn.sign_define("DiagnosticSignInfo", { text = "󰋽 ", texthl = "DiagnosticSignInfo" }) -- x000f02fd
            vim.fn.sign_define("DiagnosticSignHint", { text = "󰌶 ", texthl = "DiagnosticSignHint" }) -- x000f0336

            -- Config diagnostics
            vim.diagnostic.config({
                virtual_text = {
                    source = "always", -- Or 'if_many'  -> show source of diagnostics
                    -- prefix = '■', -- Could be '●', '▎', 'x'
                },
                float = {
                    source = "always", -- Or 'if_many'  -> show source of diagnostics
                },
            })
        end,
    },
}
