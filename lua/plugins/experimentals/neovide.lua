-- Neovide settings if available
if vim.g.neovide then
    -- Set GUI  font
    vim.o.guifont = "JetBrainsMono Nerd Font:h17"

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
end

return {}
