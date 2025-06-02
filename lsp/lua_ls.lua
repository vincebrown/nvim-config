local blink = require 'blink.cmp'

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
  capabilities = vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), blink.get_lsp_capabilities(), {
    fileOperations = {
      didRename = true,
      willRename = true,
    },
  }),
}
