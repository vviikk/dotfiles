-- function to set muted(boolean)
function micCheck()
  if hs.audiodevice.defaultInputDevice():muted() then
    hs.audiodevice.defaultInputDevice():setMuted(false)

    showAlert(
      "🎙Microphone: Live and recording... (Menu + M to mute)"
    )
  else
    hs.audiodevice.defaultInputDevice():setMuted(true)
    showAlert(
      "🎙Microphone: Muted"
    )
  end
end

-- mute / unmute microphone
hs.hotkey.bind(HYPER, "m", function()
  micCheck()
end)