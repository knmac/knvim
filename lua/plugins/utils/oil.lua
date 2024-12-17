-- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.
local detail = false

return {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "-", function() require("oil").open_float() end, desc = "Oil: open floating window" },
        { "_", function() require("oil").open() end,       desc = "Oil: open in the current buffer" },
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
