return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = { contrast = "hard" },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      vim.api.nvim_command("colorscheme gruvbox")
    end,
  }, -- colorscheme
}
