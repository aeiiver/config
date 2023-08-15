local function setup_mason()
  require('mason').setup()
  require('mason-lspconfig').setup({ ensure_installed = { 'lua_ls' } })
end

local function setup_lspconfig()
  vim.keymap.set('n', '<leader>ll', vim.diagnostic.open_float, { desc = 'Show diagnostic message' })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Next diagnostic message' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Previous diagnostic message' })
  vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, { desc = 'Find workspace diagnostics' })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Find buffer diagnostics' })

  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Map LSP keys',
    group = vim.api.nvim_create_augroup('config_lspconfig_keymaps', {}),
    callback = function(args)
      local function supported(capability)
        return vim.lsp.get_client_by_id(args.data.client_id).server_capabilities[capability .. 'Provider']
      end
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
      map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
      map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
      map('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { desc = 'List workspace folders' })
      -- stylua: ignore end

      if supported('documentHighlight') then
        vim.opt_local.updatetime = 1000
        local group = vim.api.nvim_create_augroup('config_lspconfig_highlight', {})

        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          desc = 'Highlight references',
          group = group,
          buffer = args.buf,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd('CursorMoved', {
          desc = 'Clear reference highlights',
          group = group,
          buffer = args.buf,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end,
  })
end

local function setup_completion()
  require('lsp_signature').setup({
    floating_window = false,
    hint_prefix = '',
    toggle_key = '<C-k>',
    select_signature_key = '<C-M-h>',
  })

  local lspconfig = require('lspconfig')
  local servers = require('mason-lspconfig').get_installed_servers()
  local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

  for _, server in ipairs(servers) do
    local opts = {}
    if server == 'lua_ls' then
      opts.settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
    end
    opts.capabilities = lsp_capabilities
    lspconfig[server].setup(opts)
  end

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
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip',
      'ray-x/lsp_signature.nvim',
    },
    config = function()
      setup_mason()
      setup_lspconfig()
      setup_completion()
    end,
  },
}
