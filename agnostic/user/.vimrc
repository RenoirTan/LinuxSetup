" set tab settings
set tabstop=4
set shiftwidth=4
set smarttab
set autoindent
set smartindent

" set editor visuals
set colorcolumn=80,100
highlight ColorColumn ctermbg=238 guibg=#7f7f7f
set number

" bracket autocompletion
inoremap { {}<left>
inoremap {{ {
inoremap {} {}
inoremap [ []<left>
inoremap [[ [
inoremap [] []
inoremap ( ()<left>
inoremap (( (
inoremap () ()
inoremap " ""<left>
inoremap "" ""
inoremap ' ''<left>
inoremap '' ''

" vim-plug
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
if has('nvim')
	Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

" nerdcommenter
filetype plugin on

" vim-airline
let g:airline_theme='violet'

" deoplete.nvim
let g:deoplete#enable_at_startup = 1
