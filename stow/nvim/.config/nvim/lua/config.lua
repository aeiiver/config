local M = {}

function M.setup()
  vim.opt.expandtab  = true
  vim.opt.shiftwidth = 4
  vim.opt.tabstop    = 4
  vim.opt.signcolumn = 'no'
  vim.opt.undofile   = true

  vim.g.mapleader      = ' '
  vim.g.maplocalleader = ' '

  vim.keymap.set('n', [[<C-j>]], [[:cnext<CR>]], {desc = 'Next :cc item'})
  vim.keymap.set('n', [[<C-k>]], [[:cprev<CR>]], {desc = 'Prev :cc item'})
  vim.keymap.set('n', [[<M-j>]], [[:lnext<CR>]], {desc = 'Next :ll item'})
  vim.keymap.set('n', [[<M-k>]], [[:lprev<CR>]], {desc = 'Prev :ll item'})
  vim.keymap.set('n', [[<M-n>]], [[:bnext<CR>]], {desc = 'Prev buffer'})
  vim.keymap.set('n', [[<M-p>]], [[:bprev<CR>]], {desc = 'Next buffer'})
  vim.keymap.set('n', [[<leader>v]], '`[v`]',                      {desc = 'Select last changed or yanked text'})
  vim.keymap.set('n', [[<leader>x]], [[:%s/\s\+$//e<CR>:noh<CR>]], {desc = 'Trim trailing whitespaces'})
  vim.keymap.set({'n', 'v'}, [[<leader>a]], [[!column -to' '<CR>]], {desc = 'Align columns'})
  vim.keymap.set({'n', 'v'}, [[<leader>y]], [["+y]],                {desc = 'Yank into system clipboard'})

  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

  require('lazy').setup({
    {
      'savq/melange-nvim',
      priority = 42069,
      config = function()
        vim.opt.termguicolors = true
        vim.cmd.colorscheme('melange')
        vim.api.nvim_set_hl(0, 'Normal',       {bg = '#080404'})
        vim.api.nvim_set_hl(0, 'NormalFloat',  {bg = '#181010'})
        vim.api.nvim_set_hl(0, 'StatusLine',   {bg = '#181010'})
        vim.api.nvim_set_hl(0, 'StatusLineNC', {bg = '#181010'})
      end,
    },
    {
      'nvim-treesitter/nvim-treesitter',
      dependencies = {'nvim-treesitter/nvim-treesitter-context'},
      build = ':TSUpdate',
      config = function()
        ---@diagnostic disable-next-line
        require('nvim-treesitter.configs').setup({
          ensure_installed = {'lua', 'vimdoc', 'c'},
          sync_install = false,
          auto_install = true,
          highlight = {enable = true},
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
        require('treesitter-context').setup({
          enable = true,
          max_lines = 3,
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
          cond = function() return vim.fn.executable('make') == 1 end,
        },
      },
      config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', [[<leader>ff]], builtin.find_files,  {desc = 'Find files'})
        vim.keymap.set('n', [[<leader>fs]], builtin.live_grep,   {desc = 'Live grep'})
        vim.keymap.set('n', [[<leader>fg]], builtin.grep_string, {desc = 'Grep string'})
        vim.keymap.set('n', [[<leader>fh]], builtin.help_tags,   {desc = 'Help tags'})
        vim.keymap.set('n', [[<leader>fc]], builtin.builtin,     {desc = 'Telescope'})

        require('telescope').setup({
          defaults = {
            mappings = {
              i = {['<esc>'] = require('telescope.actions').close},
            },
          },
        })
        pcall(require('telescope').load_extension, 'fzf')
      end,
    },

    {
      'mbbill/undotree',
      config = function()
        vim.keymap.set('n', [[<leader>u]], function()
          vim.cmd.UndotreeToggle()
          vim.cmd.UndotreeFocus()
        end, {desc = 'Undotree'})
      end,
    },
    {
      'folke/which-key.nvim',
      init = function()
        vim.opt.timeout    = true
        vim.opt.timeoutlen = 300
      end,
      opts = {},
    },

    {'tpope/vim-fugitive'},
    {'numToStr/Comment.nvim',     opts = {}},
    {'nmac427/guess-indent.nvim', opts = {}},

    {
      'neovim/nvim-lspconfig',
      dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        {
          'hrsh7th/nvim-cmp',
          dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            {
              'L3MON4D3/LuaSnip',
              dependencies = {'rafamadriz/friendly-snippets'},
              build = 'make install_jsregexp',
              cond = function() return vim.fn.executable('make') == 1 end,
            },
            'saadparwaiz1/cmp_luasnip',
          },
          event = 'VeryLazy',
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
        {'folke/neodev.nvim', opts = {}},
      },
      config = function()
        local cmp     = require('cmp')
        local luasnip = require('luasnip')

        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup({
          completion = {autocomplete = false},

          snippet = {expand = function(args)
            luasnip.lsp_expand(args.body)
          end},

          sources = {
            {name = 'nvim_lsp'},
            {name = 'path'},
            {name = 'luasnip'},
            {name = 'buffer'},
          },

          mapping = {
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),

            ['<CR>'] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),

            ['<C-Space>'] = cmp.mapping(function()
              if cmp.visible() then cmp.abort() else cmp.complete() end
            end),

            ['<C-n>'] = cmp.mapping(function(fallback)
              if cmp.visible() then cmp.select_next_item() else fallback() end
            end, {'i', 's'}),

            ['<C-p>'] = cmp.mapping(function(fallback)
              if cmp.visible() then cmp.select_prev_item() else fallback() end
            end, {'i', 's'}),

            ['<C-M-n>'] = cmp.mapping(function(fallback)
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, {'i', 's'}),

            ['<C-M-p>'] = cmp.mapping(function(fallback)
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, {'i', 's'}),
          },
        })

        local lspconfig    = require('lspconfig')
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local caps         = require('cmp_nvim_lsp').default_capabilities(capabilities)

        require('mason').setup()
        require('mason-lspconfig').setup({
          ensure_installed = {'lua_ls', 'clangd'},
          handlers = { function(client) lspconfig[client].setup({ capabilities = caps }) end },
        })

        vim.keymap.set('n', [[]d]],         vim.diagnostic.goto_next,  {desc = 'Next diagnostic'})
        vim.keymap.set('n', [[[d]],         vim.diagnostic.goto_prev,  {desc = 'Previous diagnostic'})
        vim.keymap.set('n', [[<leader>ll]], vim.diagnostic.open_float, {desc = 'Show diagnostic'})
        vim.keymap.set('n', [[<leader>lq]], vim.diagnostic.setqflist,  {desc = 'Find workspace diagnostics'})

        vim.api.nvim_create_autocmd('LspAttach', {
          desc = 'Map LSP keys',
          group = vim.api.nvim_create_augroup('config_lsp_keymaps', {}),
          callback = function(ev)
            local function map(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, {desc = desc, buffer = ev.buf})
            end

            map('n', [[gd]],         vim.lsp.buf.definition,      'Go to definition')
            map('n', [[gD]],         vim.lsp.buf.declaration,     'Go to declaration')
            map('n', [[<leader>gi]], vim.lsp.buf.implementation,  'Go to implementation')
            map('n', [[<leader>gr]], vim.lsp.buf.references,      'Go to references')
            map('n', [[<leader>gt]], vim.lsp.buf.type_definition, 'Go to type definition')

            map('n', [[K]],     vim.lsp.buf.hover,          'Hover details')
            map('i', [[<C-k>]], vim.lsp.buf.signature_help, 'Signature help')

            local format_async = function() vim.lsp.buf.format({async = true}) end
            map({'n', 'v'}, [[<leader>lc]], vim.lsp.buf.code_action, 'Code actions')
            map('n',        [[<leader>lr]], vim.lsp.buf.rename,      'Rename symbol')
            map('n',        [[<leader>lf]], format_async,            'Format document')

            local list_workspace_folders = function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end
            map('n', [[<leader>lwa]], vim.lsp.buf.add_workspace_folder,    'Add workspace folder')
            map('n', [[<leader>lwr]], vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder')
            map('n', [[<leader>lwl]], list_workspace_folders,              'List workspace folders')
          end,
        })
      end,
    },
  })
end

return M
