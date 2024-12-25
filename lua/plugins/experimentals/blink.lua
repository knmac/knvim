return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim",
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
        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono"
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            cmdline = function()
                local type = vim.fn.getcmdtype()
                -- Search forward and backward
                if type == "/" or type == "?" then
                    return { "buffer" }
                end
                -- Commands
                if type == ":" then
                    return { "cmdline" }
                end
                return {}
            end,
            providers = {
                lsp = {
                    min_keyword_length = 0, -- Number of characters to trigger porvider
                    score_offset = 0,       -- Boost/penalize the score of the items
                },
                path = {
                    min_keyword_length = 0,
                },
                snippets = {
                    min_keyword_length = 2,
                },
                buffer = {
                    min_keyword_length = 5,
                    max_items = 5,
                },
            },
        },
        completion = {
            keyword = { range = "full" },
            accept = { auto_brackets = { enabled = false }, },
            list = {
                selection = function(ctx)
                    return ctx.mode == "cmdline" and "auto_insert" or "preselect"
                end,
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
                            highlight = "CmpItemKind",
                        },
                        label = {
                            text = function(item)
                                return item.label
                            end,
                            highlight = "CmpItemAbbr",
                        },
                        kind = {
                            text = function(item)
                                return item.kind
                            end,
                            highlight = "CmpItemKind",
                        },
                    },
                },
                border = "rounded",
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 100,
                treesitter_highlighting = true,
                window = { border = "rounded" },
            },
            ghost_text = { enabled = true },
        },
        -- Experimental signature help support
        signature = {
            enabled = false,
            trigger = {
                blocked_trigger_characters = {},
                blocked_retrigger_characters = {},
                -- When true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
                show_on_insert_on_trigger_character = true,
            },
            window = {
                min_width = 1,
                max_width = 100,
                max_height = 10,
                border = "rounded",
                winblend = 0,
                winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
                scrollbar = true, -- Note that the gutter will be disabled when border ~= 'none'
                -- Which directions to show the window,
                -- falling back to the next direction when there's not enough space,
                -- or another window is in the way
                direction_priority = { "n", "s" },
                -- Disable if you run into performance issues
                treesitter_highlighting = true,
            },
        }
    },
    opts_extend = { "sources.default" }
}
