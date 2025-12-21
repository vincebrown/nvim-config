---@type vim.lsp.ClientConfig
return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { 'package.json', 'tsconfig.json', '.git' },
  ---@type lsp.LSPObject
  init_options = {
    provideFormatter = true,
  },
  single_file_support = true,
}
