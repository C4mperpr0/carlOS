{
  pkgs,
  flake-confs,
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
    programs.steam.enable = true;
    users.users.${flake-confs.user.name}.packages = with pkgs; [
      vesktop
      superTuxKart
      nxengine-evo
      oneko  # very important!
      linuxwave  # music for racing game
    ];

    # Enable networking
    networking.networkmanager.enable = true;
    networking.firewall = {
      enable = true;
      allowedTCPPortRanges = [
        {
          from = 2757;
          to = 2759;
        }  # SuperTuxKart
      ];
      allowedUDPPortRanges = [
        {
          from = 2757;
          to = 2759;
        }  # SuperTuxKart
      ];
    };
  };
}
