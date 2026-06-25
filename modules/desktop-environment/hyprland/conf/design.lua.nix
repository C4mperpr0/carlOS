{config}: let
  colors = config.lib.stylix.colors;
in ''
  hl.config({
    general = {
      border_size = 1,
      gaps_out = 10,
      col = {
        active_border = "#${colors.base05}",
        inactive_border ="#${colors.base06}"
      },
      -- no_border_on_floating = true,
      resize_on_border = true,
    },
    decoration =  {
      rounding = 3,
      active_opacity = 1.0,
      inactive_opacity = 0.75,
    }
  })

  -- special
  hl.workspace_rule({workspace = "s[true]", gaps_out = 50})
  -- hl.curve( "overshoot", { type = "bezier", points = { {0.5, 0.9}, {0.1, 1.1} } } ) -- find premade bezier curves here: https://easings.net/
  -- hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 8, curve = "overshoot", style = "slidefadevert 5%" })
''
