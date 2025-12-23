return {
  'b0o/incline.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', opts = {} },
  },
  config = function()
    local colors = require('catppuccin.palettes').get_palette()

    require('incline').setup {
      window = {
        padding = 0,
        margin = { horizontal = 0, vertical = 0 },
      },
      render = function(props)
        local bufname = vim.api.nvim_buf_get_name(props.buf)
        if bufname == '' then
          return { { '[No Name]', gui = 'bold', guifg = colors.text }, ' ', guibg = colors.mantle }
        end

        local devicons = require 'nvim-web-devicons'

        -- Get the last 2 parts of the file path
        local parts = vim.split(bufname, '/')
        local filename = parts[#parts]
        local parent = #parts > 1 and parts[#parts - 1] or nil

        local ft_icon = devicons.get_icon(filename)
        local modified = vim.bo[props.buf].modified

        local res = {
          ft_icon and { ' ', ft_icon, ' ', guibg = colors.green, guifg = colors.crust } or '',
          ' ',
        }

        -- Add parent directory if it exists
        if parent then
          table.insert(res, { parent, guifg = colors.subtext0 })
          table.insert(res, { '  ', guifg = colors.overlay0 })
        end

        -- Add filename
        table.insert(res, { filename, gui = modified and 'bold,italic' or 'bold', guifg = colors.text })
        table.insert(res, ' ')

        res.guibg = colors.mantle
        return res
      end,
    }
  end,
  event = 'VeryLazy',
}
