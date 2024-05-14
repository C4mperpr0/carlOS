{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.gaming;
in {
  options = {
    nixosModules.gaming = {
      enable = lib.mkEnableOption "enable gaming programs";
    };
  };
  config = lib.mkIf cfg.enable {
    users.users.carl.packages = with pkgs; [
      steam
      discord
      superTuxKart
      nxengine-evo
    ];
  };
}
