#!/bin/bash
if [[ "$1" == "-f" ]]; then
  FAKE=1
  shift
fi

if [[ -z "$1" || -z "$2" ]]; then
  echo "Usage: $0 [-f] <path> <find-regex> [<replace-regex>]" >&2
  exit
fi

DIR="$1"
FIND="$2"
REPLACE="$3"

# We can't do renames on the entire file path, we can only do it on the
# file name, so we must walk the directory tree (directory renames are done
# post-order).

function do_rename() {
  cd "$1"
  # Rename directories
  ls -A | while read FILE; do
    if [ -d "${FILE}" ]; then
      # Visit subdirectory
      do_rename "${FILE}"
    fi
    RENAMED=$(echo ${FILE} | sed -E "s@${FIND}@${REPLACE}@g")
    if [[ "${FILE}" == "${RENAMED}" ]]; then
      if [[ -n $FAKE ]]; then
        echo [fake] skipping "${FILE}"
      fi
      continue
    fi
    # Post-order rename directory or file
    if [[ -n $FAKE ]]; then
      echo [fake] mv "${FILE}" "${RENAMED}"
    else
      mv "${FILE}" "${RENAMED}"
    fi
  done
  cd ..
}

do_rename ${DIR}