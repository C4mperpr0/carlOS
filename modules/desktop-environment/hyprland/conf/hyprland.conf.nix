{
  config,
  lib,
}: let
  colors = config.lib.stylix.colors.withHashtag;
in ''
##### Testing #####
source = ./test.conf # needs to be first to override others

##### startup #####
${builtins.readFile ./startup.conf}

##### basic hyprland variables
${builtins.readFile ./basic.conf}

##### design #####
${import ./design.nix {inherit config;}}

##### monitor #####
${builtins.readFile ./monitor.conf}

##### input #####
${builtins.readFile ./input.conf}

##### window manager #####
${builtins.readFile ./window-manager.conf}

##### programs #####
${import ./binds.nix {inherit config;}}

##### window rules #####
## special window rules
${builtins.readFile ./special_window_rules.conf}

# colors example: ${config.lib.stylix.colors.base01}

#windowrulev2 = workspace name:Spotify, class:Spotify
windowrule = animation popin, tofi-drun # not working correctly yet, name not correct

###### workspace rules #####
#bind = SUPER, C, movetoworkspace, special
#workspace = s[true], name:Shell, persistens:true, on-created-empty:exec konsole
#workspace = s[true], name:Browsing, persistens:true
#workspace = s[true], name:Spotify, on-created-empty:exec spotify
# vllt spotify auf workspace spotify öffnen, aber überall anzeigen, als toogle funktion. Togglefunktion guckt dann auch ob es läuft, oder geöffnet werden muss?
# spotify immer im Hintergrund offen halten, und solange bis Focusverlust floating in der Mitte lassen

##### Testing #####
source = ./test.conf # does not work for some reason :(
''
