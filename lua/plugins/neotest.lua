return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    { 'fredrikaverpil/neotest-golang', version = '*' },
    { 'nvim-neotest/neotest-jest' },
    { 'olimorris/neotest-rspec' },
  },
  opts = {
    adapters = {
      ['neotest-golang'] = {
        go_test_args = { '-v', '-race', '-count=1', '-timeout=60s' },
        dap_go_enabled = false,
      },
      ['neotest-jest'] = {
        jestCommand = 'npm test --',
        jest_test_discovery = false,
        cwd = function(path)
          return vim.fn.getcwd()
        end,
      },
      ['neotest-rspec'] = {},
    },
    status = { virtual_text = true },
    output = { open_on_run = true },
    quickfix = {
      open = function()
        if pcall(require, 'trouble') then
          require('trouble').open { mode = 'quickfix', focus = false }
        else
          vim.cmd 'copen'
        end
      end,
    },
  },
  config = function(_, opts)
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)

    -- Adapter loader (from LazyVim full spec)
    if opts.adapters then
      local adapters = {}
      for name, config in pairs(opts.adapters or {}) do
        if type(name) == 'number' then
          if type(config) == 'string' then
            config = require(config)
          end
          adapters[#adapters + 1] = config
        elseif config ~= false then
          local adapter = require(name)
          if type(config) == 'table' and not vim.tbl_isempty(config) then
            local meta = getmetatable(adapter)
            if adapter.setup then
              adapter.setup(config)
            elseif adapter.adapter then
              adapter.adapter(config)
              adapter = adapter.adapter
            elseif meta and meta.__call then
              adapter = adapter(config)
            else
              error('Adapter ' .. name .. ' does not support setup')
            end
          end
          adapters[#adapters + 1] = adapter
        end
      end
      opts.adapters = adapters
    end

    require('neotest').setup(opts)

    -- Auto-open summary panel after running tests
    local neotest = require 'neotest'
    local function open_summary_on_run()
      vim.schedule(function()
        if not neotest.summary.is_open() then
          neotest.summary.open()
        end
      end)
    end
    vim.api.nvim_create_autocmd('User', {
      pattern = 'NeotestTestRunFinished',
      callback = open_summary_on_run,
    })

    -- Keybindings
    local map = vim.keymap.set
    map('n', '<leader>tt', function()
      neotest.run.run(vim.fn.expand '%')
    end, { desc = 'Run File (Neotest)' })
    map('n', '<leader>tT', function()
      neotest.run.run(vim.uv.cwd())
    end, { desc = 'Run All Test Files (Neotest)' })
    map('n', '<leader>tr', function()
      neotest.run.run()
    end, { desc = 'Run Nearest (Neotest)' })
    map('n', '<leader>tl', function()
      neotest.run.run_last()
    end, { desc = 'Run Last (Neotest)' })
    map('n', '<leader>ts', function()
      neotest.summary.toggle()
    end, { desc = 'Toggle Summary (Neotest)' })
    map('n', '<leader>to', function()
      neotest.output.open { enter = true, auto_close = true }
    end, { desc = 'Show Output (Neotest)' })
    map('n', '<leader>tO', function()
      neotest.output_panel.toggle()
    end, { desc = 'Toggle Output Panel (Neotest)' })
    map('n', '<leader>tS', function()
      neotest.run.stop()
    end, { desc = 'Stop (Neotest)' })
    map('n', '<leader>tw', function()
      neotest.watch.toggle(vim.fn.expand '%')
    end, { desc = 'Toggle Watch (Neotest)' })
  end,
}
