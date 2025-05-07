-- Neovim Language Server Protocol
return {
    -- ────────────────────────────────────────────────────────────────────────────────────────────
    -- LSP manager: mason
    -- ────────────────────────────────────────────────────────────────────────────────────────────
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
    },
    -- ────────────────────────────────────────────────────────────────────────────────────────────
    -- LSP: nvim-lspconfig + mason-lspconfig
    -- ────────────────────────────────────────────────────────────────────────────────────────────
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        -- event = "VeryLazy",
        dependencies = {
            "williamboman/mason-lspconfig.nvim", -- bridges mason.nvim and nvim-lspconfig
            opts = {
                ensure_installed = { "pyright", "ruff", "bashls", "clangd", "vimls", "lua_ls", "texlab", "marksman", "ts_ls", "yamlls" },
                automatic_installation = true,
            },
        },
        init = function()
            -- Enable servers installed by mason-lspconfig
            vim.lsp.enable(require("mason-lspconfig").get_installed_servers())
        end,
    },
    -- ────────────────────────────────────────────────────────────────────────────────────────────
    -- Linter: nvim-lint + mason-tool-installer
    -- ────────────────────────────────────────────────────────────────────────────────────────────
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            opts = { ensure_installed = { "cpplint", "shellcheck" } },
        },
        init = function()
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
    -- ────────────────────────────────────────────────────────────────────────────────────────────
    -- Formatter: conform + mason-tool-installer
    -- ────────────────────────────────────────────────────────────────────────────────────────────
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
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            opts = { ensure_installed = { "prettier", "bibtex-tidy", "shfmt" }, },
        },
        opts = {
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
        }
    },
}
