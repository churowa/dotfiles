""" Initial Neovim setup """

call plug#begin('~/.config/nvim/plugged')

Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'tpope/vim-fugitive'
Plug 'w0ng/vim-hybrid'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'fatih/vim-nginx' , {'for' : 'nginx'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-sayonara'
Plug 'Shougo/deoplete.nvim'
Plug 'scrooloose/syntastic'

call plug#end()

" Python settings.
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_skip_check = 1

" Change leader to comma.
let mapleader = ','

" Mouse cheats.
set mouse=a

" Color Scheme.
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
set background=dark
colorscheme hybrid
hi Search term=reverse cterm=reverse gui=reverse ctermfg=109
highlight clear SignColumn
highlight clear LineNr
hi clear SpellBad
hi SpellBad cterm=underline

" Fix clipboard for tmux (shouldn't alter normal behavior).
set clipboard^=unnamed
set clipboard^=unnamedplus

" Formatting.
"set wrap                        " Do wrap long lines
set lazyredraw                  " Buffer screen updates
"set relativenumber              " Show relative lines up or down
set noerrorbells                " No beeps
set hidden                      " It hides buffers instead of closing them
set number                      " Show current line number
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set history=10000               " Store lots of history
set ignorecase                  " Case insensitive search
set smartcase                   " If search contains Upper case, it becomes case sensitive
set ssop-=options               " do not store global and local values in a session
set ssop-=folds                 " do not store folds
set nofoldenable                " Stop the folds
set nostartofline               " Keep cursor position when switching buffers
set list                        " Show unwanted spaces/tabs
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.          " Show whitespace chars
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set spell                       " Enable spellcheck
set nocursorcolumn              " Speed up syntax highlighting
set nocursorline                " Speed up syntax highlighting
syntax sync minlines=256
set synmaxcol=300
set completeopt=menu,menuone

" Undo settings.
set undofile
if has('persistent_undo')
  set undofile
  set undodir=~/.config/nvim/tmp/undo//
endif

" Jump by visual line, not physical line.
noremap j gj
noremap k gk

" jk == escape
imap <special> jk <Esc>

" Move line of text either up or down using - and _
noremap _ :call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR>
noremap - ddp

" Clear search with `<leader>/`.
nmap <silent> <leader>/ :nohlsearch<CR>

" Toggle code paste.
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Fix a few shift key bindings.
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

" Tab mappings.
nnoremap <leader>[ :bp<cr>
nnoremap <leader>] :bn<cr>
nnoremap <silent> <leader>q :Sayonara<CR>

" Quick window change.
nnoremap <leader>w <C-w><C-w>
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Splitting.
map <Leader>- :split<CR>
map <Leader><bar> :vsplit<CR>

" Airline.
let g:bufferline_echo = 0
let g:airline_section_c = '%f'
let g:airline_theme = 'hybrid'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Syntastic.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

" TagBar.
nnoremap <silent> <leader>tt :TagbarToggle<CR>

" Vim-Go.
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1

au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>r <Plug>(go-rename)
au FileType go nmap <leader>b <Plug>(go-build)

" CtrlP upgrade: `ag`.
if executable('ag')
    " Use ag over grep.
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and
    " respects .gitignore.
    let g:ctrlp_user_command = 'ag -i %s -l --nocolor --nogroup -g ""'

    " ag is fast enough that CtrlP doesn't need to cache.
    let g:ctrlp_use_caching = 0
endif

" Deoplete
let g:deoplete#enable_at_startup = 1

" Vimfiler settings.
let g:vimfiler_safe_mode_by_default = 0
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 1
let g:vimfiler_as_default_explorer = 1        " Open it as a sidebar just like NERDTree
let g:vimfiler_no_default_key_mappings = 1    " Let's create our own mappings
let g:vimfiler_ignore_pattern = '^\%(.git\|.idea\|.DS_Store\)$'

let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_marked_file_icon = '*'

au FileType vimfiler nmap <buffer> c <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_copy_file)
au FileType vimfiler nmap <buffer> m <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_move_file)
au FileType vimfiler nmap <buffer> d <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_delete_file)
au FileType vimfiler nmap <buffer> u <Plug>(vimfiler_switch_to_parent_directory)
au FileType vimfiler nmap <buffer> R <Plug>(vimfiler_redraw_screen)
au FileType vimfiler nmap <buffer> o <Plug>(vimfiler_expand_or_edit)
au FileType vimfiler nmap <buffer> <Enter> <Plug>(vimfiler_expand_or_edit)
au FileType vimfiler nmap <buffer> C <Plug>(vimfiler_cd_or_edit)
au FileType vimfiler nmap <buffer> t <Plug>(vimfiler_expand_tree_recursive)
au FileType vimfiler nmap <buffer> T <Plug>(vimfiler_expand_tree_recursive)
au FileType vimfiler nmap <buffer> r <Plug>(vimfiler_switch_to_project_directory)
au FileType vimfiler nmap <buffer> . <Plug>(vimfiler_toggle_visible_ignore_files)
au FileType vimfiler nmap <buffer> p <Plug>(vimfiler_print_filename)
au FileType vimfiler nmap <buffer> s <Plug>(vimfiler_split_edit_file)
au FileType vimfiler nmap <buffer> gr   <Plug>(vimfiler_grep)
au FileType vimfiler nmap <buffer> gf   <Plug>(vimfiler_find)
au FileType vimfiler nmap <buffer> g?   <Plug>(vimfiler_help)
au FileType vimfiler nmap <buffer> gc   <Plug>(vimfiler_cd_file)

call vimfiler#custom#profile('default', 'context', {
      \ 'parent': 1,
      \ 'auto_expand': 1,
      \ })

function! s:VimFilerExplorerFix()
  exec 'VimFilerExplorer -find'
endfunction
noremap <Leader>e :<C-u>call <SID>VimFilerExplorerFix()<cr>
