{
  lib,
  config,
  ...
}: let
  cfg = config.nixosModules.carlOS.developement.programming;
in {
  options = {
    nixosModules.carlOS.developement.ollama = {
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
