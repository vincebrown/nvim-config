-- Debug Linters and formatters attached to current buffer
vim.api.nvim_create_user_command('LintFormatInfo', function()
  local ft = vim.bo.filetype
  local linters = require('lint').linters_by_ft[ft] or {}
  local formatters = require('conform').list_formatters(0)

  local linter_names = {}
  for _, linter in ipairs(linters) do
    table.insert(linter_names, linter)
  end

  local formatter_names = {}
  for _, formatter in ipairs(formatters) do
    table.insert(formatter_names, formatter.name)
  end

  local info = {}
  table.insert(info, '**Filetype:** ' .. ft)
  table.insert(info, '')

  if #linter_names > 0 then
    table.insert(info, '**Linters:** ' .. table.concat(linter_names, ', '))
  else
    table.insert(info, '**Linters:** None configured')
  end

  if #formatter_names > 0 then
    table.insert(info, '**Formatters:** ' .. table.concat(formatter_names, ', '))
  else
    table.insert(info, '**Formatters:** None available')
  end

  Snacks.notify.info(table.concat(info, '\n'), { title = 'Lint & Format Info' })
end, {})
