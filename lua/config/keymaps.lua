vim.cmd([[
  let mapleader = " "

  " map escape to kj
  inoremap kj <ESC>

  " cancel search term highlights
  nnoremap <leader>j :noh<CR>

  " open quicklist
  nnoremap <leader>co :copen<CR>

  " close quicklist
  nnoremap <leader>cc :cclose<CR>

  " Next item on quicklist
  nnoremap <leader>cn :cn<cr>

  " Previous item on quicklist
  nnoremap <leader>cp :cp<cr>
]])
