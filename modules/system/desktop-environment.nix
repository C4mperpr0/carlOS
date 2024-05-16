{
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.desktop-environment;
in {
  options = {
    nixosModules.desktop-environment = {
      enable = lib.mkEnableOption "enable desktop-environment programs";
      kde.enable = lib.mkEnableOption "enable kde";
      hyprland.enable = lib.mkEnableOption "enable hyprland";
    };
  };
  config =
    lib.mkIf cfg.enable {
      services.xserver.enable = true;
    }
    // lib.mkIf cfg.kde.enable
    {
      services.xserver = {
        displayManager.sddm.enable = true;
        desktopManager.plasma5.enable = true;
      };
    }
    // lib.mkIf cfg.hyprland.enable
    {
      programs.hyprland.enable = true;
      #programs.waybar = {
      #   enable = true;
      #  settings = import ./hyprland/waybarsettings.nix;
      #};
      #xdg.configFile = {
      #    "hypr/hyprland.conf".source = ./hyprland/hyprland.conf;
      # };
    };
}
