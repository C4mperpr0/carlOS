{
  pkgs,
  pkgs-unstable,
  flake-confs,
  config,
  lib,
  buildName,
  ...
}: let
  cfg = config.nixosModules.greetd;
in {
  options = {
    nixosModules.greetd = {
      enable = lib.mkEnableOption "enable greetd";
    };
  };
  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = flake-confs.user.name;
        };
      };
    };

    # Install a graphical greeter (gtkgreet)
    environment.systemPackages = with pkgs; [
      #greetd.gtkgreet # Graphical greeter
      wayland # Required for Wayland session
    ];

    # Custom script to launch gtkgreet with styling
    #systemd.services.greetd = {
    #  serviceConfig.ExecStart = ''
      #    ${pkgs.greetd.gtkgreet}/bin/gtkgreet \
      #  --time --session "${pkgs.hyprland}/bin/Hyprland" \
      #  --scaling auto \
      #  --font "JetBrainsMono Nerd Font 12" \
    #  --border-radius 10
    #  '';
    #};

    # Ensure greetd runs on the correct TTY
    services.greetd.vt = 1; # Default is tty1
  };
}
