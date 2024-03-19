" Packages
packadd! gruvbox-material   " colorscheme
" lightline.vim             " statusline
" vim-wayland-clipboard     " wayland clipboard support

" Colors
syntax enable

set termguicolors
set background=dark
let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

" foot doesn't support undercurl
" but vim doesn't fallback to underline without this
" Useful for spellchecking
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" Spaces & Tabs
set tabstop=4      " number of visual spaces per tab
set softtabstop=4  " number of spaces in tab when editing
set expandtab      " tabs are spaces
set autoindent     " match previous line indent
set smartindent    " the above, but trying to be smart about it

" Filetypes
filetype indent on " indent according to the filetype
filetype plugin on " load filetype-specific settings

" UI config
set number         " show line numbers
set relativenumber " show relative line numbers
set cursorline     " highlight current line
set showmatch      " highlight matching [{()}]
set wildmenu       " visual autocomplete for command menu
set lazyredraw     " avoid redraws in the middle of macros

" Search
set incsearch      " search as you type
set hlsearch       " highlight matches
" turn off search highlight (leader is \)
nnoremap <leader><space> :nohlsearch<CR>

" Status line
set laststatus=2
set noshowmode
let g:lightline = { 'colorscheme': 'gruvbox_material' }

" Movement
" Default movement uses visual lines, multiline jumps use actual lines
" https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
" https://stackoverflow.com/questions/20975928/moving-the-cursor-through-long-soft-wrapped-lines-in-vim
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')

" Spell-check Markdown files and Git commit messages
autocmd FileType markdown  setlocal spell
autocmd FileType gitcommit setlocal spell
" Enable dictionary auto-completion with <Ctrl-N>
autocmd FileType markdown  setlocal complete+=kspell
autocmd FileType gitcommit setlocal complete+=kspell

" Note-taking settings

" Go to notes home and set the working directory to be able to follow links
command! Nindex cd $NOTESDIR |
              \ edit $NOTESDIR/home.md
nnoremap <leader>ni :Nindex<CR>

" Create new note and manually apply modeline
command! Nnote cd $NOTESDIR | edit `date +\%Y\%m\%d\%H\%M` |
             \ set filetype=markdown |
             \ set textwidth=79 formatoptions+=t formatoptions-=l |
             \ .!note_template
nnoremap <leader>nn :Nnote<CR>

" Find in notes.
" Instead of external grep, you can use the internal vim[grep]
" and you won't have to juggle as shown below, but it's slower.
"
" silent prevents the Press ENTER or type command to continue
" redraw! forces a redraw because silent messes up the window
" grep! doesn't jump to the first match, doing it with cfirst
" instead, prints the line (1 of X: match) that silent omits
command! -nargs=1 Ngrep execute 'silent grep! <args> $NOTESDIR/*' |
                        \ redraw! | cfirst
nnoremap <leader>nf :Ngrep 
" Show matches window
command! Vlist botright vertical copen | vertical resize 80
nnoremap <leader>nv :Vlist<CR>
