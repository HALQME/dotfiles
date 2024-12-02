set shiftwidth=4
set tabstop=4
set autoindent
set relativenumber

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
    Jetpack 'tani/vim-jetpack',  "bootstrap

    Jetpack 'catppuccin/vim', { 'event': ['BufRead'], 'as': 'catppuccin' }
    Jetpack 'tpope/vim-fugitive', { 'event': ['BufRead']}
    Jetpack 'tpope/vim-surround', { 'event': ['BufRead']}
    Jetpack 'airblade/vim-gitgutter', { 'event': ['BufRead']}
    Jetpack 'scrooloose/nerdtree', { 'cmd': ['NERDTreeToggle'] }
    Jetpack 'tpope/vim-repeat', { 'event': ['BufRead']}
    Jetpack 'tpope/vim-commentary', { 'event': ['BufRead']}
    Jetpack 'dense-analysis/ale', { 'event': ['BufRead']}
    " Completions
    Jetpack 'Shougo/ddc.vim', { 'opt': 1 }
    "" dependencies
    Jetpack 'vim-denops/denops.vim', { 'opt': 1 }
    Jetpack 'Shougo/pum.vim', { 'opt': 1 }
    "" source
    Jetpack 'Shougo/ddc-around', { 'event': ['BufRead']}
    Jetpack 'LumaKernel/ddc-file', { 'event': ['BufRead']}
    Jetpack 'Shougo/ddc-omni', { 'event': ['BufRead'] }
    Jetpack 'matsui54/ddc-buffer', { 'event': ['BufRead'] }
    "" filter
    Jetpack 'Shougo/ddc-matcher_head', { 'event': ['BufRead']}
    Jetpack 'Shougo/ddc-sorter_rank', { 'event': ['BufRead']}
    Jetpack 'Shougo/ddc-converter_remove_overlap', { 'event': ['BufRead']}
    "" Copilot
    Jetpack 'github/copilot.vim', { 'event': ['BufRead'] }
    " LSP
    Jetpack 'mattn/vim-lsp-settings', { 'event': ['BufRead']}
    Jetpack 'prabirshrestha/vim-lsp', { 'event': ['BufRead']}
    " Syntax
    Jetpack 'sheerun/vim-polyglot'
    " IME
    Jetpack 'vim-skk/skkeleton', { 'opt': 1 }

call jetpack#end()

let s:sources = [
  \  'omni',
  \  'around',
  \  'buffer',
  \  'file',
  \ ]
let s:sourceOptions = {
  \ '_': {
  \   'matchers': ['matcher_head'],
  \   'sorters': ['sorter_rank'],
  \ },
  \ 'omni': {
  \   'mark': 'O',
  \   'forceCompletionPattern': '\.\w*|:\w*|->\w*',
  \   'minAutoCompleteLength': 1,
  \ },
  \ 'buffer': {'mark': 'B'},
  \ 'around': {'mark': 'A'},
  \ 'file': {
  \   'mark': 'F',
  \   'isVolatile': v:true,
  \   'forceCompletionPattern': '\S/\S*',
  \ }}
call ddc#custom#patch_global('sources', s:sources)
call ddc#custom#patch_global('sourceOptions', s:sourceOptions)

call ddc#custom#patch_global('sourceParams', {
    \ 'buffer': {
    \   'requireSameFiletype': v:false,
    \   'limitBytes': 5000000,
    \   'fromAltBuf': v:true,
    \   'forceCollect': v:true,
    \ },
    \ })
call ddc#enable()

map <C-n> :NERDTreeToggle<CR> " Ctrl+nでNERDTreeをトグル
