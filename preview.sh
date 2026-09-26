#!/usr/bin/env bash
# Previews a logo without installing anything: prints it the way the floating
# terminal and screensaver show it, and opens a picture of the unlock screen.
#
# Usage: ./preview.sh [name|file]   (default: $LOGO, else aum)

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

src=$(logo_file "${1:-${LOGO:-$DEFAULT_LOGO}}") || exit 1

echo -e "\033[32m"
cat <"$src"
echo -e "\033[0m"

out_dir="${XDG_RUNTIME_DIR:-/tmp}/omarchy-aum"
mkdir -p "$out_dir"
"$ROOT/bin/omarchy-aum-render-logo" "$src" "$out_dir/login.png"
read -r bg text < <(login_colors)
omarchy plymouth preview "$bg" "$text" "$out_dir/login.png" "$out_dir/unlock-preview.png" >/dev/null
echo "Unlock screen preview: $out_dir/unlock-preview.png"
setsid -f xdg-open "$out_dir/unlock-preview.png" >/dev/null 2>&1 || true
