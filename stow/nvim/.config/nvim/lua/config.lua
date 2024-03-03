local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

local function remap(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc, remap = true })
end

local M = {}

function M.setup()
  vim.opt.colorcolumn = '79'
  vim.opt.expandtab = true
  vim.opt.shiftwidth = 4
  vim.opt.tabstop = 4
  vim.opt.undofile = true

  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  map('n', '<M-n>', [[:bnext<CR>]], 'Next buffer')
  map('n', '<M-p>', [[:bprev<CR>]], 'Prev buffer')
  map('n', '<C-j>', [[:cnext<CR>]], 'Next :cc item')
  map('n', '<C-k>', [[:cprev<CR>]], 'Prev :cc item')
  map('n', '<M-j>', [[:lnext<CR>]], 'Next :ll item')
  map('n', '<M-k>', [[:lprev<CR>]], 'Prev :ll item')

  remap({ 'n', 'v' }, '<leader>d', [[*Ncgn]], 'Substitute')
  remap('n', '<leader>x', [[:%s/\s\+$//e<CR><C-l>]], 'Trim trailing whitespaces')
  map('n', '<leader>v', '`[v`]', 'Select last changed or yanked text')

  map({ 'n', 'v' }, '<leader>y', [["+y]], 'Yank into system clipboard')
  remap({ 'n', 'v' }, '<leader>Y', [["+Y]], 'Yank into system clipboard')
  map({ 'n', 'v' }, '<leader>p', [["+p]], 'Put from system clipboard')
  map({ 'n', 'v' }, '<leader>P', [["+P]], 'Put from system clipboard')

  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup(M.plugs)
end

M.plugs = {
  {
    'savq/melange-nvim',
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme('melange')
      vim.api.nvim_set_hl(0, 'Normal', { bg = '#080404' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#181010' })
      vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#080404' })
      vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#181010' })
      vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = '#181010' })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-context' },
    build = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'lua', 'vimdoc', 'bash' },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
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
    end,
  },

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
      local builtin = require('telescope.builtin')
      map('n', '<leader>ff', builtin.find_files, 'Find files')
      map('n', '<leader>fs', builtin.live_grep, 'Live grep')
      map('n', '<leader>fg', builtin.grep_string, 'Grep string')
      map('n', '<leader>fh', builtin.help_tags, 'Help tags')
      map('n', '<leader>fc', builtin.builtin, 'Telescope')

      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ['<esc>'] = require('telescope.actions').close,
            },
          },
        },
      })
      pcall(require('telescope').load_extension, 'fzf')
    end,
  },
  {
    'mbbill/undotree',
    config = function()
      map('n', '<leader>u', function()
        vim.cmd.UndotreeToggle()
        vim.cmd.UndotreeFocus()
      end, 'Undotree')
    end,
  },
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
  },
  {
    'nmac427/guess-indent.nvim',
    opts = {},
  },
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'folke/which-key.nvim',
    init = function()
      vim.opt.timeout = true
      vim.opt.timeoutlen = 300
    end,
    opts = {},
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      {
        'hrsh7th/nvim-cmp',
        dependencies = {
          {
            'L3MON4D3/LuaSnip',
            dependencies = { 'rafamadriz/friendly-snippets' },
            build = 'make install_jsregexp',
            cond = function()
              return vim.fn.executable('make') == 1
            end,
          },
          'saadparwaiz1/cmp_luasnip',

          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
        },
        event = 'VeryLazy',
      },

      {
        'folke/neodev.nvim',
        opts = {},
      },
      {
        'ray-x/lsp_signature.nvim',
        event = 'VeryLazy',
        opts = {
          floating_window = false,
          hint_prefix = '?',
          toggle_key = '<C-k>',
          select_signature_key = '<C-M-h>',
        },
      },
      {
        'j-hui/fidget.nvim',
        event = 'VeryLazy',
        opts = {},
      },
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        completion = { autocomplete = false },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'luasnip' },
          { name = 'buffer' },
        },
        mapping = {
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),

          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),

          ['<C-Space>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.abort()
            else
              cmp.complete()
            end
          end),

          ['<C-n>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<C-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
      })

      local lspconfig = require('lspconfig')
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local caps = require('cmp_nvim_lsp').default_capabilities(capabilities)

      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls' },
        handlers = {
          function(client)
            lspconfig[client].setup({ capabilities = caps })
          end,
        },
      })

      map('n', '<leader>ll', vim.diagnostic.open_float, 'Show diagnostic')
      map('n', '[d', vim.diagnostic.goto_prev, 'Next diagnostic')
      map('n', ']d', vim.diagnostic.goto_next, 'Previous diagnostic')
      map('n', '<leader>q', vim.diagnostic.setloclist, 'Find buffer diagnostics')
      map('n', '<leader>Q', vim.diagnostic.setqflist, 'Find workspace diagnostics')

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'Map LSP keys',
        group = vim.api.nvim_create_augroup('config_lsp_keymaps', {}),
        callback = function(ev)
          local function map2(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = ev.buf })
          end

          map2('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
          map2('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
          map2('n', '<leader>gi', vim.lsp.buf.implementation, 'Go to implementation')
          map2('n', '<leader>gt', vim.lsp.buf.type_definition, 'Go to type definition')
          map2('n', '<leader>gr', vim.lsp.buf.references, 'Find references')

          map2('n', 'K', vim.lsp.buf.hover, 'Hover details')
          map2('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature help')

          map2('n', '<leader>lr', vim.lsp.buf.rename, 'Rename symbol')
          map2({ 'n', 'v' }, '<leader>lc', vim.lsp.buf.code_action, 'Code actions')
          map2('n', '<leader>lf', function()
            vim.lsp.buf.format({ async = true })
          end, 'Format document')

          map2('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, 'Add workspace folder')
          map2('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder')
          map2('n', '<leader>lwl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, 'List workspace folders')
        end,
      })
    end,
  },
}

return M
