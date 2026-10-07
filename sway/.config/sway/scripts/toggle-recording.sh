#!/bin/bash
if pgrep -x wf-recorder >/dev/null; then
  pkill -SIGINT wf-recorder
  notify-send "Screen Recording" "Stopped"
else
  output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
  filename="$HOME/Videos/recording-$(date +%Y%m%d-%H%M%S).mp4"
  wf-recorder -o "$output" -f "$filename" >/tmp/wf-recorder.log 2>&1 &
  notify-send "Screen Recording" "Started ($output) → $filename"
fi
