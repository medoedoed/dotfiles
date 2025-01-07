#!/bin/bash

mode="$1"

if pgrep -x "slurp" >/dev/null; then
  exit 1
fi

if [[ "$mode" == "full" ]]; then
  grim - | wl-copy -t image/png
else
  grim -g "$(slurp -c ebdbb2 -w 6 -b 28282890)" - | wl-copy -t image/png
fi
