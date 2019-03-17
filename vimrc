set mouse-=a
set number
set backspace=indent,eol,start
set smartindent
syntax on
filetype plugin on
set clipboard=unnamed
set rtp+=/usr/local/opt/fzf
execute pathogen#infect()
set cursorline
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

call SetupCommandAlias("nt","NERDTree")

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE 
highlight Comment ctermfg=DarkGrey
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

