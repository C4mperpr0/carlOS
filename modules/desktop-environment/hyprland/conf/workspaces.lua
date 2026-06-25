-- konsole
hl.workspace_rule({ workspace = "special:konsole", on_created_empty = "konsole" })
hl.bind("SUPER + SHIFT + T", hl.dsp.workspace.toggle_special("konsole")) -- TODO: SUPER_L_SHIFT_L is actually XF85Assistant, but it's not available in hyprland yet
hl.bind("SUPER + T", hl.dsp.workspace.toggle_special("konsole"), { long_press = true })

-- spotify
hl.workspace_rule({ workspace = "special:spotify", on_created_empty = "spotify" })
hl.window_rule({
    match = { class = "^(Spotify)$" },
    workspace = "special:spotify"
})
hl.bind("SUPER + SHIFT + m", hl.dsp.workspace.toggle_special("spotify"))

-- signal
hl.workspace_rule({ workspace = "special:signal", on_created_empty = "signal-desktop" })
hl.window_rule({
    match = { class = "^(Signal)$" },
    workspace = "special:signal"
})
hl.bind("SUPER + SHIFT + s", hl.dsp.workspace.toggle_special("signal"))

-- whatsapp
hl.workspace_rule({ workspace = "special:whatsapp", on_created_empty = "karere" })
hl.window_rule({
    match = { class = "^(karere)$" },
    workspace = "special:whatsapp"
})
hl.bind("SUPER + SHIFT + w", hl.dsp.workspace.toggle_special("whatsapp"))

-- discord
hl.workspace_rule({ workspace = "special:discord", on_created_empty = "discord" })
hl.window_rule({
    match = { class = "^(Discord)$" },
    workspace = "special:discord"
})
hl.bind("SUPER + SHIFT + x", hl.dsp.workspace.toggle_special("discord"))
