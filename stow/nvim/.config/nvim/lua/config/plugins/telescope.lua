return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable('make') == 1
        end,
      },
    },
    config = function()
      local bu = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', bu.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fs', bu.live_grep, { desc = 'Live grep' })
      vim.keymap.set('n', '<leader>fg', bu.grep_string, { desc = 'Grep string' })
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
      pcall(require('telescope').load_extension, 'fzf')
    end,
  },
}
