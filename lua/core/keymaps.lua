---------------------------------------------------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim and plugins.
---------------------------------------------------------------------------------------------------
local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }
-- local g = vim.g


---------------------------------------------------------------------------------------------------
-- Basic key bindings
---------------------------------------------------------------------------------------------------
-- Maintain visual mode after shifting
map("v", ">", ">gv", default_opts)
map("v", "<", "<gv", default_opts)

-- Go down/up soft-wrapped lines instead of "real" lines
-- map("n", "j", "gj", default_opts)
-- map("n", "k", "gk", default_opts)

-- Keep the cursor line in the middle of the screen
-- map("n", "j", "jzz", default_opts)
-- map("n", "k", "kzz", default_opts)

-- Window navigation
map("n", "<A-h>", "<C-w>h", default_opts)
map("n", "<A-j>", "<C-w>j", default_opts)
map("n", "<A-k>", "<C-w>k", default_opts)
map("n", "<A-l>", "<C-w>l", default_opts)

-- In insert mode, <Alt>+h,j,k,l becomes arrows
map("i", "<A-h>", "<Left>", default_opts)
map("i", "<A-j>", "<Down>", default_opts)
map("i", "<A-k>", "<Up>", default_opts)
map("i", "<A-l>", "<Right>", default_opts)

-- Window swapping
map("n", "<A-S-h>", "<C-w>h<C-w>x", default_opts)
map("n", "<A-S-j>", "<C-w>j<C-w>x", default_opts)
map("n", "<A-S-k>", "<C-w>k<C-w>x", default_opts)
map("n", "<A-S-l>", "<C-w>l<C-w>x", default_opts)

-- Navigation from terminal
map("t", "<C-esc>", [[<C-\><C-n>]], default_opts)
map("t", "<A-h>", [[<C-\><C-n><C-w>h]], default_opts)
map("t", "<A-j>", [[<C-\><C-n><C-w>j]], default_opts)
map("t", "<A-k>", [[<C-\><C-n><C-w>k]], default_opts)
map("t", "<A-l>", [[<C-\><C-n><C-w>l]], default_opts)

-- Toggle conceal level between 0 and 2
map("n", "<leader>cc",
    function()
        vim.opt_local.conceallevel = math.abs(vim.opt_local.conceallevel._value - 2)
    end,
    { desc = "Toggle conceal level in the current buffer", noremap = true, silent = true }
)


---------------------------------------------------------------------------------------------------
-- Function key bindings
---------------------------------------------------------------------------------------------------
-- <F1>: Show help
map("n", "<F1>", "<cmd>Telescope help_tags<CR>", default_opts)
-- <S-F1>: Show keymaps
map("n", "<F13>", "<cmd>Telescope keymaps<CR>", default_opts)

-- <F2>: Rename (check lspconfig)
map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", default_opts)
-- <S-F2>: Show task list
map("n", "<F14>", "<cmd>TodoTelescope<CR>", default_opts)

-- <F3>: Show file tree explorer
-- map("n", "<F3>", "<cmd>NvimTreeToggle<CR>", default_opts)
map("n", "<F3>", "<cmd>Neotree toggle<CR>", default_opts)
-- <F3>: Show file tree at the current file dir
map("n", "<F15>", "<cmd>Neotree dir=%:p:h<CR>", default_opts)

-- <F4>: Show tags of current buffer
-- map("n", "<F4>", ":Telescope current_buffer_tags<CR>", default_opts)
map("n", "<F4>", "<cmd>SymbolsOutline<CR>", default_opts)
-- <S-F4>: Show diagnostics
map("n", "<F16>", "<cmd>Telescope diagnostics<CR>", default_opts)
-- <S-F4>: Generate tags
-- map("n", "<F16>", ":!ctags -R --links=no . <CR>", default_opts)

-- <F5>: Show and switch buffer
map("n", "<F5>", "<cmd>Telescope buffers<CR>", default_opts)
-- <S-F5>: Show and switch tab
map("n", "<F17>", "<cmd>tabs<CR>", default_opts)

-- <F6>: Prev buffer
map("n", "<F6>", "<cmd>BufferPrevious<CR>", default_opts)
-- <S-F6>: Prev tab
map("n", "<F18>", "<cmd>tabprevious<CR>", default_opts)

-- <F7>: Next buffer
map("n", "<F7>", "<cmd>BufferNext<CR>", default_opts)
-- <S-F7>: Next tab
map("n", "<F19>", "<cmd>tabnext<CR>", default_opts)

-- <F8>: Close current buffer and switch to previous buffer
map("n", "<F8>", "<cmd>BufferClose<CR>", default_opts)
-- <S-F8>: Close current tab
map("n", "<F20>", "<cmd>tabclose<CR>", default_opts)

-- <F9>: Remove trailing spaces
map("n", "<F9>", [[<cmd>%s/\s\+$//e<CR>]], default_opts)
-- <S-F9>: Clear registers
map("n", "<F21>", "<cmd>ClearRegisters<CR>", default_opts)

-- <F10>: Run make file
map("n", "<F10>", "<cmd>make<CR>", default_opts)
-- <S-F10>: Run make clean
map("n", "<F22>", "<cmd>make clean<CR>", default_opts)

-- <F11>: Toggle zoom the current window (from custom functions)
map("n", "<F11>", "<cmd>ZenMode<CR>", default_opts)
-- <S-F11>: Toggle colorizer
map("n", "<F23>", "<cmd>ColorizerToggle<CR>", default_opts)

-- <F12>: Toggle relative number
map("n", "<F12>", "<cmd>set nu rnu!<CR>", default_opts)
-- <S-F11>: Toggle welcome screen
map("n", "<F24>", "<cmd>Alpha<CR>", default_opts)
