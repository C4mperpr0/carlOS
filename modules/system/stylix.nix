{
  lib,
  pkgs,
  flake-confs,
  pkgs-unstable,
  inputs,
  config,
  ...
}: let
  cfg = config.nixosModules.stylix;
in {
  options = {
    nixosModules.stylix = {
      enable = lib.mkEnableOption "enable ricing with stylix";
    };
  };
  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      #image = import ./hyprland/hyprpaper.nix {inherit lib;};
      image = pkgs.fetchurl {
        url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
        sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
      };
      base16Scheme = "${pkgs.base16-schemes}/share/themes/unikitty-dark.yaml";
      #colors.override = {
      #};
      cursor = {
        package = pkgs.vimix-cursors;
        name = "Vimix-cursors";
      };

      #targets = {
      #  playmouth = {
      #    enable = true;
      #    logo = "";
          #logoAnimated = true;
      #  };
      #};
    };
  };
}
