-- gestures
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
hl.gesture({
    fingers = 3,
    direction = "vertical",
    scale = 1.5,
    action = "special",
    workspace_name = "konsole"
})
hl.gesture({
    fingers = 4,
    direction = "vertical",
    action = "fullscreen"
})
hl.gesture({
    fingers = 5,
    direction = "vertical",
    action = "float"
})

-- general
hl.bind("SUPER + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())   -- Change focus to another window
    hl.dispatch(hl.dsp.window.bring_to_top()) -- Bring it to the top
end)
hl.bind("ALT + SPACE", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + SPACE", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + Q", hl.dsp.window.close({ window = "activewindow" }), { repeating = true })
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.kill(), { repeating = true })
hl.bind("SUPER + F", hl.dsp.window.float("toggle"))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.pin("toggle"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))

-- rearrange windows
hl.bind("SUPER + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + down", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + right", hl.dsp.window.move({ direction = "r" }))

-- move window over workspaces
hl.bind("SUPER + SHIFT + a", hl.dsp.window.move({ workspace = "-1" }))
hl.bind("SUPER + SHIFT + d", hl.dsp.window.move({ workspace = "+1" }))

-- move focus
hl.bind("ALT + w", hl.dsp.focus({ direction = "u" }))
hl.bind("ALT + a", hl.dsp.focus({ direction = "l" }))
hl.bind("ALT + s", hl.dsp.focus({ direction = "d" }))
hl.bind("ALT + d", hl.dsp.focus({ direction = "r" }))

-- workspaces
hl.bind("SUPER + a", hl.dsp.focus({ workspace = "-1" }))
hl.bind("SUPER + d", hl.dsp.focus({ workspace = "+1" }))

-- special keys
hl.bind("XF86Calculator", hl.dsp.exec_cmd("speedcrunch"))

-- media
-- -- Volume
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { repeating = true, locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
    { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
-- Next/Previous song
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("SHIFT + XF86AudioMute", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

-- display brightness
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
hl.bind("SUPER + XF86MonBrightnessDown",
    hl.dsp.exec_cmd("dunstify 'Display off in 3s...' && sleep 3 && hyprctl dispatch 'hl.dsp.dpms({ action = 1 })'"),
    { locked = true })

-- zoom
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5
---@param offset number
---@return nil
local function zoom(factor)
    local current = hl.get_config("cursor.zoom_factor")
    if factor ~= nil then
        current = current * factor
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, current)
    hl.config({ cursor = { zoom_factor = current } })
end
hl.bind("SUPER + plus", function()
    zoom(1.2)
end, { repeating = true })
hl.bind("SUPER + minus", function()
    zoom(-1.2)
end, { repeating = true })
