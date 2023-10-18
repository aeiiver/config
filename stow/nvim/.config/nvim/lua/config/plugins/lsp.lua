local lua_ls = {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
}

local function prepare_cmp()
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

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'path' },
    },
  })
end

local function setup_lsp()
  local lspc = require('lspconfig')

  local caps = lspc.util.default_config
  local cmp_caps = require('cmp_nvim_lsp').default_capabilities()
  caps.capabilities = vim.tbl_deep_extend('force', caps.capabilities, cmp_caps)

  require('mason').setup()
  require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls' },
    handlers = {
      function(srv)
        local opts = caps
        if srv == 'lua_ls' then
          opts = vim.tbl_deep_extend('force', opts, lua_ls)
        end
        lspc[srv].setup(opts)
      end,
    },
  })

  require('lsp_signature').setup({
    floating_window = false,
    hint_prefix = '?',
    toggle_key = '<C-k>',
    select_signature_key = '<C-M-h>',
  })
end

local function map_keys()
  vim.keymap.set('n', '<leader>ll', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Next diagnostic' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Previous diagnostic' })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Find buffer diagnostics' })
  vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, { desc = 'Find workspace diagnostics' })

  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Map LSP keys',
    group = vim.api.nvim_create_augroup('config_lspconfig_keymaps', {}),
    callback = function(args)
      local function map(mode, lhs, rhs, opts)
        local options = opts or {}
        options.buffer = args.buf
        vim.keymap.set(mode, lhs, rhs, options)
      end

      -- stylua: ignore start
      map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
      map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
      map('n', '<leader>gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
      map('n', '<leader>gt', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
      map('n', '<leader>gr', vim.lsp.buf.references, { desc = 'Find references' })
      map('n', 'K', vim.lsp.buf.hover, { desc = 'Show hover details' })
      map('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature help' })

      map('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'Rename symbol' })
      map({ 'n', 'v' }, '<leader>lc', vim.lsp.buf.code_action, { desc = 'Code actions' })
      map('n', '<leader>lf', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format' })

      map('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
      map('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
      map('n', '<leader>lwl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { desc = 'List workspace folders' })
      -- stylua: ignore end
    end,
  })
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'ray-x/lsp_signature.nvim',

      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',

      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      prepare_cmp()
      setup_lsp()
      map_keys()
    end,
  },
}
