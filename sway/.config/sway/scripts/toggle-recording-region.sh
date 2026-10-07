#!/bin/bash
if pgrep -x wf-recorder >/dev/null; then
  pkill -SIGINT wf-recorder
  notify-send "Screen Recording" "Stopped"
elif pgrep -x slurp >/dev/null; then
  exit 0
else
  geometry=$(slurp)
  if [[ -z "$geometry" || "$geometry" =~ 0x0$ ]]; then
    exit 0
  fi
  filename="$HOME/Videos/recording-$(date +%Y%m%d-%H%M%S).mp4"
  wf-recorder -g "$geometry" -f "$filename" >/tmp/wf-recorder.log 2>&1 &
  notify-send "Screen Recording" "Started (region) → $filename"
fi
