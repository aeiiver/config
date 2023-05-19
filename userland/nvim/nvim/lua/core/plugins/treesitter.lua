return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'lua', 'vimdoc' },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true, additional_vim_regex_highlighting = false },
      })
    end,
  },
  {
    'nvim-treesitter/playground',
    config = function()
      require('nvim-treesitter.configs').setup({
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { 'BufWrite', 'CursorHold' },
        },
      })
    end,
  },
}
