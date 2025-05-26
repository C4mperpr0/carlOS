{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.nixosModules.carlOS.software.office;
in {
  options = {
    nixosModules.carlOS.software.office = {
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
        kdePackages.kate
        kdePackages.okular
        #pkgs-unstable.obsidian
        obsidian
        thunderbird
        libreoffice
        bitwarden
        wacomtablet
        speedcrunch
        linuxKernel.packages.linux_6_1.v4l2loopback # TODO: what was this used for again?
        android-tools # TODO: what does this do here?
      ]
      ++ lib.optionals cfg.latex.enable
      [
        texliveFull
        jabref
        texstudio
      ];
  };
}
