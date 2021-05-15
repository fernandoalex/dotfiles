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
set updatetime=300
set signcolumn=yes

call plug#begin()

Plug 'airblade/vim-rooter'
Plug 'ap/vim-buftabline'

" Git stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'stsewd/fzf-checkout.vim'

" color stuff
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'

Plug 'hashivim/vim-terraform'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'vimwiki/vimwiki'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'arzg/vim-rust-syntax-ext'
Plug 'preservim/nerdcommenter'
"Plug 'preservim/nerdtree'
Plug 'wellle/targets.vim'
Plug 'itchyny/lightline.vim'
"Plug 'nvie/vim-flake8'
"Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'justinmk/vim-sneak'
Plug 'wellle/context.vim'
Plug 'Yggdroot/indentLine'
" LSP plugins

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

"Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'}

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'

call plug#end()

" LanguageServer stuff
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ }

lua << EOF

local nvim_lsp = require'lspconfig'

local on_attach = function(client)
    require'completion'.on_attach(client)
end

nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

EOF

let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_defaultGroup = 'SpecialKey'
set list lcs=tab:\|\ 

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
"nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs
\ lua require'lsp_extensions'.inlay_hints{ prefix = '// ', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

" note that if you are using Plug mapping you should not use `noremap` mappings.
nmap <F5> <Plug>(lcn-menu)
nmap <silent> gd <Plug>(lcn-definition)
"nmap <silent> gD <Plug>(coc-implementation)
nmap <silent> <F2> <Plug>(lcn-rename)


" Initialize plugin system
set foldlevel=99
autocmd vimenter * colorscheme gruvbox


" remaps
let mapleader = "\<Space>"
nnoremap <leader>gf :Gvdiff<CR>
nnoremap gfh :diffget //2<CR>
nnoremap gfl :diffget //3<CR>
nnoremap <leader>co :GBranches<CR>
nnoremap <leader><leader> <c-^>
nnoremap <leader>w :write<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>q :bufdo q<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" BufTabstuff
nnoremap <C-M> :bnext<CR>
nnoremap <C-N> :bprev<CR>

syntax on
filetype plugin on
set clipboard=unnamed
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5, 'highlight': 'Comment' } }
let $FZF_DEFAULT_OPTS='--reverse'

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

""preview stuff""

let g:fzf_preview_window = 'right:60%'

"" sneak
let g:sneak#label = 1
let g:sneak#s_next = 1

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
highlight LanguageClientCodeLens ctermfg=DarkGrey 

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
let @c="0i{{/*\<Esc>A*/}}"

" Filetype
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2
autocmd Filetype gitcommit setlocal spell
autocmd Filetype markdown setlocal spell
autocmd Filetype *.txt setlocal spell

" leader cmd"
let g:vimwiki_list = [{ 'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md' }]

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

"" Git Messenger color ""
hi gitmessengerPopupNormal term=None guifg=#eeeeee guibg=#333333 ctermfg=255 ctermbg=234
hi gitmessengerHeader term=None guifg=#88b8f6 ctermfg=111
hi gitmessengerHash term=None guifg=#f0eaaa ctermfg=229
hi gitmessengerHistory term=None guifg=#fd8489 ctermfg=210

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
