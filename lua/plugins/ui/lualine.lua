-- Statusline at the bottom
local is_clickable = false
vim.api.nvim_create_user_command(
    "ToggleClickableLualine",
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
-- Show notification
-- local notify_stat = {
--     function()
--         return " "
--     end,
--     on_click = function(_, btn, _)
--         if not is_clickable then return end
--
--         if btn == "l" then
--             require("telescope").extensions.notify.notify()
--         elseif btn == "r" then
--             require("notify").dismiss()
--         end
--     end,
-- }

-- Show click
local click_stat = {
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
local fmt_stat = {
    icon = "󱁐",
    function()
        local stat = ""
        -- stat = stat .. "Spaces:" .. vim.opt_local.tabstop:get()
        stat = vim.opt_local.tabstop:get()
        return stat
    end,
    on_click = function()
        if not is_clickable then return end

        -- local spaces = tonumber(vim.fn.input('Local number of spaces per tab: '))
        -- vim.opt_local.tabstop = spaces
        -- vim.opt_local.softtabstop = spaces -- For editing
        -- vim.opt_local.shiftwidth = spaces  -- For autoindent
        vim.ui.select(
            { 2, 4, 8 },
            { prompt = "Local number of spaces per tab" },
            function(spaces)
                if (spaces ~= nil) then
                    vim.opt_local.tabstop = spaces
                    vim.opt_local.softtabstop = spaces -- For editing
                    vim.opt_local.shiftwidth = spaces  -- For autoindent
                end
            end
        )
    end,
}

-- Fancier version of the builtin 'location' and 'progress' components
local progress_stat = {
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
        if vim.g.neovide then
            sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" } -- lower one eigth block -> full block
        else
            sbar = { "▔", "🮂", "🮃", "▀", "🮄", "🮅", "🮆", "█" } -- upper one eigth block -> full block
        end
        local i = math.floor((curr_line - 1) / lines * #sbar) + 1
        local progress_bar = string.rep(sbar[i], 1)

        return location .. " " .. percent .. " " .. progress_bar
    end,
    -- icon = '',
}

-- Clickable version of builtin 'fileformat'
local fileformat_stat = {
    "fileformat",
    on_click = function()
        if not is_clickable then return end
        vim.ui.select(
            { "unix", "mac", "dos" },
            { prompt = "Select fileformat" },
            function(ff)
                if ff ~= nil then
                    vim.opt_local.fileformat = ff
                end
            end
        )
    end,
}

-- Custom components using swenv
local env_stat = {
    function()
        local swenv = require("swenv.api")
        local current_env = "[-]" -- No environment

        -- if swenv.get_current_venv() ~= nil then
        --     -- Environment loaded by swenv
        --     local _name = swenv.get_current_venv().name
        --     local _src = swenv.get_current_venv().source
        --     current_env = _name .. " (" .. _src .. ")"
        -- elseif vim.g.python3_host_prog ~= nil then
        if vim.g.python3_host_prog ~= nil then
            -- Default environment from python3_host_prog
            local Path = require("plenary.path")
            local tokens = Path._split(Path:new(vim.g.python3_host_prog))

            -- Get the environment name from python3_host_prog
            if #tokens > 2 then
                -- Standard path is .../[name]/bin/python, so get the third last token
                current_env = tokens[#tokens - 2]

                -- Check if python3_host_prog is registered in swenv and get its source
                for _, v in ipairs(swenv.get_venvs()) do
                    if v.name == current_env then
                        current_env = current_env .. " (" .. v.source .. ")"
                        break
                    end
                end
            end
        end

        return current_env
    end,
    icon = "󰌠",
    on_click = function()
        if not is_clickable then return end
        require("swenv.api").pick_venv()
    end,
}

-- Custom components using telescope
local filetype_stat = {
    "filetype", -- builtin filetype component
    on_click = function()
        if not is_clickable then return end
        require("telescope.builtin").filetypes()
        vim.cmd.LspRestart()
    end,
}

local branch_stat = {
    "branch",
    icon = "󰘬",
    on_click = function()
        if not is_clickable then return end
        require("telescope.builtin").git_branches()
    end,
}

local diagnostics_stat = {
    "diagnostics",
    on_click = function()
        if not is_clickable then return end
        require("telescope.builtin").diagnostics()
    end,
}

-- Custom components using gitsigns
local diff_stat = {
    "diff", -- builtin diff component
    symbols = { added = " ", modified = " ", removed = " " },
    on_click = function()
        if not is_clickable then return end
        vim.cmd("DiffviewOpen")
    end,
}

-- Custom components using remote-nvim
local remote_stat = {
    function()
        ---@diagnostic disable-next-line: undefined-field
        return (vim.g.remote_neovim_host and vim.uv.os_gethostname()) or ""
    end,
    padding = { right = 1, left = 1 },
    icon = "",
}

-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Main config
-- ────────────────────────────────────────────────────────────────────────────────────────────────
return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope.nvim", -- Switch filetype and git branches
        "AckslD/swenv.nvim",             -- Show and switch python env
        "sindrets/diffview.nvim",        -- Clickable diffthis
    },
    config = function()
        require("lualine").setup({
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
                    -- statusline = { "snacks_dashboard" },
                    statusline = {},
                    winbar = {
                        "NvimTree", "neo-tree", "Outline", "toggleterm", "alpha", "dap-repl",
                        "packer",
                    },
                },
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = {
                    remote_stat,
                    { "mode", icon = "" },
                },
                lualine_b = {
                    branch_stat,
                    diff_stat,
                    diagnostics_stat,
                },
                lualine_c = {
                    { "filename", path = 3, },
                    { "searchcount", icon = "󰍉", },
                },
                lualine_x = {
                    fmt_stat,
                    "encoding",
                    fileformat_stat,
                    filetype_stat,
                },
                lualine_y = {
                    progress_stat,
                },
                lualine_z = {
                    env_stat,
                    click_stat,
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
        })
    end,
}
