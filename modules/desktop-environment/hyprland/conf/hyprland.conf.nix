{
  config,
  lib,
}: let
  colors = config.lib.stylix.colors.withHashtag;
in ''
##### Testing #####
# source = ./test.conf # needs to be first to override others

##### startup #####
${import ./startup.nix}

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

##### binds and programs #####
${import ./binds.nix {inherit config;}}

##### window rules #####
## special window rules
${builtins.readFile ./special_window_rules.conf}

##### workspaces #####
${builtins.readFile ./workspaces.conf}


# colors example: ${config.lib.stylix.colors.base01}

''
