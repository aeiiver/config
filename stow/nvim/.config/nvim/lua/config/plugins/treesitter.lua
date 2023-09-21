return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'lua', 'query', 'vimdoc' },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-M-j>',
            node_incremental = '<C-M-j>',
            scope_incremental = '<C-M-l>',
            node_decremental = '<C-M-k>',
          },
        },
      })
      require('treesitter-context').setup({})
    end,
  },
}
