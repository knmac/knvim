-- Writing and navigating an Obsidian vault
local palettes = require("catppuccin.palettes").get_palette()

return {
    -- Render markdown
    {
        "MeanderingProgrammer/markdown.nvim",
        name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
        ft = "markdown",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            {
                "<leader>m",
                function()
                    if vim.bo.filetype == "markdown" then
                        vim.cmd [[RenderMarkdown buf_toggle]]
                        -- require("render-markdown").toggle()
                    end
                end,
                desc = "RenderMarkdown: Toggle rendering of the current buffer"
            },
            {
                "<leader>M",
                function()
                    if vim.bo.filetype == "markdown" then
                        vim.cmd [[RenderMarkdown preview]]
                        vim.cmd [[wincmd l]]
                        vim.cmd [[RenderMarkdown buf_enable]]
                        vim.cmd [[wincmd h]]
                    end
                end,
                desc = "RenderMarkdown: Toggle preview mode"
            },
        },
        init = function()
            require("render-markdown").setup({
                enabled = false, -- Only render markdown on <leader>m
                anti_conceal = { enabled = false },
                heading = { icons = { "󰎥 ", "󰎨 ", "󰎫 ", "󰎲 ", "󰎯 ", "󰎴 " } },
                bullet = { icons = { "", "", "◆", "◇" } },
                checkbox = {
                    custom = {
                        inprogress = { raw = "[~]", rendered = "󰏭 ", highlight = "RenderMarkdownInfo" },
                        urgent = { raw = "[!]", rendered = "󰳤 ", highlight = "RenderMarkdownWarn", scope_highlight = "@text.warning" },
                        postponed = { raw = "[>]", rendered = "󱋭 ", highlight = "RenderMarkdownError", scope_highlight = "markdownStrikeDelimiter" },
                    },
                },
                -- indent = { enabled = true, icon = "│" },
                -- indent = { enabled = true, icon = "" },
                inline_highlight = { highlight = "@text.warning" },
                latex = { enabled = false },
            })
        end,
    },
    -- Obsidian helper
    {
        -- "epwalsh/obsidian.nvim",
        "obsidian-nvim/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
        --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        --   "BufReadPre path/to/my-vault/**.md",
        --   "BufNewFile path/to/my-vault/**.md",
        -- },
        -- dependencies = {
        --     "nvim-lua/plenary.nvim",
        -- },
        --
        opts = {
            legacy_commands = false,
            workspaces = {
                {
                    name = "work",
                    path = "~/Documents/vaults/work",
                },
                {
                    name = "no-vault",
                    path = function()
                        -- alternatively use the CWD:
                        -- return assert(vim.fn.getcwd())
                        return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
                    end,
                    overrides = {
                        notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
                        daily_notes = { folder = vim.NIL },
                        new_notes_location = "current_dir",
                        templates = { folder = vim.NIL },
                    },
                },
            },
            ui = {
                enable = false, -- In favor for render-markdown
                -- checkboxes = {},
                -- bullets = {},
                -- checkboxes = {
                --     [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                --     ["x"] = { char = "󰄲", hl_group = "ObsidianDone" },
                -- },
                -- reference_text = { hl_group = "ObsidianRefText" },
                -- highlight_text = { hl_group = "ObsidianHighlightText" },
                -- tags = { hl_group = "ObsidianTag" },
                -- hl_groups = {
                --     ObsidianExtLinkIcon = { fg = palettes.lavender },
                --     ObsidianHighlightText = { bg = palettes.yellow, fg = palettes.base },
                --     ObsidianDone = { bold = true, fg = palettes.green },
                --     ObsidianTodo = { bold = true, fg = palettes.rosewater },
                --     ObsidianTilde = { bold = true, fg = palettes.red },
                --     ObsidianBullet = { bold = true, fg = palettes.sapphire },
                --     ObsidianTag = { italic = true, fg = palettes.sapphire },
                --     ObsidianImportant = { bold = true, fg = palettes.red },
                --     ObsidianRightArrow = { bold = true, fg = palettes.rosewater },
                --     ObsidianBlockID = { italic = true, fg = palettes.sapphire },
                --     ObsidianRefText = { underline = true, fg = palettes.lavender },
                -- },
            },
            daily_notes = {
                folder = "journal",
                date_format = "%Y-%m-%d",
                alias_format = "%B %-d, %Y",
                template = nil,
            },
            templates = {
                folder = "templates",
            },
            completion = {
                -- Enables completion using nvim_cmp
                nvim_cmp = false,
                -- Enables completion using blink.cmp
                blink = true,
                -- Trigger completion at 2 chars.
                min_chars = 2,
                -- Set to false to disable new note creation in the picker
                create_new = true,
            },
        },
    },
}
