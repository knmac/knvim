return {
    "saghen/blink.cmp",
    enabled = function() return vim.g.knvim_completion_engine == "blink" end,
    event = { "CmdlineEnter", "InsertEnter" },
    dependencies = {
        {
            "rafamadriz/friendly-snippets",
            event = { "CmdlineEnter", "InsertEnter" },
        },
        {
            "onsails/lspkind.nvim",
            event = { "CmdlineEnter", "InsertEnter" },
        },
    },
    version = "*",
    opts = {
        keymap = {
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-c>"] = { "hide", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
            ["<Tab>"] = {
                function(cmp) return cmp.select_next() end,
                "snippet_forward",
                "fallback",
            },
            ["<S-Tab>"] = {
                function(cmp) return cmp.select_prev() end,
                "snippet_backward",
                "fallback",
            },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "scroll_documentation_up", "fallback" },
            ["<C-j>"] = { "scroll_documentation_down", "fallback" },
            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        },
        completion = {
            keyword = { range = "full" },
            accept = { auto_brackets = { enabled = false }, },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = true,
                    -- preselect = function(ctx) return ctx.mode ~= "cmdline" end,
                    -- auto_insert = function(ctx) return ctx.mode ~= "cmdline" end,
                },
            },
            menu = {
                auto_show = true,
                draw = {
                    columns = {
                        { "label",     "label_description", gap = 1 },
                        { "kind_icon", "kind" },
                    },
                    components = {
                        kind_icon = {
                            text = function(item)
                                local kind = require("lspkind").symbol_map[item.kind] or ""
                                return kind .. " "
                            end,
                        },
                    },
                },
                border = "rounded",
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 100,
                window = { border = "rounded" },
            },
            ghost_text = { enabled = true },
        },
        -- Experimental signature help support
        signature = {
            enabled = false,
            window = { border = "rounded", },
        }
    },
    opts_extend = { "sources.default" }
}
