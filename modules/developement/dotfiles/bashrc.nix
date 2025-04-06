buildName: userName:
# bash
''
      hyfetch -p femboy -b fastfetch

      # nix commands (make it not depend on host!)
      alias update="nh os switch -H ${buildName}"
      alias upgrade="nh os switch --update -H ${buildName}"
      alias devupdate="nix flake update carlOS && nh os switch . --hostname {buildName}"

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
      eval "$(thefuck --alias fu)"
      # nix direnv (for dev shells)
      eval "$(direnv hook bash)"
''
