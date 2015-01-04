#!/bin/bash
if [[ "$1" == "" ]]
then
  echo Please provide a path >&2
  exit
fi

ROOT_PATH=$1

for f in `find "$ROOT_PATH" -type f`
do
  ext=`echo $f | perl -ne 'if (m@([^/]+)\.([^/]+)$@){ print "$2" }'`
  case $ext in
    css ) mime="text/css";;
    html) mime="text/html";;
    js  ) mime="text/javascript";;
    xml ) mime="text/xml";;
    png ) mime="image/png";;
    gif ) mime="image/gif";;
    jpg ) mime="image/jpeg";;
    kml ) mime="application/vnd.google-earth.kml+xml";;
    kmz ) mime="application/vnd.google-earth.kmz";;
    dae ) mime="application/xml";;
    zip ) mime="application/zip";;
    *) mime="";;
  esac

  if [[ "$mime" != "" ]]; then
    echo $f --\> $mime
    svn propset svn:mime-type $mime $f
    echo
  fi
done
