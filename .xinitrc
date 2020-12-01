#!/usr/bin/env bash

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

xset +fp $HOME/.fonts
xset fp rehash
xrandr --dpi 96

exec bspwm
