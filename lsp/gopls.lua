local blinkCapabilities = require 'blink.cmp'

local function make_gopls_capabilities()
  local base_capabilities = vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), blinkCapabilities.get_lsp_capabilities(), {
    fileOperations = {
      didRename = true,
      willRename = true,
    },
  })

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

return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', 'go.work', '.git' },
  single_file_support = true,
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
  capabilities = make_gopls_capabilities(),
}
