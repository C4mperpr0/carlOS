{
  lib,
  config,
  flake-confs,
  pkgs,
  ...
}: let
  cfg = config.nixosModules.carlOS.desktop-environment.hyprland.hyprpaper;
in {
  options = {
    nixosModules.carlOS.desktop-environment.hyprland.hyprpaper = {
      enable = lib.mkEnableOption "enable wallpapers with hyprpaper";
    };
  };
  config = lib.mkIf cfg.enable {
    users.users.${flake-confs.user.name}.packages = with pkgs; [
      hyprpaper
    ];
    home-manager.users."${flake-confs.user.name}".services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        wallpaper = [
          {
            monitor = "";
            path = builtins.path {path = ../assets/red_black_shapes_lines_abstraction_4k_hd_abstract-3840x2160.jpg;};
          }
        ];
      };
    };
  };
}
