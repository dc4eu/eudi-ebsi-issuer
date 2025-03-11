#!/bin/bash

OS="$(uname)"

if [[ "$OS" == "Darwin" ]]; then
  # macOS
  if command -v ifconfig >/dev/null 2>&1; then
    ifconfig en0 | sed -nE 's/.*inet ([0-9.]+) netmask.*/\1/p'
  else
    echo "Error: 'ifconfig' not found on macOS." >&2
    exit 1
  fi
else
  # Assume Linux
  if command -v hostname >/dev/null 2>&1; then
    hostname -I | awk '{print $1}'
  else
    echo "Error: 'hostname' not found on Linux." >&2
    exit 1
  fi
fi

