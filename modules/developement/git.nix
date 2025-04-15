{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.nixosModules.carlOS.developement.git;
in {
  options = {
    nixosModules.carlOS.developement.git = {
      enable = lib.mkEnableOption "enable git config";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      meld
    ];

    programs.git = {
      enable = true;
      config = {
        aliases = {
          s = "status";
          ci = "commit";
          co = "checkout";
          ps = "push";
          pl = "pull";
        };
        push.autoSetupRemote = true;
        commit.verbose = true;
        merge.tool = "vimdiff";
        mergetool.vimdiff.trustExitCode = "false";
        diff.tool = "meld";
        difftool.meld.cmd = "meld '$LOCAL $REMOTE'";
      };
    };
  };
}
