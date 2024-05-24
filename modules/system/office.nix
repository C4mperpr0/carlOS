{
  lib,
  pkgs,
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
      media.enable = lib.mkEnableOption "enable media";
    };
  };
  config = lib.mkIf cfg.enable {
    programs = {
      kdeconnect.enable = true;
      droidcam.enable = true;
      #firefox = {          enable = true;          profiles.default = {              extensions = with inputs.firefox-addons.packages."x86_64-linux"; [                bitwarden                ublock-origin                sponsorblock                darkreader                youtube-shorts-block                tridactyl              ];            };        };
    };

    home-manager.users.carl = {
      programs.firefox = {
        enable = true;
        profiles.default = {
          extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
            bitwarden
            ublock-origin
            sponsorblock
            darkreader
            youtube-shorts-block
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
      ]
      ++ lib.optionals cfg.media.enable
      [
        ffmpeg-full
        spotify
        vlc
        blender
        freecad
        gimp
      ];
  };
}
