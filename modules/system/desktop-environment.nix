{
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.desktop-environment;
in {
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
        #specialisation."kde".configuration = {
        # system.nixos.tags = ["test2"];
        services = {
          xserver.enable = true;
          displayManager.sddm.enable = true;
          desktopManager.plasma6.enable = true;
        };
        #};
      })
    (lib.mkIf cfg.hyprland.enable
      {
        #specialisation."hyprland".configuration = {
        nixosModules.hyprland.enable = true;
        #};
      })
    (lib.mkIf cfg.gnome.enable {
      #specialisation."gnome".configuration = {
      services.xserver.desktopManager.gnome.enable = true;
      #};
    })
  ];
}
