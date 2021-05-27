" super basic init.vim so I can actually do stuff in other places
set backspace=indent,eol,start
set completeopt-=preview
set completeopt=menuone,noinsert,noselect
set cursorline
set hlsearch
set inccommand=split
set incsearch
set mouse-=a
set number
set number relativenumber
set shiftwidth=8
set shortmess+=c
set showcmd
set smartindent
set softtabstop=8 
set tabstop=8


" remaps
let mapleader = "\<Space>"
nnoremap <leader><leader> <c-^>
nnoremap <leader>w :write<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>q :bufdo q<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

syntax on

highlight CursorLine term=NONE cterm=NONE ctermfg=NONE ctermbg=black gui=NONE guifg=DarkGrey guibg=NONE 
highlight LineNr term=bold cterm=NONE ctermfg=Grey ctermbg=black gui=NONE guifg=DarkGrey guibg=NONE 
highlight Comment ctermfg=DarkGrey
highlight Todo cterm=bold ctermfg=red ctermbg=NONE
highlight Done cterm=bold ctermfg=green ctermbg=NONE
highlight CursorLineNR cterm=bold ctermfg=LightGrey ctermbg=black


inoremap <C-j> <Esc>

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

inoremap {;<CR> {<CR>};<ESC>O

let @v='v$%'
let @c="0i{{/*\<Esc>A*/}}"

" Filetype
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2
autocmd Filetype gitcommit setlocal spell
autocmd Filetype markdown setlocal spell
autocmd Filetype *.txt setlocal spell
