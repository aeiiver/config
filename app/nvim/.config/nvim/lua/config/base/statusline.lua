local function git_branch()
  -- if you switch to another branch from vim, then gg because this probably won't update
  local proc = io.popen('git rev-parse --abbrev-ref HEAD 2>/dev/null', 'r')
  if not proc then
    return
  end
  local stdout = proc:read('*a')
  proc:close()

  local branch = stdout:match('^(.+)%s+')
  if branch == nil then
    vim.g.config_git_branch = ''
  else
    vim.g.config_git_branch = '(' .. branch .. ')'
  end

  return '%{g:config_git_branch}'
end

local function lsp_client()
  vim.api.nvim_create_autocmd({ 'BufEnter', 'LspAttach' }, {
    desc = 'Update LSP client list in the statusline',
    group = vim.api.nvim_create_augroup('config_lsp_client', {}),
    callback = function()
      local clients = {}
      vim.lsp.for_each_buffer_client(0, function(client, client_id, bufnr)
        table.insert(clients, client.name)
      end)
      if #clients == 0 then
        vim.g.config_lsp_client = '~'
        return
      end
      vim.g.config_lsp_client = '<' .. table.concat(clients, '+') .. '>'
    end,
  })

  return '%{g:config_lsp_client}'
end

local function setup(active, inactive)
  local active_str = table.concat(active or {}, '')
  local inactive_str = table.concat(inactive or {}, '')

  local group = vim.api.nvim_create_augroup('config_statusline', {})
  vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
    desc = 'Switch statusline to active',
    group = group,
    callback = function()
      vim.opt_local.statusline = active_str
    end,
  })
  vim.api.nvim_create_autocmd({ 'BufLeave', 'WinLeave' }, {
    desc = 'Switch statusline to inactive',
    group = group,
    callback = function()
      vim.opt_local.statusline = inactive_str
    end,
  })
  vim.api.nvim_create_autocmd('FileType', {
    desc = 'Switch statusline to inactive when entering Netrw',
    group = group,
    pattern = 'netrw',
    callback = function()
      vim.opt_local.statusline = inactive_str
    end,
  })
end

local function hlcolor(hl_group, str)
  return '%#' .. hl_group .. '#' .. str .. '%*'
end

local active = {
  '%<',
  hlcolor('Function', '%(' .. git_branch() .. ' %)'),
  hlcolor('String', '%t'),
  hlcolor('Identifier', '%( %h%r%m%w%)'),
  hlcolor('Normal', '%='),
  hlcolor('Constant', lsp_client()),
  hlcolor('Normal', '%='),
  hlcolor('Statement', '%(%y %)'),
  hlcolor('Character', '%((%{&ff}) %)'),
  hlcolor('Identifier', '0x%B'),
  hlcolor('PreProc', '%( (%l:%c%V)%)'),
}

local inactive = {
  '%<',
  hlcolor('String', '%t'),
  hlcolor('Identifier', '%( %h%r%m%w%)'),
  hlcolor('Normal', '%='),
  hlcolor('Statement', '%(%y %)'),
  hlcolor('Identifier', '0x%B'),
  hlcolor('PreProc', '%( (%l:%c%V)%)'),
}

setup(active, inactive)
