{
  flake-confs,
  carlOS-lib,
  ...
}: let
  confs =
    {
      display-dimm-after = 240;
      display-off-after = 270;
      lock-after = 300;
      sleep-after = 315;
    }
    // carlOS-lib.getNestedAttr flake-confs "modules.hyprland.hypridle";
in
  ''
  # https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/
    
    ${if confs.display-dimm-after != 0 then "# display dimm
    listener {
      timeout = ${toString confs.display-dimm-after}
      on-timeout = brightnessctl -s set 10 && brightnessctl -sd platform::* set 0
      on-resume = brightnessctl -r && brightnessctl -rd platform::*;
    }" else "# Display-dimm timer deactivated. Set modules.hyprland.hypridle.display-dimm-after to activate it."}

    ${if confs.display-off-after != 0 then "# display timeout
    listener {
      timeout = ${toString confs.display-off-after}
      on-timeout = hyprctl dispatch dpms off
      on-resume = hyprctl dispatch dpms on;
    }" else "# Display-off timer deactivated. Set modules.hyprland.hypridle.display-off-after to activate it."}

    ${if confs.lock-after != 0 then "# lock
    listener {
      timeout = ${toString confs.lock-after}
      on-timeout = pidof hyprlock || hyprlock --grace 15
      on-resume = notify-send \"unlocked notification\";
    }" else "# Lock timer deactivated. Set modules.hyprland.hypridle.lock-after to activate it."}

    ${if confs.sleep-after != 0 then "# sleep
    listener {
      timeout = ${toString confs.sleep-after}
      on-timeout = systemctl sleep
      on-resume = notify-send \"woken up from sleep\";
    }" else "# Sleep timer deactivated. Set modules.hyprland.hypridle.sleep-after to activate it."}
  ''
