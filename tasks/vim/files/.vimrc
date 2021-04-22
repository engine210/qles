" Install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/joshdick/onedark.vim'
call plug#end()

set ai
set tabstop=4
set shiftwidth=4
set nu
set incsearch
filetype indent on
syntax on
colorscheme onedark
set t_Co=256
set pastetoggle=<F2>