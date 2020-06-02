call plug#begin('~/vimfiles/bundle')
" these are for text
Plug 'dbmrq/vim-ditto', { 'for': ['md', 'tex', 'txt', 'rst'] }
Plug 'dbmrq/vim-redacted', { 'for': ['md', 'tex', 'txt', 'rst'] }
Plug 'reedes/vim-pencil', { 'for': ['md', 'tex', 'txt', 'rst'] }
Plug 'reedes/vim-wordy', { 'for': ['md', 'tex', 'txt', 'rst'] }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': ['md', 'tex', 'txt', 'rst'] }
" filetype specifics
Plug 'PProvost/vim-ps1', { 'for': ['ps1'] }
" functional
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'powershell -executionpolicy bypass -File install.ps1' }
Plug 'junegunn/fzf', { 'do': './install.ps1 --bin' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-syntastic/syntastic'
Plug 'ajh17/VimCompletesMe'
Plug 'Shougo/echodoc.vim'
" aesthetics
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'her/synicons.vim'
Plug 'albfan/nerdtree-git-plugin'
if has('nvim')
    Plug 'norcalli/nvim-colorizer.lua'
endif
call plug#end()

" set up language servers
" powershell currently doesn't work.
let g:LanguageClient_serverCommands = {
\ 'javascript': ['powershell', 'javascript-typescript-stdio.ps1'],
\ 'typescript': ['powershell', 'javascript-typescript-stdio.ps1'],
\ 'tex': ['~\vimfiles\langservers\latex\texlab.exe'],
\ 'yaml': ['node', '~\vimfiles\langservers\yaml-language-server\out\server\src\server.js', '--stdio'],
\ 'ps1': ['~\vimfiles\langservers\PowerShellEditorServices\PowerShellEditorServices\Start-EditorServices.ps1', '-Stdio'],
\ 'python': ['pyls']
\ }

" and the language client
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
autocmd BufWritePre *.yml :call LanguageClient#textDocument_formatting_sync()

" vim-markdown
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0

" echodoc
let g:echodoc#enable_at_startup = 1

syntax enable
filetype plugin indent on
set number
set noshowmode
set wrap linebreak nolist

" hide the scrollbar
set go-=r

" backspace usability
set backspace=2

" spacing
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set background=dark
set encoding=utf-8

" set up vim-airline correctly
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
    let g:airline_powerline_fonts = 1
    let g:airline_symbols.linenr = ""
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'
set laststatus=2

" font sizes are rendered differently, weirdly enough...
if !has('nvim')
    " nvim doesn't need this
    set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1
    set guifont=FiraCode\ NF:h11
else
    " set guifont=FiraCode\ NF:h13
    set guifont=FiraCode\ NF\ Retina:h13
endif
colorscheme base16-ocean

if has("termguicolors")
    set termguicolors
endif

let g:neovide_cursor_vfx_mode = "pixiedust"
let g:neovide_cursor_vfx_particle_lifetime = 1.3

" latex specific stuff
autocmd FileType latex,tex,md,markdown setlocal spell
" fix chktex American quote issues
let g:syntastic_tex_chktex_args = ("-l \"".$HOME."\\.chktexrc\"")

" limelight x goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" nerdtree ignore latex stuff
" also ignore vim swapfiles
" and node_modules
let NERDTreeIgnore = ['\.aux$', '\.dvi$', '\.ps$', '\.fdb_latexmk$', '\.log$', '\.pdf$', '\.fls$', '\.swp$', '\.bbl$', '\.bcf$', '\.blg$', '\.xml$', '\.ttt$', '\.fff$', 'node_modules']
" NERDTree folder +
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
" vim-devicons change icons
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''

" attempt to reset cursor?
" dotfile specific.
au VimLeave * set guicursor=a:ver1-blinkon1

" handy macro to change 2-space to 4
" set ts=2 noet | retab! | set et ts=4 | retab

" indentLine
let g:indentLine_char = '│'
" does weird things to JSON, so disable
autocmd FileType json IndentLinesDisable
autocmd FileType startify IndentLinesDisable

" fzf
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" fix re-source devicons
if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

" colorizer
if has('nvim')
    lua require 'colorizer'.setup({'*';}, { mode = 'foreground' })
endif

