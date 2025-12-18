{
  pkgs,
  pkgs-unstable,
  flake-confs,
  config,
  lib,
  inputs,
  self,
  ...
}: let
  cfg = config.nixosModules.carlOS.development.cli-packages;
in {
  options = {
    nixosModules.carlOS.development.cli-packages = {
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
      wifi-qr
      zenity # required for wifi-qr GUI
    ];

    # enable v4l2loopback for wifi-qr
    # TODO: does droidcam also require this?
    # boot.extraModulePackages = with config.boot.kernelPackages; [
    #   v4l2loopback
    # ];
    # boot.kernelModules = ["v4l2loopback"];
    boot.extraModprobeConfig = ''
      options devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    security.polkit.enable = true;

    fonts.packages = with pkgs;
      [
        monocraft
      ]
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

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
        configFile."/home/${flake-confs.user.name}/.bashrc".text = import ./dotfiles/bashrc.nix flake-confs.buildname flake-confs.user.name;
      };
      programs = {
        nvim-dromedar = {
          enable = true;
          flake-path = self;
          hostname = flake-confs.hostname;
        };
      };
    };

    programs = {
      nix-index-database.comma.enable = true; # comma tool for nix shell temp bin automation
      nix-index.enable = true; # integrate with shells' command-not-found
      nh = {
        enable = true;
        flake = flake-confs.flake-path;
      };
      xonsh = {
        enable = true;
        config = "";
      };
    };
  };
}
