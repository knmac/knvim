-- Neovim Language Server Protocol
return {
    -- Mason
    {
        "williamboman/mason.nvim",
        event = { "BufReadPre", "BufNewFile" },
        -- event = "VeryLazy",
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
        init = function()
            -- Enable servers installed by Mason
            vim.lsp.enable(require("mason-lspconfig").get_installed_servers())
        end,
    },
    -- Ensure install for Mason's LSP
    {
        "williamboman/mason-lspconfig.nvim", -- bridges mason.nvim and nvim-lspconfig
        event = { "BufReadPre", "BufNewFile" },
        -- event = "VeryLazy",
        opts = {
            -- Install the LSP servers automatically using mason-lspconfig
            ensure_installed = {
                "pyright", "ruff", "bashls", "clangd", "vimls", "lua_ls", "texlab", "marksman", "ts_ls", "yamlls",
            },
            automatic_installation = true,
        },
    },
    -- LSP config
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        -- init = function()
            -- ────────────────────────────────────────────────────────────────────────────────────
            -- Set up LSP servers
            -- ────────────────────────────────────────────────────────────────────────────────────
            -- Server-specific configs
            -- local lsp_settings = {
            --     lua_ls = {
            --         Lua = {
            --             runtime = {
            --                 version = "LuaJIT",
            --                 path = vim.split(package.path, ";"),
            --             },
            --             workspace = {
            --                 library = { vim.env.VIMRUNTIME },
            --                 checkThirdParty = false,
            --             },
            --             telemetry = {
            --                 enable = false,
            --             },
            --         },
            --     },
            -- }

            -- local utf16_cap = vim.lsp.protocol.make_client_capabilities()
            -- ---@diagnostic disable-next-line: inject-field
            -- utf16_cap.offsetEncoding = { "utf-16" }
            -- local lsp_capabilities = {
            --     clangd = { utf16_cap },
            -- }

            -- Use a loop to conveniently call 'setup' on multiple servers and
            -- map buffer local keybindings when the language server attaches
            -- The servers are ensured to be installed by mason-lspconfig
            -- local servers = require("mason-lspconfig").get_installed_servers()
            -- for _, lsp in ipairs(servers) do
            --     require("lspconfig")[lsp].setup({
            --         settings = lsp_settings[lsp],
            --         capabilities = lsp_capabilities[lsp],
            --         on_attach = function(client, bufnr)
            --             if lsp == "ruff" then
            --                 -- Turn off hover for ruff
            --                 client.server_capabilities.hoverProvider = false
            --             end
            --         end,
            --     })
            -- end

            -- ────────────────────────────────────────────────────────────────────────────────────
            -- Setup UI
            -- ────────────────────────────────────────────────────────────────────────────────────
            -- require("lspconfig.ui.windows").default_options.border = "rounded"
        -- end,
    },
}
