{
  config,
  lib,
}: ''
  ##### startup #####
  exec-once = waybar
  exec-once = hyprpaper
  exec-once = ags run
  exec-once = nm-applet --indicator & disown
  exec-once = kdeconnectd
  exec-once = kwalletd5

  ##### monitor #####
  #monitor = , 1920x1080@120, 0x0, 1
  monitor = eDP-1, 2880x1800@120, auto, 2
  monitor = , preferred, auto, 1

  ##### input #####
  input {
          kb_layout = de
          kb_options = caps:escape
          touchpad {
                  natural_scroll = true
          }
  }

  ##### window manager #####
  bind = SUPER, Tab, cyclenext,
  bind = SUPER, Tab, bringactivetotop,
  #bindm = ALT, mouse:272, movewindow
  bindm = ALT, SPACE, resizeactive
  bindm = SUPER, SPACE, movewindow
  binde = SUPER, Q, killactive,

  # workspaces
  bind = SUPER_CTRL, left, workspace, -1
  bind = SUPER_CTRL, A, workspace, -1
  bind = SUPER_CTRL, right, workspace, +1
  bind = SUPER_CTRL, d, workspace, +1
  #bind = SUPER_CTRL, N, togglespecialworkspace, Spotify
  #bind = SUPER_CTRL, M, workspace, name:Spotify
  bind = SUPER__ALT_L, left, movetoworkspace, -1
  bind = SUPER__ALT_L, right, movetoworkspace, +1

  # media
  bindel = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
  bindel = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
  bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

  # display brightness
  bindl = , XF86MonBrightnessUp, exec, brightnessctl set +5%
  bindl = , XF86MonBrightnessDown, exec, brightnessctl set 5%-

  ##### programs #####
  bind = SUPER, SUPER_L, exec, pkill tofi-drun || tofi-drun --config ${builtins.toFile "tofi.conf" (import ./tofi-config.nix {inherit config;})}
  bind = SUPER, T, exec, konsole
  bind = SUPER, E, exec, dolphin
  bind = SUPER, B, exec, firefox
  bind = SUPER, O, exec, obsidian
  bind = SUPER, K, exec, kdeconnect-app
  bind = SUPER, ESCAPE, exec, btop
  # media
  bind = SUPER, M, submap, media
  submap = media
  bind = , M, exec, spotify
  bind = , W, exec, whatsapp-for-linux
  bind = , S, exec, signal
  bind = , catchall, submap, reset
  submap = reset

  ##### window rules #####
  windowrule = float, title:^(SpeedCrunch)$
  windowrule = move 75% 65%, title:^(SpeedCrunch)$
  windowrule = size 25% 35%, title:^(SpeedCrunch)$
  windowrule = opacity 0.6, title:^(SpeedCrunch)$

  #windowrulev2 = workspace name:Spotify, class:Spotify
  windowrule = animation popin, tofi-drun # not working correctly yet, name not correct

  ###### workspace rules #####
  bind = SUPER, C, movetoworkspace, special
  #workspace = s[true], name:Shell, persistens:true, on-created-empty:exec konsole
  #workspace = s[true], name:Browsing, persistens:true
  #workspace = s[true], name:Spotify, on-created-empty:exec spotify
  # vllt spotify auf workspace spotify öffnen, aber überall anzeigen, als toogle funktion. Togglefunktion guckt dann auch ob es läuft, oder geöffnet werden muss?
  # spotify immer im Hintergrund offen halten, und solange bis Focusverlust floating in der Mitte lassen
''
