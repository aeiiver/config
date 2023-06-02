local function augroup(name)
  return vim.api.nvim_create_augroup('core_' .. name, { clear = true })
end

-- reload buffers that were changed outside of vim
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  command = 'checktime',
})

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function() vim.highlight.on_yank({ timeout = 50 }) end,
})

-- autoresize splits whenever the window gets resized
vim.api.nvim_create_autocmd('VimResized', {
  group = augroup('autoresize_splits'),
  callback = function() vim.cmd('tabdo wincmd =') end,
})

-- go to the last location after opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_location'),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- mkdir if necessary when saving a file
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup('auto_mkdir'),
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- set some keymaps for netrw
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('netrw_keymaps'),
  pattern = 'netrw',
  callback = function()
    local keymap = function(lhs, rhs)
      vim.keymap.set('n', lhs, rhs, { buffer = true, remap = true })
    end
    -- open parent directory
    keymap('h', '-')
    -- open file
    keymap('l', '<cr>')
  end,
})
