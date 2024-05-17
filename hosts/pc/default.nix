# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nixosModules = {
    desktop-environment = {
      kde.enable = true;
      #hyprland.enable = true;
    };
    office = {
      enable = true;
      latex.enable = true;
      media.enable = true;
    };
    programming = {
      enable = true;
      game-development.enable = true;
      virtualization.enable = true;
      basic-languages.enable = true;
    };
    gaming.enable = true;
    social.enable = true;
    cli-packages.enable = true;
    ui-utils.enable = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.videoDrivers = [
    "nvidia" # https://github.com/NixOS/nixpkgs/issues/80936#issuecomment-1003784682
  ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # make Wa do the Com
  services.xserver.wacom.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.carl = {
    isNormalUser = true;
    description = "Carl";
    extraGroups = ["networkmanager" "wheel"];
  };

  home-manager = {
    extraSpecialArgs = {unstable = pkgs;};
    useGlobalPkgs = true;
    users.carl = {pkgs, ...}: {
      imports = [../../modules/nvim/neovim.nix];
      home-modules.nvim.enable = true;
      home.stateVersion = "23.11";
    };
  };

#  nixpkgs = {
#    overlays = let
#     #obsidiansettingssync-overlay = final: prev: {
#     # obsidiansettingssync = prev.callPackage /home/carl/Documents/git/obsidian_settings_sync#/#packaging/derivation.nix {};
#    #};
#    astah-overlay = final: prev: {
#      astah = prev.callPackage /home/carl/Documents/install-astah/astah.nix {};
#    };
#     #in [ obsidiansettingssync-overlay astah-overlay ];
#     in [ astah-overlay ];
#  };
#  environment.systemPackages = with pkgs; [
#    astah
#  ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
