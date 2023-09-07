-- Function that checks if display is widescreen
-- Returns true if display is widescreen
function moveTerminal()
	local app = hs.application.get("kitty")
	local screen = app:mainWindow():screen()
	local screenFrame = screen:frame()
	local screenAspectRatio = screenFrame.w / screenFrame.h

	if screenAspectRatio > 1.5 then
			app:mainWindow():moveToUnit'[80,50,20,0]'
			return true
	else
			app:mainWindow():moveToUnit'[100,50,0,0]'
			return false
	end
end
hs.window.animationDuration = 0.10

hs.hotkey.bind({'cmd'}, "U", function()
	local app = hs.application.get("kitty")

	if app then
			if not app:mainWindow() then
					app:selectMenuItem({"kitty", "New OS window"})
					moveTerminal()
			elseif app:isFrontmost() then
					app:mainWindow():moveToUnit'[100,10,0,0]'
					hs.timer.usleep(10000)
					app:hide()
			else
					app:activate()
					moveTerminal()
			end
	else
			hs.application.launchOrFocus("kitty")
			app = hs.application.get("kitty")
	end

end)

hs.hotkey.bind({'cmd', 'shift'}, "U", function()
	local app = hs.application.get("kitty")
	if app then
			app:activate()
			-- check if app width is screen width
			if app:mainWindow():frame().w == app:mainWindow():screen():frame().w then
			 	moveTerminal()
			else
				app:mainWindow():moveToUnit'[100,100,0,0]'
			end
	end
end)