# Shared paths and helpers for install.sh, status.sh, uninstall.sh and preview.sh.
# shellcheck shell=bash

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
BRANDING_DIR="$HOME/.config/omarchy/branding"
USER_BIN_DIR="$HOME/.config/omarchy/bin"
UWSM_ENV_DIR="$HOME/.config/uwsm/env.d"
UWSM_ENV_FILE=50-omarchy-user-bin
PLYMOUTH_THEME=/usr/share/plymouth/themes/omarchy
SDDM_THEME=/usr/share/sddm/themes/omarchy
STOCK_BG="#1a1b26"
STOCK_TEXT="#c0caf5"
DEFAULT_LOGO=aum
# Remembers which logo install.sh installed, for status.sh and uninstall.sh.
STATE_FILE="${XDG_STATE_HOME:-$HOME/.local/state}/omarchy-aum/logo"

warn() {
  echo "warning: $*" >&2
}

die() {
  echo "error: $*" >&2
  exit 1
}

# Path of a logo given by name (logos/<name>.txt) or as a path to a .txt file.
logo_file() {
  local logo=$1 names
  if [[ $logo != */* && -f $ROOT/logos/$logo.txt ]]; then
    echo "$ROOT/logos/$logo.txt"
  elif [[ -f $logo ]]; then
    realpath -- "$logo"
  else
    names=$(cd "$ROOT/logos" && ls -- *.txt | sed 's/\.txt$//' | paste -sd, | sed 's/,/, /g')
    die "no logo \"$logo\": use a name from logos/ ($names) or a path to a .txt file"
  fi
}

# The logo install.sh installed last, or the default if it never ran.
installed_logo() {
  local logo
  logo=$(cat "$STATE_FILE" 2>/dev/null)
  echo "${logo:-$DEFAULT_LOGO}"
}

# True if two logo PNGs show the same picture. Renders from different
# ImageMagick or Pillow versions differ only in anti-aliasing, so only pixels
# whose opacity differs by more than half count.
same_logo() {
  local a=$1 b=$2 diff
  [[ -f $a && -f $b ]] || return 1
  [[ $(magick identify -format %wx%h "$a") == "$(magick identify -format %wx%h "$b")" ]] || return 1
  diff=$(magick compare -metric AE -fuzz 50% <(magick "$a" -alpha extract png:-) <(magick "$b" -alpha extract png:-) null: 2>&1) || true
  [[ ${diff%% *} == 0 ]]
}

# PATH of the running Hyprland session, which keybindings and menus launch the
# floating terminal with. Falls back to the systemd user manager's PATH.
session_path() {
  local pid
  pid=$(pgrep -u "$UID" -x Hyprland | head -n 1)
  if [[ -n $pid && -r /proc/$pid/environ ]]; then
    tr '\0' '\n' <"/proc/$pid/environ" | sed -n 's/^PATH=//p'
  else
    systemctl --user show-environment 2>/dev/null | sed -n 's/^PATH=//p'
  fi
}

# Background and text colors the login screens use now, so reinstalling the
# logo keeps them. LOGIN_BG / LOGIN_TEXT override; the stock colors are the fallback.
login_colors() {
  local bg text
  bg=$(grep -m1 -oE 'color: "#[0-9a-fA-F]{6}"' "$SDDM_THEME/Main.qml" 2>/dev/null | grep -oE '#[0-9a-fA-F]{6}')
  text=$(magick "$SDDM_THEME/lock.png" -format %c histogram:info:- 2>/dev/null | sort -rn | grep -m1 -oE '#[0-9A-F]{6}FF\b' | cut -c1-7 | tr A-F a-f)
  echo "${LOGIN_BG:-${bg:-$STOCK_BG}} ${LOGIN_TEXT:-${text:-$STOCK_TEXT}}"
}
