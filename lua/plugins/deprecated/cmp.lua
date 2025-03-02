-- Code completion
return {
    "hrsh7th/nvim-cmp", -- code completion
    event = { "CmdlineEnter", "InsertEnter" },
    -- event = "VeryLazy",
    dependencies = {
        {
            "hrsh7th/cmp-nvim-lsp", -- source for neovim's built-in language server client
            event = { "CmdlineEnter", "InsertEnter" },
        },
        {
            "hrsh7th/cmp-buffer", -- source for buffer words
            event = { "CmdlineEnter", "InsertEnter" },
        },
        {
            "hrsh7th/cmp-path", -- source for filesystem paths
            event = { "CmdlineEnter", "InsertEnter" },
        },
        {
            "hrsh7th/cmp-cmdline", -- source for vim's cmdline
            event = { "CmdlineEnter", "InsertEnter" },
        },
        {
            -- "hrsh7th/cmp-nvim-lsp-signature-help", -- source for displaying function signatures with the current parameter emphasized
            "hrsh7th/cmp-calc", -- source for math calculation
            event = { "CmdlineEnter", "InsertEnter" },
        },
        {
            "onsails/lspkind-nvim", -- pictogram for LSP
            event = { "CmdlineEnter", "InsertEnter" },
        },
        {
            -- snippets plugin
            "L3MON4D3/LuaSnip",
            event = { "CmdlineEnter", "InsertEnter" },
            version = "v2.*",
            build = "make install_jsregexp",
        },
        {
            "saadparwaiz1/cmp_luasnip", -- snippets source for nvim-cmp
            event = { "CmdlineEnter", "InsertEnter" },
        },
        {
            "rafamadriz/friendly-snippets", -- Snippets collection for a set of different programming languages
            event = { "CmdlineEnter", "InsertEnter" },
        },
    },
    config = function()
        local cmp = require("cmp")

        -- Navigate to the next item in the list
        local next_item = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
                require("luasnip").expand_or_jump()
            elseif require("neogen").jumpable() then
                require("neogen").jump_next()
            else
                fallback()
            end
        end

        -- Navigate to the next item in the list
        local prev_item = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
                require("luasnip").jump(-1)
            elseif require("neogen").jumpable(true) then
                require("neogen").jump_prev()
            else
                fallback()
            end
        end

        -- Main config
        cmp.setup({
            snippet = {
                expand = function(args)
                    -- vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn['UltiSnips#Anon'](args.body) -- For `ultisnips` users.
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"]     = cmp.mapping.scroll_docs(-4),
                ["<C-j>"]     = cmp.mapping.scroll_docs(4),
                ["<C-u>"]     = cmp.mapping.scroll_docs(-4),
                ["<C-d>"]     = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-c>"]     = cmp.mapping.abort(),
                ["<CR>"]      = cmp.mapping.confirm({ select = false }),
                ["<Tab>"]     = cmp.mapping(next_item, { "i", "s" }),
                ["<S-Tab>"]   = cmp.mapping(prev_item, { "i", "s" }),
                ["<C-n>"]     = cmp.mapping(next_item, { "i", "s" }),
                ["<C-p>"]     = cmp.mapping(prev_item, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
                -- { name = "nvim_lsp_signature_help" },
                { name = "calc" },
                -- { name = "neorg" },
                -- { name = 'vsnip' }, -- For vsnip users.
                { name = "luasnip" }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
            }),
            formatting = {
                format = require("lspkind").cmp_format({
                    mode = "symbol_text",
                    preset = "codicons",
                }),
            },
            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.kind,
                    cmp.config.compare.recently_used,
                },
            },
        })

        -- `/` cmdline setup.
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
                { { name = "path" } },
                { { name = "cmdline" } }
            ),
            matching = { disallow_symbol_nonprefix_matching = false },
        })

        -- Load snippets for luasnip
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
