set shiftwidth=4
set tabstop=4
set autoindent
set relativenumber
set rtp+=/opt/homebrew/opt/fzf

set noswapfile

" 括弧の自動補完
inoremap ( ()<Left>
inoremap { {  }<Left><Left>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap < <><Left>
inoremap 「 「」<left>
inoremap ` ``<Left>

packadd vim-jetpack

call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
    Jetpack 'catppuccin/vim', { 'event': ['BufRead'], 'as': 'catppuccin' }
    Jetpack 'tpope/vim-fugitive', { 'event': ['BufRead']}
    Jetpack 'tpope/vim-surround', { 'event': ['BufRead']}
    Jetpack 'airblade/vim-gitgutter', { 'event': ['BufRead']}
    Jetpack 'scrooloose/nerdtree', { 'cmd': ['NERDTreeToggle'] }
    Jetpack 'tpope/vim-repeat', { 'event': ['BufRead']}
    Jetpack 'tpope/vim-commentary', { 'event': ['BufRead']}
    Jetpack 'dense-analysis/ale', { 'event': ['BufRead']}
call jetpack#end()
