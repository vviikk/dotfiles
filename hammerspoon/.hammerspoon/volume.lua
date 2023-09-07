
function isVscode()
	-- get frontmost application
	app = hs.application.frontmostApplication()
	-- chgeck if application is vscode
	appName = app:name()
	if string.match(appName, "Code") then
		return true
	else
		return false
	end
end

hs.hotkey.bind({}, "f12", function()
  -- playing = hs.spotify.isPlaying()

  if isVscode() then
    -- hs.spotify.volumeUp()
		-- show alert
		hs.alert.show("VSCode is frontmost application, sending keystroke")
		app = hs.application.frontmostApplication()
		hs.eventtap.keyStroke({}, "f12", 0, app)
  else
    -- output = hs.audiodevice.defaultOutputDevice()
    -- output:setVolume(output:volume() + 10)
			-- hs.eventtap.keyStroke({"cmd"}, "`") 
			-- hs.eventtap.keyStroke({"fn"}, "f12", 20)
			hs.eventtap.event.newSystemKeyEvent('SOUND_UP', true):post()
		-- hs.alert.show("Volume is now " .. output:volume() .. "%" )
  end
end)


function changeVolume(diff)
  return function()
    local current = hs.audiodevice.defaultOutputDevice():volume()
    local new = math.min(100, math.max(0, math.floor(current + diff)))
    if new > 0 then
      hs.audiodevice.defaultOutputDevice():setMuted(false)
    end
    hs.alert.closeAll(0.0)
    hs.alert.show("Volume " .. new .. "%", {}, 0.5)
    hs.audiodevice.defaultOutputDevice():setVolume(new)
  end
end

hs.hotkey.bind(HYPER, 'Down', changeVolume(-3))
hs.hotkey.bind(HYPER, 'Up', changeVolume(3))

-- map + key to volume up
hs.hotkey.bind(HYPER, '=', changeVolume(3))

-- map - key to volume down
hs.hotkey.bind(HYPER, '-', changeVolume(-3))
