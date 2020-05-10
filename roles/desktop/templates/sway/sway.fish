if test -z $DISPLAY; and test (tty) = "/dev/tty1"

  # enforce Wayland for Firefox
  set -x MOZ_ENABLE_WAYLAND 1

  exec sway
end
