#!/usr/bin/env bash
# Previews a logo without installing anything: prints it the way the floating
# terminal and screensaver show it, and opens a picture of the unlock screen.
#
# Usage: ./preview.sh [name|file]   (default: $LOGO, else the active logo, else aum)
exec "$(dirname "${BASH_SOURCE[0]}")/bin/omarchy-aum-logo" preview "${1:-${LOGO:-}}"
