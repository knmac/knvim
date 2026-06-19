if vim.g.neovide then
    -- Set GUI  font
    vim.o.guifont = "JetBrainsMono Nerd Font:h17"

    -- Set background
    vim.cmd[[set background=dark]]

    -- Cursor effect
    -- vim.g.neovide_cursor_vfx_mode = "railgun"

    -- Allow Alt key in MacOS
    vim.g.neovide_input_macos_option_key_is_meta = "both"

    -- Allow MacOS cmd+c cmd+v for copy/paste
    vim.keymap.set("v", "<D-c>", '"+y')       -- Copy
    vim.keymap.set("n", "<D-v>", '"+P')       -- Paste normal mode
    vim.keymap.set("v", "<D-v>", '"+P')       -- Paste visual mode
    vim.keymap.set("c", "<D-v>", "<C-R>+")    -- Paste command mode
    vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

    -- Allow clipboard copy paste in neovim
    vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

    -- Frosted pop-up windows
    vim.opt.winblend = 100
    vim.opt.pumblend = 100
    vim.g.neovide_floating_blur_amount_x = 30
    vim.g.neovide_floating_blur_amount_y = 30

    -- Ignore snacks ui features
    vim.b.minianimate_disable = true
    vim.b.snacks_scroll = false
    vim.b.snacks_dim = false
end
