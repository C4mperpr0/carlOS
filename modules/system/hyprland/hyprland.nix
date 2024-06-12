{
  inputs,
  lib,
  config,
  flake-confs,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.hyprland;
in {
  options = {
    nixosModules.hyprland = {
      enable = lib.mkEnableOption "enable hyprland";
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    programs.hyprland.enable = true;

    home-manager.users."${flake-confs.user.name}" = {
      xdg.configFile = {
        "hypr/hyprland.conf".source = ./hyprland.conf;
        "hypr/hyprpaper.conf".text = import ./hyprpaper.nix {inherit lib;};
      };
      imports = [inputs.ags.homeManagerModules.default];
      programs = {
        #waybar = {
        #  enable = true;
        #  settings = import ./waybarsettings.nix;
        #};
        ags = {
          enable = true;
          # configDir = ./ags;
          extraPackages = with pkgs; [
            gtksourceview
            webkitgtk
            accountsservice
          ];
        };
      };
      home.packages = with pkgs; [
        hyprpaper
        libsForQt5.qt5.qtwayland
        brightnessctl
        libnotify
      ];
    };
  };
}
