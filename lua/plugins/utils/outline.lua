-- Show project outline
return {
    "hedyhli/outline.nvim", -- show symbols of the current buffer
    event = "VeryLazy",
    keys = {
        { "<leader>o", "<CMD>Outline!<CR>", desc = "Toggle Outline" },
        { "<leader>O", "<CMD>Outline<CR>",  desc = "Toggle Outline with focus" },
    },
    config = function()
        --- Return with with minimum threshold
        local width_with_min = function(ratio, min_width)
            local width = math.floor(vim.go.columns * ratio)
            width = math.max(width, min_width)
            return width
        end

        require("outline").setup({
            outline_window = {
                relative_width = false,
                width = width_with_min(0.15, 50),
                -- autofold_depth = 2,
            },
            symbols = {
                -- VScode-like icons
                icons = {
                    File = { icon = "", hl = "Identifier" },
                    Module = { icon = "", hl = "Include" },
                    Namespace = { icon = "", hl = "Include" },
                    Package = { icon = "", hl = "Include" },
                    Class = { icon = "", hl = "Type" },
                    Method = { icon = "", hl = "Function" },
                    Property = { icon = "", hl = "Identifier" },
                    Field = { icon = "", hl = "Identifier" },
                    Constructor = { icon = "", hl = "Special" },
                    Enum = { icon = "", hl = "Type" },
                    Interface = { icon = "", hl = "Type" },
                    Function = { icon = "", hl = "Function" },
                    Variable = { icon = "", hl = "Constant" },
                    Constant = { icon = "", hl = "Constant" },
                    String = { icon = "", hl = "String" },
                    Number = { icon = "", hl = "Number" },
                    Boolean = { icon = "", hl = "Boolean" },
                    Array = { icon = "", hl = "Constant" },
                    Object = { icon = "", hl = "Type" },
                    Key = { icon = "", hl = "Type" },
                    Null = { icon = "", hl = "Type" },
                    EnumMember = { icon = "", hl = "Identifier" },
                    Struct = { icon = "", hl = "Structure" },
                    Event = { icon = "", hl = "Type" },
                    Operator = { icon = "", hl = "Identifier" },
                    TypeParameter = { icon = "", hl = "Identifier" },
                    Component = { icon = "", hl = "Function" },
                    Fragment = { icon = "", hl = "Constant" },
                    TypeAlias = { icon = "", hl = "Type" },
                    Parameter = { icon = "", hl = "Identifier" },
                    StaticMethod = { icon = "", hl = "Function" },
                    Macro = { icon = "", hl = "Function" },
                },
            },
        })
    end,
}
