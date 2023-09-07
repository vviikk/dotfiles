HYPER = { "cmd", "alt", "ctrl", "shift" }
wm=hs.webview.windowMasks

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install=spoon.SpoonInstall

--	Auto-reload config file. Called whenever a *.lua in the directory changes
function reloadConfig(files)
   doReload = false
   for _,file in pairs(files) do
       if file:sub(-4) == ".lua" then
           doReload = true
       end
   end
   if doReload then
       hs.reload()
   end
end

hs.alert.defaultStyle.textSize = 14
hs.alert.defaultStyle.radius = 2
hs.alert.defaultStyle.atScreenEdge = 2
hs.alert.defaultStyle.fadeInDuration = 0
hs.alert.defaultStyle.fadeOutDuration = 0
hs.alert.defaultStyle.fillColor = { white = 0, alpha = 1 }
hs.alert.defaultStyle.textStyle = {paragraphStyle = {alignment = "right"}}

-- custom hs.alert.show function
function showAlert(message, style, screen, duration)
    -- show only one alert at a time
    hs.alert.closeAll()
    hs.alert.show(message, style, screen, duration)
end

local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

local SkyRocket = hs.loadSpoon("SkyRocket")

sky = SkyRocket:new({
  -- Which modifiers to hold to move a window?
  moveModifiers = {'cmd', 'shift'},

  -- Which modifiers to hold to resize a window?
  resizeModifiers = {'ctrl', 'shift'},

  -- Which modifiers to enable zones?
  fancyZoneModifier = HYPER,

  -- Which zones
  -- Y=0 upside
  zones = {
    {w=0.50,h=0.65,x=0.0 ,y=0},
    {w=0.50,h=0.65,x=0.50,y=0},
    {w=0.25,h=0.35,x=0.0, y=0.65},
    {w=0.25,h=0.35,x=0.25,y=0.65},
    {w=0.25,h=0.35,x=0.50,y=0.65},
    {w=0.25,h=0.35,x=0.75,y=0.65},
  },
})

require('keyboard') -- Load Hammerspoon bits from https://github.com/jasonrudolph/keyboard
-- require('spoons') -- Load Hammerspoon bits from
require('kitty-visor')
require('translation-popup')
require('mic-drop')
require('show-status')
require('volume')
require('file-manager-visor')

-- Alert "Config loaded" here, happens not as we call reload, but as we load. Default alert durration=2 sec.
showAlert("Config loaded")