local utils = require 'core.utils'

---@type vim.lsp.ClientConfig
return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  ---@type lsp.LSPObject
  init_options = {
    provideFormatter = true,
  },
  single_file_support = true,
  ---@type lsp.ClientCapabilities
  capabilities = utils.create_lsp_capabilities(),
}
