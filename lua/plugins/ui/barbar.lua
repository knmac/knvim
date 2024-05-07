-- Tabline bar at the top
return {
    "romgrk/barbar.nvim",              -- buffer line (top)
    dependencies = {
        "lewis6991/gitsigns.nvim",     -- OPTIONAL: for git status
        "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    event = "BufEnter",
    init = function() vim.g.barbar_auto_setup = false end,
    keys = {
        { "<C-A-h>",   "<CMD>BufferPrevious<CR>",     desc = "Barbar: previous buffer" },
        { "<C-A-j>",   "<CMD>BufferPick<CR>",         desc = "Barbar: pick buffer to switch to" },
        { "<C-A-k>",   "<CMD>BufferPickDelete<CR>",   desc = "Barbar: pick and delete buffer" },
        { "<C-A-l>",   "<CMD>BufferNext<CR>",         desc = "Barbar: next buffer" },
        { "<C-A-S-h>", "<CMD>BufferMovePrevious<CR>", desc = "Barbar: swap with previous buffer" },
        { "<C-A-S-j>", "<CMD>BufferRestore<CR>",      desc = "Barbar: restore a deleted buffer" },
        { "<C-A-S-k>", "<CMD>BufferClose<CR>",        desc = "Barbar: delete the current buffer" },
        { "<C-A-S-l>", "<CMD>BufferMoveNext<CR>",     desc = "Barbar: swap with next buffer" },
        { "<C-A-p>",   "<CMD>BufferPin<CR>",          desc = "Barbar: pin the current buffer" },
    },
    opts = {
        -- Excludes buffers from the tabline
        exclude_ft = {},
        exclude_name = {},
        -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
        hide = { extensions = false, inactive = false },
        icons = {
            modified = { button = "" },
            pinned = { button = "", filename = true },
        },
        -- Set the filetypes which barbar will offset itself for
        sidebar_filetypes = {
            -- Use the default values: {event = 'BufWinLeave', text = nil}
            NvimTree = true,
            -- Or, specify the text used for the offset:
            undotree = { text = "undotree" },
            -- Or, specify the event which the sidebar executes when leaving:
            -- ["neo-tree"] = { event = "BufWipeout" },
            -- Or, specify both
            -- Outline = { event = "BufWinLeave", text = "symbols-outline" },
        },
    },
}
