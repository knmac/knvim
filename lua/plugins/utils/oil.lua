-- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.
local detail = true

-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir = require("oil").get_current_dir(bufnr)
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
    end
end

return {
    "stevearc/oil.nvim",
    event = { "BufReadPre", "BufNewFile" },
    -- event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        -- {
        --     "_",
        --     function()
        --         local oil = require("oil")
        --         oil.open_float()
        --
        --         -- Wait until oil has opened, for a maximum of 1 second.
        --         vim.wait(1000, function()
        --             return oil.get_cursor_entry() ~= nil
        --         end)
        --         if oil.get_cursor_entry() then
        --             oil.open_preview()
        --         end
        --     end,
        --     desc = "Oil: open floating window"
        -- },
        { "_", function() require("oil").open() end, desc = "Oil: open in the current buffer" },
    },
    opts = {
        columns = { "icon", "permissions", "size", "mtime", },
        float = { padding = 2, border = "rounded", },
        view_options = { show_hidden = true, },
        confirmation = { border = "rounded", },
        progress = { border = "rounded", },
        ssh = { border = "rounded", },
        keymaps_help = { border = "rounded", },
        win_options = {
            winbar = "%!v:lua.get_oil_winbar()",
        },
        keymaps = {
            ["q"] = { "actions.close", mode = "n" },
            ["gd"] = {
                desc = "Toggle file detail view",
                callback = function()
                    detail = not detail
                    if detail then
                        require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                    else
                        require("oil").set_columns({ "icon" })
                    end
                end,
            },
        }
    },
}
