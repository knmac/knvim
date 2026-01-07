-- Statusline at the bottom
local is_clickable = false
vim.api.nvim_create_user_command(
    "KnvimToggleClickableLualine",
    function()
        is_clickable = not is_clickable
        local msg = ""
        if is_clickable then
            msg = "󰍽 Lualine clickable on"
        else
            msg = "󰍾 Lualine clickable off"
        end
        vim.notify(msg, vim.log.levels.INFO)
    end,
    {}
)

-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Custom components
-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Show click
local click_status = {
    function()
        if is_clickable then
            return "󰍽 "
        end
        return "󰍾 "
    end,
    on_click = function()
        is_clickable = not is_clickable
    end,
}

-- Show and change the number of spaces per tab of the local buffer
local space_status = {
    icon = "󱁐",
    function()
        local stat = ""
        -- stat = stat .. "Spaces:" .. vim.opt_local.tabstop:get()
        ---@diagnostic disable-next-line: undefined-field
        stat = vim.opt_local.tabstop:get()
        return stat
    end,
    on_click = function()
        if not is_clickable then return end

        vim.ui.select(
            { 2, 4, 8 },
            { prompt = "Local number of spaces per tab" },
            function(spaces)
                if spaces ~= nil then
                    vim.opt_local.tabstop = spaces
                    vim.opt_local.softtabstop = spaces -- For editing
                    vim.opt_local.shiftwidth = spaces  -- For autoindent
                end
            end
        )
    end,
}

-- Fancier version of the builtin 'location' and 'progress' components
local progress_status = {
    function()
        -- Location
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local curr_col = vim.api.nvim_win_get_cursor(0)[2] + 1
        local lines = vim.api.nvim_buf_line_count(0)
        -- local location = string.format('%3d/%3d:%-2d', curr_line, lines, curr_col)
        local location = string.format("%3d:%-2d", curr_line, curr_col)

        -- Percentage
        local percent = ""
        if curr_line == 1 then
            percent = "Top"
        elseif curr_line == lines then
            percent = "Bot"
        else
            percent = string.format("%2d%%%%", math.floor(curr_line / lines * 100))
        end

        -- Progress bar
        local sbar = {}
        -- if vim.g.neovide then
        --     sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" } -- lower one eigth block -> full block
        -- else
        --     sbar = { "▔", "🮂", "🮃", "▀", "🮄", "🮅", "🮆", "█" } -- upper one eigth block -> full block
        -- end
        sbar = { "󰪞 ", "󰪟 ", "󰪠 ", "󰪡 ", "󰪢 ", "󰪣 ", "󰪤 ", "󰪥 " }
        local i = math.floor((curr_line - 1) / lines * #sbar) + 1
        local progress_bar = string.rep(sbar[i], 1)

        return location .. " " .. percent .. " " .. progress_bar
    end,
    -- icon = '',
}

-- Custom components to show current python environment
local env_status = {
    function()
        local current_env = "[-]" -- No environment
        local python_path = require("venv-selector").python() or vim.g.python3_host_prog

        if python_path ~= nil then
            -- Default environment from python path
            local Path = require("plenary.path")
            local tokens = Path._split(Path:new(python_path))

            -- Get the environment name from python path
            if #tokens > 2 then
                -- Standard path is .../[name]/bin/python, so get the third last token
                current_env = tokens[#tokens - 2]
            end
        end

        return current_env
    end,
    icon = "󰌠",
    on_click = function()
        if not is_clickable then return end
        -- require("swenv.api").pick_venv()
        vim.cmd [[VenvSelect]]
    end,
}

-- Custom component using session_manager
-- local sess_status = {
--     function()
--         local sess_utils = require("session_manager.utils")
--         if sess_utils.exists_in_session() then
--             return " "
--         end
--         return " "
--     end,
--     on_click = function()
--         if not is_clickable then return end
--         local sess = require("session_manager")
--         sess.save_current_session()
--         vim.notify("Session saved", vim.log.levels.INFO)
--     end,
-- }

-- Custom components using remote-nvim
-- local remote_status = {
--     function()
--         ---@diagnostic disable-next-line: undefined-field
--         return (vim.g.remote_neovim_host and vim.uv.os_gethostname()) or ""
--     end,
--     padding = { right = 1, left = 1 },
--     icon = "",
-- }

-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Modified status from builtin
-- ────────────────────────────────────────────────────────────────────────────────────────────────
local filename_mod = {
    "filename", -- builtin filename component
    path = 3,
    on_click = function()
        if not is_clickable then return end
        require("oil").open()
    end,
}

local filetype_mod = {
    "filetype", -- builtin filetype component
    on_click = function()
        if not is_clickable then return end
        vim.ui.select(
            vim.fn.getcompletion("", "filetype"),
            { prompt = "Select filetype" },
            function(ft) if ft ~= nil then vim.bo.filetype = ft end end
        )
        vim.cmd.LspRestart()
    end,
}

local fileformat_mod = {
    "fileformat",
    on_click = function()
        if not is_clickable then return end
        vim.ui.select(
            { "unix", "mac", "dos" },
            { prompt = "Select fileformat" },
            function(ff) if ff ~= nil then vim.opt_local.fileformat = ff end end
        )
    end,
}

local branch_mod = {
    "branch",
    icon = "󰘬",
    on_click = function()
        if not is_clickable then return end
        Snacks.picker.git_branches()
    end,
}

local diagnostics_mod = {
    "diagnostics",
    on_click = function()
        if not is_clickable then return end
        Snacks.picker.diagnostics_buffer()
    end,
}

local diff_mod = {
    "diff", -- builtin diff component
    symbols = { added = " ", modified = " ", removed = " " },
    on_click = function()
        if not is_clickable then return end
        if next(require("diffview.lib").views) == nil then
            vim.cmd("DiffviewOpen")
        else
            vim.cmd("DiffviewClose")
        end
    end,
}

local lsp_status_mod = {
    "lsp_status", -- builtin lsp status
    on_click = function()
        if not is_clickable then return end
        Snacks.picker.lsp_config()
    end,

}

local searchcount_mod = {
    "searchcount", -- builtin searchcount
    icon = "󰍉",
    cond = function() return vim.fn.searchcount().total > 0 end,
    on_click = function()
        if not is_clickable then return end
        vim.cmd("nohlsearch")
    end,
}

-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Main config
-- ────────────────────────────────────────────────────────────────────────────────────────────────
return {
    "nvim-lualine/lualine.nvim",
    -- event = { "BufReadPre", "BufNewFile", "BufEnter" },
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "sindrets/diffview.nvim", -- Clickable diffthis
    },
    opts = {
        options = {
            icons_enabled = true,
            theme = "auto",
            -- component_separators = {left='', right=''},
            -- section_separators = {left='', right=''},
            -- component_separators = { left = "", right = "" },
            -- section_separators = { left = "", right = "" },
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = { "snacks_dashboard" },
                winbar = { "NvimTree", "neo-tree", "Outline", "toggleterm", "alpha", "dap-repl", "packer" },
            },
            always_divide_middle = true,
            globalstatus = true,
        },
        sections = {
            lualine_a = {
                -- remote_status,
                { "mode", icon = "" },
            },
            lualine_b = {
                branch_mod,
                diff_mod,
                diagnostics_mod,
            },
            lualine_c = {
                filename_mod,
                -- sess_status,
            },
            lualine_x = {
                space_status,
                "encoding",
                fileformat_mod,
                filetype_mod,
                lsp_status_mod,
            },
            lualine_y = {
                searchcount_mod,
                progress_status,
            },
            lualine_z = {
                env_status,
                click_status,
                -- notify_stat,
            },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {}
        },
        -- winbar = {
        --     lualine_a = {},
        --     lualine_b = {},
        --     lualine_c = { { 'filename', path = 1, color = { bg = 'NONE' } }, navic_stat, },
        --     lualine_x = {},
        --     lualine_y = {},
        --     lualine_z = {}
        -- },
        -- inactive_winbar = {
        --     lualine_a = {},
        --     lualine_b = {},
        --     lualine_c = { { 'filename', path = 1, color = { bg = 'NONE' } }, },
        --     lualine_x = {},
        --     lualine_y = {},
        --     lualine_z = {}
        -- },
        tabline = {},
        -- extensions = { 'nvim-tree', 'neo-tree', 'quickfix', 'fugitive', 'symbols-outline', 'toggleterm', 'nvim-dap-ui' }
    },
}
