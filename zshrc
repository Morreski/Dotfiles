export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bira"

plugins=()

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh  # fzf

# Variables & Fonctions

export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow"
export EDITOR='vim'

function gi { curl -L -s https://www.gitignore.io/api/$@ ;}
function loadenv { source <(sed '/^\( \|\t\)*#/d ; /^$/d ; s/^/export /g' $1) }
function side-effect { rg $1 -l | grep -v lib-memento | grep -v database-tool | grep -v tests | sed 's@^\([^/]*\).*$@\1@g' | sort | uniq }
function togif { ffmpeg -y -i $1 -filter_complex '[0:v] fps=12,scale=800:-1,split [a][b];[a] palettegen [p];[b][p] paletteuse' $2 }
function changelog { git log --format='* %s' ${1:-develop}..HEAD }
function ec2-ls { aws ec2 describe-instances --filters "Name=tag:env,Values=$1" | python3 -c "import json, sys; ec2 = json.loads(sys.stdin.read()); [print(next((t['Value'] for t in i['Tags'] if t['Key'] == 'Name'))  + ': ' +  i.get('PrivateIpAddress', '')) for r in ec2['Reservations'] for i in r['Instances'] if 'PrivateIpAddress' in i]" | sort }
function ec2-ip { aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" | python3 -c "import json, sys; ec2 = json.loads(sys.stdin.read()); sys.stdout.write(ec2['Reservations'][0]['Instances'][0].get('PrivateIpAddress', ''))" }
function ec2-ssh { ssh -i ~/.ssh/keys/production-admin.pem ubuntu@$@}
function gcli { gcloud compute instances list --filter="name~$1"}
function gssh { gcloud compute ssh --internal-ip $@}
function timecurl { curl -s -o /dev/null -w "%{time_starttransfer}\n" $@ }
function bumptag { git tag $1 && git push --tags }
function quicknote { vim ~/Documents/notes/$(date --iso-8601).md }
function gen_mac_addr { openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//' }

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
alias jsonschema="echo \"$1\" | genson | python3 -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)'"

# Images functions
function set_taken_date_to_now { exiv2 -M "set Exif.Photo.DateTimeOriginal $(date +'%Y:%m:%d %H:%M:%S')" $1 }
function generate_faces { for i in {1..$1} ; do ; curl 'https://thispersondoesnotexist.com/image' -H 'User-Agent: Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:66.0) Gecko/20100101 Firefox/66.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -o ./$i.jpg ; done; }

# Web dev functions
function dumpsite { wget -e robots=off -E -H -k -K -p $1 }

# Emojis
function emoji { EMPATH=$HOME/.local/share/emojis/emojis.txt; if [ ! -f $EMPATH ] ; then ; mkdir -p $(dirname $EMPATH) && wget -O $EMPATH https://unicode.org/Public/emoji/13.1/emoji-test.txt ; fi ; grep "$1" $EMPATH | awk -F '  +|#|;' '{ if ($4 != "") printf "%s ", substr($4, 1, 2); else if ($5 != "") printf("%s ", substr($5, 1, 2));} END {print ""}' }

# Git workflows
alias dev2staging="git checkout develop && git pull --rebase && git submodule update && git checkout staging && git pull --rebase && git rebase develop && git push"
alias dev2master="git checkout develop && git pull --rebase && git submodule update && git checkout staging && git pull --rebase && git rebase develop && git push && git checkout master && git pull --rebase && git rebase staging && git push && git tag | sort --version-sort"
alias staging2master="git checkout staging && git pull --rebase && git submodule update && git checkout master && git pull --rebase && git rebase staging && git push && git tag | sort --version-sort"
export PATH="$PATH:/home/enguerrand/Memento/memento-cli/bin"
