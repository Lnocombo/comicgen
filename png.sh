#!/usr/bin/env bash

# Loop through all SVG files under the svg/ folder
for svg in $(find svg -name "*.svg")
do
  echo "$svg"
  # Convert svg/.../file.svg to png/.../file.png
  png="${svg//svg/png}"
  # Check if the SVG is older than the PNG. If so, the SVG has been updated
  if [ "$svg" -nt "$png" ]; then
    # Compress the SVG
    svgo -q --multipass "$svg"
    # Create the PNG
    mkdir -p $(dirname "$png")
    convert -background none "$svg" "$png"
    # Compress the PNG
    pngquant --force --ext .png "$png"
  fi
done
