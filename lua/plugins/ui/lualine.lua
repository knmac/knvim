-- Statusline at the bottom
return {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        -- Custom winbar config that uses nvim-navic
        local navic_ok, navic = pcall(require, 'nvim-navic')
        local winbar_cfg = {}
        local inactive_winbar_cfg = {}

        if navic_ok then
            winbar_cfg = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    { 'filename', path = 1, color = { bg = 'NONE' } },
                    {
                        function()
                            local loc = navic.get_location()
                            if loc ~= '' then
                                return '› ' .. loc
                            end
                            return loc
                        end,
                        cond = function()
                            return navic.is_available()
                        end,
                        color = { bg = 'NONE' },
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            }
            inactive_winbar_cfg = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    { 'filename', path = 1, color = { bg = 'NONE' } },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            }
        end

        -- Custom message to show the number of spaces per tab of the buffer
        local fmt_stat = function()
            local stat = ''
            stat = stat .. 'spaces=' .. vim.opt_local.tabstop._value
            return stat
        end

        -- Main config
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
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { { 'filename', path = 3, }, 'searchcount' },
                lualine_x = { fmt_stat, 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'location', 'progress' },
                lualine_z = {
                    { 'swenv', icon = ' ', color = { fg = '#24273A', }, }
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = winbar_cfg,
            inactive_winbar = inactive_winbar_cfg,
            -- extensions = { 'nvim-tree', 'neo-tree', 'quickfix', 'fugitive', 'symbols-outline', 'toggleterm', 'nvim-dap-ui' }
        })
    end,
}
