{lib, ...}:
with lib; let
  image = builtins.fetchurl {
    url = "https://w.wallhaven.cc/full/ex/wallhaven-ex9gwo.png";
    sha256 = "1xaqgn8n56q77ji22sf5134vqxbhgb8g6bw7rhr55bclnmzjdgph";
  };
in ''
  preload = ${image}
  wallpaper = eDP-1, ${image}
  ipc = false
''

