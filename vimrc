set mouse-=a
set number
set backspace=indent,eol,start
set smartindent
set showcmd
set incsearch

syntax on
filetype plugin on
set clipboard=unnamed
set rtp+=/usr/local/opt/fzf

""preview stuff""

let g:fzf_preview_window = 'right:60%'

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)


execute pathogen#infect()
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

call SetupCommandAlias("nt","NERDTree")

highlight CursorLine term=NONE cterm=NONE ctermfg=NONE ctermbg=black gui=NONE guifg=DarkGrey guibg=NONE 
highlight LineNr term=bold cterm=NONE ctermfg=Grey ctermbg=black gui=NONE guifg=DarkGrey guibg=NONE 
highlight Comment ctermfg=DarkGrey
highlight Todo cterm=bold ctermfg=red ctermbg=NONE
highlight CursorLineNR cterm=bold ctermfg=LightGrey ctermbg=black

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
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_show_hidden = 1

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
inoremap (; ();<left><left>
inoremap [ []<left>
inoremap ` ``<left>
inoremap { {  }<left><left>
inoremap } {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

set undodir=~/.vimdid
set undofile

let g:terraform_fmt_on_save=1

let @v='v$%'

autocmd Filetype yaml setlocal tabstop=2

" leader cmd"
nnoremap <leader>s :write<CR>
nnoremap <leader>r :Rg<CR>
let g:vimwiki_list = [{ 'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md' }]

"tags"
let g:gutentags_ctags_exclude = ['*.git/*', '*.terraform/*']

"" auto set paste""
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
