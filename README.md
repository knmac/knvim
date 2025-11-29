# KNVIM

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

K-nvim or kn-vim, personal attempt to config Neovim and a pun on my username `knmac`.

## 1. Overview

### 1.1. Demo

Video demo with clickable `lualine`:

![demo 1](./res/demo1.gif)

Config structure and cheat sheet (rendered):

![demo 2](./res/demo2.png)

Editing a python file, with LSP, Tree-sitter, and outline support:

![demo 3](./res/demo3.png)

### 1.2. Feature highlights

- Targeting python, bash, latex, markdown, and (_some_) C/C++ usage.
- [Lualine](https://github.com/nvim-lualine/lualine.nvim) is configured to be (_mostly_) clickable. (Toggle with the command `:KnvimToggleClickableLualine`).
- Key-bindings that (_hopefully_) make sense.
- Fun (_for me_) to use!!!

## 2. Installation

### 2.1. Manual installation

#### 2.1.1. Dependencies

The following dependencies are for manual installation.

- Neovim 0.11.0+. Follow the installation guide on Neovim's [homepage](https://neovim.io/). This repo is just holding the config.
- A [nerdfont](https://www.nerdfonts.com) for the glyphs and a terminal that supports the font (the screenshots use [Ghostty](https://ghostty.org/) and its baked-in [JetBrains Mono](https://www.jetbrains.com/lp/mono/) font). Knvim is also tested with [WezTerm](https://wezfurlong.org/wezterm/).
- [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) for [mason.nvim](https://github.com/williamboman/mason.nvim) and [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) (package managers for LSPs, DAPs, linters, and formatters).
- [rg](https://github.com/BurntSushi/ripgrep) and [fd](https://github.com/sharkdp/fd) for fuzzy finder (`Snacks.picker`).

Optional dependencies:

- Python package `pynvim` (can be installed with `pip install pynvim`).
- [LazyGit](https://github.com/jesseduffield/lazygit) for quick git management from [Snacks.nvim](https://github.com/folke/snacks.nvim).
- [Yazi](https://yazi-rs.github.io/) for file explorer.
- A virtual environment (e.g., `conda`, `pyenv`, etc.) with the name `knvim`.

#### 2.1.2. Installation steps

Clone this repo to `$HOME/.config`:

```bash
git clone https://github.com/knmac/knvim.git $HOME/.config/knvim
```

Then add this command to `.bashrc` or `.zshrc`.

```bash
export NVIM_APPNAME="knvim"
```

_Notes:_ Knvim will try to find the default python interpreter. But it is recommended to create a virtual environment using `conda` or `pyenv` with the name `knvim` to sandbox your package installation. For more information, see the variable `vim.g.python3_host_prog` in `knvim/init.lua` and `knvim/core/setting.lua`.

#### 2.1.3. Removing knvim

Simply delete the two directories `$HOME/.config/knvim` and `$HOME/.local/share/knvim`. You can also remove your virtual environment if you set up one.

### 2.2. Installation using nvim-lazyman

[Nvim-lazyman](https://github.com/doctorfree/nvim-lazyman) is a configuration manager that supports popular Neovim configurations. After installing `nvim-lazyman`, run the following command to install knvim:

```bash
lazyman -L Knvim
```

Follow instructions from [nvim-lazyman](https://github.com/doctorfree/nvim-lazyman) for details about installation, bootstrapping, and other cool features.

## 3. Content

### 3.1. Configured servers

| Language              | Name               | Category         |
| --------------------- | ------------------ | ---------------- |
| Python                | basedpyright       | LSP              |
|                       | ruff_lsp           | Linter/Formatter |
|                       | debugpy            | DAP              |
| Bash                  | bashls             | LSP              |
|                       | shellcheck         | Linter           |
|                       | shfmt              | Formatter        |
|                       | bash-debug-adapter | DAP              |
| C/C++                 | clangd             | LSP              |
|                       | cpplint            | Linter           |
|                       | codelldb           | DAP              |
| Vimscript             | vimls              | LSP              |
| Lua                   | lua_ls             | LSP              |
| LaTex                 | texlab             | LSP              |
|                       | bibtex-tidy        | Formatter        |
| Markdown              | marksman           | LSP              |
|                       | prettier           | LSP              |
| Typst                 | tinymist           | LSP              |
|                       | typstyle           | Formatter        |
| YAML                  | yamlls             | LSP              |
|                       | prettier           | Formatter        |
| Typescript/Javascript | ts_ls              | LSP              |
|                       | prettier           | Formatter        |
| JSON                  | jsonls             | LSP              |
|                       | prettier           | Formatter        |
| HTML/CSS              | prettier           | Formatter        |
| Copilot               | copilot            | LSP              |

### 3.2. Config structure

```txt
init.lua
lsp/
└── ...
lua/
├── core/
│  ├── auto_commands.lua
│  ├── init.lua
│  ├── keymaps.lua
│  ├── settings.lua
│  └── symbols.lua
└── plugins/
   ├── coding/
   │  ├── blink_cmp.lua
   │  ├── dap.lua
   │  ├── lsp_linter_formatter.lua
   │  ├── neogen.lua
   │  ├── neotest.lua
   │  └── treesitter.lua
   ├── experimentals/
   │  └── ...
   ├── ui/
   │  ├── barbar.lua
   │  ├── catppuccin.lua
   │  ├── dropbar.lua
   │  ├── lualine.lua
   │  ├── noice.lua
   │  ├── rainbow_delimiters.lua
   │  └── winsep.lua
   ├── utils/
   │  ├── diffview.lua
   │  ├── easy-align.lua
   │  ├── flash.lua
   │  ├── gitsigns.lua
   │  ├── leap.lua
   │  ├── nvim-colorizer.lua
   │  ├── oil.lua
   │  ├── outline.lua
   │  ├── persistence.lua
   │  ├── quicker.lua
   │  ├── renderer-markdown-obsidian.lua
   │  ├── sidekick.lua
   │  ├── snacks.lua
   │  ├── todo-comments.lua
   │  ├── which-key.lua
   │  └── yazi.lua
   └── init.lua
```

The configs in `experimentals/` directories are not activated by default. To use them, uncomment the following line in `lua/plugins/init.lua`:

```lua
{ import = "plugins.experimentals", },
```

If you want to try individual experimental plugins instead of the all of them, uncomment a specific plugins, e.g.,

```lua
{ import = "plugins.experimentals.neorg", },
{ import = "plugins.experimentals.remote-nvim", },
```

## 4. Knvim Cheatsheet

Cheat sheet for knvim can be found [here](cheatsheet.md). You can also access cheat sheet from the start page.

## 5. Extra configs (optional)

This section shows you how to set up extra configuration for knvim to work as you want (completely optional).

### 5.1. Ruff (Python linter and formatter)

Create the file `pyproject.toml` for each Python project, where the content looks something like this:

```toml
[tool.ruff]
line-length = 110

[tool.ruff.lint]
# Enable Pyflakes (`F`) and a subset of the pycodestyle (`E`) codes by default.
select = ["E", "F"]
# Avoid enforcing line-length violations (`E501`)
ignore = ["E501"]

[tool.ruff.format]
# Use double quotes for strings.
quote-style = "double"
# Indent with spaces, rather than tabs.
indent-style = "space"
```

For more information, visit [here](https://docs.astral.sh/ruff/configuration/) and [here](https://python-poetry.org/docs/pyproject/).

### 5.2. DAP (Debugging Adapter Protocol)

Create the file `.vscode/launch.json` for each project, where the content looks something like this:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "python",
      "request": "launch",
      "name": "NAME OF THE LAUNCH",
      "program": "${file} OR ${workspaceFolder}/path/to/file",
      "console": "integratedTerminal",
      "cwd": "${workspaceFolder}",
      "repl_lang": "javascript",
      "args": ["ARG1", "ARG2", ...]
    }
  ]
}
```

The above config uses Python as an example, but you can setup debugger for other languages similarly. The template for Python launcher can be generated with `,g`. If you want to specify a file for a launch instead of the current file, you can also set `cwd` as `${workspaceFolder}/path/to/the/file`. For more information, visit [here](https://go.microsoft.com/fwlink/?linkid=830387).

### 5.3. Diffview (Integrate Diffview to git mergetool automatically)

Create the file `~/.gitconfig` globally, where the content looks something like this:

```toml
[merge]
    tool = nvim
[mergetool]
    keepBackup = false
    prompt = false
[mergetool "nvim"]
    cmd = "nvim -d -c \"wincmd l\" -c \"norm ]c\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\" -c DiffviewOpen"
```

### 5.4. Marksman (LSP server for markdown)

Create the file `.marksman.toml` for each project, where the (default) content looks something like this:

```toml
[core]
markdown.file_extensions = ["md", "markdown"]
text_sync = "full"
incremental_references = false
paranoid = false

[code_action]
toc.enable = true
create_missing_file.enable = true

[completion]
wiki.style = "title-slug"
```

## 6. FAQs

_Q1: Why knvim is not working on Windows?_

_A1:_ knvim config targets Unix-based OS (e.g., Linux and MacOS) and is not fully tested on Windows. Some common problems include different path separator (`/` on Unix vs `\` on Windows) and `EOL` character (`LF` on Unix and `CR LF` on Windows). You may want to change these characters manually if you want to try knvim on Windows machines.

_Q2: Why knvim does not include (this and that) by default?_

_A2:_ knvim is my personal config of Neovim, so it does not cover a wide range of different use cases. You are more than welcome (and recommended) to fork and customize knvim to your personal liking. That said, I will try to add some configs if they are commonly used. Cheers!

_Q3: Why knvim does not render markdown correctly (using markdown preview)?_

_A3:_ This is mostly how the terminal is configured. I find Ghostty supports most of the features out-of-the box. For WezTerm, some features need additional setup. Please inspect the code carefully before running.

- Rendering under-curl [ref](https://wezfurlong.org/wezterm/faq.html#how-do-i-enable-undercurl-curly-underlines):

```bash
tempfile=$(mktemp) \
  && curl -o "$tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo" \
  && tic -x -o ~/.terminfo "$tempfile" \
  && rm "$tempfile"
```

- Rendering strike-through [ref](https://github.com/neovim/neovim/discussions/24346):

```bash
infocmp "$TERM" > myterm.info
nvim myterm.info # add smxx=\E[9m, rmxx=\E[29m,
tic -x myterm.info
```

_Q4: Image rendering in knvim?_

_A4:_ Corresponding configuration can be found in `lua/plugins/utils/snacks.lua`. For more information, refer to [Snacks.nvim/image](https://github.com/folke/snacks.nvim/blob/main/docs/image.md).

## 7. TODO

- [x] Image rendering.
- [x] ~Automatically~ copy knvim to server for remote editing. You can try the experimental config `plugins.experimental.remote-nvim`.
- [ ] Automatically switch path separator and `EOL` character, depending on the OS (Linux/MacOS/Windows). This will not be considered in the short run because I do not have a Windows machine to test :)
