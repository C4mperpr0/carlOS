{
  lib,
  pkgs,
  flake-confs,
  config,
  ...
}: let
  cfg = config.nixosModules.git;
in {
  options = {
    nixosModules.git = {
      enable = lib.mkEnableOption "enable git config";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      meld
    ];

    home-manager.users."${flake-confs.user.name}" = {
      programs.git = {
        enable = true;
        aliases = {
          s = "status";
          ci = "commit";
          co = "checkout";
        };
        extraConfig = {
          merge.tool = "meld";
          mergetool.meld.cmd = "meld '$BASE $LOCAL $REMOTE $MERGED'";
          mergetool.meld.trustExitCode = "false";
          diff.tool = "meld";
          difftool.meld.cmd = "meld '$LOCAL $REMOTE'";
        };
      };
    };
  };
}
