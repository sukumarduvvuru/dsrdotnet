" Plugins

call plug#begin()

" Removed http:// from URLs (not strictly necessary but cleaner)
Plug 'tpope/vim-fugitive' "Git Integration
Plug 'dracula/vim' " Dracula Theme color theme
Plug 'mbbill/undotree' "Undo Tree
Plug 'kyazdani42/nvim-web-devicons' "Neogit Dev Icons
Plug 'nvim-telescope/telescope.nvim', { 'do': ':UpdateRemotePlugins'} "Telescope for search and browse
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-tree/nvim-tree.lua' " Install nvim-tree
Plug 'kyazdani42/nvim-web-devicons' "integrates with Git to show icons for modified, added, or deleted file
Plug 'tpope/vim-commentary' "gc and gcc for commenting and uncommenting
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' " Optional: For themes
Plug 'nvim-lua/plenary.nvim'          " Lua functions library
Plug 'sindrets/diffview.nvim'         " Optional for diff view

call plug#end()

" General Configuration

colorscheme dracula
set ignorecase
set number
set mouse=a
set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set encoding=UTF-8
set expandtab
set cursorline

let mapleader = " "

hi Normal guibg=#282a36 guifg=#f8f8f2 "Text Area
hi NonText guibg=#44475a guifg=#6272a4 "Non-Text characters

hi StatusLine guibg=#f8f8f2 guifg=#282a36 " Status line background
hi StatusLineNC guibg=#f8f8f2 guifg=#44475a " Status line not active background

hi Comment guibg=#1d2021 guifg=#928374 gui=italic

hi Normal guibg=NONE ctermbg=NONE

" VIM AIRLINE CONFIGURATION
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '>'
let g:airline_right_sep = '<'
let g:airline_right_alt_sep = '<'
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Map <Leader>g to open NeoGit
nnoremap <Leader>ng :Neogit<CR>

" TELESCOEP MAPPINGS BEGIN
" Map <Leader>ff to search files
nnoremap <Leader>ff :Telescope find_files<CR>

" Map <Leader>fg to search text in files
nnoremap <Leader>fg :Telescope live_grep<CR>

" Map <Leader>fb to switch between open buffers
nnoremap <Leader>fb :Telescope buffers<CR>

" Map <Leader>gf to search Git files
nnoremap <Leader>gf :Telescope git_files<CR>

" Map <Leader>gb to list and switch git branches
nnoremap <Leader>gs :Telescope git_status<CR>
"
" TELESCOEP MAPPINGS END

" GITSIGNS CONFIGURATION BEGIN
lua << EOF
require('gitsigns').setup {
  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
  },
  numhl = true,  -- Enable number highlighting
  linehl = false, -- Disable line highlights

  -- Enable current_line_blame to show git blame on the current line
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 500, -- Delay before showing blame (in ms)
  },

  -- We no longer specify keymaps in the 'setup' function, but separately:
}
-- Manually define the highlights for GitSigns (e.g., for added/modified/deleted lines)
vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#A6E22E' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#FD971F' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#F92672' })
vim.api.nvim_set_hl(0, 'GitSignsChangeDelete', { fg = '#F92672' })

vim.api.nvim_set_hl(0, 'GitSignsAddNr', { fg = '#A6E22E' })
vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { fg = '#FD971F' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { fg = '#F92672' })

vim.api.nvim_set_hl(0, 'GitSignsAddLn', { fg = '#A6E22E', bg = '#000000' })
vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { fg = '#FD971F', bg = '#000000' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { fg = '#F92672', bg = '#000000' })

-- Customize colors for inline blame text
vim.api.nvim_set_hl(0, 'GitSignsBlame', { fg = '#00FF00', bg = '#1C1C1C' }) -- Green text, very dark gray background

-- Customize floating window colors for inline blame
vim.api.nvim_set_hl(0, 'NormalFloat', { fg = '#87CEEB', bg = '#4B0082' }) -- Light Blue text, Dark Purple background
vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#DAA520', bg = '#4B0082' }) -- Golden border, Dark Purple background
vim.api.nvim_set_hl(0, 'FloatTitle', { fg = '#32CD32', bg = '#4B0082' }) -- Lime Green title, Dark Purple background
vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#00FFFF', bg = '#000080' }) -- Cyan text, Dark Blue background
vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#928374', bg = 'NONE' }) -- Light Green text, Dark Gray background

EOF

" -- Key mappings for GitSigns
nnoremap <Leader>hs :Gitsigns stage_hunk<CR>
nnoremap <Leader>hr :Gitsigns reset_hunk<CR>
nnoremap ]c :Gitsigns next_hunk<CR>
nnoremap [c :Gitsigns prev_hunk<CR>

" GITSIGNS CONFIGURATION END


" NVIM-TREE CONFIGURATION BEGIN

lua << EOF
require'nvim-tree'.setup {
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
}
EOF

" Keybindings for nvim-tree
nnoremap <Leader>e :NvimTreeToggle<CR> " Toggle the file tree
nnoremap <Leader>n :NvimTreeFocus<CR>  " Focus the file tree
nnoremap <Leader>r :NvimTreeRefresh<CR> "Refresh nvim tree
nnoremap <Leader>c :NvimTreeClose<CR> "Close nvim tree

" NVIM-TREE CONFIGURATION END


" AIRLINE CONFIGURATION BEGIN
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme='onedark' " Set your theme here
" or
" let g:airline_theme='powerlineish'
" or
" let g:airline_theme='simple'

"Powerline fonts (optional, but recommended for icons)
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1

" Disable showing mode in Airline
let g:airline#disable_mode=1

" AIRLINE CONFIGURATION END

