{
  lib,
  config,
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

    home-manager.users.carl = {
      xdg.configFile = {
        "hypr/hyprland.conf".source = ./hyprland.conf;
        "hypr/hyprpaper.conf".text = import ./hyprpaper.nix {inherit lib;};
      };
      programs = {
        waybar = {
          enable = true;
          settings = import ./waybarsettings.nix;
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
