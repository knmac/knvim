-- Colorschemecat
return {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
        require("catppuccin").setup({
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
            transparent_background = false,
            show_end_of_buffer = true,
            term_colors = true,
            -- dim_inactive = {
            --     enabled = false,
            --     shade = "dark",
            --     percentage = 0.15,
            -- },
            styles = {
                comments = { "italic" },
                conditionals = { "bold" },
                loops = { "bold" },
                functions = { "bold", "italic" },
                keywords = { "bold", "italic" },
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
            integrations = {
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                barbar = true,
                blink_cmp = true,
                colorful_winsep = {
                    enabled = true,
                    color = "mauve",
                },
                -- dropbar = {
                --     enabled = true,
                --     color_mode = true,
                -- },
                -- noice = true,
                -- notify = true,
                snacks = {
                    enabled = true,
                    indent_scope_color = "lavender",
                },
                -- symbols_outline = true,
                rainbow_delimiters = true,
                -- which_key = true,
            }
        })

        vim.cmd.colorscheme("catppuccin")
    end,
}
