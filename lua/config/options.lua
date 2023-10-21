local o = vim.opt

o.number = true
o.relativenumber = true
o.signcolumn = "yes"

-- default indentation
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.expandtab = true

-- indentation by file type
vim.cmd([[
  autocmd Filetype go setlocal ts=8 sw=8 sts=8 expandtab
  autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
  autocmd Filetype json setlocal ts=4 sw=4 sts=4 expandtab
  autocmd Filetype lua setlocal ts=2 sw=2 sts=2 expandtab
  autocmd Filetype python setlocal ts=4 sw=4 sts=4 expandtab
  autocmd Filetype rust setlocal ts=4 sw=4 sts=4 expandtab
  autocmd Filetype terraform setlocal ts=2 sw=2 sts=2 expandtab
  autocmd Filetype typescript setlocal ts=2 sw=2 sts=2 expandtab
  autocmd Filetype yaml setlocal ts=2 sw=2 sts=2 expandtab
]])
