-- Writing and navigating an Obsidian vault
return {
    -- Render markdown
    {
        "MeanderingProgrammer/markdown.nvim",
        name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
        ft = "markdown",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "<leader>m", "<CMD>RenderMarkdownToggle<CR>", desc = "Toggle markdown rendering" },
        },
        config = function()
            require("render-markdown").setup({
                -- Configure whether Markdown should be rendered by default or not
                start_enabled = false,
                -- Character to use for the bullet points in lists
                bullets = { "", "", "◆", "◇" },
                checkbox = {
                    -- Character that will replace the [ ] in unchecked checkboxes
                    unchecked = "󰄱 ",
                    -- Character that will replace the [x] in checked checkboxes
                    checked = "󰄲 ",
                },
                conceal = {
                    -- conceallevel used for buffer when not being rendered, get user setting
                    default = vim.opt.conceallevel:get(),
                    -- conceallevel used for buffer when being rendered
                    rendered = 2,
                },
            })
        end,
    },
    -- Obsidian helper
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        -- lazy = true,
        ft = "markdown",
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
        --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        --   "BufReadPre path/to/my-vault/**.md",
        --   "BufNewFile path/to/my-vault/**.md",
        -- },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            {
                "<C-space>",
                function() return require("obsidian").util.toggle_checkbox() end,
                desc = "Toggle markdown checkboxes"
            },
        },
        opts = {
            workspaces = {
                {
                    name = "work",
                    path = "~/Documents/vaults/work",
                },
                {
                    name = "personal",
                    path = "~/Documents/vaults/personal",
                },
            },
            mappings = {
                -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
                -- ["gf"] = {
                --     action = function()
                --         return require("obsidian").util.gf_passthrough()
                --     end,
                --     opts = { noremap = false, expr = true, buffer = true },
                -- },
                -- Toggle check-boxes
                -- ["<C-space>"] = {
                --     action = function()
                --         return require("obsidian").util.toggle_checkbox()
                --     end,
                --     opts = { buffer = true },
                -- },
            },
            ui = {
                enable = true,
                checkboxes = {},
                bullets = {},
                -- checkboxes = {
                --     [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                --     ["x"] = { char = "󰄲", hl_group = "ObsidianDone" },
                -- },
                -- reference_text = { hl_group = "ObsidianRefText" },
                -- highlight_text = { hl_group = "ObsidianHighlightText" },
                -- tags = { hl_group = "ObsidianTag" },
                hl_groups = {
                    ObsidianTodo = { bold = true, fg = "#ed8796" },
                    ObsidianDone = { bold = true, fg = "#a6da95" },
                    ObsidianRefText = { underline = true, fg = "#b7bdf8" },
                    ObsidianTag = { italic = true, fg = "#7dc4e4" },
                    ObsidianHighlightText = { bg = "#eed49f", fg = "#24273a" },
                },
            },
            daily_notes = {
                folder = "journal",
                date_format = "%Y-%m-%d",
                alias_format = "%B %-d, %Y",
                template = nil,
            },
        },
    },
}
