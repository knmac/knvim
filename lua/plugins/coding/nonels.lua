-- Code linter and formatter
return {
    -- Ensure install for linter and formatter
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = { "cpplint", "shellcheck", "prettier", },
        },
    },
    -- Linter and formatter
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.cpplint,
                    null_ls.builtins.diagnostics.shellcheck,
                    null_ls.builtins.formatting.prettier,
                    -- null_ls.builtins.formatting.black,
                },
            })
        end,
    },
}
