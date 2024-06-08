{
  lib,
  pkgs,
  flake-confs,
  pkgs-unstable,
  inputs,
  config,
  ...
}: let
  cfg = config.nixosModules.office;
in {
  options = {
    nixosModules.office = {
      enable = lib.mkEnableOption "enable office programs";
      latex.enable = lib.mkEnableOption "enable latex";
    };
  };
  config = lib.mkIf cfg.enable {
    programs = {
      kdeconnect.enable = true;
      droidcam.enable = true;
    };

    home-manager.users.${flake-confs.user.name} = {
      programs.firefox = {
        enable = true;
        #languagePacks = ["en-US" "de" "eo"];
        profiles.default = {
          settings = {
            "browser.startup.homepage" = "https://bellgardt.dev";
            "signon.rememberSignons" = false;
            "browser.download.panel.shown" = true;
          };
          search = {
            engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@np"];
              };
            };
            force = true;
            default = "DuckDuckGo";
            order = ["DuckDuckGo" "Nix Packages" "Google"];
          };
          extensions = with inputs.firefox-addons.packages."${flake-confs.system}"; [
            bitwarden
            ublock-origin
            sponsorblock
            darkreader
            youtube-shorts-block
            #dictionary-german-2.1
            #tridactyl
          ];
        };
      };
    };

    boot = {
      kernelModules = ["v4l2loopback"]; # for droidcam
      extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
    };
    environment.systemPackages = with pkgs;
      [
        firefox
        pkgs-unstable.obsidian
        kate
        okular
        thunderbird
        libreoffice
        bitwarden
        wacomtablet
        speedcrunch
        linuxKernel.packages.linux_6_1.v4l2loopback
        android-tools
      ]
      ++ lib.optionals cfg.latex.enable
      [
        texliveFull
        jabref
        texstudio
      ];
  };
}
