local function set_git_branch()
  -- if you switch to another branch from vim, then gg, this probably won't update
  local proc = io.popen('git rev-parse --abbrev-ref HEAD 2>/dev/null')
  if not proc then
    return
  end
  local stdout = proc:read('*a')
  proc:close()

  vim.g.core_git_branch = stdout:match('^%s*(.-)%s*$') or ''
  if vim.g.core_git_branch ~= '' then
    vim.g.core_git_branch = '(' .. vim.g.core_git_branch .. ') '
  end
end

local function set_lsp_client()
  vim.g.core_lsp_client = '~'

  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Update g:core_lsp_client variable',
    group = vim.api.nvim_create_augroup('core_lsp_client', {}),
    callback = function()
      local ft = vim.api.nvim_buf_get_option(0, 'ft')
      local clients = vim.lsp.get_active_clients()
      if #clients == 0 then
        vim.g.core_lsp_client = '~'
        return
      end
      for _, filetype in ipairs(clients[1].config.filetypes) do
        if filetype == ft then
          vim.g.core_lsp_client = '<' .. clients[1].name .. '>'
          return
        end
      end
      vim.g.core_lsp_client = '~'
    end,
  })
end

local function hl(hl_group, text)
  return '%#' .. hl_group .. '#' .. text .. '%*'
end

set_git_branch()
set_lsp_client()

local active_statusline = table.concat({
  '%<',
  hl('Todo', '%{g:core_git_branch}'),
  hl('String', '%t'),
  hl('Identifier', ' %h%r%m'),
  hl('Normal', '%='),
  hl('Constant', '%{g:core_lsp_client}'),
  hl('Normal', '%='),
  hl('Statement', '%y '),
  hl('Character', '[%{&ff}] '),
  hl('Normal', '0x%B '),
  hl('PreProc', '(%l:%c%V)'),
}, '')

local inactive_statusline = table.concat({
  '%<',
  hl('String', '%t'),
  hl('Identifier', ' %h%r%m'),
  hl('Normal', '%='),
  hl('Number', '%y '),
  hl('Normal', '0x%B '),
  hl('PreProc', '(%l:%c%V)'),
}, '')

local group = vim.api.nvim_create_augroup('core_statusline', {})
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
  desc = 'Switch statusline to active',
  group = group,
  callback = function()
    vim.opt.statusline = active_statusline
  end,
})
vim.api.nvim_create_autocmd({ 'WinLeave' }, {
  desc = 'Switch statusline to inactive',
  group = group,
  callback = function()
    vim.opt.statusline = inactive_statusline
  end,
})
