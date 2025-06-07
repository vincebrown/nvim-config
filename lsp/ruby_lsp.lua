local blink = require 'blink.cmp'

return {
  cmd = { 'ruby-lsp' },
  filetypes = { 'ruby', 'eruby' },
  root_marker = { '.git', 'Gemfile' },
  single_file_support = true,
  capabilities = vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), blink.get_lsp_capabilities()),
}
