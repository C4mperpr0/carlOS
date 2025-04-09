{
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.carlOS.minegrub;
in {
  options = {
    nixosModules.carlOS.minegrub = {
      enable = lib.mkEnableOption "enable programming minegrub";
    };
  };
  config = lib.mkIf cfg.enable {
    boot.loader.grub = {
      minegrub-theme = {
        enable = true;
        boot-options-count = 4;
      };
    };
  };
}
