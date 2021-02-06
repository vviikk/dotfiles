#!/bin/bash
# Find all xinput devices whose name matches any of the arguments passed here,
# then set the Natural Scrolling' property to '1' regardless of its
# current state.

# expect multiple arguments, store them as array
deviceNames="$@"

# exit if no argument is passed
if [ "$deviceNames" = "" ]; then
        echo "No argument received, exiting."
        echo "Call this script with argument(s) like 'Logitech' that match"
        echo "any of your attached pointer devices."
    exit 1
fi

for deviceName in $deviceNames
do
    deviceId=$(xinput --list | awk -v search="$deviceName" \
    '$0 ~ search {match($0, /id=[0-9]+/);\
                  if (RSTART) \
                    print substr($0, RSTART+3, RLENGTH-3)\
                 }'\
     )
  # set device-specific property (works i.e for 'TrackPoint' & 'Logitech')
  xinput set-prop $deviceId "libinput Natural Scrolling Enabled" 1
done
