if test -z $DISPLAY; and test (tty) = "/dev/tty1"

  # enforce Wayland for Firefox
  set -x MOZ_ENABLE_WAYLAND 1

  # use xdg-desktop-portal-wlr
  set -x XDG_CURRENT_DESKTOP sway

  exec sway
end
