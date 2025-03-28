{
  lib,
  flake-confs,
  ...
}: let
  specific-confs = flake-confs.modules.hyprland.hypridle;
  confs = {
    display-dimm-after =
      if builtins.hasAttr "display-dimm-after" specific-confs
      then specific-confs.display-dimm-after
      else 240;
    display-off-after =
      if builtins.hasAttr "display-off-after" specific-confs
      then specific-confs.display-off-after
      else 270;
    lock-after =
      if builtins.hasAttr "lock-after" specific-confs
      then specific-confs.lock-after
      else 300;
    sleep-after =
      if builtins.hasAttr "sleep-after" specific-confs
      then specific-confs.sleep-after
      else 315;
  };
in
  # https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/
  ''
    # display dimm
    listener {
        timeout = ${toString confs.display-dimm-after}
        on-timeout = brightnessctl -s set 10 && brightnessctl -sd platform::* set 0
        on-resume = brightnessctl -r && brightnessctl -rd platform::*
    }

    # display timeout
    listener {
        timeout = ${toString confs.display-off-after}
        on-timeout = hyprctl dispatch dpms off
        on-resume = hyprctl dispatch dpms on
    }

    # lock
    listener {
        timeout = ${toString confs.lock-after}
        on-timeout = pidof hyprlock || hyprlock
        on-resume = notify-send "unlocked notification"
    }

    # sleep
    listener {
        timeout = ${toString confs.sleep-after}
        on-timeout = systemctl sleep
        on-resume = notify-send "woken up from sleep"
    }
  ''
