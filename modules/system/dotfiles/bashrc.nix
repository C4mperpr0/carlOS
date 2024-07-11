buildName: userName:
# bash
''
      hyfetch -p femboy -b fastfetch

      # nix commands (make it not depend on host!)
      alias nichts="nh os switch /home/${userName}/Documents/git/carlOS/ -H ${buildName}"
      alias garnichts="nh os switch /home/${userName}/Documents/git/carlOS/ --update -H ${buildName}"
      alias tracenichts="sudo nixos-rebuild switch --flake /home/${userName}/Documents/git/carlOS/.#${buildName} --show-trace"
      alias testhyprconf="sudo cp --remove-destination /home/carl/Documents/git/carlOS/modules/system/hyprland/hyprland.conf /home/carl/.config/hypr/hyprland.conf && hyprctl reload"

      # program aliases
      alias cd="z"
      alias v="nvim"

      # program functions
      alias kder="kdeconnect-cli --refresh"
      c() { z "$1" && ls -A; }
      fucking() { sudo $(fc -ln -1); }
      alias gitsync="git pull && git add * && git commit -m \"sync\" && git push"
      quitgame() { local streak_file="$HOME/test"; (( RANDOM % 10 == 0 )) && echo "0" > "$streak_file" && echo "You've lost!" && systemctl suspend || { [ ! -f "$streak_file" ] && echo "1" > "$streak_file" || { streak=$(<"$streak_file"); ((streak++)); echo "$streak" > "$streak_file"; }; echo "You got lucky! Your streak is $streak"; }; }
      alias fixvscode="rm -rf ~/.config/VSCodium/GPUCache"
      javarun() { javac "$1" && java "$(basename "$1" .java)" && rm *.class; }

      # zoxide
      eval "$(zoxide init bash)"
      # thefuck
      eval "$(thefuck --alias fuck)"
''
