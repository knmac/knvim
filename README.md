# KNVIM

K-nvim or kn-vim, personal attempt to config Neovim and a pun on my username knmac.

## Demo
<!-- ![Screenshot](./res/screenshot.png) -->
Video demo with clickable lualine
![demo3](./res/demo1.gif)

Config structure and cheatsheet
![demo1](./res/demo2.png)

Editing a python file, with LSP, Tree-sitter, and Symbols-outline support
![demo2](./res/demo3.png)


## Feature highlights

- Targeting python, bash, latex, markdown, and (*some*) C/C++ usage
- [Lualine](https://github.com/nvim-lualine/lualine.nvim) is configured to be (*mostly*) clickable
- Key-biddings that (*hopefully*) make sense
- Fun (*for me*) to use!!!


## Config structure

```
init.lua
lua/
├── core/
│  ├── auto_commands.lua
│  ├── init.lua
│  ├── keymaps.lua
│  └── settings.lua
└── plugins/
   ├── coding/
   │  ├── cmp.lua
   │  ├── comment.lua
   │  ├── dap.lua
   │  ├── lspconfig-mason-navic.lua
   │  ├── null-ls.lua
   │  └── treesitter.lua
   ├── experimentals/
   │  └── ...
   ├── ui/
   │  ├── alpha.lua
   │  ├── barbar.lua
   │  ├── catppuccin.lua
   │  ├── fold.lua
   │  ├── illuminate.lua
   │  ├── indentblankline.lua
   │  ├── lualine.lua
   │  ├── noice-notify.lua
   │  └── winsep.lua
   ├── utils/
   │  ├── extra.lua
   │  ├── gitsigns.lua
   │  ├── neo-tree.lua
   │  ├── swenv.lua
   │  ├── symbols-outline.lua
   │  ├── telescope.lua
   │  ├── todo-comments.lua
   │  ├── toggleterm.lua
   │  ├── which-key.lua
   │  └── zen-mode.lua
   └── init.lua
```

The configs in `experimentals/` directories are not activated by default. To use them, uncommment the following line in `lua/plugins/init.lua`:

```lua
{ import = 'plugins.experimentals', },
```


## Manual installation

### Prerequisites

The following prerequisites are for manual installation.
- Neovim 0.9.0+. Follow the installation guide on Neovim's [homepage](https://neovim.io/). This repo is just holding the config.
- A [nerdfont](https://www.nerdfonts.com) for the glyphs and a terminal that supports the font (the screenshots use [WezTerm](https://wezfurlong.org/wezterm/) and its baked-in [JetBrains Mono](https://www.jetbrains.com/lp/mono/) font).
- `npm` for [mason.nvim](https://github.com/williamboman/mason.nvim) (package manager for LSPs, DAPs, linters, and formaters).
- `rg` and `fd` for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (fuzzy finder).

### Installation

Clone this repo to `$HOME/.config`:

```bash
git clone https://github.com/knmac/knvim.git $HOME/.config/knvim
```

Then add this command to `.bashrc` or `.zshrc`.

```bash
export NVIM_APPNAME="knvim"
```

### Removing knvim

Simply delete the two directories `$HOME/.config/knvim` and `$HOME/.local/share/knvim`.


## Installation using nvim-lazyman

[Nvim-lazyman](https://github.com/doctorfree/nvim-lazyman) is a configuration manager that supports popular Neovim configurations. After installing `nvim-lazyman`, run the folling command to install knvim:

```bash
lazyman -w Knvim
```

Follow instructions from [nvim-lazyman](https://github.com/doctorfree/nvim-lazyman) for details about installation, boostrapping, and other cool features.


## Knvim Cheatsheet

Cheatsheet for knvim can be found [here](res/cheatsheet.md). You can also access cheatsheet from the start page.
