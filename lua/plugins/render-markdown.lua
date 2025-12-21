return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    completions = { blink = { enabled = true } },
    preset = 'obsidian',
    code = {
      disable_background = false,
    },
  },
}
