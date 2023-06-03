return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local b = require('telescope.builtin')
      local function grep() b.grep_string({ search = vim.fn.input('grep: ') }) end

      vim.keymap.set('n', '<leader>ff', b.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fg', grep, { desc = 'Grep string' })
      vim.keymap.set('n', '<leader>fG', b.live_grep, { desc = 'Live grep' })
      vim.keymap.set('n', '<leader>fb', b.buffers, { desc = 'Buffers' })
      vim.keymap.set('n', '<leader>fh', b.help_tags, { desc = 'Vim help tags' })
      vim.keymap.set('n', '<leader>fc', b.builtin, { desc = 'Telescope' })
      vim.keymap.set('n', '<leader>fm', b.man_pages, { desc = 'Man pages' })
    end,
  },
}
