-- Start page greeter
return {
    {
        'goolord/alpha-nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            local dashboard = require('alpha.themes.dashboard')

            -- Get version
            local function get_version()
                local version = vim.version()
                local nvim_version_info = 'NVIM v' .. version.major .. '.' .. version.minor .. '.' .. version.patch
                return nvim_version_info
            end

            -- Set header
            dashboard.section.header.val = {
                '   ██╗  ██╗███╗   ██╗██╗   ██╗██╗███╗   ███╗  ',
                '   ██║ ██╔╝████╗  ██║██║   ██║██║████╗ ████║  ',
                '   █████╔╝ ██╔██╗ ██║██║   ██║██║██╔████╔██║  ',
                '   ██╔═██╗ ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║  ',
                '   ██║  ██╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║  ',
                '   ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝  ',
            }

            dashboard.section.buttons.val = {
                dashboard.button('e', '󰝒  Edit a new file',  ':ene<CR>'),
                dashboard.button('r', '  Recent files',     ':Telescope oldfiles<CR>'),
                dashboard.button('s', '󰺄  Session manager',  ':SessionManager load_session<CR>'),
                dashboard.button('f', '󰱼  File finder',      ':Telescope find_files<CR>'),
                dashboard.button('t', '󱎸  Text finder',      ':Telescope live_grep<CR>'),
                dashboard.button('u', '󰏖  Update packages',  ':Lazy sync<CR>'),
                dashboard.button('l', '  Language servers', ':Mason<CR>'),
                dashboard.button('h', '  Health checker',   ':checkhealth<CR>'),
                dashboard.button('c', '  Configurations',   ':cd ' .. vim.fn.stdpath('config') .. ' | e $MYVIMRC<CR>'),
                dashboard.button('?', '  Cheatsheet',       ':e ' .. vim.fn.stdpath('config') .. '/res/cheatsheet.md | SymbolsOutlineOpen<CR>'),
                dashboard.button('q', '󰍃  Quit',             ':qa<CR>'),
            }

            -- Set footer
            local fortune = require('alpha.fortune')
            dashboard.section.footer.val = fortune()

            -- Dynamic header padding (center of the page)
            local min_padding = 2
            -- local margin_top_percent = 0.2
            -- local header_padding = vim.fn.max({ min_padding, vim.fn.floor(vim.fn.winheight(0) * margin_top_percent) })
            local page_len = #dashboard.section.header.val + 1 + min_padding +
                2 * #dashboard.section.buttons.val + #dashboard.section.footer.val
            local header_padding = vim.fn.max({ min_padding, vim.fn.floor((vim.fn.winheight(0) - page_len) / 2) })

            -- Set layout
            dashboard.config.layout = {
                { type = 'padding', val = header_padding },
                dashboard.section.header,
                { type = 'text',    val = get_version(), opts = { position = 'center', hl = 'hl_group' } },
                { type = 'padding', val = min_padding },
                dashboard.section.buttons,
                dashboard.section.footer,
            }

            -- Send config to alpha
            require('alpha').setup(dashboard.opts)
        end,
    },
    -- Session manager
    {
        'Shatur/neovim-session-manager',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            local Path = require('plenary.path')
            require('session_manager').setup({
                sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),         -- The directory where the session files will be saved.
                path_replacer = '__',                                                -- The character to which the path separator will be replaced for session files.
                colon_replacer = '++',                                               -- The character to which the colon symbol will be replaced for session files.
                autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
                autosave_last_session = true,                                        -- Automatically save last session on exit.
                autosave_ignore_not_normal = true,                                   -- Plugin will not save a session when no writable and listed buffers are opened.
                autosave_ignore_dirs = {},                                           -- A list of directories where the session will not be autosaved.
                autosave_ignore_filetypes = {                                        -- All buffers of these file types will be closed before the session is saved.
                    'gitcommit',
                    'toggleterm',
                    'NvimTree',
                    'neo-tree',
                    'vista',
                    'Outline',
                },
                autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
                autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
                max_path_length = 75,         -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
            })
        end,
    },
}
