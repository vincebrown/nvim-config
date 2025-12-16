local utils = require 'core.utils'

-- Configure global capabilities for all LSP servers
---@type lsp.ClientCapabilities
local global_capabilities = utils.create_lsp_capabilities()

vim.lsp.config('*', {
  ---@type lsp.ClientCapabilities
  capabilities = global_capabilities,
  root_markers = { '.git' },
})

-- Add tsgo once stable
vim.lsp.enable { 'tsgo', 'gopls', 'lua_ls', 'ruby_lsp', 'jsonls', 'bashls', 'tailwindcss' }

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
