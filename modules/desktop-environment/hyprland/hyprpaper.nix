{lib, ...}:
with lib; let
  image = builtins.path {
    path = ../assets/red_black_shapes_lines_abstraction_4k_hd_abstract-3840x2160.jpg;
  };
in ''
  preload = ${image}
  wallpaper = , ${image}
  ipc = false
''
