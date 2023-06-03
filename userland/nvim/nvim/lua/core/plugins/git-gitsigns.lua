local function attach(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, { expr = true })

  map('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, { expr = true })

  -- Actions
  map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
  map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Unstage hunk' })
  map('n', '<leader>hR', gs.reset_hunk, { desc = 'Reset hunk' })
  map('n', '<leader>hh', gs.preview_hunk_inline, { desc = 'Preview hunk' })
  map('n', '<leader>hb', gs.toggle_current_line_blame, { desc = 'Blame line' })
  map(
    'n',
    '<leader>hB',
    function() gs.blame_line({ full = true }) end,
    { desc = 'Blame line more' }
  )
  map('n', '<leader>hd', gs.diffthis, { desc = 'Diff' })
  map(
    'n',
    '<leader>hD',
    function() gs.diffthis('~') end,
    { desc = 'Full diff' }
  )
  map('n', '<leader>hx', gs.toggle_deleted, { desc = 'Show deleted' })
end

return {
  {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup({ on_attach = attach }) end,
  },
}
