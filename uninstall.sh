#!/usr/bin/env bash
# Puts the stock Omarchy logo back everywhere install.sh changed it.
#
# Usage: ./uninstall.sh [--skip-login]
#   --skip-login  leave the login screens alone (resetting them needs sudo)

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

skip_login=false
case "${1:-}" in
"") ;;
--skip-login) skip_login=true ;;
*)
  echo "Usage: ./uninstall.sh [--skip-login]" >&2
  exit 1
  ;;
esac

for file in "$USER_BIN_DIR/omarchy-show-logo" "$UWSM_ENV_DIR/$UWSM_ENV_FILE"; do
  if grep -qs omarchy-aum "$file"; then
    rm -f "$file"
    echo "Removed $file"
  fi
done
rmdir "$USER_BIN_DIR" "$UWSM_ENV_DIR" "${UWSM_ENV_DIR%/*}" 2>/dev/null || true

stock_logo=${OMARCHY_PATH:-/usr/share/omarchy}/logo.txt
if cmp -s "$ROOT/logo.txt" "$BRANDING_DIR/screensaver.txt"; then
  cp "$stock_logo" "$BRANDING_DIR/screensaver.txt"
  echo "Reset $BRANDING_DIR/screensaver.txt to the stock logo"
else
  echo "Left $BRANDING_DIR/screensaver.txt alone: it isn't logo.txt"
fi

rendered=$(mktemp --suffix=.png)
trap 'rm -f "$rendered"' EXIT
"$ROOT/bin/omarchy-aum-render-logo" "$ROOT/logo.txt" "$rendered"
if $skip_login; then
  echo "Left the login screens alone (--skip-login)"
elif same_logo "$rendered" "$PLYMOUTH_THEME/logo.png" || same_logo "$rendered" "$SDDM_THEME/logo.png"; then
  echo "Resetting the Plymouth and SDDM themes to stock; this asks for your sudo password"
  echo "and rebuilds the initramfs"
  omarchy plymouth reset
else
  echo "Left the login screens alone: they don't show this logo"
fi
rm -f "$BRANDING_DIR/login.png"

echo
echo "Done. Log out and back in once so the floating terminal drops the override."
ls "$BRANDING_DIR"/screensaver.txt.bak.* >/dev/null 2>&1 &&
  echo "Screensaver texts saved by install.sh are still in $BRANDING_DIR/screensaver.txt.bak.*"
exit 0
