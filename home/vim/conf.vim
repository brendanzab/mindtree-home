" Sync clipboards
set clipboard=unnamedplus

" Smart indenting specific to files
filetype indent plugin on
set autoindent smartindent

" Turn on syntax highlighting.
syntax enable
syntax on

" Tab business (set to 4 spaces)
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

" File saving and confirmation
set confirm
set autowriteall

" be iMproved, required
set nocompatible

" Improves drawing with fast terminals
set ttyfast

" Show cursor in ruler
set ruler

" Better command line completion
set wildmenu

" Show what you are typing as a command.
set showcmd

" Keep at least 3 lines above/below when scrolling
set scrolloff=3

" Uncomment this to enable mouse support in console.
" set mouse=a

" Turn on line numbers
set number

" Sync clipboards
set clipboard=unnamedplus

" Make backspace delete over newlines etc
set backspace=2

" Ignore case using / but consider when uppercase is specified
set ignorecase
set smartcase

" Move cursor to matched string while searching and highlight
set incsearch
set hlsearch

" Always show statusline
set laststatus=2

" Keep all backup and temp files in the same place
set backup
call mkdir($HOME . "/.vim/backup", "p", 0700)
call mkdir($HOME . "/.vim/tmp", "p", 0700)
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Automatically set directory to current file
set autochdir

" Soft wrap text
set wrap linebreak nolist

" Set off matching parenthesis
highlight MatchParen ctermbg=4

" Change line number colour.
highlight LineNr ctermfg=darkblue

" Map jj to escape
inoremap jj <Esc>

" A little easier to navigate with j/k.
nnoremap j gj
nnoremap k gk

" Map ctrl j/k to scroll 3lines in insert mode.
nnoremap <C-k> 3<C-y>
nnoremap <C-j> 3<C-e>

" Auto open NERDTree...
autocmd vimenter * NERDTree

" Turn spell checking on for .txt files.
autocmd BufRead,BufNewFile *.txt setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell

" Line wrap for txt and md files.
autocmd BufRead,BufNewFile *.txt set tw=80
autocmd BufRead,BufNewFile *.md set tw=80

" Force markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Allow for fenced code within markdown blocks in the following languages.
let g:markdown_fenced_languages = ['rust']

" Color markdown italics light grey (instead of ugly white highlight block).
hi markdownItalic ctermfg=lightgrey

" Change spell check to use an underline rather than highlight.
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red

" Function for stripping whitespace from the end of all lines in the buffer.
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Strip whitespace from ends of lines when saving certain types of files.
autocmd BufWritePre *.rs,*.txt,*.md,*.pl,*.apl,*.idr,*.h,*.hpp,*.cpp,*.c,*.toml,*.nix :call <SID>StripTrailingWhitespaces()

" ---------------------------------------------------------
" Colors
" ---------------------------------------------------------

" Make statusbar black.
hi StatusLine ctermbg=white ctermfg=black
hi StatusLineNC ctermbg=white ctermfg=black

" Make vsplits black
hi VertSplit ctermfg=black

" APL character picker on leader.
au FileType apl nnoremap <leader><Tab> :emenu APL.<C-Z>
au FileType dyalog nnoremap <leader><Tab> :emenu APL.<C-Z>

let g:syntastic_rust_checkers = ['cargo']

" Read `.vs` and `.fs` as GLSL file extensions.
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

" Two space tabs for arduino files.
autocmd FileType arduino setlocal shiftwidth=2 softtabstop=2 expandtab

" ---------------------------------------------------------
" Plugin-specific
" ---------------------------------------------------------

" elm.vim
" -------

" Stop weird backspace behaviour from elm.vim in .elm files.
let g:Haskell_no_mapping=1

" idris.vim
" ---------

" Smarter idris indentations
let g:idris_indent_if = 3
let g:idris_indent_case = 5
let g:idris_indent_let = 4
let g:idris_indent_where = 6
let g:idris_indent_do = 3
let g:idris_indent_rewrite = 8

" rust.vim
" --------

" Run on \r
au FileType rust nnoremap <leader>r :RustRun<CR>
" Fmt on \f
au FileType rust nnoremap <leader>f :RustFmt<CR>

" NERDTree
" --------

" Toggle on ctrl+n and auto-open.
nnoremap <C-n> :NERDTreeToggle<CR>
autocmd vimenter * NERDTree

" Syntastic
" ---------

" Check header files
let g:syntastic_cpp_check_header=1

" Compiler
let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options=' -std=c++11 -stdlib=libc++'
let g:syntastic_check_on_open=0
let g:syntastic_cpp_config_file='.clang_complete'

" Passive Mode for cpp / h / rs
let g:syntastic_mode_map = { 'mode': 'passive', 'passive_filetypes': ['cpp', 'h', 'rust'] }
autocmd FileType cpp nnoremap <C-e> :SyntasticCheck<CR>
autocmd FileType h nnoremap <C-e> :SyntasticCheck<CR>
au FileType rust nnoremap <leader>c :SyntasticCheck<CR>

" Syntax highlighting
let g:syntastic_enable_highlighting=0

" Auto-complete easier with ctrl-space
autocmd Filetype cpp inoremap <C-Space> <C-x><C-o>
autocmd Filetype h inoremap <C-Space> <C-x><C-o>
autocmd Filetype rust inoremap <C-Space> <C-x><C-o>
if !has("gui_running")
    inoremap <C-@> <C-x><C-o>
endif
