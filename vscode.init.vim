"**** basic vim settings ****
set signcolumn=yes
set number
set relativenumber
" map leader to Space
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

nnoremap <leader>gd <Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>
nnoremap <leader>gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
nnoremap <leader>gr <Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>
nnoremap <leader>gt <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>

nnoremap <leader>k <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
nnoremap <leader>rn <Cmd>call VSCodeNotify('editor.action.rename')<CR>
