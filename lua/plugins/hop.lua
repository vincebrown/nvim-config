---@diagnostic disable: missing-fields
return {
  'smoka7/hop.nvim',
  version = '2.*',
  event = 'VeryLazy',
  config = function()
    local hop = require 'hop'
    local directions = require('hop.hint').HintDirection
    local set = vim.keymap.set

    hop.setup {
      keys = 'etovxqpdygfblzhckisuran',
    }

    set('n', 'f', function()
      hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true }
    end, { remap = true, desc = 'Hop forward to character' })

    set('n', 'F', function()
      hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
    end, { remap = true, desc = 'Hop backward to character' })

    set('n', 't', function()
      hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }
    end, { remap = true, desc = 'Hop forward until character' })

    set('n', 'T', function()
      hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }
    end, { remap = true, desc = 'Hop backward until character' })

    set('n', '<leader>hw', '<CMD>HopWord<CR>', { desc = 'Hop words' })

    set('n', '<leader>hb', '<CMD>HopLineStart<CR>', { desc = 'Hop lines' })

    set('n', '<leader>hs', '<CMD>HopChar1<CR>', { desc = 'Hop search 1 char' })

    set('n', '<leader>hS', '<CMD>HopChar2<CR>', { desc = 'Hop search 2 char' })
  end,
}
