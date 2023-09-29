local function set_options()
  -- context
  vim.opt.colorcolumn = '80'
  vim.opt.cursorline = true
  vim.opt.number = true
  vim.opt.relativenumber = true

  -- indent
  vim.opt.expandtab = true
  vim.opt.shiftwidth = 4
  vim.opt.tabstop = 4

  -- file
  vim.opt.swapfile = false
  vim.opt.undofile = true
end

local function map_keys()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  vim.keymap.set('n', '<M-j>', [[:lnext<CR>]], { desc = 'Next location item' })
  vim.keymap.set('n', '<M-k>', [[:lprev<CR>]], { desc = 'Previous location item' })
  vim.keymap.set('n', '<C-j>', [[:cnext<CR>]], { desc = 'Next quickfix item' })
  vim.keymap.set('n', '<C-k>', [[:cprev<CR>]], { desc = 'Previous quickfix item' })

  vim.keymap.set('n', '<leader>d', [[*Ncgn]], { desc = 'Star-substitute word', remap = true })
  vim.keymap.set('v', '<leader>d', [[*Ncgn]], { desc = 'Star-substitute selection', remap = true })

  vim.keymap.set('n', '<leader>x', [[:%s/\s\+$//e<CR><C-l>]], { desc = 'Trim trailing whitespaces', remap = true })
  vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<C-c>', [[<esc>]], { desc = 'Escape' })

  vim.keymap.set('n', '<leader>v', '`[v`]', { desc = 'Select last changed or yanked text' })
  vim.keymap.set('n', '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
  vim.keymap.set('v', '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
  vim.keymap.set('n', '<leader>p', [["+p]], { desc = 'Put from system clipboard' })
  vim.keymap.set('v', '<leader>p', [["+p]], { desc = 'Put from system clipboard' })
  vim.keymap.set('n', '<leader>P', [["+P]], { desc = 'Put from system clipboard' })
  vim.keymap.set('v', '<leader>P', [["+P]], { desc = 'Put from system clipboard' })

  vim.keymap.set('n', '<leader>e', function()
    if not pcall(vim.cmd.Rexplore) then
      vim.cmd.Explore()
    end
  end, { desc = 'Netrw' })

  vim.api.nvim_create_autocmd('FileType', {
    desc = 'Map keys for Netrw buffers',
    group = vim.api.nvim_create_augroup('config_netrw_keymaps', {}),
    pattern = 'netrw',
    callback = function(args)
      vim.keymap.set('n', 'h', [[-]], { desc = 'Go to parent directory', buffer = args.buf, remap = true })
      vim.keymap.set('n', 'l', [[<CR>]], { desc = 'Open file', buffer = args.buf, remap = true })
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
