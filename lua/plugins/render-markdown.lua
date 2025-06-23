return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  config = function()
    require('render-markdown').setup {
      completions = { blink = { enabled = true } },
      preset = 'obsidian',
      code = {
        disable_background = false,
      },
    }
  end,
}
