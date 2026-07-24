# Bialet plugin for Vim & VS Code

Syntax highlighting for the [Bialet](https://bialet.dev) framework,
based on the [Wren](https://wren.io) language.

## Installation

### Vim / Neovim

Install with [Plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'bialet/bialet.vim'
```

### VS Code

1. Clone the repo into `~/.vscode/extensions/bialet.bialet-wren-0.1.0/`:
   ```bash
   git clone https://github.com/bialet/bialet.vim \
     ~/.vscode/extensions/bialet.bialet-wren-0.1.0/
   ```
2. Reload VS Code (`Cmd+Shift+P` → "Developer: Reload Window").

Alternatively, build a `.vsix` package:
```bash
npx vsce package
```
Then install it via `code --install-extension bialet-wren-0.1.0.vsix`.

## LSP support

This plugin bundles LSP configuration for the [`bialet-lsp`](https://github.com/bialet/bialet)
language server, which provides diagnostics, autocompletion, and
go-to-definition for `.wren` files.

First, build and install `bialet-lsp` from the main Bialet repository:

```bash
git clone https://github.com/bialet/bialet
cd bialet && make lsp && make lsp-install
```

Then configure your LSP client:

### Neovim (nvim-lspconfig)

```lua
-- Register the Bialet server config provided by this plugin
require('lspconfig.configs').bialet = require('bialet-lsp')
require('lspconfig').bialet.setup({})
```

### vim-lsp

```vim
let g:lsp_settings = {
\ 'bialet-lsp': {
\   'cmd': ['bialet-lsp'],
\   'filetypes': ['bialet', 'wren'],
\   'allowlist': ['bialet', 'wren'],
\ }}
```

### coc.nvim

```json
{
  "languageserver": {
    "bialet": {
      "command": "bialet-lsp",
      "filetypes": ["bialet", "wren"]
    }
  }
}
```

### VS Code

Install `bialet-lsp` globally, then add to your VS Code `settings.json`:

```json
{
  "bialet-lsp.path": "/usr/local/bin/bialet-lsp"
}
```

Or use the [Bialet VS Code extension](https://marketplace.visualstudio.com/items?itemName=bialet.bialet) if available.
