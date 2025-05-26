{
  lib,
  pkgs,
  flake-confs,
  config,
  ...
}: let
  cfg = config.nixosModules.carlOS.nixos-basics;
in {
  options = {
    nixosModules.carlOS.nixos-basics = {
      enable = lib.mkEnableOption "enable basic nixos configurations";
      home-manager.enable = lib.mkEnableOption "enable basic home-manager config";
      gc.enable = lib.mkEnableOption "enable nixos gc";
      soundserver.enable = lib.mkEnableOption "enable videoEditing";
      user.enable = lib.mkEnableOption "enable initial user setup";
    };
  };
  config = lib.mkMerge [
    (
      lib.mkIf cfg.enable {
        # add supported filesystems
        boot.supportedFilesystems = ["nfts"];

        # set hostname
        networking.hostName = flake-confs.hostname;

        # naming in grub
        system.nixos.tags = ["CarlOS:${flake-confs.buildname}"];

        # set nixpkgs config
        nixpkgs.config = {
          allowUnfree = true;
        };

        # enable all required experimental-features
        nix = {
          settings = {
            experimental-features = ["nix-command" "flakes" "pipe-operators"];
            auto-optimise-store = true;
          };
        };
      }
    )

    # garbage collector
    (
      lib.mkIf cfg.gc.enable {
        nix.gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
      }
    )

    # user
    (
      lib.mkIf cfg.user.enable {
        # Define a user account. Don't forget to set a password with ‘passwd’.
        users.users.${flake-confs.user.name} = {
          isNormalUser = true;
          description = "${flake-confs.user.description}";
          extraGroups = ["networkmanager" "wheel"];
        };
      }
    )

    # home-manager
    (
      lib.mkIf cfg.home-manager.enable {
        home-manager = {
          # home-manager
          backupFileExtension = "hm-bak";
          extraSpecialArgs = {
            unstable = pkgs;
            username = flake-confs.user.name;
            hostname = flake-confs.hostname;
          };
          useGlobalPkgs = true;
        };
      }
    )

    # sound server
    (
      lib.mkIf cfg.soundserver.enable {
        # Enable sound with pipewire.
        security.rtkit.enable = true;
        services = {
          pulseaudio.enable = false; # TODO: where is the difference between this and pipewire.pulse?
          pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
          };
        };
      }
    )
  ];
}
