-- Distraction-free coding
return {
    'folke/zen-mode.nvim',
    event = 'VeryLazy',
    config = function()
        local map = vim.keymap.set
        local default_opts = { noremap = true, silent = true }

        --- Return with with maximum threshold
        local width_with_max = function(ratio, min_width)
            local width = math.floor(vim.go.columns * ratio)
            width = math.min(width, min_width)
            return width
        end

        require('zen-mode').setup({
            window = {
                backdrop = 0.9,
                width = width_with_max(0.85, 150),
            },
            plugins = {
                kitty = {
                    enabled = false,
                    font = '+4',
                },
            },
            -- callback where you can add custom code when the Zen window opens
            on_open = function()
                map('n', 'j', 'jzz', default_opts)
                map('n', 'k', 'kzz', default_opts)
            end,
            -- callback where you can add custom code when the Zen window closes
            on_close = function()
                map('n', 'j', 'j', default_opts)
                map('n', 'k', 'k', default_opts)
            end,
        })
    end,
}
