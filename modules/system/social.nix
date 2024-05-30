{
  lib,
  flake-confs,
  pkgs,
  config,
  ...
}: let
  cfg = config.nixosModules.social;
in {
  options = {
    nixosModules.social = {
      enable = lib.mkEnableOption "enable social programs";
    };
  };
  config = lib.mkIf cfg.enable {
    users.users.${flake-confs.user.name}.packages = with pkgs; [
      discord
      whatsapp-for-linux
      signal-desktop
      spotify
      sptlrx # spotify lyrics in cli
    ];
  };
}
