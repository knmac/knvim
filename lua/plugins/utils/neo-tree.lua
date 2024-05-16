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
        keys = {
            { "<leader>t", "<CMD>Neotree toggle<CR>", desc = "Toggle Neotree" },
            { "<leader>T", "<CMD>Neotree reveal<CR>", desc = "Open Neotree at the current file" },
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
                window = {
                    mappings = {
                        -- Open with system defaults
                        ["O"] = {
                            command = function(state)
                                local node = state.tree:get_node()
                                local filepath = node.path
                                -- local ostype = os.getenv("OS")
                                local ostype = vim.loop.os_uname().sysname

                                local command

                                if ostype == "Windows_NT" then
                                    command = "start " .. filepath
                                elseif ostype == "Darwin" then
                                    command = "open " .. filepath
                                else
                                    command = "xdg-open " .. filepath
                                end
                                os.execute(command)
                            end,
                            desc = "open_with_system_defaults",
                        }
                    },
                },
            })
        end,
    },
    -- Window picker
    -- only needed if you want to use the commands with '_with_window_picker' suffix
    {
        "s1n7ax/nvim-window-picker",
        version = "v2.*",
        event = "VeryLazy",
        opts = {
            hint = "floating-big-letter",
            selection_chars = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ",
            -- use_winbar = "smart",
            filter_rules = {
                -- filter using buffer options
                bo = {
                    -- if the file type is one of following, the window will be ignored
                    filetype = { "neo-tree", "neo-tree-popup", "notify" },
                    -- if the buffer type is one of following, the window will be ignored
                    buftype = { "terminal", "quickfix" },
                },
            },
        },
    },
}
