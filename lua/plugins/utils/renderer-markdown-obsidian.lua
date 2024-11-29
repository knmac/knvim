-- Writing and navigating an Obsidian vault
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
                        require("render-markdown").toggle()
                    end
                end,
                desc = "RenderMarkdown: Toggle rendering"
            },
        },
        config = function()
            require("render-markdown").setup({
                enabled = false,
                heading = {
                    icons = { "󰎥 ", "󰎨 ", "󰎫 ", "󰎲 ", "󰎯 ", "󰎴 " },
                },
                bullet = {
                    icons = { "", "", "◆", "◇" },
                },
                checkbox = {
                    custom = {
                        todo = { raw = "[~]", rendered = "󰥔 ", highlight = "@markup.raw" },
                    },
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
        opts = {
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
                        new_notes_location = "current_dir",
                        templates = {
                            folder = vim.NIL,
                        },
                        disable_frontmatter = true,
                    },
                },
            },
            -- { name = "global", path = "~" },
            mappings = {
                -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true, desc = "Obsidian: Go to file under the cursor" },
                },
                -- Toggle check-boxes
                ["<C-space>"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox({ " ", "x", "~" })
                    end,
                    opts = { buffer = true, desc = "Obsidian: Toggle checkboxes" },
                },
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
            -- daily_notes = {
            --     folder = "journal",
            --     date_format = "%Y-%m-%d",
            --     alias_format = "%B %-d, %Y",
            --     template = nil,
            -- },
            templates = {
                folder = "templates",
            },
        },
    },
}
