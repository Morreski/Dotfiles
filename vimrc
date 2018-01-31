" Author: Enguerrand Pelletier
" Derived from Sebastien Bernery's original vimrc file
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Général
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""" VUNDLE
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
"
" " let Vundle manage Vundle, required
Bundle 'gmarik/vundle'

filetype plugin indent on " required

" Language specific plugins
Bundle 'derekwyatt/vim-scala'
Bundle 'ekalinin/Dockerfile.vim'
Bundle 'rust-lang/rust.vim'
Bundle 'digitaltoad/vim-jade'
Bundle 'pangloss/vim-javascript'
Bundle 'leafgarland/typescript-vim'
Bundle 'terryma/vim-multiple-cursors'

" Utilities
"Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-surround'
Bundle 'tomtom/tcomment_vim'

" Git integration
Bundle 'tpope/vim-fugitive'

" Syntax highlight coloration
Bundle 'altercation/vim-colors-solarized'
Bundle 'tomasr/molokai'

" Syntax checker
Bundle 'scrooloose/syntastic'

" Completion
Bundle 'Shougo/neocomplcache.vim'
Bundle 'SirVer/ultisnips'

" Recherche
Bundle 'junegunn/fzf.vim'


"""""" END VUNDLE

"""""" General
set history=400
set encoding=utf-8
set fileencoding=utf-8
set viminfo='20,\"500,h

" Pour que le backspace fonctionne convenablement
set backspace=indent,eol,start

" mapleader
let mapleader = "!"
let g:mapleader = "!"

" Recharger et éditer le .vimrc
nmap <leader>s :source ~/.vimrc<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nu              " numérotation des lignes ...
set numberwidth=1   " ... mais pas plus de place que nécessaire !
set ruler           " Montre la position du curseur
set shm=tToOIA      " Formatage des messages
set showmode        " affiche le mode actuel
set showcmd         " affiche les commandes incomplètes
set wildmenu        " Menu pour la complétion des commandes
set wildmode=list:longest
set wildignore=*.o,*.bak,*.pyc,*.swp,*.jpg,*.gif,*.png
set cc=80 " Colonne a 80 caractères

" Silence !
set noerrorbells
set visualbell t_vb=
autocmd GUIEnter * set vb t_vb=

" Mouse
set mouse=a         " la souris est activée tout le temps
set mousehide       " mais on la cache quand on s'en sert pas

set ttymouse=xterm2
set ttyfast

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Couleurs et polices
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" La coloration syntaxique
syntax on
syntax sync fromstart
autocmd BufEnter * :syntax sync fromstart

set nowrap

filetype plugin indent on

set t_Co=256        " 256 couleurs inside (marche avec gnome-terminal debian)

let g:solarized_termcolors=256
set background=dark
colorscheme molokai

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation - Gestion des tabs/espaces
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set smartindent

" Voir :help smartindent pour comprendre le raccourci suivant
":inoremap # X<C-H>#

set smarttab        " 'shiftwidth' en début en ligne, '(soft)tabstop' ailleurs
set expandtab       " Utilise des espaces, et non des tabulations
set tabstop=4       " Indentation de 4 espaces
set softtabstop=4   " Nombre d'espaces pour une tabulation en mode édition
set shiftwidth=4    " Nombre d'espaces pour indent (<<, >>)
set shiftround      " Les tabs sont toujours multiples de shiftwidth (<<, >>)


" filetype plugin indent on

autocmd FileType c set expandtab tabstop=4 shiftwidth=4

autocmd FileType python,py set tabstop=1|set softtabstop=4|set shiftwidth=4|set expandtab
autocmd FileType javascript,js set tabstop=1|set softtabstop=4|set shiftwidth=4|set expandtab
autocmd FileType yaml,yml set tabstop=1|set softtabstop=4|set shiftwidth=4|set expandtab

autocmd FileType html,xhtml,xml,css,mako,smarty setl tabstop=2|setl softtabstop=2|setl shiftwidth=2

" Supprime automatiquement les espaces de fin de ligne
autocmd BufWritePre * :%s/\s\+$//e

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Édition
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cursorline      " Montre la ligne courante
set nostartofline   " Conserve la colonne
set showmatch       " Montre le/la crochet/parenthèse/croche correspondante
set matchtime=2     " pendant 2 dixièmes de secondes
set matchpairs=(:),[:],{:},<:>,":"
set scrolloff=10 " Offset pour le scrolling

" Enregistrement rapide
nmap <leader>w :w!<cr>

set pastetoggle=<F2>

" Quitter le mode visual avec confort
vnoremap v <esc>

" Suppression rapide du buffer courant
nnoremap <leader>q :bd<cr>

" Redimenssionement du splitting
nnoremap <F4> :res +1<cr>
nnoremap <F5> :res -1<cr>
nnoremap <F6> :vertical res +1<cr>
nnoremap <F7> :vertical res -1<cr>

set hlsearch        " hilight les recherches
set incsearch       " Recherches incrèmentales
set ignorecase      " La recherche ne tient pas compte de la casse
set smartcase       " Sauf si la recherche contient des majuscules

" Recherche de fichiers avec fzf
map <C-p> :Files!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Buffers / Fenêtres / Tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitright      " Nouvelle fenêtre à droite (:vsp)
set nofoldenable    " Désactive le folding automatique
set hidden

" Liste les buffers
nmap ; :Buffers!<CR>

" Naviguer entre les buffers avec TAB
map <S-Tab> :bprevious!<CR>
map <Tab> :bnext!<CR>

set directory=~/.vim/swap

" Créer le fichier de swap automatiquement
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gesture
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Indentation avec les fleches du clavier
nmap <Left> <<
nmap <Right> >>

" Parce que des fois Escape se trouve loin des doigts...
nnoremap <silent> œ  :silent noh<CR>
nnoremap <silent> ²  :silent noh<CR>
inoremap <silent> œ  <esc>
inoremap <silent> ²  <esc>

" Navigation en mode insertion
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0
inoremap <C-h> <C-o>B
inoremap <C-l> <C-o>E
inoremap <C-k> <Esc>d$i

" Splitting et navigation entre les panes
noremap <S-d> :vs <cr>
noremap <C-d> :split <cr>
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-Up> <C-w>_
noremap <C-Down> <C-w>=
noremap <C-Right> 5<C-w>+
noremap <C-Left> 5<C-w>-

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" neocomplcache

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Syntastic

let g:syntastic_python_checkers = [ 'pyflakes', 'python3'  ]
" let g:syntastic_javascript_checkers = [ 'eslint']
let g:syntastic_rust_checkers = ['rustc']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_jump = 3
let g:syntastic_auto_loc_list = 2

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

nmap <C-e> :lopen <cr>

" UltiSnips

let g:UltiSnipsExpandTrigger = '<S-Tab>'
let g:UltiSnipsEditSplit="vertical"

" vim-multiple-cursors

function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

let g:multi_cursor_exit_from_insert_mode=0
let g:multi_cursor_quit_key='q'
