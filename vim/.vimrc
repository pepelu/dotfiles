vim9script

# Plugin manager
# Bootstrap vim-plug
var plug_path = expand('~/.vim/autoload/plug.vim')
if empty(glob(plug_path))
    echo "Installing vim-plug."
    silent execute $'!curl -fLo {plug_path} --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

# Packages
plug#begin()
    Plug 'tpope/vim-sensible'
    Plug 'sainnhe/gruvbox-material'
    Plug 'itchyny/lightline.vim'
    Plug 'tpope/vim-surround'
    Plug 'airblade/vim-gitgutter'
plug#end()


#######################
# Options and globals #
#######################

g:mapleader = " "
g:maplocalleader = " "

# Use primary selection for yanking
set clipboard=unnamed

# UI
set number         # show line numbers
set relativenumber # show relative line numbers
set cursorline     # highlight current line
set showmatch      # highlight matching [{()}]
set wildmenu       # visual autocomplete for command menu
set lazyredraw     # avoid redraws in the middle of macros
set updatetime=100 # ms to show changed lines with gitgutter

# Spaces & Tabs
set tabstop=4      # number of visual spaces per tab
set softtabstop=4  # number of spaces in tab when editing
set shiftwidth=4   # auto indent is 4 spaces
set expandtab      # tabs are spaces
set autoindent     # match previous line indent
set smartindent    # the above, but trying to be smart about it

# Filetypes
filetype indent on # indent according to the filetype
filetype plugin on # load filetype-specific settings

# Search
set incsearch      # search as you type
set hlsearch       # highlight matches

# Theme
syntax enable
set termguicolors
set background=dark
g:gruvbox_material_background = 'soft'
g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

# Status line
set laststatus=2
set noshowmode
g:lightline = { 'colorscheme': 'gruvbox_material' }

# foot doesn't support undercurl
# but vim doesn't fallback to underline without this
# Useful for spellchecking
&t_Cs = "\e[4:3m"
&t_Ce = "\e[4:0m"

# Movement
# Default movement uses visual lines, multiline jumps use actual lines
# https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
# https://stackoverflow.com/questions/20975928/moving-the-cursor-through-long-soft-wrapped-lines-in-vim
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')

# Spell-check Markdown files and Git commit messages
autocmd FileType markdown  setlocal spell
autocmd FileType gitcommit setlocal spell
