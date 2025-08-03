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

    local function client_supports_method(client, method, bufnr)
      return client:supports_method(method, bufnr)
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.name == 'vtsls' then
      map('<leader>co', function()
        vim.lsp.buf.code_action {
          apply = true,
          context = {
            only = { 'source.organizeImports' },
            diagnostics = {},
          },
        }
      end, 'Typescript organize imports')

      map('<leader>cm', function()
        vim.lsp.buf.code_action {
          apply = true,
          context = {
            ---@diagnostic disable-next-line: assign-type-mismatch
            only = { 'source.addMissingImports.ts' },
            diagnostics = {},
          },
        }
      end, 'Typescript add missing imports')

      map('<leader>cu', function()
        vim.lsp.buf.code_action {
          apply = true,
          context = {
            ---@diagnostic disable-next-line: assign-type-mismatch
            only = { 'source.removeUnused.ts' },
            diagnostics = {},
          },
        }
      end, 'Typescript remove unused imports')

      map('<leader>cD', function()
        vim.lsp.buf.code_action {
          apply = true,
          context = {
            ---@diagnostic disable-next-line: assign-type-mismatch
            only = { 'source.fixAll.ts' },
            diagnostics = {},
          },
        }
      end, 'Typescript remove unused imports')
    end

    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, 'Toggle Inlay Hints')
    end
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

-- Close certain filetypes with q
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('close-with-q', { clear = true }),
  pattern = { 'help', 'man', 'qf', 'lspinfo', 'checkhealth' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})
