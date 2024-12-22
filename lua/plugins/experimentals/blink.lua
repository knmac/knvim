return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",

    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- See the full "keymap" documentation for information on defining your own keymap.
        keymap = { preset = "default" },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- Will be removed in a future release
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "Nerd Font Mono"
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },

        completion = {
            -- 'prefix' will fuzzy match on the text before the cursor
            -- 'full' will fuzzy match on the text before *and* after the cursor
            -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
            keyword = { range = "full" },

            -- Disable auto brackets
            -- NOTE: some LSPs may add auto brackets themselves anyway
            accept = { auto_brackets = { enabled = false }, },

            -- Insert completion item on selection, don't select by default
            list = { selection = "auto_insert" },

            menu = {
                -- Don't automatically show the completion menu
                auto_show = true,

                -- nvim-cmp style menu
                draw = {
                    columns = {
                        { "label",    "label_description", gap = 1 },
                        { "kind_icon" },
                        { "kind" }
                    },
                },
                border = "rounded",
                winblend = 0,
            },

            -- Show documentation when selecting a completion item
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 100,
                window = { border = "rounded", winblend = 0, },
            },

            -- Display a preview of the selected item on the current line
            ghost_text = { enabled = true },
        },

        -- Experimental signature help support
        signature = {
            enabled = true,
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
                scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
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
