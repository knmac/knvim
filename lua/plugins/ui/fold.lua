-- Code folding
return {
    'kevinhwang91/nvim-ufo',
    dependencies = {
        'kevinhwang91/promise-async',
        {
            'luukvbaal/statuscol.nvim',
            config = function()
                local builtin = require('statuscol.builtin')
                require('statuscol').setup({
                    -- foldfunc = 'builtin',
                    -- setopt = true,
                    relculright = true,
                    segments = {
                        { text = { builtin.foldfunc },      click = 'v:lua.ScFa' },
                        { text = { '%s' },                  click = 'v:lua.ScSa' },
                        { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
                    },
                })
            end,
        },
    },
    config = function()
        -- Fold options
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        vim.o.foldcolumn = '1' -- '0' is not bad
        vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- Hide fold columnn for some file types (still have them enable)
        local folding_group = vim.api.nvim_create_augroup('folding_group', { clear = true })
        vim.api.nvim_create_autocmd('FileType', {
            desc = 'Hide foldcolumn for some file types',
            pattern = { 'Outline', 'toggleterm', },
            group = folding_group,
            callback = function()
                vim.opt_local.foldcolumn = '0'
            end,
        })

        -- -- Disable fold completely for alpha
        -- vim.api.nvim_create_autocmd('FileType', {
        --     desc = 'Disable folding for alpha',
        --     pattern = { 'alpha', },
        --     group = folding_group,
        --     callback = function()
        --         vim.opt_local.foldenable = false
        --     end,
        -- })

        require('ufo').setup({})
    end,
}
