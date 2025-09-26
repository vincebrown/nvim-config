local utils = require 'core.utils'

---@type vim.lsp.ClientConfig
return {
  cmd = { 'bash-language-server', 'start' },
  ---@type lsp.LSPObject
  settings = {
    bashIde = {
      -- Glob pattern for finding and parsing shell script files in the workspace.
      -- Used by the background analysis features across files.

      -- Prevent recursive scanning which will cause issues when opening a file
      -- directly in the home directory (e.g. ~/foo.sh).
      --
      -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
      globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
    },
  },
  filetypes = { 'bash', 'sh' },
  root_markers = { '.git' },
  ---@type lsp.ClientCapabilities
  capabilities = utils.create_lsp_capabilities(),
}
