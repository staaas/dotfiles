# remap keys
if [  -f $HOME/.Xmodmap ]; then
    /usr/bin/xmodmap $HOME/.Xmodmap
fi

DEFAULT_SESSION=awesome

case $1 in
xfce4)
	exec startxfce4
	;;
awesome)
	exec awesome
	;;
*)
	exec $DEFAULT_SESSION
	;;
esac
