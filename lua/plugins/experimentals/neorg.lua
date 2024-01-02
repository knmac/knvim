-- On MacOS, run `export CC="$(which gcc-12)"; nvim`
return {
    "nvim-neorg/neorg",
    dependencies = "nvim-lua/plenary.nvim",
    build = ":Neorg sync-parsers", -- This is the important bit!
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.integrations.nvim-cmp"] = {},
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
                ["core.concealer"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/Documents/notes",
                        },
                        default_workspace = "notes",
                    }
                },
                ["core.export"] = {},
            }
        })
    end,
}
