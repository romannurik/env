#!/bin/bash
TYPE=all
VIDEO=""
while [ -n "$1" ]; do
  if [[ "$1" == "-e" ]]; then
    TYPE=extract
  elif [[ "$1" == "-c" ]]; then
    TYPE=compose
  else
    VIDEO="$1"
  fi
  shift
done

if [[ "$VIDEO" == "" ]]; then
  echo >&2 "Usage $0 [-e | -c] VIDEOFILE"
  exit
fi

if [ ! -f "${VIDEO}" ]; then
  echo >&2 "Video file $VIDEO does not exist."
  exit
fi

FPS=5
TEMP_FRAME="${VIDEO}_frame"
OUT_GIF="${VIDEO}.gif"

if [[ $TYPE == "all" || $TYPE == "extract" ]]; then
  echo Extracting frames...
  rm ${TEMP_FRAME}*.jpg
  ~/Downloads/media/ffmpeg -i "${VIDEO}" -y -an -f image2 -r $FPS "${TEMP_FRAME}%03d.jpg" >/dev/null 2>&1
fi

if [[ $TYPE == "all" || $TYPE == "compose" ]]; then
  echo Composing animated GIF...
  convert -delay $((100 / $FPS)) -loop 0 "${TEMP_FRAME}*.jpg" "${OUT_GIF}"
fi