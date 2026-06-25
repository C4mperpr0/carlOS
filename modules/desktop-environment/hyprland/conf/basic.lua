hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        -- disable_autoreload = true,
        allow_session_lock_restore = true,
        animate_manual_resizes = true,
        vrr = 1
    },

    -- unscale XWayland
    xwayland = {
        force_zero_scaling = true
    }
})

-- toolkit-specific scale
hl.env("GDK_SCALE", "2")
hl.env("XCURSOR_SIZE", "28")
