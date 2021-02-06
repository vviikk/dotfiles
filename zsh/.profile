./start_natural_scrolling.sh Touch
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
killall libinput-three-finger-drag & libinput-gestures-setup restart && ~/.bin/libinput-three-finger-drag &


