---@type vim.lsp.ClientConfig
return {
  cmd = { 'tsgo', '--lsp', '--stdio' },
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
    'jsconfig.json',
    'package.json',
    '.git',
    'tsconfig.base.json',
  },
  single_file_support = true,
  ---@type lsp.LSPObject
  settings = {
    typescript = {
      -- Inlay hints
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      -- Preferences
      preferences = {
        importModuleSpecifier = 'relative',
        importModuleSpecifierEnding = 'minimal',
        quotePreference = 'auto',
        jsxAttributeCompletionStyle = 'auto',
        allowRenameOfImportPath = true,
        allowTextChangesInNewFiles = true,
        displayPartsForJSDoc = true,
        provideRefactorNotApplicableReason = true,
      },
      -- Suggest/completion options
      suggest = {
        completeFunctionCalls = true,
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
        includeCompletionsWithSnippetText = true,
        includeCompletionsWithClassMemberSnippets = true,
        includeCompletionsWithObjectLiteralMethodSnippets = true,
      },
      -- Auto imports
      autoImport = {
        enabled = true,
        includePackageJsonAutoImports = 'auto',
        preferTypeOnlyAutoImports = false,
      },
      -- Update imports on file move
      updateImportsOnFileMove = {
        enabled = 'always',
      },
      -- Organize imports preferences
      organizeImports = {
        ignoreCase = 'auto',
        locale = 'en',
        collation = 'ordinal',
        caseFirst = false,
        numericCollation = false,
        accentCollation = true,
        typeOrder = 'last', -- or 'first', 'inline'
      },
    },
  },
}
