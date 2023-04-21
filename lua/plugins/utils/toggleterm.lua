-- Toggle terminal
return {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    opts = {
        -- size can be a number or function which is passed the current terminal
        -- size = 20 | function(term)
        size = function(term)
            if term.direction == 'horizontal' then
                return 15
            elseif term.direction == 'vertical' then
                return vim.o.columns * 0.3
            end
        end,
        open_mapping = [[<c-\>]],
        -- open_mapping = [[<F12>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        shading_factor = '3',
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        -- persist_size = true,
        persist_size = false,
        -- direction = 'vertical' | 'horizontal' | 'tab' | 'float',
        direction = 'vertical',
        close_on_exit = true, -- close the terminal window when the process exits
        shell = vim.o.shell, -- change the default shell
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
            -- The border key is *almost* the same as 'nvim_open_win'
            -- see :h nvim_open_win for details on borders however
            -- the 'curved' border is a custom border type
            -- not natively supported but implemented in this plugin.
            -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
            border = 'rounded',
            -- width = <value>,
            -- height = <value>,
            winblend = 3,
            highlights = {
                border = 'Normal',
                background = 'Normal',
            }
        }
    }
}
