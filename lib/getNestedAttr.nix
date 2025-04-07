set: path:
(
  builtins.foldl'
  (acc: key:
    if acc.found && builtins.hasAttr key acc.value
    then {
      # arrived at next nesting
      found = true;
      value = acc.value.${key};
    }
    else {
      # target does not exist
      found = false;
      value = {};
    })
  {
    # initial values
    found = true;
    value = set;
  }
  # split at "."
  (builtins.filter (x: builtins.isString x) (builtins.split "([.])" path))
)
.value
