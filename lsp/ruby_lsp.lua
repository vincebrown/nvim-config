---@type vim.lsp.ClientConfig
return {
  cmd = { 'ruby-lsp' },
  filetypes = { 'ruby', 'eruby' },
  root_markers = { '.git', 'Gemfile' },
  single_file_support = true,
}
