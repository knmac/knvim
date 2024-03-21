-- Neovim settings

---------------------------------------------------------------------------------------------------
-- Neovim API aliases
---------------------------------------------------------------------------------------------------
local g = vim.g     -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options


---------------------------------------------------------------------------------------------------
-- Setup python path
---------------------------------------------------------------------------------------------------
local possible_python_paths = {
    -- Extend the list for possible python path. Will use the 1st possible one
    "/Users/bqm/Library/Caches/pypoetry/virtualenvs/dev--gguq6YB-py3.12",
    os.getenv("HOME") .. "/.venvs/dev/bin/python",             -- Python3's venv (dev)
    os.getenv("HOME") .. "/opt/anaconda3/envs/dev/bin/python", -- MacOS's conda (dev)
    os.getenv("HOME") .. "/anaconda3/envs/dev/bin/python",     -- Linux's conda (dev)
    os.getenv("HOME") .. "/.conda/envs/dev/bin/python",        -- Linux's alternative conda (dev)
    os.getenv("HOME") .. "/.pyenv/shims/python",               -- pyenv's default path
    "/usr/bin/python3",                                        -- System default python3
    "/usr/bin/python",                                         -- System default python
}
for _, python_path in pairs(possible_python_paths) do
    if io.open(python_path, "r") ~= nil then
        g.python3_host_prog = python_path
        break
    end
end


---------------------------------------------------------------------------------------------------
-- Deactivate unused providers
---------------------------------------------------------------------------------------------------
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0


---------------------------------------------------------------------------------------------------
-- General
---------------------------------------------------------------------------------------------------
-- g.mapleader = ','
opt.mouse = "a"                    -- enable mouse support
opt.clipboard = "unnamedplus"      -- copy/paste to system clipboard
opt.swapfile = false               -- don't use swapfile
opt.wildmenu = true                -- enhance mode of command-line completion
opt.wildmode = "longest:full,full" -- completion mode config
opt.backspace = "indent,eol,start" -- resolve the problem that backspace not working
opt.encoding = "utf-8"             -- use Unicode
opt.spelllang = "en_us"            -- set spell language as US english
opt.spellfile = vim.fn.stdpath("data") ..
    "/spelling/en.utf-8.add"       -- file to store custom spelling

-- vim.cmd [[ set path+=** ]]         -- provide tab-completion for file-related tasks, e.g., gf


---------------------------------------------------------------------------------------------------
-- Neovim UI
---------------------------------------------------------------------------------------------------
opt.termguicolors = true  -- enable 24-bit RGB color in the TUI
opt.ls = 2                -- always show status bar
opt.number = true         -- show line number
opt.relativenumber = true -- use relative number
opt.numberwidth = 5       -- width of line numbers
opt.showcmd = true        -- show command in bottom bar
opt.cursorline = true     -- highlight current line
opt.colorcolumn = "100"   -- line length marker at 100 columns
opt.showmatch = true      -- highlight matching parenthesis
opt.smartcase = true      -- ignore lowercase for the whole pattern
opt.linebreak = true      -- wrap on word boundary
opt.signcolumn = "yes"    -- always show the sign column to not shift the text

-- Marking special characters
opt.list = true                  -- list mode to mark special characters
opt.listchars = "tab:>-,trail:." -- mark <Tab> as >-, trailing <Space> as .

-- Splitting
opt.splitright = true -- vertical split to the right
opt.splitbelow = true -- orizontal split to the bottom

-- Folding (refer to lua/plugins/ui/fold.lua)
-- opt.foldenable = true   -- enable folding
-- opt.foldlevelstart = 10 -- open most folds by default
-- opt.foldnestmax = 10    -- 10 nested fold max
-- opt.foldmethod = 'indent' -- set folding method by looking at indent


---------------------------------------------------------------------------------------------------
-- Searching and substitution
---------------------------------------------------------------------------------------------------
opt.ignorecase = true -- ignore case letters when search
opt.incsearch = true  -- search as characters are entered
opt.hlsearch = true   -- highlight matches
-- opt.inccommand = 'nosplit' -- show substitution results live


---------------------------------------------------------------------------------------------------
-- Tabs, indent
---------------------------------------------------------------------------------------------------
opt.expandtab = true  -- use spaces instead of tabs
opt.tabstop = 4       -- change the width of the <Tab> key
opt.softtabstop = 4   -- affect what happens when press <Tab> or <BS>
opt.shiftwidth = 4    -- affect what happens when press >>, <<, or ==
opt.smarttab = true   -- affects how <Tab> are interpreted based on cursor location
opt.autoindent = true -- copy the indent from the prev line to a new line


---------------------------------------------------------------------------------------------------
-- Others
---------------------------------------------------------------------------------------------------
opt.hidden = true -- enable background buffers
-- opt.history = 100     -- remember n lines in history
-- opt.lazyredraw = true -- faster scrolling
-- opt.synmaxcol = 240   -- max column for syntax highlight
