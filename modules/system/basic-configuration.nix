{
  pkgs,
  flake-confs,
  ...
}: {
  # TODO: remove this when nix conf works!!!
  nix.settings.experimental-features = ["nix-command" "flakes" "pipe-operators"];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${flake-confs.user.name} = {
    isNormalUser = true;
    description = "${flake-confs.user.description}";
    extraGroups = ["networkmanager" "wheel"];
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
}
