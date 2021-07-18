set number
set noswapfile
set nowrap
set mouse=a
set expandtab
set shiftwidth=4
set tabstop=4
set termguicolors
set clipboard+=unnamedplus
set cmdheight=2
set completeopt=menuone,noselect
set encoding=utf8
set signcolumn=yes


" Vim-Plug init
if !filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ~/.config/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'glepnir/dashboard-nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'glepnir/galaxyline.nvim'
Plug 'Avimitin/nerd-galaxyline'
Plug 'simrat39/symbols-outline.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-project.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'tpope/vim-commentary'

Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'ray-x/lsp_signature.nvim'
call plug#end()

colorscheme gruvbox

lua << EOF
require('bufferline').setup {}
require('nvim-autopairs').setup()
require('nvim-ts-autotag').setup()
require('nvim-treesitter.configs').setup { 
    ensure_installed = "maintained",
    highlight = { enable = true }
}
require('lsp_signature').setup()

require('lspinstall').setup()
local servers = require('lspinstall').installed_servers()
for _, server in pairs(servers) do
    require('lspconfig')[server].setup{}
end

require('lspsaga').init_lsp_saga({code_action_icon = '💡'})
EOF

" Keymappings
let mapleader=" "
nnoremap <Space> <Nop>
inoremap jk <Esc>
" Split Navigation
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <Leader>fp :lua require'telescope'.extensions.project.project{}<CR>
" NvimTree
nnoremap <silent><C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" Bufferline
nnoremap <silent><S-h> :BufferLineCyclePrev<CR>
nnoremap <silent><S-l> :BufferLineCycleNext<CR>
" lspsaga
nnoremap <silent>gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent>gh :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent><C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent><C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent>gs :Lspsaga signature_help<CR>
nnoremap <silent>gr :Lspsaga rename<CR>
nnoremap <silent>gd :Lspsaga preview_definition<CR>
autocmd CursorHold * Lspsaga show_line_diagnostics
nnoremap <silent>g[ :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent>g] :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent><F5> :Lspsaga open_floaterm<CR>
tnoremap <silent><F6> <C-\><C-n>:Lspsaga close_floaterm<CR>
highlight link LspSagaFinderSelection Search
" compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <C-e> compe#close('<C-e>')
inoremap <silent><expr> <Cr> compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })

let g:dashboard_default_executive ='telescope'

let g:indentLine_fileTypeExclude = ['dashboard']

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
