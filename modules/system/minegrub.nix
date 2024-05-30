{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.nixosModules.minegrub;
in {
  options = {
    nixosModules.minegub = {
      enable = lib.mkEnableOption "enable programming minegrub";
    };
  };
  config = lib.mkIf cfg.enable {
    boot.loader.grub = {
      minegrub-theme = {
        enable = true;
        splash = "100% Flakes!";
        boot-options-count = 4;
      };
    };
  };
}
