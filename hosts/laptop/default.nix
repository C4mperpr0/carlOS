# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  flake-confs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nixosModules = {
    minegrub.enable = true;
    university.enable = true;
    desktop-environment = {
      kde.enable = true;
      hyprland.enable = true;
    };
    office = {
      enable = true;
      latex.enable = true;
    };
    media = {
      enable = true;
      modeling.enable = true;
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

  networking.hostName = flake-confs.hostname; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # make Wa do the Com
  services.xserver.wacom.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${flake-confs.user.name} = {
    isNormalUser = true;
    description = "${flake-confs.user.description}";
    extraGroups = ["networkmanager" "wheel"];
  };

  home-manager = {
    backupFileExtension = "bak";
    extraSpecialArgs = {unstable = pkgs;};
    useGlobalPkgs = true;
    users.${flake-confs.user.name} = {pkgs, ...}: {
      imports = [../../modules/nvim/neovim.nix];
      home-modules.nvim.enable = true;
      home.stateVersion = "23.11";
    };
  };

  system.stateVersion = "23.05"; # Did you read the comment?
}
