#!/bin/bash
# Check if a list of systemd services is active.

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 service1 service2 ..."
  exit 3
fi

failed=0

for svc in "$@"; do
  systemctl is-active --quiet "$svc"
  if [ "$?" -ne 0 ]; then
    echo "CRITICAL - Service not running: $svc"
    failed=1
  else
    echo "OK - Service running: $svc"
  fi
done

if [ "$failed" -eq 1 ]; then
  exit 2
else
  exit 0
fi
