call plug#begin()

Plug 'ellisonleao/gruvbox.nvim'
Plug 'sitiom/nvim-numbertoggle'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'numToStr/Comment.nvim'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

"set backgroung=dark
colorscheme gruvbox

set number
vnoremap  <leader>y  "+y
set ts=4 sw=4
set smarttab
set mouse=a
hi Normal guibg=NONE ctermbg=NONE

lua require('Comment').setup()
lua require('colorizer').setup()
