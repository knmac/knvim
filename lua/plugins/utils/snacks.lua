-- Collection of some nvim utilities

-- Disable indent for markdown
vim.api.nvim_create_autocmd("FileType", {
    desc = "Disable indent for markdown",
    pattern = { "markdown" },
    group = vim.api.nvim_create_augroup("snacks_group", { clear = false }),
    callback = function()
        vim.b.snacks_indent = false
    end,
})

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        -- Misc ───────────────────────────────────────────────────────────────────────────────────
        { "<leader>z",      function() Snacks.zen() end,                         desc = "Snacks: Toggle Zen Mode" },
        { "<leader>Z",      function() Snacks.zen.zoom() end,                    desc = "Snacks: Toggle Zoom" },
        { "<leader>n",      function() Snacks.notifier.hide() end,               desc = "Snacks: Dismiss All Notifications" },
        { "<leader>N",      function() Snacks.notifier.show_history() end,       desc = "Snacks: Notification History" },
        { "<leader>g",      function() Snacks.lazygit() end,                     desc = "Snacks: Lazygit" },
        { "<leader>s",      function() Snacks.scratch() end,                     desc = "Snacks: Toggle Scratch Buffer" },
        { "<leader>S",      function() Snacks.scratch.select() end,              desc = "Snacks: Select Scratch Buffer" },
        { "<C-\\>",         function() Snacks.terminal() end,                    desc = "Snacks: Toggle Terminal",          mode = { "n", "t" } },
        { "<C-y>",          function() Snacks.terminal.toggle({ "yazi" }) end,   desc = "Snacks: Open Yazi" },
        -- Pickers ────────────────────────────────────────────────────────────────────────────────
        { "<space><space>", function() Snacks.picker() end,                      desc = "Picker: pickers" },
        { "<space>f",       function() Snacks.picker.files() end,                desc = "Picker: Find files" },
        { "<space>t",       function() Snacks.picker.grep() end,                 desc = "Picker: Find text" },
        { "<space>b",       function() Snacks.picker.buffers() end,              desc = "Picker: Find buffer" },
        { "<space>*",       function() Snacks.picker.grep_word() end,            desc = "Picker: Find hovered word" },
        { "<space>/",       function() Snacks.picker.grep_buffers() end,         desc = "Picker: Find in open buffers" },
        -- { "<space>c",       "<CMD>Telescope bibtex<CR>",                       desc = "Snacks: Find bibtex" },
        -- { "<space>v",       "<CMD>Telescope vim_options<CR>",                  desc = "Snacks: Find vim option" },
        { "<space>h",       function() Snacks.picker.help() end,                 desc = "Picker: Find help" },
        { "<space>k",       function() Snacks.picker.keymaps() end,              desc = "Picker: Find key map" },
        { "<space>c",       function() Snacks.picker.commands() end,             desc = "Picker: Find command" },
        { "<space>m",       function() Snacks.picker.marks() end,                desc = "Picker: Find marks" },
        { "<space>r",       function() Snacks.picker.registers() end,            desc = "Picker: Find registers" },
        -- LSP ────────────────────────────────────────────────────────────────────────────────────
        { "<space>d",       function() Snacks.picker.diagnostics() end,          desc = "LSP: Show all diagnostics" },
        { "gd",             function() Snacks.picker.lsp_definitions() end,      desc = "LSP: Go to definition" },
        { "gD",             function() Snacks.picker.lsp_declarations() end,     desc = "LSP: Go to declarations" },
        { "gi",             function() Snacks.picker.lsp_implementations() end,  desc = "LSP: Go to implementation" },
        { "gr",             function() Snacks.picker.lsp_references() end,       desc = "LSP: Go to references" },
        { "gy",             function() Snacks.picker.lsp_type_definitions() end, desc = "LSP: Go to type definition" },
        { "gs",             function() Snacks.picker.lsp_symbols() end,          desc = "LSP: Go to symbols" },
    },
    opts = {
        -- ────────────────────────────────────────────────────────────────────────────────────────
        bigfile = {
            enabled = true,
            size = 1.5 * 1024 * 1024, -- 1.5MB
            notify = true,
            setup = function(ctx)
                vim.cmd([[NoMatchParen]])
                Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
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
                    { icon = " ", key = "r", desc = "Open a recent file", action = ":lua Snacks.dashboard.pick('recent')" },
                    { icon = "󰱼 ", key = "f", desc = "Find file", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = "󱎸 ", key = "g", desc = "Grep text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = "󰺄 ", key = "s", desc = "Session manager", action = ":SessionManager" },
                    -- { icon = "󰺄 ", key = "s", desc = "Session manager", action = ":lua Snacks.dashboard.pick('projects')" },
                    -- { icon = " ", key = "r", desc = "Remote manager", action = ":RemoteStart" },
                    --
                    { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = " ", key = "m", desc = "Mason", action = ":Mason" },
                    { icon = "󰓙 ", key = "h", desc = "Health check", action = ":checkhealth" },
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
        statuscolumn = {
            enabled = true,
            folds = {
                open = true,   -- show open fold icons
                git_hl = true, -- use Git Signs hl for fold icons
            },
        },
        -- ────────────────────────────────────────────────────────────────────────────────────────
        picker = {
            enabled = true,
            ui_select = true, -- replace `vim.ui.select` with the snacks picker
        },
        -- ────────────────────────────────────────────────────────────────────────────────────────
        terminal = { enabled = true },
        lazygit = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true, top_down = false, },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        zen = { enabled = true },
        -- words = { enabled = true },
    },
}
