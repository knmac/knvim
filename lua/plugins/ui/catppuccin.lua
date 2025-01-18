-- Colorschemecat
return {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
        require("catppuccin").setup({
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
            transparent_background = false,
            term_colors = true,
            dim_inactive = {
                enabled = false,
                shade = "dark",
                percentage = 0.15,
            },
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
                barbar = true,
                blink_cmp = true,
                cmp = true,
                colorful_winsep = {
                    enabled = true,
                    color = "mauve",
                },
                dropbar = {
                    enabled = true,
                    color_mode = true,
                },
                gitsigns = true,
                leap = true,
                neotree = true,
                noice = true,
                notify = true,
                nvimtree = true,
                snacks = true,
                symbols_outline = true,
                treesitter = true,
                rainbow_delimiters = true,
                which_key = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false,
                },
                navic = {
                    enabled = true,
                    custom_bg = "NONE",
                },
                dap = {
                    enabled = true,
                    enable_ui = true, -- enable nvim-dap-ui
                },
                window_picker = true,
            }
        })

        vim.cmd.colorscheme("catppuccin")
        vim.cmd.highlight("DiagnosticUnderlineError gui=undercurl") -- use undercurl for error, if supported by terminal
    end,
}
