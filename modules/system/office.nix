{
  lib,
  pkgs,
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
    services.printing.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    programs = {
      kdeconnect.enable = true;
      droidcam.enable = true;
    };

    boot = {
      kernelModules = ["v4l2loopback"]; # for droidcam
      extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
    };
    environment.systemPackages = with pkgs;
      [
        firefox
        kdePackages.konsole
        kdePackages.dolphin
        kdePackages.qt6ct # for theming dolphin
        #pkgs-unstable.obsidian
        obsidian
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
