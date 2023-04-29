return {
  {
    'ramojus/mellifluous.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      vim.cmd.colorscheme('mellifluous')
      -- restore transparent background
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    end,
  },
}
