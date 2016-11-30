" Font on terminal - inconsolata

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

set numberwidth=5 "Set width of the gutter column

set nu "number - show line numbers"

" Makes it easy to jump up and down x number of lines
set rnu "relativenumber - show line numbers in relation to the cursor

set cursorline "Highlight current cursor line

"set cursorcolumn "Highlight current column

"set mouse+=a "Use mouse to highlight lines for copy

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

" Colors from zenburn: https://github.com/jnurmine/Zenburn/blob/master/colors/zenburn.vim
" Copy to ~/.vim/colors/
colors zenburn
