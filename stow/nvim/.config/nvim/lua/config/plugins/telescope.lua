return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local bu = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', bu.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fg', bu.live_grep, { desc = 'Live grep' })
      vim.keymap.set('n', '<leader>fh', bu.help_tags, { desc = 'Help tags' })
      vim.keymap.set('n', '<leader>fc', bu.builtin, { desc = 'Telescope' })

      local ac = require('telescope.actions')
      require('telescope').setup({
        defaults = {
          mappings = {
            i = { ['<esc>'] = ac.close },
          },
        },
      })
    end,
  },
}
