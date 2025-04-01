{
  lib,
  pkgs,
  flake-confs,
  config,
  ...
}: let
  cfg = config.nixosModules.nixos-basics;
in {
  options = {
    nixosModules.nixos-basics = {
      enable = lib.mkEnableOption "enable basic nixos configurations";
      home-manager.enable = lib.mkEnableOption "enable basic home-manager config";
      gc.enable = lib.mkEnableOption "enable nixos gc";
      soundserver.enable = lib.mkEnableOption "enable videoEditing";
    };
  };
  config =
    lib.mkIf cfg.enable {
      # add supported filesystems
      boot.supportedFilesystems = ["nfts"];

      # set hostname
      networking.hostName = throw "testing...";#flake-confs.hostname;

      # naming in grub
      system.nixos.tags = ["CarlOS:${flake-confs.buildname}"];

      # enable all required experimental-features
      nix = {
        settings =
          {
            experimental-features = ["nix-command" "flakes" "pipe-operators"];
            auto-optimise-store = true;
          }
          // lib.mkIf cfg.gc.enable {
            gc = {
              automatic = true;
              dates = "weekly";
              options = "--delete-older-than 7d";
            };
          };
        home-manager = lib.mkIf cfg.home-manager.enable {
          # home-manager
          backupFileExtension = "hm-bak";
          extraSpecialArgs = {
            unstable = throw "test"; # pkgs;
            username = flake-confs.user.name;
            hostname = flake-confs.hostname;
          };
          useGlobalPkgs = true;
        };
      };

      # user
      users.users =
        lib.optionals cfg.user.enable {
        };
    }
    // lib.mkIf cfg.soundserver.enable {
      # Enable sound with pipewire.
      hardware.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };
}
