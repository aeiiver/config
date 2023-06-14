return {
  {
    'j-hui/fidget.nvim',
    branch = 'legacy',
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
