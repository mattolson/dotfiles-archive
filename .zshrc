# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Setup homebrew env
eval $(/opt/homebrew/bin/brew shellenv)

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# zplug
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

# Declare zsh plugins
zplug "modules/prompt", from:prezto
zplug "romkatv/powerlevel10k", as:theme, depth:1

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

export CURRENT_PROJ="ledger"
export WORKSPACE="$HOME/dev/workspace"
export PROJ_ROOT="$WORKSPACE/snowpackmoney/$CURRENT_PROJ"

alias ls='ls -alF'
alias be='bundle exec'
alias dc='docker compose'

function ws() { cd $WORKSPACE; }
function gp() { cd $PROJ_ROOT; }

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/matt/dev/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/matt/dev/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/matt/dev/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/matt/dev/google-cloud-sdk/completion.zsh.inc'; fi

# Init pyenv
eval "$(pyenv init - zsh)"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/matt/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
