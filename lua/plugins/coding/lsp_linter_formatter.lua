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
    -- Ensure install for linter and formatter
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        -- event = { "BufReadPre", "BufNewFile" },
        -- event = "VeryLazy",
        opts = {
            ensure_installed = { "cpplint", "shellcheck", "prettier", "bibtex-tidy", "shfmt" },
        },
    },
    -- LSP config: using the predefined config for some LSP
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        -- event = "VeryLazy",
        init = function()
            -- Enable servers installed by Mason
            vim.lsp.enable(require("mason-lspconfig").get_installed_servers())
        end,
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
