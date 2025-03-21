{
  lib,
  pkgs,
  flake-confs,
  config,
  ...
}: let
  cfg = config.nixosModules.programming;
in {
  options = {
    nixosModules.ollama = {
      enable = lib.mkEnableOption "enable ollama service and setup";
    };
  };
  config = lib.mkIf cfg.enable {
    services = {
      ollama = {
        enable = true;
        environmentVariables = {
          OLLAMA_NUM_THREADS = "20";
          OLLAMA_NUM_THREAD = "20";
        };
      };
      open-webui = {
        enable = true;
        port = 3030;
      };
    };
  };
}
