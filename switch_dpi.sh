#!/bin/bash

if [ "$1" == "retina" ]; then
  echo "Configuring retina dpi"

  xrdb -merge ~/.Xresources
  
  # scale firefox
  scale = 1.8
  
  xrandr --dpi 220

elif [ "$1" == "downscale" ]; then
  echo "Configuring downscaled dpi"
  
  
