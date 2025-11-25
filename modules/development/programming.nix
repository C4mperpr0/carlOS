{
  lib,
  pkgs,
  pkgs-unstable,
  config,
  flake-confs,
  ...
}: let
  cfg = config.nixosModules.carlOS.development.programming;
in {
  options = {
    nixosModules.carlOS.development.programming = {
      enable = lib.mkEnableOption "enable programming programs";
      game-development.enable = lib.mkEnableOption "enable game-development";
      virtualization.enable = lib.mkEnableOption "enable virtualization";
      basic-languages.enable = lib.mkEnableOption "enable basic-languages";
      android.enable = lib.mkEnableOption "enable android development tools";
    };
  };
  config = lib.mkIf cfg.enable {
    nixpkgs.config = {
      android_sdk.accept_license = true;
    };

    # for quickemu VMs display and USB
    # TODO: only do this when virtualization is enabled
    services.spice-vdagentd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    # make nibo work
    # TODO: make own docker and tty/com stuff
    users.users.${flake-confs.user.name} = {
      extraGroups = ["docker" "dialout" "tty" "input"];
    };

    programs.direnv.enable = true; # for nix dev-shells
    environment.systemPackages = with pkgs;
      [
        vscodium
        wev # for detecting keycodes
        xdotool
        hoppscotch # debugging http requests
        arduino
        nixos-firewall-tool
        (python3.withPackages (ps:
          with ps; [
            requests
            numpy
            matplotlib
            pandas
            pynput
            beautifulsoup4
            gtts
            simple-term-menu
            psycopg2
            pygobject3
            pymongo
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
        winePackages.stableFull # wine is not an emulator
        winetricks
      ]
      ++ lib.optionals cfg.basic-languages.enable [
        gcc
        gnumake
        rustc
      ]
      ++ lib.optionals cfg.android.enable [
        flutter
        android-studio
        #androidsdk
        gtk3
        graphite2
      ];
  };
}
