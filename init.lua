-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Nvim's core settings without plugins
-- ────────────────────────────────────────────────────────────────────────────────────────────────
require("core")

-- Overwrite some custom paths if needed (already defined in lua/core/settings.lua)
-- vim.g.python3_host_prog = ""
-- vim.opt.spellfile = ""


-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Setup plugins with the package-manager lazy-nvim
-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Bootstrap 1st install
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local plugins_cfg_dir = "plugins"

---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = plugins_cfg_dir, },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = {
        colorscheme = { "catppuccin-macchiato" },
    },
    -- automatically check for plugin updates
    checker = { enabled = true },
    -- border
    ui = {
        border = "rounded",
    },
})

-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Disable background of some highlights (affects loaded plugins)
-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = nil })
-- vim.api.nvim_set_hl(0, "PMenu", { ctermbg = nil })
local rm_bg = function(hl_name)
    local old_fg = vim.api.nvim_get_hl(0, { name = hl_name }).fg
    vim.api.nvim_set_hl(0, hl_name, { fg = old_fg, bg = nil })
end

for _, hl_name in ipairs({ "NormalFloat", "PMenu", "FloatBorder", "BlinkCmpMenuBorder" }) do
    rm_bg(hl_name)
end
