{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.nixosModules.carlOS.plymouth;
in {
  options = {
    nixosModules.carlOS.plymouth = {
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
