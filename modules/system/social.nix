{
  lib,
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
    users.users.carl.packages = with pkgs; [
      discord
      whatsapp-for-linux
      signal-desktop
      spotify
      sptlrx # spotify lyrics in cli
    ];
  };
}
