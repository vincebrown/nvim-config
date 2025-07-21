return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    enabled = true,
    opts = {
      popupmenu = {
        enabled = true,
      },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
        progress = {
          enabled = false,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
        inc_rename = true,
      },
    },
  -- stylua: ignore
   config = function(_, opts)
      require('noice').setup(opts)
    end,
  },
}
