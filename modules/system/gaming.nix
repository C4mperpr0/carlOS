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
    # Make steam work
    hardware.opengl.driSupport32Bit = true;

    users.users.carl.packages = with pkgs; [
      steam
      discord
      superTuxKart
      nxengine-evo
    ];

    # Enable networking
    networking.networkmanager.enable = true;
    networking.firewall = {
      enable = true;
      allowedTCPPortRanges = [
        {
          from = 2757;
          to = 2759;
        } # SuperTuxKart
      ];
      allowedUDPPortRanges = [
        {
          from = 2757;
          to = 2759;
        } # SuperTuxKart
      ];
    };
  };
}
