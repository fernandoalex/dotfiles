call plug#begin()

" stuff depends on this
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-telescope/telescope.nvim'

Plug 'airblade/vim-rooter'
Plug 'ap/vim-buftabline'
Plug 'ap/vim-css-color'

" Git stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'stsewd/fzf-checkout.vim'

" themes
Plug 'morhetz/gruvbox'

Plug 'hashivim/vim-terraform'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'arzg/vim-rust-syntax-ext'
Plug 'preservim/nerdcommenter'

Plug 'wellle/targets.vim'
Plug 'itchyny/lightline.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-scripts/ReplaceWithRegister'
"Plug 'wellle/context.vim'
Plug 'Yggdroot/indentLine'
" LSP plugins

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

"Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'}

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'mogelbrod/vim-jsonpath'
Plug 'hrsh7th/nvim-cmp'

" Testing plugins
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'TimUntersberger/neogit'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rcarriga/nvim-notify'
Plug 'mrjones2014/dash.nvim', { 'do': 'make install' }
Plug 'ThePrimeagen/harpoon'

Plug 'nvim-orgmode/orgmode'
Plug 'ThePrimeagen/git-worktree.nvim'

call plug#end()

lua << EOF

local nvim_lsp = require'lspconfig'

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
},
sources = cmp.config.sources({
	{ name = 'nvim_lsp' },
	-- { name = 'luasnip' }, -- For luasnip users.
	-- { name = 'ultisnips' }, -- For ultisnips users.
	-- { name = 'snippy' }, -- For snippy users.
	{ name = 'orgmode' },
	},{
		{ name = 'buffer' },
	})
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.rust_analyzer.setup{
	on_attach = on_attach,
	capabilities = capabilities
}

nvim_lsp.terraformls.setup{
	on_attach = on_attach,
	capabilities = capabilities
}

nvim_lsp.pylsp.setup {
	on_attach = on_attach,
	capabilities = capabilities
}

nvim_lsp.clangd.setup {
	on_attach = on_attach,
	capabilities = capabilities
}

nvim_lsp.gopls.setup {
	cmd = {"gopls", "serve"},
	on_attach = on_attach,
	capabilities = capabilities
}

nvim_lsp.phpactor.setup {
	on_attach = on_attach,
	capabilities = capabilities
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup_ts_grammar({
  org_agenda_files = {'~/git/org/*.org'},
  org_default_notes_file = '~/git/org/index.org',
})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

require("telescope").load_extension("git_worktree")

local neogit = require('neogit')

neogit.setup {}
EOF

let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentLine_setConceal = 0
let g:indentLine_concealcursor = ""

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

" Folding
set foldenable 
set foldmethod=syntax
set foldlevel=99

" JsonPath

let g:jsonpath_register = 'p'

"""" BEGIN remaps

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

inoremap <C-j> <Esc>

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
nnoremap <silent> <C-l> :Files %:h<CR>
nnoremap <C-b> :Buffer<CR>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Center when jumping
nnoremap n nzz
nnoremap N Nzz
nnoremap G Gzz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

inoremap {;<CR> {<CR>};<ESC>O
inoremap {<CR> {<CR>}<ESC>O

nnoremap Y y$

" better break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <C-f> :silent !tmux neww tmux-jump.sh<CR>
nnoremap <C-t> :silent !tmux neww tmux-tmp-vi.sh<CR>

" get file name and line
nnoremap <leader>cfn :let @*=expand("%").":".line(".")<CR>

" gets the current branch name and send to register a
command Bn let @a = system("git rev-parse --abbrev-ref HEAD")
	
" worktree stuff
nnoremap <leader>wt :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
nnoremap <leader>wc :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>

""" END remaps

filetype plugin on
set clipboard=unnamed
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5, 'highlight': 'Comment' } }
let $FZF_DEFAULT_OPTS='--reverse'

" Lightline
let g:lightline = {
	\'colorscheme': 'wombat',
	\'active': {
	\	'left': [ [ 'mode', 'paste' ],
	\            [ 'redonly', 'gitbranch', 'filename', 'modified' ] ]
	\},
	\'component_function': {
	\	'gitbranch': 'FugitiveHead',
	\},
	\}

""preview stuff""

let g:fzf_preview_window = 'right:60%'

"" sneak
let g:sneak#label = 1
let g:sneak#s_next = 1

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --ignore-case --hidden --follow --glob "!.git/*" --glob "!.terraform/*" --glob "!venv/*" '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

fun! SetupCommandAlias(from, to)
	exec 'cnoreabbrev <expr> '.a:from
        	\ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        	\ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_show_hidden = 1

set undodir=~/.vimdid
set undofile

let g:terraform_fmt_on_save=1

" Filetype
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2
autocmd Filetype gitcommit setlocal spell
autocmd Filetype markdown setlocal spell
autocmd Filetype *.txt setlocal spell

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

"" vim-rooter
let g:rooter_patterns = ['.git', 'Makefile']
let g:rooter_patterns = ['!.git/worktrees']

autocmd vimenter * colorscheme gruvbox
autocmd VimEnter * hi Normal ctermbg=none

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
set colorcolumn=120
set noshowmode

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" harpoon
nnoremap <leader>ha <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>ho <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>
nnoremap <leader>h1 <cmd>lua require("harpoon.ui").nav_file(1)<cr>
nnoremap <leader>h2 <cmd>lua require("harpoon.ui").nav_file(2)<cr>
nnoremap <leader>h3 <cmd>lua require("harpoon.ui").nav_file(3)<cr>

" Neogit stuff
hi NeogitNotificationInfo guifg=#80ff95
hi NeogitNotificationWarning guifg=#fff454
hi NeogitNotificationError guifg=#c44323

hi def NeogitDiffAddHighlight guibg=#404040 guifg=#859900
hi def NeogitDiffDeleteHighlight guibg=#404040 guifg=#dc322f
hi def NeogitDiffContextHighlight guibg=#333333 guifg=#b2b2b2
hi def NeogitHunkHeader guifg=#cccccc guibg=#404040
hi def NeogitHunkHeaderHighlight guifg=#cccccc guibg=#4d4d4d

nnoremap <leader>ngo <cmd>lua require('neogit').open({ kind = "vsplit" })<cr>

