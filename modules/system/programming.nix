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
    nixosModules.programming = {
      enable = lib.mkEnableOption "enable programming programs";
      game-development.enable = lib.mkEnableOption "enable game-development";
      virtualization.enable = lib.mkEnableOption "enable virtualization";
      basic-languages.enable = lib.mkEnableOption "enable basic-languages";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        monocraft
        vscodium
        wev # for detecting keycodes
        xdotool
        hoppscotch # debugging http requests
        arduino
        (python3.withPackages (ps:
          with ps; [
            requests
            numpy
            matplotlib
            pandas
            pynput
            beautifulsoup4
            pyautogui
            gtts
            simple-term-menu
            psycopg2
          ]))
      ]
      ++ lib.optionals cfg.game-development.enable [
        godot_4
        gimp
      ]
      ++ lib.optionals cfg.virtualization.enable [
        qemu_full
        qtemu # qt-UI for qemu
        quickemu # automatically fetch ISOs and generate VMs
        anbox # android emulation
        winePackages.stableFull # wine is not an emulator
        winetricks
      ]
      ++ lib.optionals cfg.basic-languages.enable [
        gcc
        gnumake
        rustc
      ];
  };
}
