execute pathogen#infect()
syntax enable

set encoding=utf8

set et "expandtab - expand tabs into spaces

set sta "smarttab - intelligently tab lines based on other lines

set sw=4 "shiftwidth=4 - tab inserts 4 spaces

set ts=4 "tabstop=4 - Number of spaces each tab accounts for

set lbr "linebreak - display lines in multiple lines. "

set tw=72 "textwidth=72 - After 72 char, the first space breaks line

set ai "autoindent - copy indent from current line when starting newline

set si "Smart indent"

" Python specific smart indent keywords based on which vim auto-indents
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
let python_highlight_all = 1

set wrap "Wrap lines"

set nu "number - show line numbers"


set omnifunc=pythoncomplete#Complete

"Control+P toggles fuzzy search functionality
set runtimepath^=~/.vim/bundle/ctrlp.vim

map <F2> :NERDTreeToggle<CR>

autocmd FileType tf setlocal shiftwidth=2 tabstop=2
autocmd FileType tfvars setlocal shiftwidth=2 tabstop=2

" https://superuser.com/questions/22444/make-vim-display-a-line-at-the-edge-of-the-set-textwidth
" set colorcolumn=80
" set colorcolumn=-2 (if textwidth = 80, column would be drawn in 78)
" highlight ColorColumn ctermbg=green guibg=orange

