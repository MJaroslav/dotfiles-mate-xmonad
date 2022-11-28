:set number
:set relativenumber
:set autoindent
:set tabstop=8
:set shiftwidth=4
:set smarttab
:set softtabstop=0
:set mouse=a
:set expandtab
 
:set updatetime=300

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'andweeb/presence.nvim'
Plug 'lambdalisue/suda.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'

call plug#end()

:set completeopt-=preview
:let g:suda_smart_edit = 1

" Why I not found this in airline README???

let g:airline#extensions#tabline#enabled = 1

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
