return {
  {
    'savq/melange-nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    lazy = false,
    priority = 6942,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme('melange')
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    end,
  },
}
