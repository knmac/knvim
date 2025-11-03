-- Import lua modules (as directories) that uses lazy.nvim package manager
return {
    { import = "plugins.ui", },
    { import = "plugins.coding", },
    { import = "plugins.utils", },

    -- Uncomment the following line to try all experimental plugins together
    -- { import = "plugins.experimentals" },

    -- Uncomment the individual experimental plugins to try them out
    -- { import = "plugins.experimentals.image" },
    -- { import = "plugins.experimentals.img-clip" },
    -- { import = "plugins.experimentals.jupynium" },
    -- { import = "plugins.experimentals.metals" },
    -- { import = "plugins.experimentals.neopyter" },
    -- { import = "plugins.experimentals.neorg" },
    -- { import = "plugins.experimentals.neovide" },
    -- { import = "plugins.experimentals.nonels" },
    -- { import = "plugins.experimentals.remote-nvim" },
}
