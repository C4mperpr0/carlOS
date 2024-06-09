{
  lib,
  pkgs,
  flake-confs,
  pkgs-unstable,
  inputs,
  config,
  ...
}: let
  cfg = config.nixosModules.firefox-setup;
in {
  options = {
    nixosModules.firefox-setup = {
      enable = lib.mkEnableOption "enable firefox setup";
    };
  };
  config = lib.mkIf cfg.enable {
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
            return-youtube-dislikes
            plasma-integration
            localcdn
            ### Bionic reader is still missing from rycee :(
            #tree-style-tab
            #dictionary-german-2.1
            #tridactyl
          ];
        };
      };
    };
  };
}
