# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nixosModules.office = {
    enable = true;
    latex.enable = true;
  };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
  programs.kdeconnect.enable = true;


  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  #hardware.bluetooth.powerOnBoot = true;

  # Make steam work
  hardware.opengl.driSupport32Bit = true;

  # make Wa do the Com
  services.xserver.wacom.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.carl = {
    isNormalUser = true;
    description = "Carl";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      firefox
      whatsapp-for-linux
      signal-desktop
      wacomtablet
      kate
      discord
      spotify
      steam
      godot_4
      vscodium
      rustc
      ffmpeg-full
      pkgs-unstable.obsidian
      bitwarden
      xcowsay
      qdirstat
      superTuxKart
      qemu_full
      qtemu
      libsForQt5.kdeconnect-kde
      vlc
      gparted
      jdk
      systemdgenie
      nxengine-evo
      anbox
      quickemu
      poetry
      sptlrx
      jupyter
      speedcrunch
      lf
      winePackages.stableFull
      qgis # for telematics systems (univsersity)

      (python3.withPackages (ps:
        with ps; [
          requests
          numpy
          cbonsai
          matplotlib
          pandas
          pynput
          selenium
          beautifulsoup4
          pyautogui
          googletrans
          flask
          flask-socketio
          flask-session
          flask-sqlalchemy
        ]))
    ];
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    speedtest-cli
    wget
    gcc
    inxi
    mc
    #pkgs.fastfetch
    wget
    unzip
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
