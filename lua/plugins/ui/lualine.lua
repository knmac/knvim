-- Statusline at the bottom
return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'nvim-telescope/telescope.nvim',  -- Switch filetype
        'SmiteshP/nvim-navic',  -- Show navic status
        'AckslD/swenv.nvim',  -- Show and switch python env
    },
    config = function()
        -- Custom components --------------------------------------------------
        -- Navic status for winbar
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

        -- Message to show the number of spaces per tab of the buffer
        local fmt_stat = {
            function()
                local stat = ''
                stat = stat .. 'spaces=' .. vim.opt_local.tabstop._value
                return stat
            end,
        }

        -- Python virtual env
        local env_stat = {
            function()
                return require('swenv.api').get_current_venv().name
            end,
            icon = ' ',
            on_click = function()
                require('swenv.api').pick_venv()
                vim.cmd.LspRestart()
            end,
        }

        -- Clickable filetype
        local filetype_stat = {
            'filetype',  -- builtin filetype component
            on_click = function()
                require('telescope.builtin').filetypes()
                vim.cmd.LspRestart()
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
                lualine_b = { 'branch',
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
