"====================================================================================
"Plugins
"
"Concept:
"Using vim/plugged for installation.
"====================================================================================

call plug#begin('~/.vim/plugged')
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'rhysd/vim-clang-format'
Plug 'funorpain/vim-cpplint'
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
call plug#end()
"====================================================================================



"====================================================================================
"Settings
"
"Concept:
"Solarized theme and line centering.
"====================================================================================

"colorscheme
set termguicolors
colo corvine_light
let g:lightline = {
      \ 'colorscheme': 'selenized_light',
      \ }
let g:lightline.enable = {
            \ 'statusline': 1,
            \ 'tabline': 1 
            \ }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"allow undo previous to closing
if has('persistent_undo')
    set undodir=~/.vim/undo
    set undofile

endif

"show line numbers
set number

"show cursor line
augroup BgHighlight
	autocmd!
	autocmd WinEnter * call OnWindowEnter()
	autocmd WinLeave * call OnWindowLeave()
augroup END

function! OnWindowEnter()
	hi CursorLine gui=underline cterm=underline
	set cuc
	set cul
endfunction
	
function! OnWindowLeave()
	set nocuc
	set nocul
endfunction

"show status line
set laststatus=2

"show tabline
set showtabline=2

"highlight searched word
set hlsearch!
set nohlsearch

"show autocomplete options on tab
set wildmenu

"display full path in title
set title

"scrolling
set scrolloff=999

"turn off swap
set noswapfile

"set autoindent
set autoindent
set smartindent

"Set backspace behavior
set backspace=indent,eol,start

"netrw settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3

"Disable save warning
set hidden

"Automatically set directory to current file
autocmd BufEnter * silent! lcd %:p:h

"Do not store globals and lobal values in a session
set ssop-=options    
set ssop-=globals

"Use tabs for buffer switching
set switchbuf=usetab

"window splitting
set splitbelow
set splitright

"====================================================================================



"====================================================================================
"Function sourcing
"====================================================================================

source ~/.vim/plugins/minimal-find-replace.vim
source ~/.vim/plugins/minimal-session.vim
source ~/.vim/plugins/minimal-split-tools.vim
source ~/.vim/plugins/minimal-surround.vim
source ~/.vim/plugins/minimal-tabswitcher.vim

"====================================================================================



"====================================================================================
"Mappings
"
"Concept:
"For one time actions, Leader then key in succcession is mapped.
"For actions likely to be repeated, Shift+key is mapped.
"
"Maps that use marker 'X' to keep current position have a *.
"====================================================================================


"Essentials
"-----------------------------------------------------

"Set leader
let mapleader = (' ')

"Map semiclon
nnoremap ; :

"Esc mapping
inoremap jj <Esc>

"reload config
noremap <F5> :source ~/.vimrc<CR>:noh<CR>:echom "Updated configuration!"<CR>

"Open vimrc
noremap <F6> :tabe ~/.vimrc<CR>

"Save
noremap <Leader><Leader> :w<CR>

"Quit
noremap <Leader>w :q<CR>

"session handling
nnoremap <Leader>=s :SaveSession<CR>
nnoremap <Leader>=q :QuitSession<CR>
nnoremap <Leader>=r :RestoreSession<CR>

"-----------------------------------------------------


"Abbreviated listing commands
"-----------------------------------------------------

"cd
nnoremap <Leader>c :cd <C-d>

"buffer navigation
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader><tab> :b#<CR>

"marker navigation
nnoremap <Leader>m :<C-u>marks<CR>:normal! `

"list buffers
nnoremap <Leader>l :BLines<CR>
nnoremap <Leader>L :Lines<CR>

"print registers
nnoremap <Leader>r :registers<CR>

"-----------------------------------------------------


"Navigation
"-----------------------------------------------------

"page up/down
nnoremap <Leader>d <C-d>
nnoremap <Leader>u <C-u>

"window navigation
nnoremap J <C-W><C-J>
nnoremap K <C-W><C-K>
nnoremap L <C-W><C-L>
nnoremap H <C-W><C-H>

"EasyMotion setup
map , <Plug>(easymotion-prefix)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

"Disable arrow keys in non-insert mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Right> <Nop>
noremap <Left> <Nop>

"allow up and down for wrapped line
nnoremap j gj
nnoremap k gk

"mapping start and end
noremap <Leader>. $
noremap <Leader>, ^
 
"vim tab switcher
nnoremap <C-l> :tabn<CR>
nnoremap <C-h> :tabp<CR>
nnoremap ) :call TabRight()<CR>
nnoremap ( :call TabLeft()<CR>

"-----------------------------------------------------


"Exploration
"-----------------------------------------------------

"Explorer
nnoremap <Leader>e :Explore<CR>

"New tab
nnoremap <Leader>t :tabe<CR>:Explore<CR>

"New splits
nnoremap <Leader>vo :call MaximizeToggle()<CR>
nnoremap <Leader>vv :vs<CR>:Explore<CR>
nnoremap <Leader>vV :vert botright split<CR>:Explore<CR>
nnoremap <Leader>vh :sp<CR>:Explore<CR>
nnoremap <Leader>vH :botright split<CR>:Explore<CR>

"-----------------------------------------------------


"Edits
"-----------------------------------------------------

"macro shortcut
nnoremap Q @q
vnoremap Q :norm @q<CR>


"Bracket auto-completes
inoremap <F2> <Esc>yypa/<Esc>O
inoremap {<CR>  {<CR>}<Esc>O
inoremap [<CR>  [<CR>]<Esc>O
inoremap (<CR>  (<CR>)<Esc>O

"surround commands
nnoremap cs :call ChangeSurround()<CR>
nnoremap ds :call DeleteSurround()<CR>

"yanking file *
noremap <Leader>y mXggVGy`X

"-----------------------------------------------------
"====================================================================================



"====================================================================================
"Formatting
"
"Concept:
"Formatters for c, js, and py and syntastic linters.
"====================================================================================

augroup filetype_c
  autocmd!
  :autocmd FileType c,cpp,h setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
  :autocmd FileType c,cpp,h ClangFormatAutoEnable
  :autocmd FileType c,cpp,h  noremap <C-/> // <Esc>
augroup end
let g:syntastic_cpp_cpplint_exec = 'cpplint'
let g:syntastic_cpp_checkers = ['cpplint']

augroup filetype_js
  autocmd!
  :autocmd BufWritePost *.js execute ':PrettierAsync'
  :autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  :autocmd FileType javascript noremap <C-/> // <Esc>
augroup end
"let g:prettier#config#parser = 'babylon'

augroup filetype_py
  autocmd!
  :autocmd BufWritePost *.py execute ':Black' 
  :autocmd FileType python,py setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  :autocmd FileType python,py noremap <C-/> A# <Esc>
augroup end

augroup filetype_json
	autocmd!
	:autocmd BufWritePost *.json execute ':%!jq .'
augroup end
let g:syntastic_python_flake8_exec = 'flake8'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore="E203, E501"'
