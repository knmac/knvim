-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Neovim basic settings
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Setup python path
-- ────────────────────────────────────────────────────────────────────────────────────────────────
local possible_python_paths = {
    -- Extend the list for possible python path. Will use the 1st possible one
    os.getenv("HOME") .. "/.venvs/knvim/bin/python",             -- Python3's venv (knvim)
    os.getenv("HOME") .. "/opt/anaconda3/envs/knvim/bin/python", -- MacOS's conda (knvim)
    os.getenv("HOME") .. "/anaconda3/envs/knvim/bin/python",     -- Linux's conda (knvim)
    os.getenv("HOME") .. "/miniconda3/envs/knvim/bin/python",    -- Linux's conda (knvim)
    os.getenv("HOME") .. "/.conda/envs/knvim/bin/python",        -- Linux's alternative conda (knvim)
    os.getenv("HOME") .. "/.pyenv/shims/python",                 -- pyenv's default path
    "/usr/bin/python3",                                          -- System default python3
    "/usr/bin/python",                                           -- System default python
}
for _, python_path in pairs(possible_python_paths) do
    if io.open(python_path, "r") ~= nil then
        vim.g.python3_host_prog = python_path
        break
    end
end


-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Deactivate unused providers
-- ────────────────────────────────────────────────────────────────────────────────────────────────
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0


-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- General
-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- vim.g.mapleader = ','
vim.opt.mouse = "a"                    -- enable mouse support
vim.opt.clipboard = "unnamedplus"      -- copy/paste to system clipboard
vim.opt.swapfile = false               -- don't use swapfile
vim.opt.wildmenu = true                -- enhance mode of command-line completion
vim.opt.wildmode = "longest:full,full" -- completion mode config
vim.opt.backspace = "indent,eol,start" -- resolve the problem that backspace not working
vim.opt.encoding = "utf-8"             -- use Unicode
vim.opt.spelllang = "en_us"            -- set spell language as US english
vim.opt.spellfile = vim.fn.stdpath("data") ..
    "/spelling/en.utf-8.add"           -- file to store custom spelling

-- vim.cmd [[ set path+=** ]]         -- provide tab-completion for file-related tasks, e.g., gf


-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Neovim UI
-- ────────────────────────────────────────────────────────────────────────────────────────────────
vim.opt.termguicolors = true  -- enable 24-bit RGB color in the TUI
vim.opt.ls = 2                -- always show status bar
vim.opt.number = true         -- show line number
vim.opt.relativenumber = true -- use relative number
vim.opt.numberwidth = 5       -- width of line numbers
vim.opt.showcmd = true        -- show command in bottom bar
vim.opt.cursorline = true     -- highlight current line
vim.opt.colorcolumn = "100"   -- line length marker at 100 columns
vim.opt.showmatch = true      -- highlight matching parenthesis
vim.opt.smartcase = true      -- ignore lowercase for the whole pattern
vim.opt.linebreak = true      -- wrap on word boundary
vim.opt.signcolumn = "yes"    -- always show the sign column to not shift the text

-- Marking special characters
vim.opt.list = true                  -- list mode to mark special characters
vim.opt.listchars = "tab:>-,trail:." -- mark <Tab> as >-, trailing <Space> as .

-- Splitting
vim.opt.splitright = true -- vertical split to the right
vim.opt.splitbelow = true -- orizontal split to the bottom

-- Folding (refer to lua/plugins/ui/fold.lua)
vim.opt.foldenable = true   -- enable folding
vim.opt.foldlevel = 99      -- set fold level
vim.opt.foldlevelstart = 99 -- open most folds by default
vim.opt.foldnestmax = 10    -- 10 nested fold max
-- vim.opt.foldmethod = "indent" -- set folding method by looking at indent
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Fold column options
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.foldcolumn = "1" -- '0' is not bad | Number of different visible folding levels


-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Searching and substitution
-- ────────────────────────────────────────────────────────────────────────────────────────────────
vim.opt.ignorecase = true -- ignore case letters when search
vim.opt.incsearch = true  -- search as characters are entered
vim.opt.hlsearch = true   -- highlight matches
-- vim.opt.inccommand = 'nosplit' -- show substitution results live


-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Tabs, indent
-- ────────────────────────────────────────────────────────────────────────────────────────────────
vim.opt.expandtab = true  -- use spaces instead of tabs
vim.opt.tabstop = 4       -- change the width of the <Tab> key
vim.opt.softtabstop = 4   -- affect what happens when press <Tab> or <BS>
vim.opt.shiftwidth = 4    -- affect what happens when press >>, <<, or ==
vim.opt.smarttab = true   -- affects how <Tab> are interpreted based on cursor location
vim.opt.autoindent = true -- copy the indent from the prev line to a new line


-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Others
-- ────────────────────────────────────────────────────────────────────────────────────────────────
vim.opt.hidden = true -- enable background buffers
-- vim.opt.history = 100     -- remember n lines in history
-- vim.opt.lazyredraw = true -- faster scrolling
-- vim.opt.synmaxcol = 240   -- max column for syntax highlight

-- Force latex instead of plaintex
vim.g.tex_flavor = "latex" -- plain|context|latex
