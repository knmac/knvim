-- Session manager
local session_dir = vim.fn.stdpath("state") .. "/sessions/"

return {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    keys = {
        { "<space>s", function() require("persistence").select() end, desc = "Persistence: Select session" },
        {
            "<space>S",
            function()
                vim.ui.select(
                    require("persistence").list(),
                    {
                        prompt = "Select session to delete",
                        format_item = function(item)
                            item = item:gsub(session_dir, "") -- Remove the session dir path
                            item = item:gsub(".vim$", "") -- Remove .vim extension at the end
                            item = item:gsub("%%%%", " | 󰘬") -- Format the git branch name
                            item = item:gsub("%%", "/") -- Convert to the standard path
                            return item
                        end,
                    },
                    function(choice)
                        if choice == nil then return end
                        vim.fn.system("rm " .. choice)
                        vim.print("Removed " .. choice)
                    end
                )
            end,
            desc = "Persistence: Delete session",
        },
    },
    opts = {
        -- add any custom options here
        dir = session_dir,
    },
    init = function()
        -- vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,terminal"
        vim.opt.sessionoptions = "buffers,curdir,folds,tabpages"

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
