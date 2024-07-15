-- Writing and navigating an Obsidian vault

local toggle_checkbox = function(opts, line_num)
    -- Allow line_num to be optional, defaulting to the current line if not provided
    line_num = line_num or unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]

    local checkbox_pattern = "^%s*- %[.] "
    local checkboxes = opts or { " ", "x" }

    if not string.match(line, checkbox_pattern) then
        local unordered_list_pattern = "^(%s*)[-*+] (.*)"
        if string.match(line, unordered_list_pattern) then
            line = string.gsub(line, unordered_list_pattern, "%1- [ ] %2")
        else
            line = string.gsub(line, "^(%s*)", "%1- [ ] ")
        end
    else
        for i, check_char in require("obsidian.itertools").enumerate(checkboxes) do
            if string.match(line, "^%s*- %[" .. require("obsidian").util.escape_magic_characters(check_char) .. "%].*") then
                if i == #checkboxes then
                    i = 0
                end
                line = require("obsidian").util.string_replace(line, "- [" .. check_char .. "]",
                    "- [" .. checkboxes[i + 1] .. "]", 1)
                break
            end
        end
    end
    -- 0-indexed
    vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, { line })
end

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
            { "<leader>m", "<CMD>RenderMarkdownToggle<CR>", desc = "RenderMarkdown: Toggle rendering" },
            {
                "<C-space>",
                function()
                    return toggle_checkbox({ " ", "x", "~" })
                end,
                desc = "RenderMarkdown: Cycle through checkboxes"
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
                    name = "personal",
                    path = "~/Documents/vaults/personal",
                },
                -- { name = "global", path = "~" },
            },
            mappings = {
                -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true, desc = "Obsidian: Go to file under the cursor" },
                },
                -- Toggle check-boxes
                -- ["<C-space>"] = {
                --     action = function()
                --         return require("obsidian").util.toggle_checkbox()
                --     end,
                --     opts = { buffer = true, desc = "Obsidian: Toggle checkboxes" },
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
