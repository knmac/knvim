-- Session manager
return {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    keys = {
        { "<space>s", function() require("persistence").select() end, desc = "Persistence: Select" },
    },
    opts = {
        -- add any custom options here
    },
    init = function()
        -- vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,terminal"
        vim.opt.sessionoptions = "buffers,curdir,folds,tabpages,winsize"

        vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "PersistenceLoadPre",
            group = vim.api.nvim_create_augroup("SessionGroup", {}),
            callback = function()
                -- vim.cmd [[Lazy reload colorful-winsep.nvim]]
                vim.cmd [[bufdo bwipeout]]
            end,
        })
    end,
}
