export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bira"

plugins=()

source $ZSH/oh-my-zsh.sh
source $HOME/Memento/todos
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh  # fzf

# Variables & Fonctions

export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow"
export EDITOR='vim'
export PYTHONPATH="$HOME/.local/lib/python3.6/site-packages"

function gi { curl -L -s https://www.gitignore.io/api/$@ ;}
function loadenv { source <(sed '/^\( \|\t\)*#/d ; /^$/d ; s/^/export /g' $1) }
function side-effect { rg $1 -l | grep -v lib-memento | grep -v database-tool | grep -v tests | sed 's@^\([^/]*\).*$@\1@g' | sort | uniq }
function togif { ffmpeg -y -i $1 -filter_complex '[0:v] fps=12,scale=800:-1,split [a][b];[a] palettegen [p];[b][p] paletteuse' $2 }
function changelog { git log --format='* %s' ${1:-develop}..HEAD }
function ec2-ls { aws ec2 describe-instances --filters "Name=tag:env,Values=$1" | python3 -c "import json, sys; ec2 = json.loads(sys.stdin.read()); [print(next((t['Value'] for t in i['Tags'] if t['Key'] == 'Name'))  + ': ' +  i['PrivateIpAddress']) for r in ec2['Reservations'] for i in r['Instances']]" | sort }
function ec2-ip { aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" | python3 -c "import json, sys; ec2 = json.loads(sys.stdin.read()); sys.stdout.write(ec2['Reservations'][0]['Instances'][0]['PrivateIpAddress'])" }

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
