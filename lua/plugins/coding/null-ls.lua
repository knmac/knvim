-- Code linter
return {
    'jose-elias-alvarez/null-ls.nvim', -- linter and formatter
    dependencies = {
        'jayp0521/mason-null-ls.nvim', -- bridges mason.nvim and null-ls
        opts = {
            ensure_installed = { 'pylama', 'black', 'cpplint', 'shellcheck', 'prettierd', },
            automatic_installation = true,
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
                diagnostics.pylama.with({  -- Python linter
                    extra_args = {
                        '-l', 'pycodestyle', -- use pycodestyle as flake8 duplicates many things from pyright
                        '--max-line-length', '100',
                        '--ignore', 'E226,E402,E501,W503,W504,W391',
                    }
                }),
                diagnostics.cpplint,    -- C/C++ linter
                diagnostics.shellcheck, -- Shell script linter
                -- Completion
                -- completion.spell,  -- Spell suggestion
            },
        })
    end,
}
