local utils = require 'core.utils'

---@type vim.lsp.ClientConfig
return {
  cmd = { 'vtsls', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  root_markers = {
    'tsconfig.json',
    'package.json',
    '.git',
  },
  single_file_support = true,
  ---@type lsp.LSPObject
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = 'always' },
      suggest = {
        completeFunctionCalls = true,
      },
      preferences = {
        importModuleSpecifier = 'relative',
        importModuleSpecifierEnding = 'minimal',
        includePackageJsonAutoImports = 'auto',
        includeCompletionsForModuleExports = true,
        includeCompletionsWithInsertText = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = 'all' },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = true },
      },
    },
  },
  ---@type lsp.ClientCapabilities
  capabilities = utils.create_lsp_capabilities(),
}
