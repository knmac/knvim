-- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.
local detail = false

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
        float = {
            padding = 2,
        },
        view_options = {
            show_hidden = true,
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
