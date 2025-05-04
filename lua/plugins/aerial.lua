return {
  'stevearc/aerial.nvim',
  lazy = true,
  opts = function()
    local opts = {
      attach_mode = 'global',
      backends = { 'lsp', 'treesitter', 'markdown', 'man' },
      show_guides = true,
      layout = {
        placement = 'edge',
        default_direction = 'left',
        resize_to_content = true,
        max_width = { 40, 0.3 },
        win_opts = {
          winhl = 'Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB',
          signcolumn = 'yes',
          statuscolumn = ' ',
        },
      },
      -- stylua: ignore
      guides = {
        mid_item   = "├╴",
        last_item  = "└╴",
        nested_top = "│ ",
        whitespace = "  ",
      },
    }
    return opts
  end,
  keys = {
    { '<leader>cs', '<cmd>AerialToggle<cr>', desc = 'Aerial (Symbols)' },
  },
}
