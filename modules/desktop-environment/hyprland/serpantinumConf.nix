{
  inputs,
  lib,
  config,
  flake-confs,
  pkgs,
  carlOS-lib,
  ...
}: let
  cfg = config.nixosModules.serpantinumConf;
in {
  options = {
    nixosModules.serpantinumConf = {
      enable = lib.mkEnableOption "enable serpantinum shell for hyprland";
    };
  };

  config = lib.mkIf cfg.enable {
    # enable hyprpaper
    nixosModules.carlOS.desktop-environment.hyprland.hyprpaper.enable = true;

    programs.serpantinum.enable = true;

    users.users.${flake-confs.user.name} = {
      packages = with pkgs; [
        easyeffects
      ];
    };

    home-manager.users."${flake-confs.user.name}" = {
      imports = [
        inputs.serpantinum.homeManagerModules.default
      ];

      programs = {
        # ilyamiro's serpantinum shell
        serpantinum = {
          enable = true;
          systemd.enable = true;

          settings = {
            wallpaperDir = builtins.path {path = ../assets;};

            general = {
              language = "en";
              weatherUnit = "metric";
              weatherInterval = 1;
            };

            bar = {
              position = "top";
              style = "solid";
              width = 40;
              workspaceCount = 10;
              modules = {
                left = ["workspaces"];
                center = ["time"];
                right = ["tray" ["kb" "wifi" "bt" "vol" "bat"]];
              };
            };

            theme = {
              fontFamily = "Adwaita Mono";
              borderRadius = 12;
              matugen = true;
            };

            notifications = {
              dnd = false;
              position = "top right";
              sound = false;
            };
          };
        };
      };
    };
  };
}
