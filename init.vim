"NeoBundle Scripts-----------------------------

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=/home/tome/.vim/bundle/neobundle.vim/

  " Required:
  call neobundle#begin(expand('/home/tome/.vim/bundle'))

  " Let NeoBundle manage NeoBundle
  " Required:
  NeoBundleFetch 'Shougo/neobundle.vim'

  " Add or remove your Bundles here:
  NeoBundle 'carlitux/deoplete-ternjs', { 'build': { 'mac': 'npm install -g tern', 'unix': 'npm install -g tern' }}
  NeoBundle 'ternjs/tern_for_vim'
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'flazz/vim-colorschemes'
  NeoBundle 'scrooloose/syntastic'
  NeoBundle 'vim-airline/vim-airline'
  NeoBundle 'vim-airline/vim-airline-themes'
  NeoBundle 'justinmk/vim-sneak'
  NeoBundle 'airblade/vim-gitgutter'
  NeoBundle 'vim-airline/vim-airline-themes'
  NeoBundle 'junegunn/fzf.vim'
  NeoBundle 'godlygeek/tabular'
  NeoBundle 'plasticboy/vim-markdown'
  NeoBundle 'euclio/vim-markdown-composer'
  NeoBundle 'blindFS/vim-taskwarrior'
  NeoBundle 'maksimr/vim-jsbeautify'
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'Shougo/deoplete.nvim'
  NeoBundle 'posva/vim-vue'

  " You can specify revision/branch/tag.
  NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

  " Required:
  call neobundle#end()

  " Required:
  filetype plugin indent on

  " If there are uninstalled bundles found on startup,
  " this will conveniently prompt you to install them.
  NeoBundleCheck
  "End NeoBundle Scripts-------------------------


" ###########- Key Mappings -########### 

let mapleader = "\<Space>"
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>rv :source $MYVIMRC<cr>

nnoremap <leader>p "+P
inoremap jj <esc>
inoremap <esc> <nop>

" ###########- PLUGIN SETTINGS -###########

" Deoplete.
set runtimepath+=/home/tome/.vim/bundle/deoplete.nvim/
let g:deoplete#enable_at_startup = 1
" Let <Tab> also do completion
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
let g:tern#is_show_argument_hints_enabled = 1

" Tern use deoplete.
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete

"Add extra filetypes
let g:tern#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ '...'
                \ ]


" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Airline 
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1

" Syntastic
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" FZF
set rtp+=~/.fzf
nnoremap <leader>o :FZF -m<cr>
nnoremap <leader>r :FZF -m ~/home/tome/repos<cr>
nnoremap <leader>1 :FZF -m ../<cr>
nnoremap <leader>2 :FZF -m ../../<cr>
nnoremap <leader>3 :FZF -m ../../../<cr>
nnoremap <leader>b :Buffers<cr>

" JS Beuatify
map <c-f> :call JsBeautify()<cr>
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" Taskwarrior
nnoremap <leader>t :tabnew <bar> :TW<CR>
highlight taskwarrior_tablehead ctermbg=white ctermfg=22 guifg=#000057


" save session
nnoremap <leader>w :mksession<CR>

" move to beginning/end of line
nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>

map <c-n> <c-w><
map <c-m> <c-w>>

" ###########- Settings -########### 

set relativenumber

" whitespace indent
set expandtab
set shiftwidth=2
set softtabstop=2

" Use 256 colours 
set t_Co=256

" highlight search
set hlsearch

syntax enable
colorscheme badwolf 

" Hit enter in the file browser to open the selected file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Change directory to the current buffer when opening files.
set autochdir

" absolute width of netrw window
let g:netrw_winsize = -28

" do not display info on the top of window
let g:netrw_banner = 0

" tree-view
let g:netrw_liststyle = 3

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" use the previous window to open file
let g:netrw_browse_split = 4

" ###########- Functions -########### 

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>
