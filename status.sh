#!/usr/bin/env bash
# Checks that every place shows the logo from logo.txt.

source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

ok() { printf '  \e[32mok\e[0m    %s\n' "$*"; }
bad() { printf '  \e[31mFAIL\e[0m  %s\n' "$*"; }
note() { printf '  ..    %s\n' "$*"; }
todo() { printf '  \e[33mtodo\e[0m  %s\n' "$*"; }

rendered=$(mktemp --suffix=.png)
trap 'rm -f "$rendered"' EXIT
"$ROOT/bin/omarchy-aum-render-logo" "$ROOT/logo.txt" "$rendered" || exit 1

echo "Screensaver"
if cmp -s "$ROOT/logo.txt" "$BRANDING_DIR/screensaver.txt"; then
  ok "$BRANDING_DIR/screensaver.txt matches logo.txt"
elif [[ -f $BRANDING_DIR/screensaver.txt ]]; then
  bad "$BRANDING_DIR/screensaver.txt differs from logo.txt: copy your edits into logo.txt, or run ./install.sh"
else
  bad "$BRANDING_DIR/screensaver.txt is missing: run ./install.sh"
fi

echo "Login screens"
for logo in "$PLYMOUTH_THEME/logo.png" "$SDDM_THEME/logo.png"; do
  if same_logo "$rendered" "$logo"; then
    ok "$logo shows logo.txt"
  else
    bad "$logo shows a different logo: run ./install.sh"
  fi
done
theme=$(plymouth-set-default-theme 2>/dev/null)
if [[ $theme == omarchy ]]; then
  ok "Plymouth theme is omarchy"
else
  bad "Plymouth theme is ${theme:-unknown}, so the boot screen doesn't use this logo: omarchy plymouth reset"
fi
read -r bg text < <(login_colors)
note "colors: background $bg, text $text"
note "the boot screen reads a copy inside the initramfs, which install.sh rebuilds; /boot isn't readable without sudo"
if grep -qs '^User=' /etc/sddm.conf.d/*.conf; then
  note "SDDM autologin is on, so you mostly see the logo on the disk unlock screen"
fi

echo "Floating terminal"
if cmp -s "$ROOT/bin/omarchy-show-logo" "$USER_BIN_DIR/omarchy-show-logo"; then
  ok "$USER_BIN_DIR/omarchy-show-logo installed"
else
  bad "$USER_BIN_DIR/omarchy-show-logo missing or outdated: run ./install.sh"
fi
if cmp -s "$ROOT/share/$UWSM_ENV_FILE" "$UWSM_ENV_DIR/$UWSM_ENV_FILE"; then
  ok "$UWSM_ENV_DIR/$UWSM_ENV_FILE installed"
else
  bad "$UWSM_ENV_DIR/$UWSM_ENV_FILE missing or outdated: run ./install.sh"
fi
resolved=$(PATH=$(session_path) command -v omarchy-show-logo)
if [[ $resolved == "$USER_BIN_DIR/omarchy-show-logo" ]]; then
  ok "the running session uses the override"
elif [[ -f $UWSM_ENV_DIR/$UWSM_ENV_FILE ]]; then
  todo "the running session still uses ${resolved:-nothing}: log out and back in once"
else
  bad "the running session uses ${resolved:-nothing}"
fi
