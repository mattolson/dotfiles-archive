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
export CURRENT_PROJ="storefront"
export WORKSPACE="$HOME/workspace"
export GOPATH="$WORKSPACE/go"
export PROJ_ROOT="$WORKSPACE/$CURRENT_PROJ"

alias ls='ls -alF'
alias be='bundle exec'
alias dc='docker-compose'

function ws() { cd $WORKSPACE; }
function gp() { cd $PROJ_ROOT; }
function j() { cd $WORKSPACE/journal && vim $WORKSPACE/journal/`date -j "+%Y-%m-%d"`.log; }

# Java
export JAVA_HOME="$(/usr/libexec/java_home)"

# Additional paths
function prepend_path() {
  PATH="$1:$PATH"
}
prepend_path /usr/local/bin
prepend_path /usr/local/sbin
prepend_path /usr/local/share/npm/bin
prepend_path ./node_modules/.bin
prepend_path $HOME/pear/bin
prepend_path $HOME/.cargo/bin
prepend_path /usr/local/heroku/bin
prepend_path /usr/local/opt/go/libexec/bin
prepend_path $GOPATH/bin
prepend_path $HOME/bin

# chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
chruby ruby-2.4.4

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
nvm use 8
