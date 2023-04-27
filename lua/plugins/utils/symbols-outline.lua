-- Show project outline
return {
    'simrat39/symbols-outline.nvim', -- show symbols of the current buffer
    config = function()
        --- Return with with minimum threshold
        local width_with_min = function(ratio, min_width)
            local width = math.floor(vim.go.columns * ratio)
            width = math.max(width, min_width)
            return width
        end

        require('symbols-outline').setup({
            relative_width = false,
            width = width_with_min(0.15, 50),
            autofold_depth = 1,
        })
    end,
}
