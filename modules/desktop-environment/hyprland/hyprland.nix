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

    services = {
      xserver.enable = true;
      logind.settings.Login = {
        HandlePowerKey = "ignore";
        HandlePowerKeyLongPress = "poweroff";
        # laptop lid
        HandleLidSwitch = "(pidof hyprlock || hyprlock --immediate-render &) && systemctl sleep";
        HandleLidSwitchExternalPower = "(pidof hyprlock || hyprlock) & hyprctl dispatch dpms off";
        HandleLidSwitchDocked = "ignore";
      };
      power-profiles-daemon.enable = true;
      hypridle.enable = true;
      playerctld.enable = true; # To play/pause/skip through media
    };

    # try to fix kde-connect remote input
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        kdePackages.xdg-desktop-portal-kde
      ];
      config.hyprland.default = ["hyprland" "kde"];
    };

    programs = {
      hyprland.enable = true;
      hyprlock.enable = true;
    };

    #nixosModules.greetd.enable = false;

    users.users.${flake-confs.user.name}.packages = with pkgs; [
      # hyprwave # install once available for nix: https://github.com/mrlinuxdude/hyprwave_shantanubaddar
      dmenu # TODO: dunstify is stupid but needs this for actions -_-
      networkmanagerapplet
      wl-clipboard
      hyprpaper
      hyprland-monitor-attached
      kdePackages.qtwayland
      brightnessctl
      libnotify
      tofi
      pavucontrol # for controlling pulse audio graphically
      wl-screenrec # TODO: make this work to replace wf-recorder
      wf-recorder
      wdisplays # display setup util
      rbw
      pinentry-all # maybe not all are needed
      wtype
      cliphist
      hyprshot

      # rofi menues
      rofi
      rofi-power-menu
      rofi-rbw-wayland # bitwarden rofi
      rofi-pulse-select # pulse sink/source select
      rofi-network-manager # rofi nm
      rofi-bluetooth # rofi bluetooth connection management using nm
      fuzzel # application launcher
    ];

    # fix kde picker in hyprland issue
    environment.etc = {
      # https://discuss.kde.org/t/dolphin-doesnt-show-a-single-app-in-the-open-with-menu/14799
      "xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
    };

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
        "dunst/dunstrc".text = import ./dunstrc.nix {inherit config;};
      };

      services = {
        dunst.enable = true;
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
              #gjs
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
      home.packages = config.home-manager.users."${flake-confs.user.name}".programs.ags.extraPackages;
    };
  };
}
