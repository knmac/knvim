-- Python virtual env selector
return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
        -- { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    branch = "regexp", -- This is the regexp branch, use this for the new version
    event = "VeryLazy",
    keys = {
        { "<space>e", "<cmd>VenvSelect<cr>" },
    },
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type venv-selector.Config
    opts = {
        -- Your settings go here
    },
}
