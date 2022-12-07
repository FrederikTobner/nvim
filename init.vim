call plug#begin()
  " Include NERDTree Plugin for a file treeviewer
  Plug 'scrooloose/nerdtree'
  " For special fileicons using the file viewer
  Plug 'ryanoasis/vim-devicons'
  " Monokai based color theme
  Plug 'sainnhe/sonokai'
  " Fuzzy file finder
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " Conquerer of Completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Conquerer of Completion sub-plugins
  let g:coc_global_extensions = ['coc-clangd', 'coc-cmake', 'coc-css', 'coc-git', 'coc-html', 'coc-java', 'coc-json', 'coc-omnisharp', 'coc-prettier', 'coc-sql', 'coc-vimlsp', 'coc-tsserver', 'coc-xml', 'coc-yaml']
  Plug 'nvim-lualine/lualine.nvim'
  " If you want to have icons in your statusline choose one of these
  Plug 'kyazdani42/nvim-web-devicons'
  " Treesitter Plugin to improve the snytax highlighting  
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " language Server provider
  Plug 'neovim/nvim-lspconfig'
  " tagbar to get a overview about the contents of the file
  Plug 'preservim/tagbar'
  " Cellox plugin for vim / neovim
  Plug '~/Projects/VimPlugins/cellox.vim'
  " Vim one (Atom one clone) color schheme
  Plug 'rakr/vim-one'
  " Solarized color theme
  Plug 'lifepillar/vim-solarized8'
  " Dracula colorscheme
  Plug 'folke/tokyonight.nvim'
  " Adds the diffview plugin and it's dependency the planery plugin
  Plug 'nvim-lua/plenary.nvim'
  Plug 'sindrets/diffview.nvim'
call plug#end()

" Treesitter configuration
lua << EOF
require('treesitterconfig')
EOF

" Lualine config
lua << EOF
require('lualineconfig')
EOF

" LSP Config
lua << EOF
require'lspconfig'.clangd.setup{}
EOF

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif


" options
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set mouse=a
" Show line numbers
set number
" Show line numbers that are not selected as relative line numbers
set relativenumber
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2

" Makes sonokai background transparent
let g:sonokai_transparent_background = 1
   
" Set colorscheme to Sonokai
colorscheme sonokai

" Setup NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Fuzzy file finder config
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

filetype plugin indent on
" Enable syntax highlighting
syntax on
set t_Co=256

" True color if available
let term_program=$TERM_PROGRAM

" Check for conflicts with Apple Terminal app
if term_program !=? 'Apple_Terminal'
    set termguicolors
else
    if $TERM !=? 'xterm-256color'
        set termguicolors
    endif
endif
