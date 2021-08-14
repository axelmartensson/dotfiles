# Commands to run when starting a new x session

# https://github.com/conformal/spectrwm/issues/216
# fixes the window staying on the background 
# after close issue. starting x without 
# -background none or setting a background by 
xsetroot  -solid black

~/bin/reddisplay

~/bin/kbdconf

exec spectrwm
