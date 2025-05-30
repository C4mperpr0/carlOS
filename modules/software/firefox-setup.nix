{
  lib,
  pkgs,
  flake-confs,
  inputs,
  config,
  ...
}: let
  cfg = config.nixosModules.carlOS.software.firefox-setup;
in {
  options = {
    nixosModules.carlOS.software.firefox-setup = {
      enable = lib.mkEnableOption "enable firefox setup";
    };
  };
  config = lib.mkIf cfg.enable {
    home-manager.users.${flake-confs.user.name} = {
      programs.firefox = {
        enable = true;
        languagePacks = ["en-US" "de"];
        profiles.default = {
          settings = {
            "browser.startup.homepage" = "https://bellgardt.dev";
            "signon.rememberSignons" = false;
            "browser.download.panel.shown" = true;
            "layout.css.devPixelsPerPx" = -1.0; # follow system DPI to work with hyprland
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
            default = "ddg";
            order = ["ddg" "np" "gg"];
          };
          extensions.packages = with inputs.firefox-addons.packages."${flake-confs.system}"; [
            bitwarden
            ublock-origin
            sponsorblock
            darkreader
            youtube-shorts-block
            return-youtube-dislikes
            plasma-integration
            localcdn
            ### Bionic reader is still missing from rycee :(
            #dictionary-german-2.1
            #tridactyl
          ];
        };
      };
    };
  };
}
