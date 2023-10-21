return {
  { 'tpope/vim-commentary' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-fugitive' },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>b",
        function()
          require("neo-tree.command").execute({ toggle = true })
        end,
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>p', builtin.find_files, {})
      vim.keymap.set('n', '<leader>rg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>rr', builtin.grep_string, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      local trouble = require("trouble")
      vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end)
      vim.keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end)
      vim.keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end)
      vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end)
      vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end)
      vim.keymap.set("n", "gR", function() trouble.toggle("lsp_references") end)
    end,
  }
}
