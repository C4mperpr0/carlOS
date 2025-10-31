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
      typst.enable = lib.mkEnableOption "enable typst";
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
      # TODO: alternative this should also work:
      # programs.obs-studio.enableVirtualCamera
      # this is also needed for wifi-qr (in office programs?!)
      kernelModules = ["v4l2loopback"]; # for droidcam
      extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
      ];
    };
    environment.systemPackages = with pkgs;
      [
        firefox
        kdePackages.konsole
        kdePackages.dolphin
        kdePackages.qt6ct # for theming dolphin
        kdePackages.kate
        kdePackages.okular
        obsidian
        thunderbird
        libreoffice
        bitwarden
        wacomtablet
        speedcrunch
        android-tools # TODO: what does this do here?
      ]
      ++ lib.optionals cfg.latex.enable
      [
        texliveFull
        jabref
        texstudio
      ]
      ++ lib.optionals cfg.typst.enable
      [
        typst
      ];
  };
}
