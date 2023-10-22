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
}
