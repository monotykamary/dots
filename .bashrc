# .bashrc

# Source global definitions
if [ -f /etc/skel/.bashrc ]; then
    . /etc/skel/.bashrc
fi

function prev() {
    PREV=$(echo `history | tail -n2 | head -n1` | sed 's/[0-9]* //')
    sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
    BUFFER=$(pet search --query "$READLINE_LINE")
    READLINE_LINE=$BUFFER
    READLINE_POINT=${#BUFFER}
}
bind -x '"\C-x\C-r": pet-select'

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
#export TERM=xterm-256color
source $HOME/.profile

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=-1
export HISTFILESIZE=-1
shopt -s histappend
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

[ -f ~/.fzf.bash ] && . ~/.fzf.bash || true
[ -f ~/.forgit/forgit.plugin.sh ] && . ~/.forgit/forgit.plugin.sh || true

