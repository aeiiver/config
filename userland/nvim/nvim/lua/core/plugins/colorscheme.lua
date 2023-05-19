return {
  {
    'savq/melange-nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      -- set colorscheme
      vim.cmd.colorscheme('melange')
      -- restore transparent background
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    end,
  },
}
