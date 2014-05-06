#!/bin/bash
for pic in *.ppm; do
  pnmtojpeg "${pic}" > "${pic/%ppm/jpg}"
  # If want to delete .ppm after converting to .jpg, uncomment following:
  rm ${pic}
done
