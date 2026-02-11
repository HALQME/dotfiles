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

-- app lancher
local function launchApp(bundleID)
    local app = hs.application.get(bundleID)
    if not app then
        hs.application.open(bundleID)
        app = hs.application.get(bundleID)
        app:activate(true)
    else
        if app:isFrontmost() then
            app:hide()
        else
            app:activate(true)
        end
    end
end

local hyper = { "cmd", "alt", "ctrl", "shift" }

-- toggle app
local function toggleApp(appName, key)
    hs.hotkey.bind(hyper, key, function()
        launchApp(appName)
    end)
end

toggleApp("com.mitchellh.ghostty", "g")
-- toggleApp("com.github.wez.wezterm", "w")
toggleApp("com.culturedcode.ThingsMac", "t")
