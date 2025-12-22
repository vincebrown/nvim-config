-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Oil rename file LSP integrated
vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('oil-lsp-rename', { clear = true }),
  pattern = 'OilActionsPost',
  callback = function(event)
    if event.data.actions[1].type == 'move' then
      Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
    end
  end,
})

-- Run this anytime a LSP attaches
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gr', Snacks.picker.lsp_references, 'Go to references')

    map('gI', Snacks.picker.lsp_implementations, 'Go to implementation')

    map('gd', Snacks.picker.lsp_definitions, 'Go to definition')

    map('gD', Snacks.picker.lsp_declarations, 'Go to declaration')

    map('gt', Snacks.picker.lsp_type_definitions, 'Go to type definitions')

    -- TypeScript-specific keymaps using Snacks.keymap (vtsls only)
    Snacks.keymap.set('n', '<leader>co', function()
      vim.lsp.buf.code_action {
        apply = true,
        context = {
          only = { 'source.organizeImports' },
          diagnostics = {},
        },
      }
    end, {
      lsp = { name = 'vtsls' },
      desc = 'LSP: Typescript organize imports',
    })

    Snacks.keymap.set('n', '<leader>cm', function()
      vim.lsp.buf.code_action {
        apply = true,
        context = {
          ---@diagnostic disable-next-line: assign-type-mismatch
          only = { 'source.addMissingImports.ts' },
          diagnostics = {},
        },
      }
    end, {
      lsp = { name = 'vtsls' },
      desc = 'LSP: Typescript add missing imports',
    })

    Snacks.keymap.set('n', '<leader>cu', function()
      vim.lsp.buf.code_action {
        apply = true,
        context = {
          ---@diagnostic disable-next-line: assign-type-mismatch
          only = { 'source.removeUnused.ts' },
          diagnostics = {},
        },
      }
    end, {
      lsp = { name = 'vtsls' },
      desc = 'LSP: Typescript remove unused imports',
    })

    Snacks.keymap.set('n', '<leader>cD', function()
      vim.lsp.buf.code_action {
        apply = true,
        context = {
          ---@diagnostic disable-next-line: assign-type-mismatch
          only = { 'source.fixAll.ts' },
          diagnostics = {},
        },
      }
    end, {
      lsp = { name = 'vtsls' },
      desc = 'LSP: Typescript fix all',
    })

    -- Inlay hints toggle using Snacks.keymap (only for clients that support the method)
    Snacks.keymap.set('n', '<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = vim.api.nvim_get_current_buf() })
    end, {
      lsp = { method = vim.lsp.protocol.Methods.textDocument_inlayHint },
      desc = 'LSP: Toggle Inlay Hints',
    })
  end,
})

-- Trim trailing space
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('trim-whitespace', { clear = true }),
  callback = function()
    require('mini.trailspace').trim()
  end,
})

-- Show LSP Progress when opening file
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd('LspProgress', {
  group = vim.api.nvim_create_augroup('lsp-progress', { clear = true }),
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= 'table' then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ('[%3d%%] %s%s'):format(
            value.kind == 'end' and 100 or value.percentage or 100,
            value.title or '',
            value.message and (' **%s**'):format(value.message) or ''
          ),
          done = value.kind == 'end',
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    vim.notify(table.concat(msg, '\n'), 'info', {
      id = 'lsp_progress',
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

-- Open help in vertical split
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('help-vertical-split', { clear = true }),
  pattern = { '*.txt' },
  callback = function()
    if vim.bo.filetype == 'help' then
      vim.cmd.wincmd 'L'
    end
  end,
})

-- Close certain filetypes with q
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('close-with-q', { clear = true }),
  pattern = { 'help', 'man', 'qf', 'lspinfo', 'checkhealth' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- Auto-reload files when focus is gained or buffer is entered (fixes tmux issue)
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  group = vim.api.nvim_create_augroup('auto-reload', { clear = true }),
  callback = function()
    if vim.fn.mode() ~= 'c' then
      vim.cmd 'checktime'
    end
  end,
})

-- Notify when file changes outside of Neovim
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  group = vim.api.nvim_create_augroup('file-changed-notification', { clear = true }),
  callback = function()
    Snacks.notify.info 'File changed on disk. Buffer reloaded.'
  end,
})

-- Enable cursorline in active buffer
vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
  group = vim.api.nvim_create_augroup('cursorline-active', { clear = true }),
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

-- Disable cursorline in inactive buffer
vim.api.nvim_create_autocmd({ 'BufLeave', 'WinLeave' }, {
  group = vim.api.nvim_create_augroup('cursorline-inactive', { clear = true }),
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
