{
  pkgs,
  pkgs-unstable,
  flake-confs,
  config,
  lib,
  buildName,
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
    users.users.${flake-confs.user.name}.packages = with pkgs; [
      cowsay # holy cow
      sl
      nix-search-cli
      asciiquarium
      hyfetch # gay fastfetch frontend
      fastfetch # better neofetch (backend for hyfetch)
      btop # better htop
      zoxide # cd replacement
      thefuck # cmd auto correct
      speedtest-cli
      unzip
      git
      wget
      curl
      gitui
      lolcat
      lf # cli file manager
      nixos-generators # for generating ISOs
      cpulimit # limit cpu usage for a certain process
    ];
    fonts.packages = with pkgs; [nerdfonts];
    environment.systemPackages = with pkgs; [
      git
      pkgs-unstable.nh # yet another nix helper
      nano
      pkgs-unstable.nix-inspect
    ];
    home-manager.users.${flake-confs.user.name}.xdg = {
      configFile."/home/${flake-confs.user.name}/.bashrc".text = import ./dotfiles/bashrc.nix buildName flake-confs.user.name;
    };
  };
}
