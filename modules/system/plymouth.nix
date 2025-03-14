{
  lib,
  pkgs,
  flake-confs,
  config,
  ...
}: let
  cfg = config.nixosModules.plymouth;
in {
  options = {
    nixosModules.plymouth = {
      enable = lib.mkEnableOption "enable plymouth splash screen";
    };
  };
  config = lib.mkIf cfg.enable {
    boot.plymouth = {
      enable = true;
      themePackages = with pkgs; [
        plymouth-blahaj-theme
      ];
      theme = "blahaj";
    };
  };
}
