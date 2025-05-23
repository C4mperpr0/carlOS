{
  lib,
  config,
  pkgs-unstable,
  ...
}: let
  cfg = config.nixosModules.carlOS.development.programming;
in {
  options = {
    nixosModules.carlOS.development.ollama = {
      enable = lib.mkEnableOption "enable ollama service and setup";
    };
  };
  config = lib.mkIf cfg.enable {
    services = {
      ollama = {
        enable = true;
        package = pkgs-unstable.ollama;
        environmentVariables = {
          OLLAMA_NUM_THREADS = "20";
          OLLAMA_NUM_THREAD = "20";
        };
      };
      open-webui = {
        enable = true;
        package = pkgs-unstable.open-webui;
        port = 3030;
      };
    };
  };
}
