local function setup_git_branch()
  -- if you switch to another branch from vim, then gg, this probably won't update
  local proc = io.popen('git rev-parse --abbrev-ref HEAD 2>/dev/null')
  if not proc then
    return
  end
  local stdout = proc:read('*a')
  proc:close()

  vim.g.config_git_branch = stdout:match('^%s*(.-)%s*$') or ''
  if vim.g.config_git_branch ~= '' then
    vim.g.config_git_branch = '(' .. vim.g.config_git_branch .. ') '
  end
  return '%{g:config_git_branch}'
end

local function setup_lsp_client()
  vim.g.config_lsp_client = '~'

  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Update g:config_lsp_client variable',
    group = vim.api.nvim_create_augroup('config_lsp_client', {}),
    callback = function()
      local clients = vim.lsp.get_active_clients()
      if #clients == 0 then
        vim.g.config_lsp_client = '~'
        return
      end
      local ft = vim.api.nvim_buf_get_option(0, 'ft')
      for _, supported_ft in ipairs(clients[1].config.filetypes) do
        if supported_ft == ft then
          vim.g.config_lsp_client = '<' .. clients[1].name .. '>'
          return
        end
      end
      vim.g.config_lsp_client = '~'
    end,
  })
  return '%{g:config_lsp_client}'
end

local function hl(hl_group, text)
  return '%#' .. hl_group .. '#' .. text .. '%*'
end

local git_branch = setup_git_branch()
local lsp_client = setup_lsp_client()

local active_statusline = table.concat({
  '%<',
  hl('Function', git_branch),
  hl('String', '%t'),
  hl('Identifier', ' %h%r%m'),
  hl('Normal', '%='),
  hl('Constant', lsp_client),
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

local group = vim.api.nvim_create_augroup('config_statusline', {})
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
