return {
  default_config = {
    cmd = { 'bialet-lsp' },
    filetypes = { 'bialet', 'wren' },
    root_dir = function(fname)
      local util = require('lspconfig.util')
      return util.root_pattern('.git', '_app.wren', 'index.wren')(fname)
    end,
    single_file_support = true,
  },
  docs = {
    description = [[
Bialet LSP server for Wren files (.wren).

Provides diagnostics, completions (Response, Request, Session, Db,
Layout, query chain methods), and go-to-definition for imports and
file-based routes.

The `bialet-lsp` binary must be installed and in your PATH.
Build it from source: https://github.com/bialet/bialet
    ]],
  },
}
