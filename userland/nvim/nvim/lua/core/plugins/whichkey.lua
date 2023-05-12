return {
  {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 666
      require('which-key').setup({})
    end,
  },
}
