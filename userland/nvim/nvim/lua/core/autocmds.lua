local function augroup(name)
  return vim.api.nvim_create_augroup('core_' .. name, {})
end

vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  desc = 'Check if any buffers were changed outside of Vim',
  group = augroup('checktime'),
  command = 'checktime',
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanks',
  group = augroup('highlight_yanks'),
  callback = function() vim.highlight.on_yank({ timeout = 50 }) end,
})

vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Resize window splits when the vim window gets resized',
  group = augroup('resize_splits'),
  callback = function() vim.cmd('tabdo wincmd =') end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Restore last cursor position',
  group = augroup('restore_cursor'),
  callback = function()
    local row_col = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if row_col[1] >= 1 and row_col[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, row_col)
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Map some keys for Netrw',
  group = augroup('map_netrw_keys'),
  pattern = 'netrw',
  callback = function()
    -- stylua: ignore start
    vim.keymap.set('n', 'h', '-', { desc = 'Go parent directory', buffer = true, remap = true })
    vim.keymap.set('n', 'l', '<CR>', { desc = 'Open file', buffer = true, remap = true })
    -- stylua: ignore end
  end,
})
