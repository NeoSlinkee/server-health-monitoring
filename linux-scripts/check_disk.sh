#!/bin/bash
# Simple disk usage check. Exits non-zero if usage exceeds threshold.

THRESHOLD="${1:-85}"

usage=$(df -hP / | awk 'NR==2 {gsub("%",""); print $5}')

if [ "$usage" -ge "$THRESHOLD" ]; then
  echo "CRITICAL - Disk usage at ${usage}% (threshold ${THRESHOLD}%)"
  exit 2
else
  echo "OK - Disk usage at ${usage}% (threshold ${THRESHOLD}%)"
  exit 0
fi
