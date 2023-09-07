tell application "System Events" to tell process "Control Center"
    click menu bar item "Control Center" of menu bar 1
    set currentlyPlaying to value of static text 3 of window "Control Center"
    key code 53 -- press 'esc' key
end tell

activate
display dialog currentlyPlaying with title "Currently Playing" buttons ¬
    {"OK"} default button 1 giving up after 3
