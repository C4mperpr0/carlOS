flake-confs: attr-root: defaults:
if builtins.hasAttr attr-root flake-confs
then defaults // flake-confs.${attr-root}
else defaults
