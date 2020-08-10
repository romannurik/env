#!/bin/sh
# Run this in a directory full of pngs
# Pass in the fps (default is 60)
FPS=60
if [ "$1" ]; then
  FPS=$1
fi

ffmpeg -y -r $FPS -pattern_type glob -i "*.png" "_.gif"
