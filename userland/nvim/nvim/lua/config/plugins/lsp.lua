local function setup_mason()
  require('mason').setup()
  require('mason-lspconfig').setup({ ensure_installed = { 'lua_ls' } })
end

local function setup_lspconfig()
  -- stylua: ignore start
  vim.keymap.set('n', '<leader>gl', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Next diagnostic' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Previous diagnostic' })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Find buffer diagnostics' })
  vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, { desc = 'Find workspace diagnostics' })
  -- stylua: ignore end

  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Map LSP keys',
    group = vim.api.nvim_create_augroup('config_lspconfig_keys', {}),
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
      map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go definition' })
      map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go declaration' })
      map('n', '<leader>gi', vim.lsp.buf.implementation, { desc = 'Go implementation' })
      map('n', '<leader>gt', vim.lsp.buf.type_definition, { desc = 'Go type definition' })
      map('n', '<leader>gr', vim.lsp.buf.references, { desc = 'Find references' })
      map('n', 'K', vim.lsp.buf.hover, { desc = 'Show hover details' })
      map('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature help' })
      map('n', '<leader>r', vim.lsp.buf.rename, { desc = 'Rename symbol' })
      map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
      map('n', '<leader>lf', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format' })
      map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
      map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
      map('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { desc = 'List workspace folders' })
      -- stylua: ignore end

      if supported('documentHighlight') then
        -- stylua: ignore
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

  cmp.setup({
    completion = { autocomplete = false },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'luasnip' },
    },
    mapping = {
      ['<CR>'] = cmp.mapping.confirm({ select = true }),

      ['<C-Space>'] = cmp.mapping(function()
        if cmp.visible() then
          cmp.abort()
        else
          cmp.complete()
        end
      end),

      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),

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
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
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
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
    },
    config = function()
      setup_mason()
      setup_lspconfig()
      setup_completion()
    end,
  },
}
