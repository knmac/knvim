-- Statusline at the bottom
return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'nvim-telescope/telescope.nvim',  -- Switch filetype and git branches
        'SmiteshP/nvim-navic',  -- Show navic status
        'AckslD/swenv.nvim',  -- Show and switch python env
    },
    config = function()
        -- Custom components --------------------------------------------------
        -- Message to show the number of spaces per tab of the buffer
        local fmt_stat = {
            function()
                local stat = ''
                stat = stat .. 'spaces=' .. vim.opt_local.tabstop._value
                return stat
            end,
        }

        -- Custom components using nvim-navic
        local navic_stat = {
            function()
                local loc = require('nvim-navic').get_location()
                if loc ~= '' then
                    return '› ' .. loc
                end
                return loc
            end,
            cond = function()
                return require('nvim-navic').is_available()
            end,
            color = { bg = 'NONE' },
        }

        -- Custom components using swenv
        local env_stat = {
            function()
                local current_env = require('swenv.api').get_current_venv()
                if current_env ~= nil then
                    current_env = current_env.name
                else
                    current_env = '∅'
                end
                return current_env
            end,
            icon = ' ',
            on_click = function()
                require('swenv.api').pick_venv()
                vim.cmd.LspRestart()
            end,
        }

        -- Custom components using telescope
        local filetype_stat = {
            'filetype',  -- builtin filetype component
            on_click = function()
                require('telescope.builtin').filetypes()
                vim.cmd.LspRestart()
            end,
        }

        local branch_stat = {
            'branch',
            on_click = function()
                require('telescope.builtin').git_branches()
            end,
        }

        -- Main config --------------------------------------------------------
        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = 'auto',
                --component_separators = {left='', right=''},
                --section_separators = {left='', right=''},
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {
                        'NvimTree',
                        'neo-tree',
                        'Outline',
                        'toggleterm',
                        'alpha',
                        'dap-repl',
                        'packer',
                    },
                },
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { branch_stat,
                              'diff',
                              'diagnostics',
                            },
                lualine_c = { { 'filename', path = 3, },
                              'searchcount',
                            },
                lualine_x = { fmt_stat,
                              'encoding',
                              'fileformat',
                              filetype_stat,
                            },
                lualine_y = { 'location',
                              'progress',
                            },
                lualine_z = { env_stat },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { 'filename', path = 1, color = { bg = 'NONE' } },
                              navic_stat,
                            },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { 'filename', path = 1, color = { bg = 'NONE' } },
                            },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            -- extensions = { 'nvim-tree', 'neo-tree', 'quickfix', 'fugitive', 'symbols-outline', 'toggleterm', 'nvim-dap-ui' }
        })
    end,
}
