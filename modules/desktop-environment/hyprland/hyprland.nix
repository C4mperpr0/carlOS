{
  inputs,
  lib,
  config,
  flake-confs,
  pkgs,
  carlOS-lib,
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

    services.logind = {
      powerKey = "ignore";
      powerKeyLongPress = "poweroff";
    };

    services.power-profiles-daemon.enable = true;

    # try to fix kde-connect remote input
    xdg.portal.enable = true;
    #xdg.portal.extraPortals = with pkgs; [
    #  xdg-dekstop-portal-gtk
    #  xdg-dekstop-portal-kde
    #];
    xdg.portal.wlr.enable = true;

    programs = {
      hyprland.enable = true;
      hyprlock.enable = true;
    };

    services.hypridle.enable = true;

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
        "hypr/hypridle.conf".text = import ./hypridle.nix {inherit lib carlOS-lib flake-confs;};
        "hypr/hyprlock.conf".text = import ./hyprlock.nix {inherit lib config;};
        "rofi/carlOS-theme.rasi".text = import ./rofi-carlOS-theme.rasi.nix {inherit config;};
      };

      imports = [inputs.ags.homeManagerModules.default];
      programs = {
        waybar = {
          enable = true;
          settings = import ./waybarsettings.nix;
        };
        ags = {
          enable = true;
          configDir = ./ags;
          extraPackages = with inputs.ags.packages.${flake-confs.system};
            [
              astal3
              astal4
              greet
              auth
              cava
              apps
              notifd
              gjs
              io
              hyprland
              mpris
              battery
              wireplumber
              network
              bluetooth
              tray
              #gtksourceview
              #webkitgtk
              #accountsservice
            ]
            ++ (with pkgs; [
              glib
              gobject-introspection
              gtk3
            ]);
        };
      };
      home.packages = with pkgs;
        [
          hyprpaper
          kdePackages.qtwayland
          brightnessctl
          libnotify
          tofi
          pavucontrol # for controlling pulse audio graphically
          dunst # for notifications
          wl-screenrec # TODO: make this work to replace wf-recorder
          wf-recorder
          wdisplays # display setup util
          rofi-rbw-wayland # bitwarden rofi GUI
          rbw
          pinentry-all # maybe not all are needed
          wtype
          rofi
          rofi-power-menu
          wl-clipboard
          cliphist

          xdg-desktop-portal-gtk
          xdg-desktop-portal-kde
        ]
        ++ config.home-manager.users."${flake-confs.user.name}".programs.ags.extraPackages;
    };
  };
}
