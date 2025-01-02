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
      gnome.enable = lib.mkEnableOption "enable gnome";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.kde.enable
      {
        services = {
          xserver.enable = true;
          displayManager.sddm.enable = true;
          desktopManager.plasma6.enable = true;
        };
      })
    (lib.mkIf cfg.hyprland.enable
      {
        nixosModules.hyprland.enable = true;
      })
    (lib.mkIf cfg.gnome.enable {
      services.xserver.desktopManager.gnome.enable = true;
    })
  ];
}
