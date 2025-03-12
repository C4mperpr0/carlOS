{
  pkgs,
  pkgs-unstable,
  flake-confs,
  config,
  lib,
  buildName,
  inputs,
  self,
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
      hollywood
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
      tealdeer # compact man pages
    ];

    fonts.packages = with pkgs; [nerdfonts monocraft];

    environment.systemPackages = with pkgs; [
      git
      nano
      pkgs-unstable.nix-inspect
      (python3.withPackages (ps:
        # xontribs for xonsh
          with ps; [
            numpy
            #xontrib-zoxide
          ]))
    ];

    home-manager.users.${flake-confs.user.name} = {
      imports = [
        inputs.dromedar-nvim.homeManagerModules.nvim
      ];
      xdg = {
        configFile."/home/${flake-confs.user.name}/.bashrc".text = import ./dotfiles/bashrc.nix buildName flake-confs.user.name;
      };
      programs = {
        nvim-dromedar = {
          enable = true;
          flake-path = self;
          username = flake-confs.user.name;
          hostname = flake-confs.hostname;
        };
      };
    };

    programs = {
      nix-index-database.comma.enable = true; # comma tool for nix shell temp bin automation
      nix-index.enable = true; # integrate with shells' command-not-found
      nh = {
        enable = true;
        flake = "/home/${flake-confs.user.name}/Documents/git/carlOS";
      };
      xonsh = {
        enable = true;
        config = "";
      };
    };
  };
}
