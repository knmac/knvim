-- Colorize color code
return {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    -- event = "VeryLazy",
    config = function()
        require("colorizer").setup({
            -- filetypes = { "*" },
            -- user_default_options = {
            --     RGB = false,         -- #RGB hex codes
            --     RRGGBB = true,       -- #RRGGBB hex codes
            --     names = false,       -- "Name" codes like Blue or blue
            --     RRGGBBAA = false,    -- #RRGGBBAA hex codes
            --     AARRGGBB = false,    -- 0xAARRGGBB hex codes
            --     rgb_fn = false,      -- CSS rgb() and rgba() functions
            --     hsl_fn = false,      -- CSS hsl() and hsla() functions
            --     css = false,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            --     css_fn = false,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
            --     -- Available modes for `mode`: foreground, background,  virtualtext
            --     mode = "background", -- Set the display mode.
            --     -- Available methods are false / true / "normal" / "lsp" / "both"
            --     -- True is same as normal
            --     tailwind = false,                                -- Enable tailwind colors
            --     -- parsers can contain values used in |user_default_options|
            --     sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
            --     virtualtext = "■",
            --     -- update color values even if buffer is not focused
            --     -- example use: cmp_menu, cmp_docs
            --     always_update = false
            -- },
            -- -- all the sub-options of filetypes apply to buftypes
            -- buftypes = {},
            --
            options = {
                parsers = {
                    css = false,                  -- preset: enables names, hex, rgb, hsl, oklch
                    css_fn = false,               -- preset: enables rgb, hsl, oklch
                    names = { enable = false },   -- Blue
                    hex = { enable = false },      -- #123456
                    rgb = { enable = true },      -- rgb(255, 0, 0)
                    hsl = { enable = true },      -- hsl(120, 50, 50)
                    oklch = { enable = true },    -- oklch(40.1% 0.123 21.57)
                    tailwind = { enable = true }, -- bg-sky-500
                    sass = { enable = true },
                    xterm = { enable = true },
                },
                display = {
                    mode = "background",
                    -- virtualtext = { position = "after" },
                },
            },
        })
    end,
}
