#! /usr/bin/env nix-shell
#! nix-shell -p git -i "git clone https://github.com/c4mperpr0/carlOS ~/Documents/git/carlOS"
export NIX_CONFIG="experimental-features = nix-command flakes"
#! nix-shell -p nh -i "nh os switch /home/carl/Documents/git/carlOS/ --update -H laptop"

