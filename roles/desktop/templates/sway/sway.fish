if test -z $DISPLAY; and test (tty) = "/dev/tty1"

  # enforce Wayland for Firefox
  set -x MOZ_ENABLE_WAYLAND 1

  # switching to a software cursor instead of a hardware one,
  # cursor sometimes disappears without this
  set -x WLR_NO_HARDWARE_CURSORS 1

  # use xdg-desktop-portal-wlr
  set -x XDG_CURRENT_DESKTOP sway

  exec sway
end
