-- Function that checks if display is widescreen
-- Returns true if display is widescreen
function moveFileManager()
	local app = hs.application.get("Marta")
	local screen = app:mainWindow():screen()
	local screenFrame = screen:frame()
	local screenAspectRatio = screenFrame.w / screenFrame.h

	if screenAspectRatio > 1.5 then
		app:mainWindow():moveToUnit'[80,100,20,20]' -- Changed the Y-coordinate to 100
		return true
	else
		app:mainWindow():moveToUnit'[100,100,0,0]' -- Changed the Y-coordinate to 100
		return false
	end
end
hs.window.animationDuration = 0.05

hs.hotkey.bind({'alt'}, "U", function()
	local app = hs.application.get("Marta")

	if app then
			if not app:mainWindow() then
					app:selectMenuItem({"Marta", "New OS window"})
					moveFileManager()
			elseif app:isFrontmost() then
					-- app:mainWindow():moveToUnit'[0,100,100,0]'
					-- hs.timer.usleep(10000)
					app:hide()
			else
					app:activate()
					moveFileManager()
			end
	else
			hs.application.launchOrFocus("Marta")
			app = hs.application.get("Marta")
	end

end)

hs.hotkey.bind({'alt', 'shift'}, "U", function()
	local app = hs.application.get("Marta")
	if app then
			app:activate()
			-- check if app width is screen width
			if app:mainWindow():frame().w == app:mainWindow():screen():frame().w then
			 	moveFileManager()
			else
				app:mainWindow():moveToUnit'[100,100,0,0]'
			end
	end
end)