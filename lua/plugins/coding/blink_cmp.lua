--- Experimental function to render markdown doc (for documentation)
local render_markdown_doc = function(opts)
    local buf = opts.window:get_buf()
    local item = opts.item
    local lines = {}

    if item.detail and item.detail ~= "" then
        vim.list_extend(lines, vim.split(item.detail, "\n"))
    end

    local doc = item.documentation
    if doc then
        if #lines > 0 then table.insert(lines, "---") end
        if type(doc) == "string" then
            vim.list_extend(lines, vim.split(doc, "\n"))
        elseif type(doc) == "table" and doc.value then
            vim.list_extend(lines, vim.split(doc.value, "\n"))
        end
    end

    if #lines == 0 then return end

    vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
    vim.lsp.util.stylize_markdown(buf, lines, {})
    vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
end

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
            opts = { symbol_map = vim.g.knvim_symbol_map },
        },
    },
    version = "*",
    opts = {
        keymap = {
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-y>"] = { "select_and_accept" },
            ["<C-c>"] = { "hide", "fallback" },
            ["<CR>"] = { "select_and_accept", "fallback" },
            -- ["<CR>"] = { "accept", "fallback" },
            ["<Tab>"] = {
                function() -- sidekick next edit suggestion (NES)
                    return require("sidekick").nes_jump_or_apply()
                end,
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
            -- ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
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
                                    -- icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol", })
                                    icon = require("lspkind").symbol_map[ctx.kind]
                                end

                                return icon .. ctx.icon_gap
                            end,
                        },
                    },
                },
                -- border = "rounded",
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 100,
                treesitter_highlighting = true,
                draw = render_markdown_doc,
                -- window = { border = "rounded" },
            },
            ghost_text = { enabled = true },
        },
        -- Experimental signature help support
        signature = {
            enabled = false,
            -- window = { border = "rounded", },
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
