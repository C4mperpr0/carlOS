{
  pkgs,
  flake-confs,
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.carlOS.software.gaming;
in {
  options = {
    nixosModules.carlOS.software.gaming = {
      enable = lib.mkEnableOption "enable gaming programs";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;
    users.users.${flake-confs.user.name}.packages = with pkgs; [
      vesktop
      superTuxKart
      # nxengine-evo # won't compile :(
      oneko  # very important!
      linuxwave  # music for racing game
    ];

    # Enable networking
    networking.networkmanager.enable = true;
    networking.firewall = {
      enable = false; # TODO: only temp
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
