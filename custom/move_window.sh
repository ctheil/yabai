#!/bin/bash

direction=$1

# Get the focused window's frame
window_frame=$(yabai -m query --windows --window | jq -r '.frame')
window_x=$(echo "$window_frame" | jq -r '.x')
window_y=$(echo "$window_frame" | jq -r '.y')
window_w=$(echo "$window_frame" | jq -r '.w')
window_h=$(echo "$window_frame" | jq -r '.h')

# Get the current display's frame
display_frame=$(yabai -m query --displays --display | jq -r '.frame')
display_x=$(echo "$display_frame" | jq -r '.x')
display_y=$(echo "$display_frame" | jq -r '.y')
display_w=$(echo "$display_frame" | jq -r '.w')
display_h=$(echo "$display_frame" | jq -r '.h')

at_left_edge=$(($window_x <= $display_x))
at_right_edge=$(($window_x + $window_w >= $display_x + $display_w))
at_top_edge=$(($window_y <= $display_y))
at_bottom_edge=$(($window_y + $window_h >= $display_y + $display_h))

echo "$at_left_edge, $at_top_edge, $at_bottom_edge, $at_right_edge"

#get current display
current_display=$(yabai -m query --displays --display | jq '.index')

# # determine the next display on direction
if [ "$direction" = "east" ]; then
  next_display=$((current_display + 1))
elif [ "$direction" = "west" ]; then
  next_display=$((current_display - 1))
else
  echo "$direction is not a valid argument..."
  exit 1
fi

#Move window to next display
# yabai -m window --display $next_display
#
# #focus on next display
# yabai -m display --focus $next_display
#
# # move the window in the direction on the new display
# yabai -m window --move $direction
