-- Configure global capabilities for all LSP servers
vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
  root_markers = { '.git' },
})

vim.lsp.enable { 'vtsls', 'gopls', 'lua_ls', 'ruby_lsp' }

vim.diagnostic.config {
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'if_many',
    width = 70,
  },
  underline = { severity = vim.diagnostic.severity.ERROR },
  update_in_insert = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_lines = false,
  virtual_text = false,
}
