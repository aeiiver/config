local function attach(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- stylua: ignore start
  map('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, { expr = true, desc = 'Next hunk' })

  map('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, { expr = true, desc = 'Previous hunk' })

  map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
  map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
  map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Stage hunk' })
  map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Reset hunk' })
  map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Unstage last staged hunk' })
  map('n', '<leader>hh', gs.preview_hunk, { desc = 'Preview hunk' })
  map('n', '<leader>hd', gs.diffthis, { desc = 'Show diff' })
  map('n', '<leader>hx', gs.toggle_deleted, { desc = 'Show deleted' })
  map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, { desc = 'Blame current line' })
  map('n', '<leader>hq', function() gs.setloclist(0, 0) end, { desc = 'Find buffer hunks' })
  map('n', '<leader>hQ', function() gs.setqflist('all') end, { desc = 'Find workspace hunks' })
  -- stylua: ignore end
end

return {
  {
    'lewis6991/gitsigns.nvim',
    opts = { on_attach = attach },
  },
}
