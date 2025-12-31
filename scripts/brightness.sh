#!/usr/bin/env bash
BACKLIGHT="/sys/class/backlight/intel_backlight"

CUR=$(cat "$BACKLIGHT/brightness")
MAX=$(cat "$BACKLIGHT/max_brightness")

# Step is 5% of max
STEP=$((MAX / 20))
# Ensure minimum step is at least 1
if [[ $STEP -lt 1 ]]; then
    STEP=1
fi

if [[ "$1" == "down" ]]; then
    CUR=$((CUR - STEP))
    # Ensure we don’t go below 5% of max
    MIN=$STEP
    if [[ $CUR -lt $MIN ]]; then
        CUR=$MIN
    fi
elif [[ "$1" == "up" ]]; then
    CUR=$((CUR + STEP))
    # Ensure we don’t go above MAX
    if [[ $CUR -gt $MAX ]]; then
        CUR=$MAX
    fi
fi

# Write the new brightness
echo $CUR | tee "$BACKLIGHT/brightness" > /dev/null




