{
  config,
  lib,
  ...
}: let
  cfg = config.nixosModules.carlOS.desktop-environment;
in {
  options = {
    nixosModules.carlOS.desktop-environment = {
      all.enable = lib.mkEnableOption "enable all desktop environments";

      kde.enable = lib.mkEnableOption "enable KDE";
      hyprland.enable = lib.mkEnableOption "enable Hyprland";
      gnome.enable = lib.mkEnableOption "enable GNOME";
    };
  };

  config = lib.mkMerge (
    [
      # Enable all DEs if all is enabled
      (
        lib.mkIf cfg.all.enable {
          nixosModules.carlOS.desktop-environment = {
            kde.enable = lib.mkDefault true;
            hyprland.enable = lib.mkDefault true;
            gnome.enable = lib.mkDefault true;
          };
        }
      )
    ]
    ++ [
      (lib.mkIf cfg.kde.enable {
        services = {
          xserver.enable = true;
          displayManager.sddm.enable = true;
          desktopManager.plasma6.enable = true;
        };
      })

      (lib.mkIf cfg.hyprland.enable {
        nixosModules.hyprland.enable = true;
      })

      (lib.mkIf cfg.gnome.enable {
        services.xserver = {
          displayManager.gdm.enable = true;
          desktopManager.gnome.enable = true;
        };
      })
    ]
  );
}
