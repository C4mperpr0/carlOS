{
  pkgs,
  flake-confs,
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.carlOS.software.ui-utils;
in {
  options = {
    nixosModules.carlOS.software.ui-utils = {
      enable = lib.mkEnableOption "enable ui-utils programs";
    };
  };
  config = lib.mkIf cfg.enable {
    users.users.${flake-confs.user.name}.packages = with pkgs; [
      systemdgenie
      gparted
      qdirstat
    ];
  };
}
