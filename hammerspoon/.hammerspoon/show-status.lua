local geom    = require "hs.geometry"
local rectify = geom.rect

function get_battery_remaining()
	local currentPercentage = hs.battery.percentage()
	local remBatteryString = string.format("%.0f", currentPercentage)
	if not hs.battery.isCharging() then
		return remBatteryString.."%"
	else
		return ""
	end
end

function get_wifi_name()
	local wifiName = hs.wifi.currentNetwork()
    if wifiName then
        return wifiName
    else
        return "Wifi OFF"
    end
end

function strip_newlines(s)
	return s:gsub('\n', '')
end

function get_time_in_city()
	local timeInCity = hs.execute('TZ=":Europe/Madrid" date +%H:%M')
	-- strip new lines & add " in BCN" to timeInCity
	return strip_newlines(timeInCity) .. " in BCN"
end

function get_todays_events()
	local output = hs.execute('/opt/homebrew/bin/icalbuddy -npn -nc -iep datetime,title -ps "/ » /" eventsToday | fold -sw 80')
	return output
end

function get_next_event()
	local output = hs.execute('/opt/homebrew/bin/icalbuddy  -b "" -li 1 -n -nrd -ic vik.ramanujam@travelperk.com -npn -nc -iep "title,datetime" -ps "| : |" -po "datetime,title" -tf "" -df "%H:%I %RD" -eed eventsToday+1')
	-- truncate output to 40 characters & append ...
	if string.len(output) > 40 then
		output = string.sub(output, 0, 40) .. "...\n"
	end
	return output
end

status_spots = {}

function renderTime()
	local textArray = { 
		get_wifi_name(),
		get_battery_remaining(),
		os.date("%a %b %d, %Y %H:%M"),
		get_time_in_city(),
		get_next_event(),
	}
	-- remove blanks from textArray
	for i = #textArray, 1, -1 do
		if textArray[i] == "" then
			table.remove(textArray, i)
		end
	end
	-- delete all canvases
	for _, status_spot in pairs(status_spots) do
		status_spot:delete()
	end
	-- create new canvases
	for _, screen in pairs(hs.screen.allScreens()) do
		screenSize = screen:frame()
		_first_line = table.concat(textArray, " • ")
		_second_line = get_todays_events()
		_text = _first_line .. "\n" .. _second_line
		status_spot = hs.canvas.new(screen:fullFrame()):appendElements(
			{
			type = "text",
			textFont = "FantasqueSansMono Nerd Font Mono",
    	textSize = 14,
			text = _text,
			textAlignment = "right",
			frame = {
					x = 5,
					y = 10,
					w = screenSize.w - 20,
					h = 500,
			}
			})
			status_spots[screen:id()] = status_spot
			function deleteCanvas()
				status_spot:delete()
			end
			status_spot:sendToBack()
			status_spot:show()
	end
end

function showTime()
	date_time = os.date("%a %b %d, %Y %H:%M")
	showAlert(date_time)
end

t = hs.timer.doEvery(5, renderTime)
t:start()

-- Show the time as I normally have the menubar hidden
hs.hotkey.bind(HYPER, "t", function()
  showTime()
end)

