{
  mainBar = {
    layer = "top"; # Waybar at top layer
    position = "top"; # Waybar position (top|bottom|left|right)
    spacing = 4; # Gaps between modules (4px)
    # Choose the order of the modules
    modules-left = ["backlight" "hyprland/workspaces"];
    modules-center = ["pulseaudio" "network" "network#speed" "hyprland/submap"];
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
        "class<Alacritty>" = "";
        "class<org.kde.konsole>" = "";
        "class<org.kde.dolphin>" = "";
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
      interval = 2;
    };
    memory = {
      interval = 10;
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
      tooltip-format = "{power} W";
      format-full= ""; # hides the module when battery is full;
      format-icons = ["" "" "" "" ""];
    };
    network = {
      format-wifi = "({signalStrength}%)  ";
      format-ethernet = "Ethernet 󰌗";
      tooltip-format = "{ifname}: {ipaddr}/{cidr}\nvia {gwaddr}\n{ssid}"; # {frequency}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "󰖪 ";
      on-click = "pkill .nm-connection- || nm-connection-editor";
    };
    "network#speed" = {
      interval = 2;
      format-wifi = "<small> {bandwidthUpBits}\n {bandwidthDownBits}</small>";
      format-ethernet = "<small> {bandwidthUpBits}\n {bandwidthDownBits}</small>";
      tooltip-format = "{ifname}: {ipaddr}/{cidr}\nvia {gwaddr}\n{ssid} {frequency}";
      on-click = "pkill .nm-connection- || nm-connection-editor";
    };
    pulseaudio = {
      scroll-step= 0.5;
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
      on-click = "pkill pavucontrol || pavucontrol";
    };
  };
}
