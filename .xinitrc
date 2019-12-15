
# setxkbmap -I$HOME/.xkb vicolemak -compat stickykeys -print | xkbcomp -I$HOME/.xkb - $DISPLAY
# -compat does not work
# ~/.xkb/compat/stickykeys
#
# full options for accessibility:
# /usr/share/X11/xkb/compat/accessx
# /usr/include/X11/keysymdef.h
# using xkbset instead

setxkbmap -I$HOME/.xkb vicolemak -print | xkbcomp -I$HOME/.xkb - $DISPLAY
xset r 66
xkbset sticky -twokey
exec xmonad
