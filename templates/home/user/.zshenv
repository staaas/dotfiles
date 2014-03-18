if [ -n "$DESKTOP_SESSION" ];then
  if [ -n "$GNOME_KEYRING_PID" ]; then
    # Start GNOME Keyring
    eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
    # You probably need to do this too:
    export SSH_AUTH_SOCK
    export GPG_AGENT_INFO
    export GNOME_KEYRING_CONTROL
    export GNOME_KEYRING_PID
  fi
fi
