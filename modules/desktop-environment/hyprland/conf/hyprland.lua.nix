{
  config,
  lib,
  inputs,
}: let
  colors = config.lib.stylix.colors.withHashtag;
in ''
  ----- Testing -----
  -- source = ./test.conf -- needs to be first to override others

  ----- startup -----
  ${import ./startup.lua.nix}

  ----- basic hyprland variables -----
  ${builtins.readFile ./basic.lua}

  ----- design -----
  ${import ./design.lua.nix {inherit config;}}

  ----- monitor -----
  ${builtins.readFile ./monitor.lua}

  ----- input -----
  ${builtins.readFile ./input.lua}

  ----- window manager -----
  ${builtins.readFile ./window-manager.lua}

  ----- binds and programs -----
  ${import ./binds.lua.nix {inherit config;}}

  ----- window rules -----
  ${builtins.readFile ./special_window_rules.lua}

  ----- workspaces -----
  ${builtins.readFile ./workspaces.lua}

  ----- ilyamiro's serpantinum
  ${builtins.readFile "${inputs.serpantinum}/compositors/hyprland/config/autostart.lua"}
  ${builtins.readFile "${inputs.serpantinum}/compositors/hyprland/config/env.lua"}

  -- colors example: ${config.lib.stylix.colors.base01}
''
