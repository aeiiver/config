return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>ff', builtin.find_files)
      vim.keymap.set('n', '<leader>fh', builtin.help_tags)
      vim.keymap.set('n', '<leader>fg', builtin.live_grep)
      vim.keymap.set('n', '<leader>fG', function()
        builtin.grep_string({ search = vim.fn.input('grep: ') })
      end)
      vim.keymap.set('n', '<leader>fb', builtin.buffers)
      vim.keymap.set('n', '<leader>fm', builtin.marks)
      vim.keymap.set('n', '<leader>fM', builtin.man_pages)
      vim.keymap.set('n', '<C-p>', builtin.git_files)
    end,
  },
}
