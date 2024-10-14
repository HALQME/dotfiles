set shiftwidth=4
set tabstop=4
set autoindent
set relativenumber 

syntax on

nnoremap <C-t> :NERDTreeToggle<CR>

call plug#begin()
	Plug 'preservim/nerdtree'
	Plug 'junegunn/fzf.vim'
	Plug 'previm/previm'
	Plug 'markonm/traces.vim'
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-tree/nvim-web-devicons'
call plug#end()

