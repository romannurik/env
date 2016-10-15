#!/bin/sh
while [ -n "$1" ]; do
  srcfile="$1"
  tempfile="${srcfile}.tmp.png"

  origsize=$(stat -f "%z" "${srcfile}")

  echo optipng...
  optipng "$file" >/dev/null
  echo pngquant...
  pngquant --force "${srcfile}" --output "${tempfile}" >/dev/null
  echo zopflipng...
  zopflipng -y "${tempfile}" "${srcfile}" >/dev/null
  rm "${tempfile}"

  finalsize=$(stat -f "%z" "${srcfile}")

  echo "$srcfile : ${origsize} bytes --> ${finalsize} bytes"
  shift
done
