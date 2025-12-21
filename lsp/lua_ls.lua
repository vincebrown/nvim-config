---@type vim.lsp.ClientConfig
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
  ---@type lsp.LSPObject
  settings = {
    Lua = {
      completion = {
        displayContext = 1,
        keywordSnippet = 'Replace',
      },
      diagnostics = {
        globals = {
          'Snacks',
        },
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = 'All',
        semicolon = 'Disable',
        arrayIndex = 'Disable',
      },
    },
  },
}
