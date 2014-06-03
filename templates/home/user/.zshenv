if [ -n "$DESKTOP_SESSION" ];then
  # Start GNOME Keyring
  eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
  export SSH_AUTH_SOCK
fi
