#!/bin/bash
# Check 1-minute load average against a simple threshold.

THRESHOLD="${1:-5.0}"

load_1m=$(awk '{print $1}' /proc/loadavg)

# compare as floats using awk
is_high=$(awk -v l="$load_1m" -v t="$THRESHOLD" 'BEGIN { if (l > t) print 1; else print 0 }')

if [ "$is_high" -eq 1 ]; then
  echo "WARNING - Load average high: ${load_1m} (threshold ${THRESHOLD})"
  exit 1
else
  echo "OK - Load average: ${load_1m} (threshold ${THRESHOLD})"
  exit 0
fi
