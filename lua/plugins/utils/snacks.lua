return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        { "<leader>z", function() require("snacks").zen() end,                   desc = "Snacks: Toggle Zen Mode" },
        { "<leader>Z", function() require("snacks").zen.zoom() end,              desc = "Snacks: Toggle Zoom" },
        { "<leader>n", function() require("snacks").notifier.hide() end,         desc = "Snacks: Dismiss All Notifications" },
        { "<leader>N", function() require("snacks").notifier.show_history() end, desc = "Snacks: Notification History" },
        { "<C-\\>",    function() require("snacks").terminal() end,              desc = "Snacks: Toggle Terminal" },
        { "<leader>g", function() require("snacks").lazygit() end,               desc = "Snacks: Lazygit" },
    },
    opts = {
        -- ────────────────────────────────────────────────────────────────────────────────────────
        bigfile = {
            enabled = true,
            size = 1.5 * 1024 * 1024, -- 1.5MB
            notify = true,
            setup = function(ctx)
                vim.cmd([[NoMatchParen]])
                require("snacks").util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
                vim.b.minianimate_disable = true
                vim.b.snacks_scroll = false
                vim.b.snacks_dim = false
                vim.schedule(function()
                    vim.bo[ctx.buf].syntax = ctx.ft
                end)
            end,
        },
        -- ────────────────────────────────────────────────────────────────────────────────────────
        dashboard = {
            enabled = true,
            preset = {
                keys = {
                    --
                    { icon = "󰝒 ", key = "e", desc = "Edit a new file", action = ":ene | startinsert" },
                    { icon = " ", key = "o", desc = "Open an old file", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = "󰱼 ", key = "f", desc = "Find file", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = "󱎸 ", key = "g", desc = "Grep text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = "󰺄 ", key = "s", desc = "Session manager", action = ":Telescope persisted" },
                    { icon = " ", key = "r", desc = "Remote manager", action = ":RemoteStart" },
                    --
                    { icon = "󰓙 ", key = "h", desc = "Health check", action = ":checkhealth" },
                    { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    --
                    { icon = " ", key = "c", desc = "Config", action = ":cd " .. vim.fn.stdpath("config") .. " | e $MYVIMRC" },
                    {
                        icon = " ",
                        key = "p",
                        desc = "Pull knvim",
                        action = ":!git --git-dir=" ..
                            vim.fn.stdpath("config") .. "/.git --work-tree=" .. vim.fn.stdpath("config") .. " pull"
                    },
                    {
                        icon = " ",
                        key = "?",
                        desc = "Cheatsheet",
                        action = ":e " .. vim.fn.stdpath("config") .. "/cheatsheet.md | Outline!"
                    },
                    --
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
                header = [[
██╗  ██╗███╗   ██╗██╗   ██╗██╗███╗   ███╗
██║ ██╔╝████╗  ██║██║   ██║██║████╗ ████║
█████╔╝ ██╔██╗ ██║██║   ██║██║██╔████╔██║
██╔═██╗ ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║  ██╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
]] ..
                    "───── Neovim v" ..
                    vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch ..
                    " ─────",
            },
            sections = {
                { section = "header" },
                { section = "keys",   gap = 1, padding = 1 },
                { section = "startup" },
            },
        },
        -- ────────────────────────────────────────────────────────────────────────────────────────
        terminal = {
            enabled = true,
        },
        lazygit = { enabled = true },
        -- ────────────────────────────────────────────────────────────────────────────────────────
        indent = {
            enabled = true,
            scope = {
                enabled = true,
                priority = 200,
                char = "│",
                -- char = "▎",
                underline = true,    -- underline the start of the scope
                only_current = true, -- only show scope in the current window
            },
        },
        -- ────────────────────────────────────────────────────────────────────────────────────────
        input = { enabled = true },
        notifier = { enabled = true, top_down = false, },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        -- statuscolumn = { enabled = true },
        -- words = { enabled = true },
        zen = { enabled = true },
    },
}
