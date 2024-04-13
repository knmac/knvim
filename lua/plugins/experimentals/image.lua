-- Image support
-- ImageMagick: https://github.com/ImageMagick/ImageMagick
-- Magick LuaRock: https://github.com/leafo/magick
return {
    "3rd/image.nvim",
    config = function()
        -- Example for configuring Neovim to load user-installed installed Lua rocks:
        package.path = package.path ..
            ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
        package.path = package.path ..
            ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

        require("image").setup({
            backend = "kitty",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                },
                neorg = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "norg" },
                },
            },
            max_width = 100,
            max_height = 12,
            max_width_window_percentage = math.huge,
            max_height_window_percentage = math.huge,
            window_overlap_clear_enabled = true,                                     -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
            editor_only_render_when_focused = false,                                  -- auto show/hide images when the editor gains/looses focus
            tmux_show_only_in_active_window = false,                                  -- auto show/hide images in the correct Tmux window (needs visual-activity off)
            hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
        })
    end,
}
