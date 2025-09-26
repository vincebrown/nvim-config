---@class core.utils
local M = {}

---Creates comprehensive LSP client capabilities with blink.cmp integration
---@param custom_capabilities? lsp.ClientCapabilities Optional custom capabilities to merge
---@return lsp.ClientCapabilities
function M.create_lsp_capabilities(custom_capabilities)
  -- Get base capabilities from Neovim's LSP client
  ---@type lsp.ClientCapabilities
  local base_capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Define comprehensive LSP capabilities
  ---@type lsp.ClientCapabilities
  local comprehensive_capabilities = {
    ---@type lsp.TextDocumentClientCapabilities
    textDocument = {
      ---@type lsp.CompletionClientCapabilities
      completion = {
        dynamicRegistration = false,
        completionItem = {
          snippetSupport = true,
          commitCharactersSupport = true,
          documentationFormat = { 'markdown', 'plaintext' },
          deprecatedSupport = true,
          preselectSupport = true,
          tagSupport = {
            valueSet = { 1 } -- Deprecated
          },
          insertReplaceSupport = true,
          resolveSupport = {
            properties = {
              'documentation',
              'detail',
              'additionalTextEdits',
              'command'
            }
          },
          insertTextModeSupport = {
            valueSet = { 1, 2 } -- asIs, adjustIndentation
          },
          labelDetailsSupport = true
        },
        completionItemKind = {
          valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 }
        },
        contextSupport = true
      },
      ---@type lsp.HoverClientCapabilities
      hover = {
        dynamicRegistration = false,
        contentFormat = { 'markdown', 'plaintext' }
      },
      ---@type lsp.SignatureHelpClientCapabilities
      signatureHelp = {
        dynamicRegistration = false,
        signatureInformation = {
          documentationFormat = { 'markdown', 'plaintext' },
          parameterInformation = {
            labelOffsetSupport = true
          },
          activeParameterSupport = true
        },
        contextSupport = true
      },
      ---@type lsp.DocumentFormattingClientCapabilities
      formatting = {
        dynamicRegistration = false
      },
      ---@type lsp.DocumentRangeFormattingClientCapabilities
      rangeFormatting = {
        dynamicRegistration = false
      },
      ---@type lsp.DocumentOnTypeFormattingClientCapabilities
      onTypeFormatting = {
        dynamicRegistration = false
      },
      ---@type lsp.CodeActionClientCapabilities
      codeAction = {
        dynamicRegistration = false,
        codeActionLiteralSupport = {
          codeActionKind = {
            valueSet = {
              '',
              'quickfix',
              'refactor',
              'refactor.extract',
              'refactor.inline',
              'refactor.rewrite',
              'source',
              'source.organizeImports'
            }
          }
        },
        isPreferredSupport = true,
        disabledSupport = true,
        dataSupport = true,
        resolveSupport = {
          properties = { 'edit' }
        },
        honorsChangeAnnotations = true
      },
      ---@type lsp.RenameClientCapabilities
      rename = {
        dynamicRegistration = false,
        prepareSupport = true,
        prepareSupportDefaultBehavior = 1,
        honorsChangeAnnotations = true
      },
      ---@type lsp.DocumentSymbolClientCapabilities
      documentSymbol = {
        dynamicRegistration = false,
        symbolKind = {
          valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
        },
        hierarchicalDocumentSymbolSupport = true,
        tagSupport = {
          valueSet = { 1 } -- Deprecated
        },
        labelSupport = true
      },
      ---@type lsp.FoldingRangeClientCapabilities
      foldingRange = {
        dynamicRegistration = false,
        rangeLimit = 5000,
        lineFoldingOnly = true,
        foldingRangeKind = {
          valueSet = { 'comment', 'imports', 'region' }
        },
        foldingRange = {
          collapsedText = true
        }
      },
      ---@type lsp.SemanticTokensClientCapabilities
      semanticTokens = {
        dynamicRegistration = false,
        tokenTypes = {
          'namespace', 'type', 'class', 'enum', 'interface', 'struct',
          'typeParameter', 'parameter', 'variable', 'property', 'enumMember',
          'event', 'function', 'method', 'macro', 'keyword', 'modifier',
          'comment', 'string', 'number', 'regexp', 'operator', 'decorator'
        },
        tokenModifiers = {
          'declaration', 'definition', 'readonly', 'static', 'deprecated',
          'abstract', 'async', 'modification', 'documentation', 'defaultLibrary'
        },
        formats = { 'relative' },
        requests = {
          range = true,
          full = {
            delta = true
          }
        },
        multilineTokenSupport = true,
        overlappingTokenSupport = true,
        serverCancelSupport = true,
        augmentsSyntaxTokens = true
      },
      ---@type lsp.InlayHintClientCapabilities
      inlayHint = {
        dynamicRegistration = false,
        resolveSupport = {
          properties = { 'tooltip', 'textEdits', 'label.tooltip', 'label.location', 'label.command' }
        }
      },
      ---@type lsp.DiagnosticClientCapabilities
      diagnostic = {
        dynamicRegistration = false,
        relatedDocumentSupport = false
      }
    },
    ---@type lsp.WorkspaceClientCapabilities
    workspace = {
      ---@type boolean
      applyEdit = true,
      ---@type lsp.WorkspaceEditClientCapabilities
      workspaceEdit = {
        documentChanges = true,
        resourceOperations = { 'create', 'rename', 'delete' },
        failureHandling = 'textOnlyTransactional',
        normalizesLineEndings = true,
        changeAnnotationSupport = {
          groupsOnLabel = true
        }
      },
      ---@type lsp.DidChangeConfigurationClientCapabilities
      didChangeConfiguration = {
        dynamicRegistration = false
      },
      ---@type lsp.DidChangeWatchedFilesClientCapabilities
      didChangeWatchedFiles = {
        dynamicRegistration = true,
        relativePatternSupport = true
      },
      ---@type lsp.WorkspaceSymbolClientCapabilities
      symbol = {
        dynamicRegistration = false,
        symbolKind = {
          valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
        },
        tagSupport = {
          valueSet = { 1 } -- Deprecated
        },
        resolveSupport = {
          properties = { 'location.range' }
        }
      },
      ---@type lsp.ExecuteCommandClientCapabilities
      executeCommand = {
        dynamicRegistration = false
      },
      ---@type boolean
      workspaceFolders = true,
      ---@type boolean
      configuration = true,
      ---@type lsp.SemanticTokensWorkspaceClientCapabilities
      semanticTokens = {
        refreshSupport = true
      },
      ---@type lsp.CodeLensWorkspaceClientCapabilities
      codeLens = {
        refreshSupport = true
      },
      ---@type lsp.FileOperationClientCapabilities
      fileOperations = {
        dynamicRegistration = false,
        didCreate = true,
        willCreate = true,
        didRename = true,
        willRename = true,
        didDelete = true,
        willDelete = true
      },
      ---@type lsp.InlayHintWorkspaceClientCapabilities
      inlayHint = {
        refreshSupport = true
      },
      ---@type lsp.DiagnosticWorkspaceClientCapabilities
      diagnostics = {
        refreshSupport = true
      }
    },
    ---@type lsp.WindowClientCapabilities
    window = {
      ---@type boolean
      workDoneProgress = true,
      ---@type lsp.ShowMessageRequestClientCapabilities
      showMessage = {
        messageActionItem = {
          additionalPropertiesSupport = true
        }
      },
      ---@type lsp.ShowDocumentClientCapabilities
      showDocument = {
        support = true
      }
    },
    ---@type lsp.GeneralClientCapabilities
    general = {
      staleRequestSupport = {
        cancel = true,
        retryOnContentModified = {
          'textDocument/semanticTokens/full',
          'textDocument/semanticTokens/range',
          'textDocument/semanticTokens/full/delta'
        }
      },
      regularExpressions = {
        engine = 'ECMAScript',
        version = 'ES2020'
      },
      markdown = {
        parser = 'marked',
        version = '1.1.0'
      },
      positionEncodings = { 'utf-16' }
    }
  }

  -- Start with base capabilities
  local capabilities = vim.tbl_deep_extend('force', base_capabilities, comprehensive_capabilities)

  -- Merge with custom capabilities if provided
  if custom_capabilities then
    capabilities = vim.tbl_deep_extend('force', capabilities, custom_capabilities)
  end

  -- Integrate with blink.cmp for enhanced completion support
  local ok, blink = pcall(require, 'blink.cmp')
  if ok then
    capabilities = blink.get_lsp_capabilities(capabilities)
  else
    vim.notify('blink.cmp not available, using standard capabilities', vim.log.levels.WARN)
  end

  return capabilities
end

return M