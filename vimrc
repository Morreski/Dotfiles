
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
set rtp+=~/.vim/bundle/vundle
set rtp+=~/.fzf
call vundle#rc()
"
" " let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

filetype plugin indent on " required

" Language specific plugins
Plugin 'derekwyatt/vim-scala'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'terryma/vim-multiple-cursors'

" Coloration
Plugin 'morhetz/gruvbox'
Plugin 'luochen1990/rainbow'

" Utilities
"Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tomtom/tcomment_vim'

" Git integration
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Syntax checker
Plugin 'vim-syntastic/syntastic'
Plugin 'prettier/vim-prettier'

" Completion
Plugin 'SirVer/ultisnips'

" Recherche
Plugin 'junegunn/fzf.vim'


"""""" END VUNDLE

"""""" General
set history=400
set encoding=utf-8
set fileencoding=utf-8
set viminfo='20,\"500,h

" Pour que le backspace fonctionne convenablement
set backspace=indent,eol,start

" mapleader
let mapleader = " "
let g:mapleader = " "

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
" set cc=88 " Colonne a 80 caractères

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

colorscheme gruvbox

let g:rainbow_active = 1

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
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd FileType c set expandtab tabstop=4 shiftwidth=4

autocmd FileType python,py set tabstop=1|set softtabstop=4|set shiftwidth=4|set expandtab|setlocal indentkeys-=<:>
autocmd FileType javascript,js,typescript,ts set tabstop=1|set softtabstop=4|set shiftwidth=4|set expandtab
autocmd FileType yaml,yml set tabstop=1|set softtabstop=2|set shiftwidth=2|set expandtab

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

" Selection vers clipboard
vnoremap <S-y> :'<,'>:w ! xclip -selection c<cr><cr>

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
map <C-p> :Files<CR>
nnoremap f :Lines<CR>
map <S-F> :Rg<CR>
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Buffers / Fenêtres / Tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitright      " Nouvelle fenêtre à droite (:vsp)
set nofoldenable    " Désactive le folding automatique
set hidden

" Liste les buffers
nmap ; :Buffers!<CR>

" Naviguer entre les buffers avec TAB
nmap <S-Tab> :bprevious!<CR>
nmap <Tab> :bnext!<CR>

set directory=~/.vim/swap

" Créer le fichier de swap automatiquement
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gesture
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> 1 :noh <cr>
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

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Syntastic

let g:syntastic_python_checkers = [ 'pyflakes', 'python3'  ]
" let g:syntastic_javascript_checkers = [ 'eslint']

let g:rustfmt_autosave = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_jump = 3
let g:syntastic_auto_loc_list = 2

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

" prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.ts Prettier

" astyle
function AutoFormatAstyle()
    silent ! astyle --style=google % &> /dev/null
    edit
endfunction

autocmd BufWritePost *.cpp call AutoFormatAstyle()

" black
function AutoFormatBlack()
    silent ! black % &> /dev/null
    edit
endfunction

:au BufWritePost *.py call AutoFormatBlack()

nmap <C-e> :lopen <cr>

" UltiSnips

let g:UltiSnipsExpandTrigger = '<S-Tab>'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/morreski_snippets']
let g:UltiSnipsJumpForwardTrigger='<right>'
let g:UltiSnipsJumpBackwardTrigger='<left>'

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

" Ansible vault
command Decrypt execute ":!ansible-vault decrypt %"
command Encrypt execute ":!ansible-vault encrypt %"

" Écrire le fichier dans le clipboard

command ToClip execute ":w ! xclip -selection c"

" Editer du binaire

command Hex execute ":%!xxd"
command Bin execute ":%!xxd -r"

" Look & Feel

" Parce que des fois y'a du soleil
command SetHighlight execute "hi CursorLine term=bold ctermbg=None cterm=bold | hi CursorLineNR term=bold cterm=bold ctermbg=None ctermfg=darkred"
command Light execute "set background=light | hi Normal ctermbg=None | SetHighlight"

" Et que des fois, y'en a pas
command Dark execute "set background=dark | hi Normal ctermbg=None | SetHighlight"


" Browser
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 18
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Vexplore
    endif
endfunction

" Trigger changes every X ms
set updatetime=100

" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>

Dark
"Light
