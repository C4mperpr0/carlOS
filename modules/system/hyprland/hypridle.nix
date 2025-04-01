{
  flake-confs,
  ...
}: let
  carlOS-lib = import ../../../lib;
  confs = carlOS-lib.check-flake-conf flake-confs "modules.hyprland.hypridle" {
     display-dimm-after = 240;
   display-off-after = 270;
   lock-after = 300;
   sleep-after = 315;
  };
in
  # https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/
  ''
    # display dimm
    listener {
        timeout = ${toString confs.display-dimm-after}
        on-timeout = brightnessctl -s set 10 && brightnessctl -sd platform::* set 0
        on-resume = brightnessctl -r && brightnessctl -rd platform::*;
    }

    # display timeout
    listener {
        timeout = ${toString confs.display-off-after}
        on-timeout = hyprctl dispatch dpms off
        on-resume = hyprctl dispatch dpms on;
    }

    # lock
    listener {
        timeout = ${toString confs.lock-after}
        on-timeout = pidof hyprlock || hyprlock
        on-resume = notify-send "unlocked notification";
    }

    # sleep
    listener {
        timeout = ${toString confs.sleep-after}
        on-timeout = systemctl sleep
        on-resume = notify-send "woken up from sleep";
    }
  ''
