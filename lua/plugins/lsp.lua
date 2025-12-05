return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- npm install -g typescript-language-server typescript
      vim.lsp.config('ts_ls', {})
      vim.lsp.enable('ts_ls')

      -- npm i -g pyright
      vim.lsp.config('pyright', {})
      vim.lsp.enable('pyright')

      -- brew install rust-analyzer
      -- cargo install ra-multiplex (--version 0.2.3)
      -- ra-multiplex server
      -- docs: https://github.com/pr2502/ra-multiplex
      vim.lsp.config('rust_analyzer', {
        -- cmd = vim.lsp.rpc.connect("127.0.0.1", 27631),
        -- init_options = {
        --   lspMux = {
        --     version = "1",
        --     method = "connect",
        --     server = "rust-analyzer",
        --   },
        -- },
      })
      vim.lsp.enable('rust_analyzer')

      vim.lsp.config('gopls', {})
      vim.lsp.enable('gopls')

      -- brew install lua-language-server
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {
                'vim',
                'require'
              },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              -- https://github.com/neovim/nvim-lspconfig/issues/1700#issuecomment-1033127328
              checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      })
      vim.lsp.enable('lua_ls')

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      -- and configure diagnostics display
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          vim.diagnostic.config({ virtual_text = false })

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
        end,
      })
    end,
  }
}
