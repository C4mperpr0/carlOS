{
  pkgs,
  pkgs-unstable,
  config,
  lib,
  ...
}: let
  cfg = config.nixosModules.cli-packages;
in {
  options = {
    nixosModules.cli-packages = {
      enable = lib.mkEnableOption "enable cli-packages programs";
    };
  };
  config = lib.mkIf cfg.enable {
    users.users.carl.packages = with pkgs; [
      cowsay # holy cow
      nix-search-cli
      asciiquarium
      hyfetch # gay fastfetch frontend
      fastfetch # better neofetch (backend for hyfetch)
      btop # better htop
      zoxide # cd replacement
      speedtest-cli
      unzip
      git
      wget
      curl
      spotify-tui
      gitui
      lolcat
      lf # cli file manager
    ];
    fonts.packages = with pkgs; [nerdfonts];
    environment.systemPackages = with pkgs; [
      git
      pkgs-unstable.nh # yet another nix helper
      nano
      pkgs-unstable.nix-inspect
    ];
    home-manager.users.carl.xdg = {
      configFile."/home/carl/.bashrc".source = ./dotfiles/.bashrc;
    };
  };
}
