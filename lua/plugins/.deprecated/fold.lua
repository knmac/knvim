-- Code folding
return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
        {
            "luukvbaal/statuscol.nvim",
            config = function()
                local builtin = require("statuscol.builtin")
                require("statuscol").setup({
                    -- foldfunc = 'builtin',
                    -- setopt = true,
                    relculright = true,
                    segments = {
                        { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
                        { text = { "%s" },                  click = "v:lua.ScSa" },
                        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                    },
                })
            end,
        },
    },
    config = function()
        -- Hide fold columnn for some file types (still have them enable)
        local folding_group = vim.api.nvim_create_augroup("folding_group", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            desc = "Hide foldcolumn for some file types",
            pattern = { "Outline", "toggleterm", "neotest-summary" },
            group = folding_group,
            callback = function()
                vim.opt_local.foldcolumn = "0"
            end,
        })

        -- Disable fold completely for alpha
        vim.api.nvim_create_autocmd("FileType", {
            desc = "Disable folding for alpha",
            pattern = { "alpha", },
            group = folding_group,
            callback = function()
                vim.opt_local.foldenable = false
            end,
        })

        -- treesitter as a main provider instead
        -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
        -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
        require("ufo").setup({
            provider_selector = function(_, _, _) -- function(bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end
        })
    end,
}
