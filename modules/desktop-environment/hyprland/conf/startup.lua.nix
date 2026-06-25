''
  hl.on("hyprland.start", function ()
   hl.exec_cmd("waybar")
   hl.exec_cmd("hyprpaper")
   hl.exec_cmd("nm-applet --indicator & disown")
   hl.exec_cmd("kdeconnectd")
   hl.exec_cmd("kdeconnect-indicator")
   hl.exec_cmd("kwalletd5")
   hl.exec_cmd("hypridle")
   hl.exec_cmd("wl-paste --type text --watch cliphist store") -- Stores only text data
   hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Stores only image data
   hl.exec_cmd("hyprland-monitor-attached ${builtins.toFile "hyprmonitor-db.sh" "hyprctl notify  1 2500 red Hi
 & python3 /home/carl/Documents/git/hyprmonitor/main.py"}")
  end)
''
