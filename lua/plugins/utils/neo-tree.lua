-- File explorer
return {
    -- Neo-tree
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
        },
        config = function()
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
            require('neo-tree').setup({
                popup_border_style = 'rounded',
                enable_git_status = true,
                enable_diagnostics = true,
                source_selector = {
                    winbar = true,
                    statusline = false,
                    sources = {
                        { source = 'filesystem', display_name = ' 󰉓 Files ' },
                        { source = 'buffers',    display_name = ' 󰈚 Buffers ' },
                        { source = 'git_status', display_name = ' 󰊢 Git ' },
                    },
                },
                default_component_configs = {
                    icon = {
                        folder_closed = '󰉋',
                        folder_open = '󰝰',
                        folder_empty = "󰜌",
                        folder_empty_open = "󰜌",
                    },
                    git_status = {
                        symbols = {
                            -- Change type
                            added     = '', -- or '', but this is redundant info if you use git_status_colors on the name
                            modified  = '', -- or '', but this is redundant info if you use git_status_colors on the name
                            deleted   = '', -- this can only be used in the git_status source
                            renamed   = '', -- this can only be used in the git_status source
                            -- Status type
                            untracked = '',
                            ignored   = '',
                            unstaged  = '󰄱',
                            staged    = '',
                            conflict  = '',
                        }
                    },
                },
            })
        end,
    },
    -- Window picker
    -- only needed if you want to use the commands with '_with_window_picker' suffix
    {
        's1n7ax/nvim-window-picker',
        version = 'v1.*',
        opts = {
            autoselect_one = true,
            include_current = false,
            selection_chars = '12334567890ABCDEFGHIJKLMNOPQRSTUVWXYZ',
            filter_rules = {
                -- filter using buffer options
                bo = {
                    -- if the file type is one of following, the window will be ignored
                    filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                    -- if the buffer type is one of following, the window will be ignored
                    buftype = { 'terminal', 'quickfix' },
                },
            },
            fg_color = '#24273A',
            other_win_hl_color = '#8AADF4',
        },
    },
}
