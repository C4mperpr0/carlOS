{
  lib,
  config,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;
  image = builtins.path {
    path = ../assets/red_black_shapes_lines_abstraction_4k_hd_abstract-3840x2160.jpg;
  };
in ''
  general {
      fail_timeout = 500;
  }

  background {
      monitor =
    	path = ${image}   # NOTE only png supported for now
      blur_size = 5
      blur_passes = 1 # 0 disables blurring
      noise = 0.0117
      contrast = 1.3000 # Vibrant!!!
      brightness = 0.8000
      vibrancy = 0.2100
      vibrancy_darkness = 0.0;
  }

  input-field {
      monitor =
      size = 250, 50
      outline_thickness = 3
      dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = true
      fade_on_empty = true
      placeholder_text = <i>Password...</i> # Text rendered in the input box when it's empty.
      hide_input = false

      position = 0, 200
      halign = center
      valign = bottom
  }

  # Battery
  label {
      monitor =
      text = cmd[update 30] upower -b | awk '/state:/ {c=($2=="charging")} /percentage:/ {p=$2} END {printf "%s%s\n", p, (c?" ":"")}'
      position = -50, -50
      font_size = 24
      halign = right
      valign = top
  }

  # Time
  label {
      monitor =
      text = $TIME
      font_size = 96
      font_family = JetBrains Mono Nerd Font 10
      position = 0, -250
      halign = center
      valign = top
  }

  # Date
  label {
      monitor =
      text = cmd[update 60] date '+%A, %d. %B %Y'
      font_size = 48
      font_family = JetBrains Mono Nerd Font 10
      position = 0, -450
      halign = center
      valign = top
  }

  # User
  label {
      monitor =
      text =    $USER
      font_size = 24
      font_family = Inter Display Medium

      position = 0, 100
      halign = center
      valign = bottom
  }

  # Uptime
  label {
      monitor =
      text = cmd[update 10] uptime | sed -E 's/.*up ([0-9]+ days?),?[[:space:]]+([0-9]+:[0-9]+).*/up \1 \2/'
      font_size = 24
      font_family = JetBrains Mono Nerd Font 10
      position = -50, 50
      halign = right
      valign = bottom
  }
''
