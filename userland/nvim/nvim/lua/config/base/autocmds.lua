local function group(name)
  return vim.api.nvim_create_augroup('config_' .. name, {})
end

vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  desc = 'Check if any buffers were changed outside of Vim',
  group = group('checktime'),
  command = 'checktime',
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanks',
  group = group('highlight_yanks'),
  callback = function()
    vim.highlight.on_yank({ timeout = 50 })
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Restore last cursor position',
  group = group('restore_cursor'),
  callback = function()
    local row_col = vim.api.nvim_buf_get_mark(0, [["]])
    local line_count = vim.api.nvim_buf_line_count(0)
    if row_col[1] >= 1 and row_col[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, row_col)
    end
  end,
})
