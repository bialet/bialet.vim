# Bialet plugin for vim

Syntax highlighting for the [Bialet](https://bialet.dev) framework,
based on the [Wren](https://wren.io) language.

## Installation

Install with [Plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'bialet/bialet.vim'
```

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
