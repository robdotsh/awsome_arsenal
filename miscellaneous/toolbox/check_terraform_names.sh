#!/usr/bin/env bash
set -euo pipefail

## Check TF configuration objects are named using underscores to delimit multiple words

ERROR=0

for file in "$@"; do
  # Check resource, data, module block names
  BLOCK_NAMES=$(sed -nE 's/^(resource|data|module)[[:space:]]+"[^"]+"[[:space:]]+"([^"]+)".*/\2/p' "$file")

  # Check variable names
  VARIABLE_NAMES=$(sed -nE 's/^variable[[:space:]]+"([^"]+)".*/\1/p' "$file")

  for name in $BLOCK_NAMES $VARIABLE_NAMES; do
    if echo "$name" | grep -q '-'; then
      echo "Naming convention violation in $file"
      echo "Invalid name: \"$name\""
      echo "Use underscores (_) instead of hyphens (-)."
      echo "example: ${name//-/_}"
      echo
      ERROR=1
    fi
  done
done

if [ $ERROR -ne 0 ]; then
  echo "Terraform naming convention check failed."
  exit 1
fi
