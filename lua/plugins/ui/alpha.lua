-- Start page greeter
return {
    {
        "goolord/alpha-nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            local dashboard = require("alpha.themes.dashboard")

            -- Get version
            local function get_version()
                local version = vim.version()
                local nvim_version_info = "NVIM v" ..
                    version.major .. "." .. version.minor .. "." .. version.patch
                return nvim_version_info
            end

            -- Set header
            dashboard.section.header.val = {
                "   ██╗  ██╗███╗   ██╗██╗   ██╗██╗███╗   ███╗  ",
                "   ██║ ██╔╝████╗  ██║██║   ██║██║████╗ ████║  ",
                "   █████╔╝ ██╔██╗ ██║██║   ██║██║██╔████╔██║  ",
                "   ██╔═██╗ ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
                "   ██║  ██╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
                "   ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
            }

            -- Set menu
            local cfg_pth = vim.fn.stdpath("config")
            dashboard.section.buttons.val = {
                dashboard.button("e", "󰝒  Edit a new file",
                    ":ene<CR>"),
                dashboard.button("r", "  Recent files",
                    ":Telescope oldfiles<CR>"),
                dashboard.button("s", "󰺄  Session manager",
                    ":SessionManager load_session<CR>"),
                dashboard.button("f", "󰱼  File finder",
                    ":Telescope find_files<CR>"),
                dashboard.button("t", "󱎸  Text finder",
                    ":Telescope live_grep<CR>"),
                dashboard.button("u", "󰏖  Update plugins",
                    ":Lazy sync | TSUpdate | MasonUpdate<CR>"),
                dashboard.button("l", "  Language servers",
                    ":Mason<CR>"),
                dashboard.button("h", "󰓙  Health checker",
                    ":checkhealth<CR>"),
                dashboard.button("c", "  Configurations",
                    ":cd " .. cfg_pth .. " | e $MYVIMRC<CR>"),
                dashboard.button("p", "  Pull knvim's configs",
                    ":!git --git-dir=" .. cfg_pth .. "/.git --work-tree=" .. cfg_pth .. " pull<CR>"),
                dashboard.button("?", "  Cheatsheet",
                    ":e " .. cfg_pth .. "/res/cheatsheet.md | Outline!<CR>"),
                dashboard.button("q", "󰍃  Quit",
                    ":qa<CR>"),
            }

            -- Set footer
            local fortune = require("alpha.fortune")
            dashboard.section.footer.val = fortune()

            -- Dynamic header padding (center of the page)
            local min_padding = 2
            -- local margin_top_percent = 0.2
            -- local header_padding = vim.fn.max({ min_padding, vim.fn.floor(vim.fn.winheight(0) * margin_top_percent) })
            local page_len = #dashboard.section.header.val + 1 + min_padding +
                2 * #dashboard.section.buttons.val + #dashboard.section.footer.val
            local header_padding = vim.fn.max({ min_padding, vim.fn.floor((vim.fn.winheight(0) - page_len) /
                2) })

            -- Set layout
            dashboard.config.layout = {
                { type = "padding", val = header_padding },
                dashboard.section.header,
                { type = "text",    val = get_version(), opts = { position = "center", hl = "hl_group" } },
                { type = "padding", val = min_padding },
                dashboard.section.buttons,
                dashboard.section.footer,
            }

            -- Send config to alpha
            require("alpha").setup(dashboard.opts)
        end,
    },
    -- Session manager
    {
        "Shatur/neovim-session-manager",
        dependencies = "nvim-lua/plenary.nvim",
        event = "BufEnter",
        keys = {
            { "<space>s", "<CMD>SessionManager load_session<CR>", desc = "Load session" },
        },
        config = function()
            local Path = require("plenary.path")
            require("session_manager").setup({
                -- The directory where the session files will be saved.
                sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"),
                -- The character to which the path separator will be replaced for session files.
                path_replacer = "__",
                -- The character to which the colon symbol will be replaced for session files.
                colon_replacer = "++",
                -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
                autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
                -- Automatically save last session on exit.
                autosave_last_session = true,
                -- Plugin will not save a session when no writable and listed buffers are opened.
                autosave_ignore_not_normal = true,
                -- A list of directories where the session will not be autosaved.
                autosave_ignore_dirs = {},
                -- All buffers of these file types will be closed before the session is saved.
                autosave_ignore_filetypes = { "gitcommit", "toggleterm", "NvimTree", "neo-tree", "vista", "Outline", },
                -- All buffers of these bufer types will be closed before the session is saved.
                autosave_ignore_buftypes = {},
                -- Always autosaves session. If true, only autosaves after a session is active.
                autosave_only_in_session = false,
                -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
                max_path_length = 75,
            })
        end,
    },
}
