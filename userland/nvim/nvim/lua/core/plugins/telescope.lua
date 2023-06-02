return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local b = require('telescope.builtin')
      local function grep() b.grep_string({ search = vim.fn.input('grep: ') }) end

      vim.keymap.set('n', '<leader>ff', b.find_files)
      vim.keymap.set('n', '<leader>fg', grep)
      vim.keymap.set('n', '<leader>fG', b.live_grep)
      vim.keymap.set('n', '<leader>fb', b.buffers)
      vim.keymap.set('n', '<leader>fh', b.help_tags)
      vim.keymap.set('n', '<leader>fc', b.builtin)
      vim.keymap.set('n', '<leader>fm', b.man_pages)
    end,
  },
}
