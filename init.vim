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
  let g:coc_global_extensions = ['coc-clangd', 'coc-cmake', 'coc-css', 'coc-git','coc-go', 'coc-html', 'coc-json', 'coc-omnisharp', 'coc-prettier', 'coc-sql', 'coc-vimlsp', 'coc-tsserver', 'coc-xml', 'coc-yaml']
  Plug 'nvim-lualine/lualine.nvim'
  " Used by the lua line and lsp-trouble
  Plug 'kyazdani42/nvim-web-devicons'
  " Treesitter Plugin to improve the snytax highlighting  
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " language Server provider
  Plug 'neovim/nvim-lspconfig'
  " Allows to configure the lsp highlighting
  Plug 'folke/lsp-colors.nvim'
  " Addding custom symbols for lsp messages
  Plug 'folke/lsp-trouble.nvim'
  " tagbar to get a overview about the contents of the file
  Plug 'preservim/tagbar'
  " Cellox plugin for vim / neovim
  Plug '~/Projects/VimPlugins/cellox.vim'
  " CHIP-8 plugin for vim / neovim
  Plug '~/Projects/VimPlugins/chip8.vim'
  " Vim one (Atom one clone) color schheme
  Plug 'rakr/vim-one'
  " Solarized color theme
  Plug 'lifepillar/vim-solarized8'
  " Dracula colorscheme
  Plug 'folke/tokyonight.nvim'
  " Adds the diffview plugin and it's dependency the planery plugin
  Plug 'nvim-lua/plenary.nvim'
  Plug 'sindrets/diffview.nvim'
  " To quickly comment out code wiith gcc for a line and gc for a selected
  " block
  Plug 'tpope/vim-commentary'
  " To run tests directly in neovim
  Plug 'vim-test/vim-test'
  Plug 'github/copilot.vim'
call plug#end()

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

" Use Carriage return to confirm completion,  means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" could be remapped by other vim plugin, try `:verbose imap.
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

" Expand tab stops to whitespace sequences
set expandtab
" Size of a tabstop
set tabstop=2
set shiftwidth=2

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

" Toggle Tagbar
nnoremap <silent> <C-l> :TagbarToggle<CR>

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

" use alt+hjkl to move between split panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Fuzzy file finder config
" Use Ctrl-F to open the file finder
nnoremap <C-f> :FZF<CR>
" Search apps folder (for angular development)
command! -bang AppFiles call fzf#vim#files('./src/app', fzf#vim#with_preview(), <bang>0)
" Search source folder
command! -bang SourceFiles call fzf#vim#files('./src', fzf#vim#with_preview(), <bang>0)
" Search test folder
command! -bang TestFiles call fzf#vim#files('./test', fzf#vim#with_preview(), <bang>0)
" Toggle preview window with Ctrl-S
let g:fzf_preview_window = ['right,50%', 'ctrl-s']
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-v': 'vsplit'
  \}

filetype plugin indent on
" Enable syntax highlighting
syntax on
" Use 256-bit terminal colors
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


" Scripts in lua folder
lua << EOF
require('treesitter_config')
EOF

lua << EOF
require('lualine_config')
EOF

lua << EOF
require('lsp_config')
EOF

lua << EOF
require('lspcolors_config')
EOF

lua << EOF
require('lsptrouble_config')
EOF
