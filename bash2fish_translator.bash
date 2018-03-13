#!/usr/bin/env bash

set -e
shopt -s expand_aliases

# not supported below:
# -  Foo=foo echo $foo => env Foo=foo echo $foo
function trans() {
  echo "$1" | grep 'alias' \
    | perl -pe 's/^(.+)?alias +(.+)$/alias \2/g' \
    | perl -pe 's/2>/\^/g' \
    | perl -pe 's/ +&& +/; and /g' \
    | perl -pe 's/ +\|\| +/; or /g' \
    | perl -pe 's/(\$)\?/\1status/g' \
    | perl -pe 's/if +\[ +! +(.+) \] *; *then +(.+); +fi/if not test \1; \2; end/g' \
    | perl -pe 's/if +\[ (.+) \] *; *then +(.+); +fi/if test \1; \2; end/g' \
    | perl -pe 's/do *(.+); *done/\1; end/g' \
    | perl -pe 's/`(.*?)`/(\1)/g' \
    | perl -pe 's/\$\(/(/g' \
    | perl -pe "s/\'\\\'\'/\\\'/g" \
    | perl -pe 's/<\((.*?)\)/(\1 \\\\| psub)/g' \
    | perl -pe 's/ ! / not /g'
}

if [ -p /dev/stdin ]; then
  trans "$(cat -)"
else
  if [ ! -f "${_B2F_BASHRC}" ]; then
    echo "Not exists translate target. path: ${_B2F_BASHRC}" >&2
    exit 1
  fi
  bashrc_path="${_B2F_BASHRC}"
  source $bashrc_path
  trans "$(alias)"
fi
