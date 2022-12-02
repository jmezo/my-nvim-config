" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" colorschemes
Plug 'morhetz/gruvbox'

" file tree
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'

" file search (fuzzyfind)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" go plugin
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" node extension host, language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-rust-analyzer']

" git integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" for easy commenting, changing brackets/parentheses
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" github copilot
Plug 'github/copilot.vim'

" Initialize plugin system
call plug#end()
" PlugInstall - to install plugins
" PlugUpdate - update plugins
" PlugClean - remove unlisted plugins
" PlugUpgrade - update vim-plug itself



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


"**** color schemes setup and settings ****
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
colorscheme gruvbox



"**** indentation by file type ****
" by default, the indent is 2 spaces.
set shiftwidth=2
set softtabstop=2
set tabstop=2
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype python setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype go setlocal ts=8 sw=8 sts=0 expandtab



" *** fzf config ***
" find files (tracked by git)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden -g "!.git/"'
nnoremap <leader>p :Files<CR>



" *** NERDTree config ***
let g:NERDTreeShowHidden = 1
"toggle nerdtree
" nnoremap <silent> <C-b> :NERDTreeToggle<CR>
nnoremap <leader>b :NERDTreeToggle<CR>



" *** coc.nvim config ***
" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
 
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation.
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Show documentation in preview window.
nnoremap <silent> <leader>k :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add command to autofix eslint errors (requires 'coc-eslint' extension)
command! -nargs=0 Fix :CocCommand eslint.executeAutofix

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent> <leader>cca  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <leader>cce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <leader>ccc  :<C-u>CocList commands<cr>
" Resume latest coc list.
nnoremap <silent> <leader>ccp  :<C-u>CocListResume<CR>



""" *** vim-go config ***
command GML GoMetaLinter
"let g:go_fmt_autosave = 0
"let g:go_imports_autosave = 0
" let g:go_metalinter_autosave = 1
