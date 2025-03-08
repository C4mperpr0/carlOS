{config, ...}:
''
# general binds
bind = , XF86PowerOff, exec, pkill rofi || rofi -show p -modi p:rofi-power-menu -theme carlOS-theme
bind = SUPER_SHIFT, L, exec, pkill rofi || rofi -show p -modi p:rofi-power-menu -theme carlOS-theme
bind = SUPER, SUPER_L, exec, pkill tofi-drun || tofi-drun --config ${builtins.toFile "tofi.conf" (import ./tofi-config.nix {inherit config;})}
bind = SUPER, period, exec, pkill rofi-rbw || rofi-rbw --selector rofi --clipboarder wl-copy --typer wtype
bind = SUPER, P, exec, pkill wdisplays || wdisplays
bind = SUPER, T, exec, konsole
bind = SUPER, E, exec, dolphin
bind = SUPER, B, exec, firefox
bind = SUPER, O, exec, obsidian
bind = SUPER, K, exec, kdeconnect-app
bind = SUPER, ESCAPE, exec, btop
bind = , key:248, exec, notify-send "Camera switch set"
# media
bind = SUPER, M, submap, media
submap = media
bind = , M, exec, spotify
bind = , W, exec, whatsapp-for-linux
bind = , S, exec, signal
bind = , catchall, submap, reset
submap = reset
''
