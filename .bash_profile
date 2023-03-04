# Vi command editing
set -o vi

# Prompt
if [ $(id -u) -eq 0 ]; then
  # set red colour prompt for root
  PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w #\\[$(tput sgr0)\\] "
else
  PS1="[\\u@\\h:\\w] $ "
fi

# Minor annoyance: reset prompt to first column
PS1="\[\033[G\]$PS1"

export EDITOR="vim"
export SVN_EDITOR="vim"
export CURRENT_PROJ="vault"
export WORKSPACE="$HOME/Documents/development/workspace"
export PROJ_ROOT="$WORKSPACE/$CURRENT_PROJ"

export JAVA_HOME="$(/usr/libexec/java_home)"
export GOROOT="$HOME/local/personal/Cellar/go/1.1.2/libexec"
export GOPATH="$WORKSPACE/go"

alias ls='ls -alF'
alias be='bundle exec'
alias dc='docker-compose'
alias vim='rvm use system do vim' # so extensions find the right gems

function ws() { cd $WORKSPACE; }
function gp() { cd $PROJ_ROOT; }
function op() { vim $PROJ_ROOT; }
function j() { cd $WORKSPACE/journal && vim $WORKSPACE/journal/`date -j "+%Y-%m-%d"`.log; }
function db(){
    docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" -it $1 bash;
}

# Additional paths
function prepend_path() {
  PATH="$1:$PATH"
}

prepend_path /usr/local/bin
prepend_path /usr/local/sbin
prepend_path $GOPATH/bin
prepend_path $HOME/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm use 18

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
rvm use 3.2.0
