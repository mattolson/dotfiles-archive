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
export HOMEBREW_TEMP="$HOME/local/tmp"
export CURRENT_PROJ="studentstock"
export WORKSPACE="$HOME/Documents/development/workspace"
export PROJ_ROOT="$WORKSPACE/$CURRENT_PROJ"
export GOPATH="$WORKSPACE" # needs to be set for goproj to work

alias ls='ls -alF'
alias push='git push origin master && git push heroku master'
alias be='bundle exec'
alias gpom='git push origin master'
alias go='goproj-go'

function ws() { cd $WORKSPACE; }
function gp() { cd $PROJ_ROOT; }
function op() { vim $PROJ_ROOT; }

# AWS stuff
ec2_root="$HOME/local/personal/Library/LinkedKegs/ec2-api-tools"
export EC2_HOME="$ec2_root/jars"
export JAVA_HOME="$(/usr/libexec/java_home)"
export EC2_URL="https://ec2.us-west-1.amazonaws.com"

if [[ -f $HOME/.amz/$CURRENT_PROJ/aws_user_id ]]; then
  export AWS_USER_ID="$(cat $HOME/.amz/$CURRENT_PROJ/aws_user_id)"
fi

if [[ -f $HOME/.amz/$CURRENT_PROJ/aws_access_key_id ]]; then
  export AWS_ACCESS_KEY_ID="$(cat $HOME/.amz/$CURRENT_PROJ/aws_access_key_id)"
fi

if [[ -f $HOME/.amz/$CURRENT_PROJ/aws_secret_access_key ]]; then
  export AWS_SECRET_ACCESS_KEY="$(cat $HOME/.amz/$CURRENT_PROJ/aws_secret_access_key)"
fi

if test -n "$(find $HOME/.amz/$CURRENT_PROJ -maxdepth 1 -name 'pk-*.pem' -print -quit)"; then
  export EC2_PRIVATE_KEY="$(/bin/ls $HOME/.amz/$CURRENT_PROJ/pk-*.pem | /usr/bin/head -1)"
fi

if test -n "$(find $HOME/.amz/$CURRENT_PROJ -maxdepth 1 -name 'cert-*.pem' -print -quit)"; then
  export EC2_CERT="$(/bin/ls $HOME/.amz/$CURRENT_PROJ/cert-*.pem | /usr/bin/head -1)"
fi

# Additional paths
function prepend_path() {
  PATH="$1:$PATH"
}
prepend_path $ec2_root/bin
prepend_path $HOME/local/personal/bin
prepend_path $HOME/local/personal/sbin
prepend_path $HOME/local/personal/heroku-client/bin
prepend_path $HOME/local/personal/goproj/bin
prepend_path /usr/local/bin
prepend_path /usr/local/sbin
prepend_path /usr/local/share/npm/bin

# Node path
export NODE_PATH="/usr/local/lib/node"

# Go path
export GOROOT="$HOME/local/personal/Cellar/go/1.1.2/libexec"

# Enable rbenv shims
eval "$(rbenv init -)"
