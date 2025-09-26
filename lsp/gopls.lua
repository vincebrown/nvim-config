local utils = require 'core.utils'

---@class GoplsCapabilities : lsp.ClientCapabilities
---@field semanticTokensProvider table?

---@return GoplsCapabilities
local function make_gopls_capabilities()
  ---@type GoplsCapabilities
  local base_capabilities = utils.create_lsp_capabilities()

  -- workaround for gopls not supporting semanticTokensProvider
  -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
  if base_capabilities.textDocument and base_capabilities.textDocument.semanticTokens then
    local semantic = base_capabilities.textDocument.semanticTokens
    base_capabilities.semanticTokensProvider = {
      full = true,
      legend = {
        tokenTypes = semantic.tokenTypes,
        tokenModifiers = semantic.tokenModifiers,
      },
      range = true,
    }
  end
  -- end workaround

  return base_capabilities
end

---@type vim.lsp.ClientConfig
return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', 'go.work', '.git' },
  single_file_support = true,
  ---@type lsp.LSPObject
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      semanticTokens = true,
    },
  },
  ---@type GoplsCapabilities
  capabilities = make_gopls_capabilities(),
}
