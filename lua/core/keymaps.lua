-------------------------------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim and plugins.
-------------------------------------------------------------------------------
local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }
-- local g = vim.g


-------------------------------------------------------------------------------
-- Basic key bindings
-------------------------------------------------------------------------------
-- Maintain visual mode after shifting
map('v', '>', '>gv', default_opts)
map('v', '<', '<gv', default_opts)

-- Go down/up soft-wrapped lines instead of 'real' lines
-- map('n', 'j', 'gj', default_opts)
-- map('n', 'k', 'gk', default_opts)

-- Keep the cursor line in the middle of the screen
-- map('n', 'j', 'jzz', default_opts)
-- map('n', 'k', 'kzz', default_opts)

-- Window navigation
map('n', '<A-h>', '<C-w>h', default_opts)
map('n', '<A-j>', '<C-w>j', default_opts)
map('n', '<A-k>', '<C-w>k', default_opts)
map('n', '<A-l>', '<C-w>l', default_opts)

-- Window swapping
map('n', '<A-S-h>', '<C-w>h<C-w>x', default_opts)
map('n', '<A-S-j>', '<C-w>j<C-w>x', default_opts)
map('n', '<A-S-k>', '<C-w>k<C-w>x', default_opts)
map('n', '<A-S-l>', '<C-w>l<C-w>x', default_opts)

-- Navigation from terminal
-- map('t', '<esc>', [[<C-\><C-n>]], default_opts)
map('t', '<A-h>', [[<C-\><C-n><C-w>h]], default_opts)
map('t', '<A-j>', [[<C-\><C-n><C-w>j]], default_opts)
map('t', '<A-k>', [[<C-\><C-n><C-w>k]], default_opts)
map('t', '<A-l>', [[<C-\><C-n><C-w>l]], default_opts)


-------------------------------------------------------------------------------
-- Plugins and Function key bindings
-------------------------------------------------------------------------------
-- Pounce
map('n', 's',  '<cmd>Pounce<CR>', default_opts)
map('n', 'S',  '<cmd>PounceRepeat<CR>', default_opts)
map('x', 's',  '<cmd>Pounce<CR>', default_opts)
map('o', 'gs', '<cmd>Pounce<CR>', default_opts)  -- 's' is used by vim-surround
-- map('n', 'S',  ':Pounce <C-r>/<cr>', default_opts)  -- note: if you want to use <C-r> you cannot use <cmd>

-- Barbar (buffer line)
map('n', '<C-A-h>',   '<cmd>BufferPrevious<CR>', default_opts)
map('n', '<C-A-j>',   '<cmd>BufferPick<CR>', default_opts)
map('n', '<C-A-k>',   '<cmd>BufferPickDelete<CR>', default_opts)
map('n', '<C-A-l>',   '<cmd>BufferNext<CR>', default_opts)
map('n', '<C-A-S-h>', '<cmd>BufferMovePrevious<CR>', default_opts)
map('n', '<C-A-S-j>', '<cmd>BufferRestore<CR>', default_opts)
map('n', '<C-A-S-k>', '<cmd>BufferClose<CR>', default_opts)
map('n', '<C-A-S-l>', '<cmd>BufferMoveNext<CR>', default_opts)
map('n', '<C-A-p>',   '<cmd>BufferPin<CR>', default_opts)

-- Telescope
map('n', '<space><space>', '<cmd>Telescope<CR>', default_opts)
map('n', '<space>f',       '<cmd>Telescope find_files<CR>', default_opts)
map('n', '<space>t',       '<cmd>Telescope live_grep<CR>', default_opts)
map('n', '<space>b',       '<cmd>Telescope buffers<CR>', default_opts)
map('n', '<space>/',       '<cmd>Telescope current_buffer_fuzzy_find<CR>', default_opts)
map('n', '<space>c',       '<cmd>Telescope bibtex<CR>', default_opts)
map('n', '<space>v',       '<cmd>Telescope vim_options<CR>', default_opts)
map('n', '<space>w',       '<cmd>Telescope file_browser<CR>', default_opts)
map('n', '<space>h',       '<cmd>Telescope help_tags<CR>', default_opts)
map('n', '<space>?',       '<cmd>Telescope commands<CR>', default_opts)
map('n', '<space>n',       '<cmd>Telescope notify<CR>', default_opts)
map('n', '<space>s',       '<cmd>SessionManager load_session<CR>', default_opts)
map('n', '<space>e',
    function() require('swenv.api').pick_venv() end,
    { desc = 'Switch python env', noremap = true, silent = true }
)

-- Easy align
-- Start interactive EasyAlign in visual mode (e.g. vip\a)
map('x', '<leader>a', '<Plug>(EasyAlign)', {})
-- Start interactive EasyAlign for a motion/text object (e.g. \aip)
map('n', '<leader>a', '<Plug>(EasyAlign)', {})

-- Neogen
map('n', '<leader>d', '<cmd>Neogen<CR>', default_opts)

-- Comment.nvim
map('n', '<C-/>', function() require('Comment.api').toggle.linewise.current() end, default_opts)

-- Alternative ways to toggle Neotree, symbol outline, and zen-mode
map('n', '<leader>t', '<cmd>Neotree toggle<CR>', default_opts)
-- map('n', '<leader>T', '<cmd>Neotree dir=%:p:h<CR>', default_opts)
map('n', '<leader>T', '<cmd>Neotree reveal<CR>', default_opts)
map('n', '<leader>o', '<cmd>SymbolsOutline<CR>', default_opts)
map('n', '<leader>z', '<cmd>ZenMode<CR>', default_opts)

-- Fn keys
-- <F1>: Show help
map('n', '<F1>', '<cmd>Telescope help_tags<CR>', default_opts)
-- <S-F1>: Show keymaps
map('n', '<F13>', '<cmd>Telescope keymaps<CR>', default_opts)

-- <F2>: Rename (check lspconfig)
map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', default_opts)
-- <S-F2>: Show task list
map('n', '<F14>', '<cmd>TodoTelescope<CR>', default_opts)

-- <F3>: Show file tree explorer
-- map('n', '<F3>', '<cmd>NvimTreeToggle<CR>', default_opts)
map('n', '<F3>', '<cmd>Neotree toggle<CR>', default_opts)
-- <F3>: Show file tree at the current file dir
map('n', '<F15>', '<cmd>Neotree dir=%:p:h<CR>', default_opts)

-- <F4>: Show tags of current buffer
-- map('n', '<F4>', ':Telescope current_buffer_tags<CR>', default_opts)
map('n', '<F4>', '<cmd>SymbolsOutline<CR>', default_opts)
-- <S-F4>: Show diagnostics
map('n', '<F16>', '<cmd>Telescope diagnostics<CR>', default_opts)
-- <S-F4>: Generate tags
-- map('n', '<F16>', ':!ctags -R --links=no . <CR>', default_opts)

-- <F5>: Show and switch buffer
map('n', '<F5>', '<cmd>Telescope buffers<CR>', default_opts)
-- <S-F5>: Show and switch tab
map('n', '<F17>', '<cmd>tabs<CR>', default_opts)

-- <F6>: Prev buffer
map('n', '<F6>', '<cmd>BufferPrevious<CR>', default_opts)
-- <S-F6>: Prev tab
map('n', '<F18>', '<cmd>tabprevious<CR>', default_opts)

-- <F7>: Next buffer
map('n', '<F7>', '<cmd>BufferNext<CR>', default_opts)
-- <S-F7>: Next tab
map('n', '<F19>', '<cmd>tabnext<CR>', default_opts)

-- <F8>: Close current buffer and switch to previous buffer
map('n', '<F8>', '<cmd>BufferClose<CR>', default_opts)
-- <S-F8>: Close current tab
map('n', '<F20>', '<cmd>tabclose<CR>', default_opts)

-- <F9>: Remove trailing spaces
map('n', '<F9>', [[<cmd>%s/\s\+$//e<CR>]], default_opts)
-- <S-F9>: Clear registers
map('n', '<F21>', '<cmd>ClearRegisters<CR>', default_opts)

-- <F10>: Run make file
map('n', '<F10>', '<cmd>make<CR>', default_opts)
-- <S-F10>: Run make clean
map('n', '<F22>', '<cmd>make clean<CR>', default_opts)

-- <F11>: Toggle zoom the current window (from custom functions)
map('n', '<F11>', '<cmd>ZenMode<CR>', default_opts)
-- <S-F11>: Toggle colorizer
map('n', '<F23>', '<cmd>ColorizerToggle<CR>', default_opts)

-- <F12>: Toggle relative number
map('n', '<F12>', '<cmd>set nu rnu!<CR>', default_opts)
-- <S-F11>: Toggle welcome screen
map('n', '<F24>', '<cmd>Alpha<CR>', default_opts)
