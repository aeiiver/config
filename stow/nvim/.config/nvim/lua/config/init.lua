local function set_options()
  -- context
  vim.opt.colorcolumn = '81'
  vim.opt.cursorline = true
  vim.opt.list = true
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.scrolloff = 12

  -- indent
  vim.opt.expandtab = true
  vim.opt.shiftwidth = 4
  vim.opt.smartindent = true
  vim.opt.softtabstop = 4
  vim.opt.tabstop = 4

  -- file
  vim.opt.swapfile = false
  vim.opt.undofile = true
end

local function map_keys()
  local function map(mode, lhs, rhs, opts)
    local merged = vim.tbl_extend('force', { silent = true }, opts or {})
    vim.keymap.set(mode, lhs, rhs, merged)
  end

  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  map('n', '<M-n>', [[:bnext<CR>:buffers<CR>]], { desc = 'Next buffer' })
  map('n', '<M-p>', [[:bprev<CR>:buffers<CR>]], { desc = 'Previous buffer' })
  map('n', '<M-j>', [[:lnext<CR>]], { desc = 'Next location item' })
  map('n', '<M-k>', [[:lprev<CR>]], { desc = 'Previous location item' })
  map('n', '<C-j>', [[:cnext<CR>]], { desc = 'Next quickfix item' })
  map('n', '<C-k>', [[:cprev<CR>]], { desc = 'Previous quickfix item' })

  map('n', '<leader>d', [[*Ncgn]], { desc = '*-substitute word', remap = true })
  map('v', '<leader>d', [[*Ncgn]], { desc = '*-substitute selection', remap = true })
  map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<left><left><left>]], { desc = 'Substitute', silent = false })
  map('v', '<leader>s', [[y:%s/\<<C-r>"\>/<C-r>"/gI<left><left><left>]], { desc = 'Substitute', silent = false })
  map('n', '<leader>v', '`[v`]', { desc = 'Select last changed or yanked text' })
  map('n', '<leader>x', [[:%s/\s\+$//e<CR>]], { desc = 'Trim trailing whitespaces' })
  map({'n', 'i', 'v', 'c'}, '<C-c>', [[<esc>]], { desc = 'Escape' })

  map('n', '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
  map('v', '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
  map('n', '<leader>p', [["+p]], { desc = 'Put from system clipboard' })
  map('v', '<leader>p', [["+p]], { desc = 'Put from system clipboard' })
  map('n', '<leader>P', [["+P]], { desc = 'Put from system clipboard' })
  map('v', '<leader>P', [["+P]], { desc = 'Put from system clipboard' })

  map('n', '<leader>t', function()
    vim.ui.input({ prompt = 'Command: ' }, function(input)
      if input ~= nil then
        vim.cmd('ter ' .. input)
        vim.api.nvim_create_autocmd('TermClose', {
          desc = 'Map quit buffer key for the custom terminal command',
          group = vim.api.nvim_create_augroup('config_custom_terminal_keymap', {}),
          buffer = 0,
          callback = function(args)
            map('n', 'q', [[i<CR>]], { desc = 'Quit', buffer = args.buf })
          end,
        })
      end
    end)
  end, { desc = 'Run external command' })

  map('v', '<leader>a', [[!column -to ' '<CR>]], { desc = 'Align' })

  map('n', '<leader>e', function()
    if not pcall(vim.cmd.Rexplore) then
      vim.cmd.Explore()
    end
  end, { desc = 'Netrw' })

  vim.api.nvim_create_autocmd('FileType', {
    desc = 'Map keys for Netrw buffers',
    group = vim.api.nvim_create_augroup('config_netrw_keymaps', {}),
    pattern = 'netrw',
    callback = function(args)
      map('n', 'h', [[-]], { desc = 'Go to parent directory', buffer = args.buf, remap = true })
      map('n', 'l', [[<CR>]], { desc = 'Open file', buffer = args.buf, remap = true })
    end,
  })

  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight yanks',
    group = vim.api.nvim_create_augroup('config_hightlight_yanks', {}),
    callback = function()
      vim.highlight.on_yank({ timeout = 50 })
    end,
  })
end

local function load_plugins()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup('config.plugins')
end

local function setup()
  set_options()
  map_keys()
  load_plugins()
end

return {
  setup = setup,
}
