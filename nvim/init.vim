call plug#begin()
Plug 'ellisonleao/gruvbox.nvim'
Plug 'sitiom/nvim-numbertoggle'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'numToStr/Comment.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itspriddle/vim-shellcheck'
Plug 'stevearc/conform.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


call plug#end()
 
"set backgroung=dark
colorscheme gruvbox

set number
vnoremap  <leader>y  "+y
set ts=4 sw=4
" set smarttab
set mouse=a
hi Normal guibg=NONE ctermbg=NONE
"delete word: 
inoremap <C-BS> <C-w>


" neoclide/coc.vim config:

set nobackup
set nowritebackup

set updatetime=300
set signcolumn=yes

inoremap <silent><expr> <TAB>
			\ coc#pum#visible() ? coc#pum#next(1) :
			\ CheckBackspace() ? "\<Tab>" :
			\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif



lua require('Comment').setup()
lua require('colorizer').setup()

" formatter

