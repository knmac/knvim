return {
    "saghen/blink.cmp",
    event = { "CmdlineEnter", "InsertEnter" },
    dependencies = {
        {
            "rafamadriz/friendly-snippets",
            event = { "CmdlineEnter", "InsertEnter" },
        },
        {
            "onsails/lspkind.nvim",
            event = { "CmdlineEnter", "InsertEnter" },
            opts = {
                symbol_map = {
                    Array = "󰅪",
                    Boolean = "",
                    BreakStatement = "󰙧",
                    Call = "󰃷",
                    CaseStatement = "󱃙",
                    Class = "",
                    Color = "󰏘",
                    Constant = "󰏿",
                    Constructor = "",
                    ContinueStatement = "→",
                    Copilot = "",
                    Declaration = "󰙠",
                    Delete = "󰩺",
                    DoStatement = "󰑖",
                    Enum = "",
                    EnumMember = "",
                    Event = "",
                    Field = "",
                    File = "󰈔",
                    Folder = "󰉋",
                    ForStatement = "󰑖",
                    Function = "󰊕",
                    H1Marker = "󰉫", -- Used by markdown treesitter parser
                    H2Marker = "󰉬",
                    H3Marker = "󰉭",
                    H4Marker = "󰉮",
                    H5Marker = "󰉯",
                    H6Marker = "󰉰",
                    Identifier = "󰀫",
                    IfStatement = "󰇉",
                    Interface = "",
                    Keyword = "󰌋",
                    List = "󰅪",
                    Log = "󰦪",
                    Lsp = "",
                    Macro = "󰁌",
                    MarkdownH1 = "󰉫", -- Used by builtin markdown source
                    MarkdownH2 = "󰉬",
                    MarkdownH3 = "󰉭",
                    MarkdownH4 = "󰉮",
                    MarkdownH5 = "󰉯",
                    MarkdownH6 = "󰉰",
                    Method = "󰆧",
                    Module = "󰏗",
                    Namespace = "󰅩",
                    Null = "󰢤",
                    Number = "󰎠",
                    Object = "󰅩",
                    Operator = "󰆕",
                    Package = "󰆦",
                    Pair = "󰅪",
                    Property = "",
                    Reference = "󰦾",
                    Regex = "",
                    Repeat = "󰑖",
                    Scope = "󰅩",
                    Snippet = "󰩫",
                    Specifier = "󰦪",
                    Statement = "󰅩",
                    String = "󰉾",
                    Struct = "",
                    SwitchStatement = "󰺟",
                    Table = "󰅩",
                    Terminal = "",
                    Text = "",
                    Type = "",
                    TypeParameter = "󰆩",
                    Unit = "",
                    Value = "󰎠",
                    Variable = "󰀫",
                    WhileStatement = "󰑖",
                },
            },
        },
    },
    version = "*",
    opts = {
        keymap = {
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-y>"] = { "select_and_accept" },
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
            ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
            ["<C-n>"] = { "select_next", "fallback_to_mappings" },
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        },
        completion = {
            keyword = { range = "full" },
            accept = { auto_brackets = { enabled = false }, },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = true,
                },
            },
            menu = {
                auto_show = true,
                draw = {
                    columns = {
                        { "label",     "label_description", gap = 1 },
                        { "kind_icon", "kind",              gap = 1 },
                    },
                    components = {
                        kind_icon = {
                            ellipsis = false,
                            text = function(ctx)
                                local icon = ctx.kind_icon
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        icon = dev_icon
                                    end
                                else
                                    icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol", })
                                end

                                return icon .. ctx.icon_gap
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
            enabled = true,
            window = { border = "rounded", },
        },
        cmdline = {
            completion = {
                menu = { auto_show = true },
                ghost_text = { enabled = false },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = true,
                    },
                },
            },
        },
    },
    -- opts_extend = { "sources.default" }
}
