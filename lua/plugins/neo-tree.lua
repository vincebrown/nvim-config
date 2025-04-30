-- File Explorer
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  deactivate = function()
    vim.cmd [[Neotree close]]
  end,
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.uv.fs_stat(vim.fn.argv(0))
      if stat and stat.type == 'directory' then
        require 'neo-tree'
      end
    end
  end,
  opts = {
    commands = {
      copy_selector = function(state)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        local vals = {
          ['RELATIVE'] = modify(filepath, ':.'),
          ['BASENAME'] = modify(filename, ':r'),
          ['EXTENSION'] = modify(filename, ':e'),
          ['FILENAME'] = filename,
          ['HOME'] = modify(filepath, ':~'),
          ['ABSOLUTE'] = filepath,
          ['URI'] = vim.uri_from_fname(filepath),
        }

        local options = vim.tbl_filter(function(val)
          return vals[val] ~= ''
        end, vim.tbl_keys(vals))
        if vim.tbl_isempty(options) then
          vim.notify('No values to copy', vim.log.levels.WARN)
          return
        end
        table.sort(options)
        vim.ui.select(options, {
          prompt = 'Choose to copy to clipboard:',
          format_item = function(item)
            return ('%s: %s'):format(item, vals[item])
          end,
        }, function(choice)
          local result = vals[choice]
          if result then
            vim.notify(('Copied: `%s`'):format(result))
            vim.fn.setreg('+', result)
          end
        end)
      end,
    },
    window = {
      mappings = {
        ['<space>'] = 'none',
        ['Y'] = 'copy_selector',
      },
    },
  },
  config = function(_, opts)
    vim.keymap.set('n', '<leader>ee', '<cmd>Neotree toggle<CR>', { desc = 'Neotree toggle' })
    vim.keymap.set('n', '<leader>eg', '<cmd>Neotree git_status<CR>', { desc = 'Neotree toggle' })
    vim.keymap.set('n', '<leader>eb', '<cmd>Neotree buffers<CR>', { desc = 'Neotree toggle' })

    require('neo-tree').setup(opts)
  end,
}
