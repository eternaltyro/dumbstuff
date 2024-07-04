" Color options:
"   - zenburn: https://github.com/jnurmine/Zenburn/blob/master/colors/zenburn.vim

" Terminal fonts
" - inconsolata
" - Fira Mono Medium 11 pt.

set encoding=utf8
syntax enable   " Enable syntax highlighting
" Python specific smart indent keywords based on which vim auto-indents
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufRead,BufNewFile *.py let python_highlight_all=1


" Tabs and indenting
set expandtab       " short: et - expand tabs into spaces
set smarttab        " short: sta - intelligently tab lines based on other lines
set shiftwidth=4    " short: sw=4 - tab inserts 4 spaces
set tabstop=4       " short: ts=4 - Number of spaces each tab accounts for
set autoindent      " short: ai - copy indent from current line when starting newline
set smartindent     " short: si

" tabstops for different file types
autocmd Filetype rb setlocal shiftwidth=2 tabstop=2
autocmd Filetype erb setlocal shiftwidth=2 tabstop=2
autocmd FileType py setlocal shiftwidth=4 tabstop=4
autocmd FileType tf setlocal shiftwidth=2 tabstop=2
autocmd FileType tfvars setlocal shiftwidth=2 tabstop=2
autocmd FileType json setlocal shiftwidth=2 tabstop=2

"set lbr   "linebreak - display lines in multiple lines.
set textwidth=72 " short: tw=72 the first space after tw breaks line
set wrap "Wrap lines"

set numberwidth=5   "Set width of the gutter column

" Visual cues
set hlsearch            " short: hls - Highlight search matches
set showmatch           " Show matching brackets
set number              " short: nu - show line numbers"
" Makes it easy to jump up and down x number of lines
set relativenumber      " short: rnu - show line numbers in relation to the cursor
set cursorline          "Highlight current cursor line
"set cursorcolumn       "Highlight current column
"https://superuser.com/questions/22444/make-vim-display-a-line-at-the-edge-of-the-set-textwidth
set colorcolumn=80
"set colorcolumn=-2 (if textwidth = 80, column would be drawn in 78)
" highlight ColorColumn ctermbg=green guibg=orange

"set mouse+=a "Use mouse to highlight lines for copy

" Plugins
"set omnifunc=pythoncomplete#Complete
"set runtimepath^=~/.vim/bundle/ctrlp.vim       "Control+P toggles fuzzy search functionality
"map <F2> :NERDTreeToggle<CR>
" execute pathogen#infect()

" Themes and colours
"colorscheme zenburn         " Copy to ~/.vim/colors/
"ColorScheme cobalt          " Copy to ~/.vim/colors/
"set t_Co=256                "Terminal colors

set laststatus=2        " short: ls=2 - Always show status line esp. for vim-airline
set scrolloff=5         " Show 5 lines above and below
