#!/bin/sh
if [[ -z "$1" || -z "$2" ]]; then
  echo "Usage: $0 <directory> <script>" >&2
  exit
fi

if [[ ! -e "$1" ]]; then
  echo "The file or directory is not valid." >&2
  exit
fi

WATCHDIR="$1"
shift
SCRIPT="$*"
HASH=""

function updatehash() {
  HASH=`find $WATCHDIR -not -iname ".*" -exec stat -f "%N %z %m" -L {} \; | md5`
}

updatehash
while true; do
  OLDHASH=$HASH
  updatehash
  if [ "$HASH" != "$OLDHASH" ]; then
    echo `date -j "+%Y-%m-%d %r"` $SCRIPT
    $SCRIPT
    tput bel
    updatehash
  fi
  sleep 0.2
done
