buildName: userName:
# bash
'' 
    hyfetch -p femboy -b fastfetch

    # nix commands (make it not depend on host!)
    alias nichts="nh os switch /home/${userName}/Documents/git/carlOS/ -H ${buildName}"
    alias garnichts="nh os switch /home/${userName}/Documents/git/carlOS/ --update -H ${buildName}"
    alias tracenichts="nixos-rebuild switch --show-trace" #"--flake /home/${userName}/Documents/git/carlOS/.#${buildName} --show-trace"

    # program aliases
    alias cd="z"
    alias v="nvim"

    # program functions
    alias kder="kdeconnect-cli --refresh"
    c() { z "$1" && ls -A; }
    alias gitsync="git pull && git add * && git commit -m \"sync\" && git push"
    alias fixvscode="rm -rf ~/.config/VSCodium/GPUCache"
    javarun() { javac "$1" && java "$(basename "$1" .java)" && rm *.class; }

    # zoxide
    eval "$(zoxide init bash)"
''
