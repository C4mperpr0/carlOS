{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.nixosModules.carlOS.desktop-environment.stylix;
in {
  options = {
    nixosModules.carlOS.desktop-environment.stylix = {
      enable = lib.mkEnableOption "enable ricing with stylix";
    };
  };
  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      #image = import ./hyprland/hyprpaper.nix {inherit lib;};
      image = ./assets/red_black_shapes_lines_abstraction_4k_hd_abstract-3840x2160.jpg;

      base16Scheme = {
        slug = "Black-Red";
        scheme = "Black-Red by CHB";
        author = "Carl Heinrich Bellgardt";
        base00 = "#000000"; # default background
        base01 = "#332222"; # lighter background (status bars, line numbers, folding marks)
        base02 = "#552626"; # selection background
        base03 = "#996969"; # comments, invisibles, line highlighting
        base04 = "#4d0000"; # dark foregroud 8used for status bars)
        base05 = "#ff0000"; # default foreground, caret, delimiters, operators
        base06 = "#aa3333"; # light foreground (rarely used)
        base07 = "#111111"; # light background (rarely used)
        base08 = "#f4023f"; # variables, XML tags, markup link text, markup lists, diff, del
        base09 = "#f4b002"; # integers, booleans, constants, XML attributes, markup link url
        base0A = "#9bf402"; # classes, markup bold, search text background
        base0B = "#80bf40"; # strings, inherited class, markup code, diff inserted
        base0C = "#40bfbf"; # support, regex, escape chars, markup quotes
        base0D = "#407fbf"; # functions, methods, attribute IDs, headings
        base0E = "#a00000"; # keywords, storage, selector, markup italic, diff changed
        base0F = "#bf40bf"; # deprecated, opening/closing embedded language tags
      };

      cursor = {
        package = pkgs.vimix-cursors;
        name = "Vimix-cursors";
        size = 12;
      };

      targets = {
        plymouth.enable = false;
        #firefox.profileNames = ["default"]; # TODO: this should exist and fix a warning, but it does not. Fix later...
      };
    };

    home-manager.sharedModules = [
      {
        stylix = {
          autoEnable = true;
          targets = {
            neovim.enable = false;
          };
        };
      }
    ];
  };
}
