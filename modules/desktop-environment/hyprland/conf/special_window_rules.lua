-- SpeedCrunch
hl.window_rule({
    match = { title = "^(SpeedCrunch)$" },
    float = true,
    move = { "(monitor_w*0.75)", "(monitor_h*0.65)" },
    size = { "(monitor_w*0.25)", "(monitor_h*0.35)" },
    opacity = 0.6
})

-- wdisplays
hl.window_rule({
    match = { title = "^(wdisplays)$" },
    float = true,
    size = { "(monitor_w*0.9)", "(monitor_h*0.9)" },
    center = true,
    pin = true,
    dim_around = true
})

-- volume control
hl.window_rule({
    match = { title = "^(Volume Control)$" },
    float = true,
    move = { "(monitor_w*0.3)", "(monitor_h*0.05)" },
    size = { "(monitor_w*0.4)", "(monitor_h*0.4)" },
    opacity = 0.8
})

-- mn-connection-editor
hl.window_rule({
    match = { title = "^(Volume Control)$" },
    float = true,
    move = { "(monitor_w*0.3)", "(monitor_h*0.05)" },
    size = { "(monitor_w*0.4)", "(monitor_h*0.4)" },
    opacity = 0.8
})
