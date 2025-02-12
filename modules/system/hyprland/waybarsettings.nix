{
  mainBar = {
    layer = "top"; # Waybar at top layer
    position = "top"; # Waybar position (top|bottom|left|right)
    spacing = 4; # Gaps between modules (4px)
    # Choose the order of the modules
    modules-left = ["backlight" "hyprland/workspaces"];
    modules-center = ["pulseaudio" "network" "hyprland/submap"];
    modules-right = ["cpu" "memory" "temperature" "battery" "clock" "tray"];
    # Modules configuration
    "hyprland/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      on-click = "activate";
      format = "{name}: {windows}";
      window-rewrite-default = "";
      window-rewrite = {
        "title<.*youtube.*>" = "󰗃";
        "class<Alacritty>" = "";
        "class<signal>" = "";
        "class<WebCord>" = "󰙯";
        "class<neovide>" = "";
        "title<.*[nN][iI][xX].*>" = "󱄅";
        "class<firefox>" = "";
        "class<vlc>" = "󰕼";
        "class<.*obsidian.*>" = "󰠮";
        "class<yubioath-flutter>" = "󰒃";
        "class<thunderbird>" = "";
        "class<libreoffice.*>" = "󰎚";
        "class<.*Prismlauncher.*>" = "󰍳";
        "class<.*Minecraft.*>" = "󰍳";
      };
    };
    "hyprland/submap" = {
      format = "{}";
    };
    tray = {
      # icon-size= 21;
      spacing = 12;
    };
    clock = {
      timezone = "Europe/Berlin";
      tooltip-format = "<big>{:%a, %d %b}</big>\n<tt><small>{calendar}</small></tt>";
      format = "{:%d.%m %H:%M}";
    };
    cpu = {
      format = "{usage}% ";
      tooltip = false;
      interval = 1;
    };
    memory = {
      format = "{}% ";
    };
    temperature = {
      # thermal-zone= 2;
      hwmon-path = "/sys/class/thermal/thermal_zone2/temp";
      critical-threshold = 80;
      # format-critical= "{temperatureC}°C {icon}";
      format = "{temperatureC}°C {icon}";
      format-icons = [""];
      tooltip = false;
      interval = 1;
    };
    backlight = {
      device = "intel_backlight";
      format = "{percent}% {icon}";
      format-icons = ["" "" "" "" "" "" "" "" ""];
    };
    battery = {
      states = {
        # good= 95;
        warning = 20;
        critical = 10;
      };
      format = "{capacity}% {icon}";
      format-charging = "{capacity}% ";
      format-plugged = "{capacity}% ";
      format-alt = "{time} {icon}";
      tooltip = true;
      tooltip-format = "{power}W";
      # format-good= ""; // An empty format will hide the module
      # format-full= "";
      format-icons = ["" "" "" "" ""];
    };
    network = {
      # interface= "wlp2*"; // (Optional) To force the use of this interface
      format-wifi = "({signalStrength}%) ";
      format-ethernet = "Ethernet ";
      tooltip-format = "{ifname}: {ipaddr}/{cidr}\nvia {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = " ⚠";
      format-alt = "{essid} ({signalStrength}%) ";
    };
    pulseaudio = {
      # scroll-step= 1; // %, can be a float
      format = "{volume}% {icon} {format_source}";
      format-bluetooth = "{volume}% {icon} {format_source}";
      format-bluetooth-muted = "{icon} {format_source}";
      format-muted = "󰝟 {format_source}";
      format-source = "{volume}% ";
      format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = ["" "" "󰕾"];
      };
      on-click = "pavucontrol";
    };
  };
}
