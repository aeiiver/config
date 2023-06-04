local function describe(desc, opts)
  if opts then
    return vim.tbl_deep_extend('force', opts, { desc = desc })
  end
  return { desc = desc }
end

local function setup_mason()
  require('mason').setup()
  require('mason-lspconfig').setup({ ensure_installed = { 'lua_ls' } })
end

local function setup_lspconfig()
  -- global mappings
  -- stylua: ignore start
  vim.keymap.set('n', '<leader>gl', vim.diagnostic.open_float, describe('Show diagnostic details'))
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, describe('Next diagnostic'))
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, describe('Previous diagnostic'))
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, describe('Find buffer diagnostics'))
  vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, describe('Find workspace diagnostics'))
  -- stylua: ignore end

  -- buffer-local mappings
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lspconfig_attach', {}),
    desc = 'LSP attach',
    callback = function(event)
      -- stylua: ignore start
      local opts = { buffer = event.buf }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, describe('Go definition', opts))
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, describe('Go declaration', opts))
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, describe('Go implementation', opts))
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, describe('Find references', opts))
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, describe('Go type definition', opts))
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, describe('Show hover info', opts))
      vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, describe('Show signature help', opts))
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, describe('Add workspace folder', opts))
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, describe('Remove workspace folder', opts))
      vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, describe('List workspace folders', opts))
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, describe('Rename symbol', opts))
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, describe('Show code actions', opts))
      vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format({ async = true }) end, describe('Format', opts))
      -- stylua: ignore end

      local group = vim.api.nvim_create_augroup('lspconfig_highlight', {})
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = group,
        desc = 'LSP highlight',
        buffer = event.buf,
        callback = function() vim.lsp.buf.document_highlight() end,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        group = group,
        desc = 'LSP clear highlights',
        buffer = event.buf,
        callback = function() vim.lsp.buf.clear_references() end,
      })
    end,
  })
end

local function setup_completion()
  local lspconfig = require('lspconfig')
  local servers = require('mason-lspconfig').get_installed_servers()
  local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
  local with_lsp_capabilities = { capabilities = lsp_capabilities }

  for _, server in ipairs(servers) do
    local opts = {}
    if server == 'lua_ls' then
      opts = { settings = { Lua = { diagnostics = { globals = { 'vim' } } } } }
    end
    opts = vim.tbl_deep_extend('force', opts, with_lsp_capabilities)
    lspconfig[server].setup(opts)
  end

  local cmp = require('cmp')
  local luasnip = require('luasnip')

  cmp.setup({
    completion = { autocomplete = false },
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
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
