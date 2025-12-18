{
  lib,
  flake-confs,
  pkgs,
  config,
  ...
}: let
  cfg = config.nixosModules.carlOS.software.social;
in {
  options = {
    nixosModules.carlOS.software.social = {
      enable = lib.mkEnableOption "enable social programs";
    };
  };
  config = lib.mkIf cfg.enable {
    users.users.${flake-confs.user.name}.packages = with pkgs; [
      discord
      wasistlos
      signal-desktop
      spotify
      sptlrx # spotify lyrics in cli
    ];
  };
}
