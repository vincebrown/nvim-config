---@module 'snacks'
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bufdelete = { enabled = true },
    dim = { enabled = true },
    indent = {
      enabled = true,
      only_scope = true,
      only_current = true,
    },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    lazygit = { enabled = true, configure = true },
    scroll = { enabled = true },
    win = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 4000,
    },
    dashboard = {
      enabled = true,
    },
    zen = {
      enabled = true,
      toggles = {
        dim = false,
        indent = false,
        git_signs = false,
        mini_diff_signs = false,
      },
    },
    picker = {
      previewers = {
        diff = {
          builtin = false,
          cmd = { 'delta' },
        },
      },
    },
    icons = {
      files = {
        enabled = true,
        dir = '󰉋 ',
        dir_open = '󰝰 ',
        file = '󰈔 ',
      },
    },
  },
  keys = {
    -- stylua: ignore start
    { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse', mode = { 'n', 'v' } },
    { '<leader>z', function() Snacks.zen() end, desc = 'Toggle zen mode' },
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
    { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
    { '<leader>ba', function() Snacks.bufdelete.all() end, desc = 'Buffer delete all', mode = 'n' },
    { '<leader>bo', function() Snacks.bufdelete.other() end, desc = 'Buffer delete other', mode = 'n' },

    -- Pickers
    { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
    { '<leader>,',
      function()
        Snacks.picker.buffers {
          win = {
            input = {
              keys = {
                ['dd'] = 'bufdelete',
                ['<c-d>'] = { 'bufdelete', mode = { 'n', 'i' } },
              },
            },
            list = { keys = { ['dd'] = 'bufdelete' } },
          },
        }
      end,
      desc = 'Buffers',
    },
    { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<leader>sn', function() Snacks.picker.notifications() end, desc = 'Notification History' },
    { '<leader>e', function() Snacks.explorer() end, desc = 'File Explorer' },

    -- Find
    { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>fc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = 'Find Config File' },
    { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
    {'<leader>fg', function() Snacks.picker.git_files() end, desc = 'Find Git Files'},
    { '<leader>fp', function() Snacks.picker.projects() end, desc = 'Projects' },
    { '<leader>fr', function() Snacks.picker.recent { filter = { cwd = true }, } end, desc = 'Recent (cwd)' },
    { '<leader>fR', function() Snacks.picker.recent() end, desc = 'Recent (all)' },

    -- Git
    { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git Branches' },
    { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log' },
    { '<leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log Line' },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status({
          focus ="list",
          layout = {
            preset = 'dropdown',
            layout = {
              width = 0.8,
              height = 0.8,
              preview = {
                height = 0.8
              }
            }
          },
        })
      end,
      desc = 'Git Status'
    },
    { '<leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash' },
    { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)' },
    { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log File' },

    -- Grep
    { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
    { '<leader>sB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep', },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = 'Visual selection or word', mode = { 'n', 'x' } },

    -- Search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = 'Registers' },
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = 'Search History' },
    { '<leader>sa', function() Snacks.picker.autocmds() end, desc = 'Autocmds' },
    { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
    { '<leader>sc', function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<leader>sC', function() Snacks.picker.commands() end, desc = 'Commands' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
    { '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
    { '<leader>sH', function() Snacks.picker.highlights() end, desc = 'Highlights' },
    { '<leader>si', function() Snacks.picker.icons() end, desc = 'Icons' },
    { '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
    { '<leader>sl', function() Snacks.picker.loclist() end, desc = 'Location List' },
    { '<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks' },
    { '<leader>sM', function() Snacks.picker.man() end, desc = 'Man Pages' },
    { '<leader>sp', function() Snacks.picker.lazy() end, desc = 'Search for Plugin Spec' },
    { '<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
    { '<leader>sR', function() Snacks.picker.resume() end, desc = 'Resume' },
    { '<leader>su', function() Snacks.picker.undo() end, desc = 'Undo History' },
    { '<leader>uC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' },
    { '<leader>sz', function() Snacks.picker.zoxide() end, desc = 'Zoxide' },

    -- LSP
    { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
    { '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },
    -- stylua: ignore end
  },

  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        Snacks.toggle.indent():map '<leader>ug'
        Snacks.toggle.dim():map '<leader>uD'
      end,
    })
  end,
}
