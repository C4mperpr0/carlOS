{config}: let
  colors = config.lib.stylix.colors.withHashtag;
in ''
general {
    border_size = 1
    col.active_border = ${colors.base05}
    col.inactive_border = ${colors.base06} 
    no_border_on_floating = true
    resize_on_border= true
}

decoration {
    rounding = 3
    active_opacity = 1.0
    inactive_opacity = 0.75
}
''
