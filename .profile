# {{{ autostart
. "$HOME/.anyrc"

# source git bash completion
if [ -f "$HOME/.git-completion.bash" ]; then
    . "$HOME/.git-completion.bash"

    # Add git completion to dots
    __git_complete dots __git_main
fi

source <(kubectl completion bash)
# }}}
# {{{ env
export TILLER_NAMESPACE="kube-system"
export GPG_TTY=$(tty)
export GOPATH="$HOME/go"
export EDITOR='/usr/bin/nvim'
export GIT_EDITOR=$EDITOR
export SYSTEMD_EDITOR=$EDITOR
export TERMINAL=gnome-terminal
export FILEBROWSER=ranger
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export VMWARE_USE_SHIPPED_LIBS='yes'
export ELECTRON_TRASH=gio
#export DOCKER_CONTENT_TRUST=1
#export DOCKER_CONTENT_TRUST_SERVER=https://notary-harbor.pqe.com.vn
# }}}
# {{{ path
PATH='/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin':"$PATH"
MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
PATH="/usr/lib/ccache/bin/:$PATH"
PATH="$PATH:$GOPATH/bin"
PATH="$PATH:$HOME/Programs"
PATH="$PATH:$HOME/istio-1.0.5/bin"
PATH="$PATH:$HOME/.local/bin:$HOME/bin"
PATH="$PATH:$HOME/.acme.sh"
PATH="$PATH:`yarn global bin`"
# }}}
# {{{ alias
alias kubeval="kubeval --openshift -v 3.9.0 --schema-location https://raw.githubusercontent.com/monotykamary"
alias gogh="wget -O gogh https://git.io/vQgMr && chmod +x gogh && ./gogh"
alias grep="grep --color=auto"
alias ls="ls --color=auto"
alias make="clear && make -j4"
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"
#alias arangodump="docker exec -it arangodb arangodump"
#alias arangorestore="docker exec -it arangodb arangorestore"
# }}}
# {{{ func
heketi-cli () {
    /usr/bin/heketi-cli --server http://heketi-storage-glusterfs.app.pqe.com.vn --user admin --secret "$(oc describe dc heketi-storage -n glusterfs | egrep HEKETI_ADMIN_KEY | cut -b27-)" "$@"
}

ide () {
    /usr/bin/tmux split-window -h -p 50
    /usr/bin/tmux split-window -v -p 50
}

knotz () {
    export KUBECONFIG="$HOME/VCS/working-remote/knotz-kubernetes-admin/kube_config_cluster.yml"
}

pqe () {
    export KUBECONFIG="$HOME/VCS/working-remote/phuquocexpress/pqe-kubernetes-admin/kube_config_cluster.yml"
}

oc () {
    if [[ "$@" == "kubeconfig" ]]; then
        mkdir -p "$HOME/.kube"
        sudo cp -i "/var/lib/origin/openshift.local.config/master/admin.kubeconfig" "$HOME/.kube/config"
        sudo chown $(id -u):$(id -g) "$HOME/.kube/config"
    else
        command oc "$@"
    fi
}

dots () {
    if [[ "$1" == "add" ]]; then
        if [[ "$2" == "-f" ]]; then
            git --git-dir="$HOME"/.dots/repo.git/ --work-tree="$HOME" "$1" -f "${@:3}"
            pushd "$HOME" >/dev/null
            git --git-dir="$HOME"/.dots/repo.git/ --work-tree="$HOME" ls-files > .dotfiles
            #{ echo "*"; git --git-dir="$HOME"/.dots/repo.git/ --work-tree="$HOME" ls-files | awk '{print "!"$0}'; } > .gitignore
            popd >/dev/null
        else
            git --git-dir="$HOME"/.dots/repo.git/ --work-tree="$HOME" "$1" "${@:2}"
        fi

    elif [[ "$1" == "rm" ]]; then
        if [[ "$2" == "-f" ]]; then
            git --git-dir="$HOME"/.dots/repo.git/ --work-tree="$HOME" "$1" -f "${@:3}"
            pushd "$HOME" >/dev/null
            git --git-dir="$HOME"/.dots/repo.git/ --work-tree="$HOME" ls-files > .dotfiles
            popd >/dev/null
        else
            git --git-dir="$HOME"/.dots/repo.git/ --work-tree="$HOME" "$1" "${@:2}"
        fi

    elif [[ "$@" == "vault" ]]; then
        pushd "$HOME" >/dev/null
        tar czf vault.tar.gz -T .dots/encrypt
        tar tvf vault.tar.gz
        ansible-vault encrypt vault.tar.gz --output=".dots/vault.yaml"
        rm vault.tar.gz
        popd >/dev/null

    elif [[ "$@" == "unvault" ]]; then
        pushd "$HOME" >/dev/null
        ansible-vault decrypt ".dots/vault.yaml" --output=vault.tar.gz
        tar tvf vault.tar.gz
        tar xzf vault.tar.gz
        rm vault.tar.gz
        popd >/dev/null

    elif [[ "$@" == "bootstrap" ]]; then
        pushd "$HOME" >/dev/null
        source .dots/bootstrap
        popd >/dev/null

    elif [[ "$@" == "init" ]]; then
        pushd "$HOME" >/dev/null
        git init --bare $HOME/.dots/repo.git
        popd >/dev/null

    elif [[ "$@" == "reinit" ]]; then
        pushd "$HOME" >/dev/null
        while read file; do
            git --git-dir="$HOME"/.dots/repo.git/ --work-tree="$HOME" add -f "$file"
        done < .dotfiles
        popd >/dev/null

    else
        git --git-dir="$HOME"/.dots/repo.git/ --work-tree="$HOME" "$@"
    fi
}

gpg-encrypt () {
    tar czf "$1".tar.gz "$1"
    tar tvf "$1".tar.gz
    gpg2 -o "$1".gpg -e -r tom81094@gmail.com "$1".tar.gz
    rm "$1".tar.gz
}

gpg-decrypt () {
    gpg2 -o "$1".tar.gz -d -r tom81094@gmail.com "$1".gpg
    tar tvf "$1".tar.gz
    tar xzf "$1".tar.gz
    rm "$1".tar.gz
}

# if we're in st TERM, assume we're in xst and set to esc code, else default.
# dirty, but AFAIK there is no way to detect if esc code yields nothing visible from
# the shell (as it will see the escape code only either way).
case $TERM in
  st*)
  [ -z "$TMUX" ] && _prompt=$'\e[z'
  ;;
esac

prompt () {
  _ERR=$?
  _prompt="${_prompt:->}"
  [ $(jobs | wc -l) -ne 0 ] && _prompt="$_prompt$_prompt"
  [ $_ERR -ne 0 ] && _prompt="\e[7m$_prompt\e[0m" # invert
  echo -n -e "$_prompt "
}
# }}}
