# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  pkgs-unstable,
  flake-confs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nixosModules = {
    #minegrub.enable = true;
    university.enable = true;
    desktop-environment = {
      kde.enable = true;
      hyprland.enable = true;
      gnome.enable = false;
    };
    office = {
      enable = true;
      latex.enable = true;
    };
    firefox-setup.enable = true;
    media = {
      enable = true;
      modeling.enable = true;
      videoEditing.enable = true;
    };
    programming = {
      enable = true;
      game-development.enable = true;
      virtualization.enable = true;
      basic-languages.enable = true;
    };
    git.enable = true;
    #stylix = {
    #  enable = true;
    #};
    gaming.enable = true;
    social.enable = true;
    cli-packages.enable = true;
    ui-utils.enable = true;
    plymouth.enable = true;
    ollama.enable = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # repair hibernation
  #security.protectKernelImage = false;

  # use latest kernel version (for newer hardware compatability)
  boot.kernelPackages = pkgs-unstable.linuxPackages_6_11;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # make AMD iGPU work
  boot.initrd.kernelModules = ["amdgpu"];
  #services.xserver.videoDrivers = ["amdgpu"];
  boot.kernelParams = ["amdgpu.runpm=1"]; # "acpi.ec_no_wakeup=1" "mem_sleep_default=deep"]; # latter might fix sleep issues
  hardware.firmware = [pkgs.linux-firmware];
  environment.systemPackages = with pkgs; [
    clinfo
  ];
  hardware.graphics.extraPackages = with pkgs; [
    #rocmPackages.clr.icd
    mesa
    mesa.drivers
    vaapiVdpau
    libvdpau-va-gl
    libva
    libva-utils
  ];
  hardware.graphics.enable32Bit = true; # For 32 bit applications

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # make Wa do the Com
  services.xserver.wacom.enable = true;

  home-manager.users.${flake-confs.user.name} = {pkgs, ...}: {
    home.stateVersion = "23.11";
  };

  system.stateVersion = "23.05"; # Did you read the comment?
}
