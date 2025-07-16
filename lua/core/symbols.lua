-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Diagnostic symbols
-- ────────────────────────────────────────────────────────────────────────────────────────────────
vim.diagnostic.config({
    -- LSP Diagnostic signs
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        texthl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        },
        -- linehl = {},
    },
    -- Virtual text / line
    -- virtual_text = {
    --     source = true, -- Or 'if_many'  -> show source of diagnostics
    --     -- prefix = '■', -- Could be '●', '▎', 'x'
    -- },
    virtual_lines = { current_line = true },
    -- Float
    float = {
        source = true, -- Or 'if_many'  -> show source of diagnostics
        border = "rounded",
    },
})

-- Use undercurl, if supported by terminal
vim.cmd.highlight("DiagnosticUnderlineOk gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineHint gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineInfo gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineWarn gui=undercurl")
vim.cmd.highlight("DiagnosticUnderlineError gui=undercurl")


-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- DAP symbols
-- ────────────────────────────────────────────────────────────────────────────────────────────────
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition",
    { text = "", texthl = "DapBreakpointCondition", linehl = "", numhl = "DapBreakpointCondition" })
vim.fn.sign_define("DapBreakpointRejected",
    { text = "", texthl = "DapBreakpointRejected", linehl = "", numhl = "DapBreakpointRejected" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "debugPC", numhl = "DapStopped" })


-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- File symbols
-- ────────────────────────────────────────────────────────────────────────────────────────────────
vim.g.knvim_symbol_map = {
    Array = "󰅪",
    Boolean = "",
    BreakStatement = "󰙧",
    Call = "󰃷",
    CaseStatement = "󱃙",
    Class = "",
    Color = "󰏘",
    Constant = "󰏿",
    Constructor = "",
    ContinueStatement = "→",
    Copilot = "",
    Declaration = "󰙠",
    Delete = "󰩺",
    DoStatement = "󰑖",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "",
    File = "󰈔",
    Folder = "󰉋",
    ForStatement = "󰑖",
    Function = "󰊕",
    H1Marker = "󰉫", -- Used by markdown treesitter parser
    H2Marker = "󰉬",
    H3Marker = "󰉭",
    H4Marker = "󰉮",
    H5Marker = "󰉯",
    H6Marker = "󰉰",
    Identifier = "󰀫",
    IfStatement = "󰇉",
    Interface = "",
    Keyword = "󰌋",
    List = "󰅪",
    Log = "󰦪",
    Lsp = "",
    Macro = "󰁌",
    MarkdownH1 = "󰉫", -- Used by builtin markdown source
    MarkdownH2 = "󰉬",
    MarkdownH3 = "󰉭",
    MarkdownH4 = "󰉮",
    MarkdownH5 = "󰉯",
    MarkdownH6 = "󰉰",
    Method = "󰆧",
    Module = "󰏗",
    Namespace = "󰅩",
    Null = "󰢤",
    Number = "󰎠",
    Object = "󰅩",
    Operator = "󰆕",
    Package = "󰆦",
    Pair = "󰅪",
    Property = "",
    Reference = "󰦾",
    Regex = "",
    Repeat = "󰑖",
    Scope = "󰅩",
    Snippet = "󰩫",
    Specifier = "󰦪",
    Statement = "󰅩",
    String = "󰉾",
    Struct = "",
    SwitchStatement = "󰺟",
    Table = "󰅩",
    Terminal = "",
    Text = "",
    Type = "",
    TypeParameter = "󰆩",
    Unit = "",
    Value = "󰎠",
    Variable = "󰀫",
    WhileStatement = "󰑖",
}
