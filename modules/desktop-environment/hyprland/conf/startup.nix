''
exec-once = waybar
exec-once = hyprpaper
exec-once = ags run
exec-once = nm-applet --indicator & disown
exec-once = kdeconnectd
exec-once = kdeconnect-indicator
exec-once = kwalletd5
exec-once = hypridle
exec-once = wl-paste --type text --watch cliphist store # Stores only text data
exec-once = wl-paste --type image --watch cliphist store # Stores only image data
exec-once = hyprland-monitor-attached ${builtins.toFile "hyprmonitor-db.sh" "hyprctl notify  1 2500 red Hi
 & python3 /home/carl/Documents/git/hyprmonitor/main.py"}
''
