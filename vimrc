set mouse-=a
set number
set backspace=indent,eol,start
set smartindent
set showcmd
set tw=120

syntax on
filetype plugin on
set clipboard=unnamed
set rtp+=/usr/local/opt/fzf
execute pathogen#infect()
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

call SetupCommandAlias("nt","NERDTree")

highlight CursorLine term=bold cterm=NONE ctermfg=NONE ctermbg=black gui=NONE guifg=DarkGrey guibg=NONE 
highlight LineNr term=bold cterm=NONE ctermfg=Grey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE 
highlight Comment ctermfg=DarkGrey

hi CursorLineNR cterm=bold ctermfg=LightGrey

set hlsearch
set cursorline

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set number relativenumber

let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0

set completeopt-=preview

let g:go_highlight_diagnostic_warnings = 0
let g:go_highlight_diagnostic_errors = 0

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

let mapleader = "\<Space>"
nnoremap <leader><leader> <c-^>

inoremap <C-j> <Esc>

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap ` ``<left>
inoremap { {  }<left><left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

set undodir=~/.vimdid
set undofile

let g:terraform_fmt_on_save=1

let @v='v$%'

autocmd Filetype yaml setlocal tabstop=2

" leader cmd"
nnoremap <leader>w :write<CR>
nnoremap <leader>r :Rg<CR>
