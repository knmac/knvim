-- File explorer
return {
    -- Neo-tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
            require("neo-tree").setup({
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                source_selector = {
                    winbar = true,
                    statusline = false,
                },
                filesystem = {
                    group_empty_dirs = true, -- when true, empty folders will be grouped together
                },
            })
        end,
    },
    -- Window picker
    -- only needed if you want to use the commands with '_with_window_picker' suffix
    {
        "s1n7ax/nvim-window-picker",
        version = "v1.*",
        event = "VeryLazy",
        opts = {
            autoselect_one = true,
            include_current = false,
            selection_chars = "12334567890ABCDEFGHIJKLMNOPQRSTUVWXYZ",
            filter_rules = {
                -- filter using buffer options
                bo = {
                    -- if the file type is one of following, the window will be ignored
                    filetype = { "neo-tree", "neo-tree-popup", "notify" },
                    -- if the buffer type is one of following, the window will be ignored
                    buftype = { "terminal", "quickfix" },
                },
            },
            fg_color = "#24273A",
            other_win_hl_color = "#8AADF4",
        },
    },
}
