-- hotreload config
local function reloadConfig(files)
  local doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end

ConfigWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon", reloadConfig):start()

-- clock
hs.hotkey.bind({ "option" }, "c", function()
  local datetime = os.date("%Y") ..
      "年" ..
      os.date("%m") ..
      "月" .. os.date("%d") .. "日\n       " .. os.date("%H") .. ":" .. os.date("%M") .. ";" .. os.date("%S")
  hs.alert.show(datetime)
end)

-- app lancher
local function launchApp(appName)
  local app = hs.appfinder.appFromName(appName)
  if app == nil then
    hs.application.launchOrFocus("/Applications/" .. appName .. ".app")
  elseif app:isFrontmost() then
    app:hide()
  else
    app:activate(true)
  end
end

-- toggle app
local function toggleApp(appName, key)
  hs.application.enableSpotlightForNameSearches(true)
  hs.hotkey.bind({ "option" }, key, function()
    launchApp(appName)
  end)
end

toggleApp("wezter", "w")
toggleApp("vivaldi", "v")
toggleApp("zed", "z")
toggleApp("things", "t")
