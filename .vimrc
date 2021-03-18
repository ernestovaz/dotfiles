filetype plugin on
syntax on
filetype indent on
set relativenumber
highlight LineNr ctermbg=233 ctermfg=LightGray
packadd lightline
packadd vim-css-color
set laststatus=2
set noshowmode
set ttimeout ttimeoutlen=50
" yell
inoremap <C-y> <esc>gUiw`]a
:vnoremap <C-c> "+y
:vnoremap <C-d> "+d

if !has('gui_running')
	set t_Co=256
endif

let g:lightline = {
	\'colorscheme': 'deus',
	\} 
