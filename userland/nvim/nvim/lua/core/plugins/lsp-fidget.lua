return {
  {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup({
        window = {
          relative = 'win',
          blend = 0,
        },
      })
    end,
  },
}
