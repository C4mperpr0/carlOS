{
  lib,
  pkgs,
  pkgs-unstable,
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
    environment.systemPackages = with pkgs;
      [
        firefox
        pkgs-unstable.obsidian
        kate
        freecad
        gimp
        blender
        thunderbird
        libreoffice
        bitwarden
        wacomtablet
        ffmpeg-full
        speedcrunch
        # obsidian ?????? unstable??? jokab?????
      ]
      ++ lib.optionals cfg.latex.enable
      [
        texliveFull
        jabref
        texstudio
      ];
  };
}
