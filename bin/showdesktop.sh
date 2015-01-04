#!/bin/sh
if [ "$1" == "-h" ]; then
  echo "Usage $0 [-hide]" >&2
  exit
fi

SHOW=true
if [ "$1" == "-hide" ]; then
  SHOW=false
elif [ "$1" != "" ]; then
  echo "Usage $0 [-hide]" >&2
  exit
fi

defaults write com.apple.finder CreateDesktop -bool $SHOW ; killall Finder
