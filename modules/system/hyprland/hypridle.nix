{lib, flake-confs, ...}:
let
    conf = flake-confs.desktop-environment.hyprland.hypridle;
in
# https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/
''
# display dimm 
listener {
    timeout = ${toString conf.display-dimm-after} 
    on-timeout = brightnessctl -s set 10 && brightnessctl -sd platform::* set 0
    on-resume = brightnessctl -r && brightnessctl -rd platform::*
}

# display timeout
listener {
    timeout = ${toString conf.display-off-after}
    on-timeout = hyprctl dispatch dpms off
    on-resume = hyprctl dispatch dpms on
}

# lock
listener {
    timeout = ${toString conf.lock-after}
    on-timeout = pidof hyprlock || hyprlock
    on-resume = notify-send "unlocked notification" 
}

# sleep
listener {
    timeout = ${toString conf.sleep-after}
    on-timeout = systemctl sleep
    on-resume = notify-send "woken up from sleep"
}
''
