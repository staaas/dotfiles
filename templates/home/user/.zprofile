if [ -n "$DESKTOP_SESSION" ];then
  if [ -n "$GNOME_KEYRING_PID" ]; then
    # Start GNOME Keyring
    eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
  fi
fi
