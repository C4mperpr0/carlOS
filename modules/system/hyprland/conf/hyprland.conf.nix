{
  config,
  lib,
}: let
  colors = config.lib.stylix.colors.withHashtag;
in ''
##### startup #####
${builtins.readFile ./startup.conf}

##### basic hyprland variables
${builtins.readFile ./basic.conf}

##### design #####
${builtins.readFile ./design.conf}

##### monitor #####
${builtins.readFile ./monitor.conf}

##### input #####
${builtins.readFile ./input.conf}

##### window manager #####
${builtins.readFile ./window-manager.conf}

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
# general design
${builtins.readFile ./design.conf}

# SpeedCrunch
windowrule = float, title:^(SpeedCrunch)$
windowrule = move 75% 65%, title:^(SpeedCrunch)$
windowrule = size 25% 35%, title:^(SpeedCrunch)$
windowrule = opacity 0.6, title:^(SpeedCrunch)$

# ${colors.base01}

#windowrulev2 = workspace name:Spotify, class:Spotify
windowrule = animation popin, tofi-drun # not working correctly yet, name not correct

###### workspace rules #####
bind = SUPER, C, movetoworkspace, special
#workspace = s[true], name:Shell, persistens:true, on-created-empty:exec konsole
#workspace = s[true], name:Browsing, persistens:true
#workspace = s[true], name:Spotify, on-created-empty:exec spotify
# vllt spotify auf workspace spotify öffnen, aber überall anzeigen, als toogle funktion. Togglefunktion guckt dann auch ob es läuft, oder geöffnet werden muss?
# spotify immer im Hintergrund offen halten, und solange bis Focusverlust floating in der Mitte lassen

##### Testing #####
source = ./test.conf # does not work for some reason :(
''
