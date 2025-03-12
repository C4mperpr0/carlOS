{pkgs, flake-confs,...}: {
  # Enable Flakes
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes" "pipe-operators"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${flake-confs.user.name} = {
    isNormalUser = true;
    description = "${flake-confs.user.description}";
    extraGroups = ["networkmanager" "wheel"];
  };

  # home-manager
  home-manager = {
    backupFileExtension = "hm-bak";
    extraSpecialArgs = {
      unstable = pkgs;
      username = flake-confs.user.name;
      hostname = flake-confs.hostname;
    };
    useGlobalPkgs = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # add supported filesystems
  boot.supportedFilesystems = ["nfts"];

  # set hostname
  networking.hostName = flake-confs.hostname;

  # naming in grub
  system.nixos.tags = ["CarlOS"];
}
