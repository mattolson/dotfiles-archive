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
export CURRENT_PROJ="uclarify"

alias ls='ls -alF'
alias push="git push origin master && git push heroku master"
function gp() { cd $HOME/Documents/development/workspace/${1:-$CURRENT_PROJ}; }
function op() { vim $HOME/Documents/development/workspace/${1:-$CURRENT_PROJ}; }

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
function pathadd() {
  if [ -d "$1" ]; then
    PATH="$1:$PATH"
  fi
}
pathadd $ec2_root/bin
pathadd $HOME/local/personal/bin
pathadd $HOME/local/personal/sbin
pathadd $HOME/local/personal/heroku-client
pathadd /usr/local/bin
pathadd /usr/local/sbin

# Load RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
