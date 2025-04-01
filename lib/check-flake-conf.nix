#flake-confs: attrs: defaults: {
#  check-conf = flake-confs: attr: default: (
#    if builtins.hasAttr "attr" flake-confs
#    then flake-confs.${attr}
#    else default
#  );
#}
flake-confs: attr-root: defaults:
if builtins.hasAttr attr-root flake-confs
then defaults // flake-confs.${attr-root}
else defaults
