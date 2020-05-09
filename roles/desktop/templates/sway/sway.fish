if test -z $DISPLAY; and test (tty) = "/dev/tty1"
  set -x MOZ_ENABLE_WAYLAND 1
  exec sway
end
