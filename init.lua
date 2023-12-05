---------------------------------------------------------------------------------------------------
-- Nvim's core settings without plugins
---------------------------------------------------------------------------------------------------
require("core")

-- Overwrite some custom paths if needed (already defined in core/settings.lua)
-- vim.g.python3_host_prog = ""
-- vim.opt.spellfile = ""

---------------------------------------------------------------------------------------------------
-- Setup plugins with the package-manager lazy-nvim
---------------------------------------------------------------------------------------------------
-- Bootstrap 1st install
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local plugins_cfg_dir = "plugins"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
local opts = {
    install = {
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "catppuccin-macchiato", "habamax" },
    },
    ui = {
        border = "rounded",
    },
}

require("lazy").setup(plugins_cfg_dir, opts)
