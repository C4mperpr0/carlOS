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
    # Make steam work
    hardware.opengl = {
      enable = true;
      driSupport32Bit = true;
    };
    programs.steam.enable = true;
    users.users.${flake-confs.user.name}.packages = with pkgs; [
      #steam
      vesktop
      superTuxKart
      nxengine-evo
      oneko # very important!
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
