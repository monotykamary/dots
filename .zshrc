# source profile
source $HOME/.profile

# rehash on completion
zstyle ':completion:*' rehash true

# allow emacs like bindings to work
bindkey -e

# set default alias for thefuck
eval "$(thefuck --alias)"

# get the thing
source ~/.zplug/init.zsh

# config the thing
zplug "lib/completion", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions", use:"zsh-autosuggestions.zsh"
zplug "denysdovhan/spaceship-zsh-theme", use:"spaceship.zsh", from:github, as:theme

# change spaceship settings
SPACESHIP_BATTERY_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false

# load the thing
! zplug check && zplug install
zplug load

# source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# source docker-machine completion
fpath=(~/.zsh/completion $fpath)

# source kubernetes completion
source <(kubectl completion zsh)
source <(kompose completion zsh)
source <(helm completion zsh)
source <(oc completion zsh)
