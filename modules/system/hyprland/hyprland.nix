{
  inputs,
  lib,
  config,
  flake-confs,
  pkgs,
  pkgs-unstable,
  ...
}: let
  cfg = config.nixosModules.hyprland;
in {
  options = {
    nixosModules.hyprland = {
      enable = lib.mkEnableOption "enable hyprland";
    };
  };

  config = lib.mkIf cfg.enable {
    security.pam.services."${flake-confs.user.name}".kwallet.enable = true;

    services.xserver.enable = true;
    programs.hyprland.enable = true;

    nixosModules.stylix.enable = true;
    nixosModules.greetd.enable = false;

    users.users.${flake-confs.user.name}.packages = with pkgs; [
      networkmanagerapplet
    ];

    #homeConfigurations."${flake-confs.user.name}" = home-manager.lib.homeManagerConfiguration {
    #  modules = [../ags/home.nix];
    #};

    #imports = [inputs.ags.homeManagerModules.default];
    #programs.ags = {
    # enable = true;
    #};

    home-manager.users."${flake-confs.user.name}" = {
      #  modules = [../ags/home.nix];
      xdg.configFile = {
        "hypr/hyprland.conf" = {
          source = builtins.toFile "hyprland.conf" (import ./conf/hyprland.conf.nix {inherit lib config;});
          force = true;
        };
        "hypr/hyprpaper.conf".text = import ./hyprpaper.nix {inherit lib;};
        #"hypr/" = {
        # source = ./hyprlock;
        #  recursive = true;
        #};
      };

      imports = [inputs.ags.homeManagerModules.default];
      programs = {
        waybar = {
          enable = true;
          settings = import ./waybarsettings.nix;
        };
        ags = {
          #   package = pkgs-unstable.ags;
          enable = true;
          configDir = ./ags;
          extraPackages = with pkgs-unstable.astal; [
            io
            hyprland
            mpris
            battery
            wireplumber
            network
            #tray
            #gtksourceview
            #webkitgtk
            #accountsservice
          ];
        };
      };
      home.packages = with pkgs; [
        hyprpaper
        kdePackages.qtwayland
        brightnessctl
        libnotify
        tofi
        pavucontrol # for controlling pulse audio graphically
      ];
    };
  };
}
