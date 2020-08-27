set mouse-=a
set number
set backspace=indent,eol,start
set smartindent
set showcmd
set incsearch
set inccommand=split
set tabstop=8

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'hashivim/vim-terraform'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'ludovicchabant/vim-gutentags'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'vimwiki/vimwiki'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'arzg/vim-rust-syntax-ext'
Plug 'preservim/nerdcommenter'
Plug 'wellle/targets.vim'
Plug 'itchyny/lightline.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'morhetz/gruvbox'
Plug 'nvie/vim-flake8'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

autocmd vimenter * colorscheme gruvbox

hi gitmessengerPopupNormal term=None guifg=#eeeeee guibg=#333333 ctermfg=255 ctermbg=234
hi gitmessengerHeader term=None guifg=#88b8f6 ctermfg=111
hi gitmessengerHash term=None guifg=#f0eaaa ctermfg=229
hi gitmessengerHistory term=None guifg=#fd8489 ctermfg=210

syntax on
filetype plugin on
set clipboard=unnamed
set rtp+=/usr/local/opt/fzf

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status'
      \ },
      \ }

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

""preview stuff""

let g:fzf_preview_window = 'right:60%'

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --ignore-case --hidden --follow --glob "!.git/*" --glob "!.terraform/*" '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

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
highlight Done cterm=bold ctermfg=green ctermbg=NONE
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


inoremap <C-j> <Esc>

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

inoremap {;<CR> {<CR>};<ESC>O

set undodir=~/.vimdid
set undofile

let g:terraform_fmt_on_save=1

let @v='v$%'

" Filetype
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2
autocmd Filetype gitcommit setlocal spell
autocmd Filetype markdown setlocal spell
autocmd Filetype *.txt setlocal spell

" leader cmd"
let mapleader = "\<Space>"
nnoremap <leader><leader> <c-^>
nnoremap <leader>s :write<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>q :bufdo q<CR>
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

nnoremap <silent> <leader>e :call Fzf_dev()<CR>

"syntastic"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=5

"" GODOT STUFF""
nnoremap <buffer> <F5> :GodotRun<CR>
nnoremap <buffer> <F6> :GodotRunCurrent<CR>
nnoremap <buffer> <F7> :GodotRunFZF<CR>

"" Git Messenger color ""
hi gitmessengerPopupNormal term=None guifg=#eeeeee guibg=#333333 ctermfg=255 ctermbg=234
hi gitmessengerHeader term=None guifg=#88b8f6 ctermfg=111
hi gitmessengerHash term=None guifg=#f0eaaa ctermfg=229
hi gitmessengerHistory term=None guifg=#fd8489 ctermfg=210

