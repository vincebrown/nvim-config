---@class core.utils
local M = {}

---Creates LSP client capabilities with blink.cmp integration
---Only adds capabilities not already provided by Neovim or blink.cmp
---@param custom_capabilities? lsp.ClientCapabilities Optional custom capabilities to merge
---@return lsp.ClientCapabilities
function M.create_lsp_capabilities(custom_capabilities)
  ---@type lsp.ClientCapabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  ---@type lsp.ClientCapabilities
  local additional = {
    ---@type lsp.TextDocumentClientCapabilities
    textDocument = {
      ---@type lsp.CompletionClientCapabilities
      completion = {
        completionItem = {
          commitCharactersSupport = true,
          preselectSupport = true,
        },
      },
      ---@type lsp.CodeActionClientCapabilities
      codeAction = {
        honorsChangeAnnotations = true,
      },
      ---@type lsp.RenameClientCapabilities
      rename = {
        prepareSupportDefaultBehavior = 1,
        honorsChangeAnnotations = true,
      },
      ---@type lsp.DocumentSymbolClientCapabilities
      documentSymbol = {
        labelSupport = true,
      },
      ---@type lsp.SemanticTokensClientCapabilities
      semanticTokens = {
        multilineTokenSupport = true,
        serverCancelSupport = true,
        requests = {
          range = true,
        },
      },
    },
    ---@type lsp.WorkspaceClientCapabilities
    workspace = {
      ---@type lsp.WorkspaceEditClientCapabilities
      workspaceEdit = {
        documentChanges = true,
        failureHandling = 'textOnlyTransactional',
        normalizesLineEndings = true,
        ---@type lsp.ChangeAnnotationsSupportOptions
        changeAnnotationSupport = {
          groupsOnLabel = true,
        },
      },
      ---@type lsp.ExecuteCommandClientCapabilities
      executeCommand = {
        dynamicRegistration = false,
      },
      ---@type lsp.CodeLensWorkspaceClientCapabilities
      codeLens = {
        refreshSupport = true,
      },
      ---@type lsp.FileOperationClientCapabilities
      fileOperations = {
        dynamicRegistration = false,
        didCreate = true,
        willCreate = true,
        didRename = true,
        willRename = true,
        didDelete = true,
        willDelete = true,
      },
      ---@type lsp.DiagnosticWorkspaceClientCapabilities
      diagnostics = {
        refreshSupport = true,
      },
    },
    ---@type lsp.GeneralClientCapabilities
    general = {
      ---@type lsp.StaleRequestSupportOptions
      staleRequestSupport = {
        cancel = true,
        retryOnContentModified = {
          'textDocument/semanticTokens/full',
          'textDocument/semanticTokens/range',
          'textDocument/semanticTokens/full/delta',
        },
      },
    },
  }

  capabilities = vim.tbl_deep_extend('force', capabilities, additional)

  if custom_capabilities then
    capabilities = vim.tbl_deep_extend('force', capabilities, custom_capabilities)
  end

  local ok, blink = pcall(require, 'blink.cmp')
  if ok then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end

  return capabilities
end

return M
