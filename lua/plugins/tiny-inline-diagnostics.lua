return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  opts = {
    preset = 'ghost',
    options = {
      show_source = {
        if_many = true,
      },
    },
    hi = {
      error = 'TinyInlineDiagnosticVirtualTextError',
      warn = 'TinyInlineDiagnosticVirtualTextWarn',
      info = 'TinyInlineDiagnosticVirtualTextInfo',
      hint = 'TinyInlineDiagnosticVirtualTextHint',
    },
  },
}
