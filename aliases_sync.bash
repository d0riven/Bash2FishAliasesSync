#!/usr/bin/env bash

set -e

aliases_file="$HOME/.config/fish/b2f_aliases.fish"
if [ ! -z "${_B2F_ALIASES_FILE}" ]; then
  aliases_file="${_B2F_ALIASES_FILE}"
fi

function trans() {
  echo "$1" | grep 'alias' \
    | perl -pe 's/^(.+)?alias +(.+)$/alias \2/g' \
    | perl -pe 's/2>/\^/g' \
    | perl -pe 's/ +&& +/; and /g' \
    | perl -pe 's/ +\|\| +/; or /g' \
    | perl -pe 's/(\$)\?/\1status/g' \
    | perl -pe 's/if +\[ (.+) \] *; *then +(.+); +fi/if test \1; \2; end/g' \
    | perl -pe 's/do *(.+); *done/\1; end/g' \
    | perl -pe 's/`(.*?)`/(\1)/g' \
    | perl -pe 's/\$\(/(/g'
}

if [ -p /dev/stdin ]; then
  trans "$(cat -)" > $aliases_file
else
  bash_profile_path="${HOME}/.bash_profile"
  if [ ! -z "${_B2F_BASH_PROFILE}" ]; then
    bash_profile_path="${_B2F_BASH_PROFILE}"
  fi
  . $bash_profile_path
  trans "$(alias)" > $aliases_file
fi
