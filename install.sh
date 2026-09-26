#!/usr/bin/env bash
# Installs the custom logo from logo.txt for the current user: the screensaver
# text, the floating Omarchy terminal logo, and the Plymouth/SDDM login logo.
# Safe to re-run after editing logo.txt.
#
# Usage: ./install.sh [--skip-login]
#   --skip-login  don't install the login logo (the only step that needs sudo)

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

skip_login=false
case "${1:-}" in
"") ;;
--skip-login) skip_login=true ;;
*)
  echo "Usage: ./install.sh [--skip-login]" >&2
  exit 1
  ;;
esac

command -v omarchy >/dev/null || die "omarchy is missing; this is meant for Omarchy"
command -v magick >/dev/null || die "magick is missing (package: imagemagick)"
[[ -d $PLYMOUTH_THEME && -d $SDDM_THEME ]] ||
  die "the Omarchy Plymouth/SDDM themes are missing ($PLYMOUTH_THEME, $SDDM_THEME)"

echo "Installing the screensaver text to $BRANDING_DIR/screensaver.txt"
if [[ -f $BRANDING_DIR/screensaver.txt ]] && ! cmp -s "$ROOT/logo.txt" "$BRANDING_DIR/screensaver.txt"; then
  backup="$BRANDING_DIR/screensaver.txt.bak.$(date +%s)"
  cp "$BRANDING_DIR/screensaver.txt" "$backup"
  echo "  saved the previous text to $backup"
fi
install -Dm644 "$ROOT/logo.txt" "$BRANDING_DIR/screensaver.txt"

echo "Installing the floating terminal logo to $USER_BIN_DIR/omarchy-show-logo"
install -Dm755 "$ROOT/bin/omarchy-show-logo" "$USER_BIN_DIR/omarchy-show-logo"
install -Dm644 "$ROOT/share/$UWSM_ENV_FILE" "$UWSM_ENV_DIR/$UWSM_ENV_FILE"

echo "Rendering the login logo to $BRANDING_DIR/login.png"
"$ROOT/bin/omarchy-aum-render-logo" "$ROOT/logo.txt" "$BRANDING_DIR/login.png"

login_pending=false
if same_logo "$BRANDING_DIR/login.png" "$PLYMOUTH_THEME/logo.png" &&
  same_logo "$BRANDING_DIR/login.png" "$SDDM_THEME/logo.png"; then
  echo "  the login screens already show this logo"
elif $skip_login; then
  login_pending=true
  echo "  skipped installing it (--skip-login)"
else
  read -r bg text < <(login_colors)
  echo "Installing the login logo (background $bg, text $text); this asks for your sudo password"
  echo "and rebuilds the initramfs"
  omarchy plymouth set "$bg" "$text" "$BRANDING_DIR/login.png"
fi

echo
echo "Done."
echo "- Screensaver: preview it with: omarchy launch screensaver force"
if $login_pending; then
  echo "- Login screens: not installed yet; run ./install.sh again without --skip-login"
else
  echo "- Login screens: the new logo shows on the next boot"
fi
if [[ $(PATH=$(session_path) command -v omarchy-show-logo) == "$USER_BIN_DIR/omarchy-show-logo" ]]; then
  echo "- Floating terminal: already uses the new logo"
else
  echo "- Floating terminal: log out and back in (or reboot) once to use the new logo"
fi
echo "Check everything with: $ROOT/status.sh"
