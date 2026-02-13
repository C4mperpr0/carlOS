{config, ...}:
''
# general binds
bind = , XF86PowerOff, exec, pkill rofi || rofi -show p -modi p:rofi-power-menu -theme carlOS-theme
bind = , XF86Favorites, exec, echo -e "power-saver\nbalanced\nperformance" | grep -n "$(powerprofilesctl get)" | awk -F: '{print $1}' | while read i; do p=(power-saver balanced performance); n="''${p[$((i%3))]}"; powerprofilesctl set "$n"; case "$n" in performance) ic="";; balanced) ic="󰗑";; power-saver) ic="󰌪";; esac; dunstify -h string:x-dunst-stack-tag:powerprofilechanged "$ic  Power-Mode set to $n"; done
bind = , Print, exec, tmp="$(mktemp --suffix=.png)"; hyprshot -m active -m output -r -s >"$tmp"; action="$(dunstify -a hyprshot-keybind -i "$tmp" -A save,Save -A open,Open "Screenshot saved to clipboard")"; case "$action" in save) out="$HOME/Pictures/Screenshots/$(date '+%Y-%m-%d_%H-%M-%S').png"; mkdir -p "$HOME/Pictures/Screenshots/"; mv "$tmp" "$out"; dunstify -a hyprshot-keybind "Screenshot saved as" "$(basename "$out")";; open) okular "$tmp";; *) rm "$tmp";; esac
bind = SHIFT, Print, exec, tmp="$(mktemp --suffix=.png)"; hyprshot -m region --freeze -r -s >"$tmp"; action="$(dunstify -a hyprshot-keybind -i "$tmp" -A save,Save -A open,Open "Screenshot saved to clipboard")"; case "$action" in save) out="$HOME/Pictures/Screenshots/$(date '+%Y-%m-%d_%H-%M-%S').png"; mkdir -p "$HOME/Pictures/Screenshots/"; mv "$tmp" "$out"; dunstify -a hyprshot-keybind "Screenshot saved as" "$(basename "$out")";; open) okular "$tmp";; *) rm "$tmp";; esac
bind = SUPER_SHIFT, L, exec, pkill rofi || rofi -show p -modi p:rofi-power-menu -theme carlOS-theme
bind = SUPER, SUPER_L, exec, pkill tofi-drun || tofi-drun --config ${builtins.toFile "tofi.conf" (import ./tofi-config.nix {inherit config;})}
bind = SUPER, period, exec, pkill rofi-rbw || rofi-rbw --selector rofi --clipboarder wl-copy --typer wtype --selector-args="-theme carlOS-theme" 
bind = SUPER, V, exec, cliphist list | rofi -dmenu -theme carlOS-theme | cliphist decode | wl-copy
bind = SUPER, P, exec, pkill wdisplays || wdisplays
bind = SUPER, T, exec, konsole
bind = SUPER, E, exec, dolphin
bind = SUPER, B, exec, firefox
bind = SUPER, O, exec, obsidian
bind = SUPER, K, exec, kdeconnect-app
bind = SUPER, ESCAPE, exec, btop
bind = , key:248, exec, notify-send "Camera switch set"

# media
workspace = s[true], gapsout:50
windowrule = workspace special:media, title:^(Spotify)$
windowrule = workspace special:media, title:^(Signal)$
windowrule = workspace special:media, title:^(WasIstLos)$
#bindo = SUPER_L, SHIFT_L, togglespecialworkspace, terminal 
bind = SUPER_L_SHIFT_L, m, exec, pgrep spotify && hyprctl dispatch togglespecialworkspace media || spotify &
bind = SUPER_L_SHIFT_L, s, exec, hyprctl dispatch togglespecialworkspace media && signal-desktop & # TODO: it is not possible to check wethers its running already, bc it seems to only have an electron process
bind = SUPER_L_SHIFT_L, w, exec, pgrep wasistlos && hyprctl dispatch togglespecialworkspace media || wasistlos &
''
