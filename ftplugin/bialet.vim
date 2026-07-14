setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" LSP integration — pick your client:

" 1. Neovim with nvim-lspconfig:
"    Add to your init.lua:
"      require('lspconfig.configs').bialet = require('bialet-lsp')
"      require('lspconfig').bialet.setup({})

" 2. vim-lsp (prabirshrestha/vim-lsp):
"    Add to your vimrc:
"      let g:lsp_settings = {
"      \ 'bialet-lsp': {
"      \   'cmd': ['bialet-lsp'],
"      \   'filetypes': ['bialet', 'wren'],
"      \   'root_uri': {s->lsp#utils#path#uri(
"      \     fnamemodify(finddir('.git/..;', expand('%:p:h')), ':p'))},
"      \   'allowlist': ['bialet', 'wren'],
"      \ }}

" 3. coc.nvim:
"    Add to coc-settings.json:
"      "languageserver": {
"        "bialet": {
"          "command": "bialet-lsp",
"          "filetypes": ["bialet", "wren"]
"        }
"      }
