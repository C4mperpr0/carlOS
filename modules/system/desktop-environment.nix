{
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.desktop-environment;
in {
  imports = [./hyprland/hyprland.nix];

  options = {
    nixosModules.desktop-environment = {
      kde.enable = lib.mkEnableOption "enable kde";
      hyprland.enable = lib.mkEnableOption "enable hyprland";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.kde.enable
      {
        services = {
          xserver.enable = true;
          displayManager.sddm.enable = true;
          xserver.desktopManager.plasma5.enable = true;
        };
      })
    (lib.mkIf cfg.hyprland.enable
      {
        nixosModules.hyprland.enable = true;
      })
  ];
}
