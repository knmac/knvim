-- Code linter and formatter
return {
    'jose-elias-alvarez/null-ls.nvim', -- linter and formatter
    dependencies = {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
            ensure_installed = { 'black', 'cpplint', 'shellcheck', 'prettierd', },
        },
    },
    config = function()
        -- Init for null-ls
        local null_ls = require('null-ls')
        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        -- local completion = null_ls.builtins.completion

        null_ls.setup({
            debug = true,
            sources = {
                -- Formatting -------------------------------------------------
                formatting.black.with({ -- Python formatter
                    extra_args = { '--fast', },
                }),
                formatting.prettierd,  -- Javascript, Typescript, ... formatter
                -- Non-LSP diagnostics (linters) ------------------------------
                diagnostics.cpplint,    -- C/C++ linter
                diagnostics.shellcheck, -- Shell script linter
                -- Completion
                -- completion.spell,  -- Spell suggestion
            },
        })
    end,
}
