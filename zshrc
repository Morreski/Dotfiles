export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bira"

plugins=()

source $ZSH/oh-my-zsh.sh

# Variables & Fonctions

export PATH="$PATH:$HOME/bin"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow"
export EDITOR='vim'
export PYTHONPATH="$HOME/.local/lib/python3.6/site-packages"

function gi { curl -L -s https://www.gitignore.io/api/$@ ;}
function loadenv { source <(sed '/^\( \|\t\)*#/d ; /^$/d ; s/^/export /g' $1) }

# Aliases

alias clip="xclip -selection c"
alias httpserver="python3 -m http.server"
alias open="xdg-open"
alias diff="colordiff"
alias gpg="gpg2"
alias onditpascrypter="python3 -c 'import sys; import bcrypt; pwd=input(); sys.stdout.write(bcrypt.hashpw(pwd.encode(), bcrypt.gensalt()).decode())'"
alias minivim='vim -u NONE'
alias toqrcode='xargs -0 | qrencode -o - | display'
alias dev='tmux attach -t $(basename $PWD) || tmux new -s $(basename $PWD)'
