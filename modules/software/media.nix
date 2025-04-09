{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.nixosModules.carlOS.software.media;
in {
  options = {
    nixosModules.carlOS.software.media = {
      enable = lib.mkEnableOption "enable media programs";
      modeling.enable = lib.mkEnableOption "enable modeling";
      videoEditing.enable = lib.mkEnableOption "enable videoEditing";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        vlc
        okular
        ffmpeg-full
        spotify
        #spicetify-cli
        qpwgraph
        gimp
        imagemagick # for cmd image manipulation
      ]
      ++ lib.optionals cfg.modeling.enable
      [
        blender
        freecad
      ]
      ++ lib.optionals cfg.videoEditing.enable
      [
        davinci-resolve
      ];
    #    home-manager.users.${flake-confs.userName}.lib.homeManagerConfigurations = {
    #      inherit pkgs;
    #      extraSpeicialArgs = {spicetify = inputs.spicetify-nix;};
    #      modules = [
    #        ./spicetify.nix
    #      ];
    #    };
  };
}
