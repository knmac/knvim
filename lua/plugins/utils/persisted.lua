-- Session manager

-- Avoid saving some buffers with specific types
vim.api.nvim_create_autocmd("User", {
    pattern = "PersistedSavePre",
    callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local bt = vim.bo[buf].filetype
            if bt == "neo-tree" or bt == "Outline" or bt == "snacks_terminal" or bt == "toggleterm" or string.sub(bt, 1, 3) == "dap" then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    end,
})

return {
    "olimorris/persisted.nvim",
    lazy = true,
    keys = {
        { "<space>s", "<CMD>Telescope persisted<CR>", desc = "Persisted: load" },
    },
    config = function()
        local persisted = require("persisted")
        persisted.setup({
            should_save = function()
                local ft = vim.bo.filetype
                if ft == "alpha" or ft == "snacks_dashboard" then
                    return false
                end
                return true
            end,
        })
    end,
}
