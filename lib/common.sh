# Shared paths and helpers for omarchy-aum-logo.
# shellcheck shell=bash
#
# The caller sets ROOT: the directory holding bin/, lib/ and logos/. That is the
# git checkout, or /usr/share/omarchy-aum-logo when installed as a package.

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/omarchy-aum-logo"
SETTING_FILE="$CONFIG_DIR/logo"
USER_LOGOS_DIR="$CONFIG_DIR/logos"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/omarchy-aum-logo"
BRANDING_DIR="$HOME/.config/omarchy/branding"
MENU_FILE="$HOME/.config/omarchy/extensions/omarchy-menu.jsonc"
PLYMOUTH_THEME=/usr/share/plymouth/themes/omarchy
SDDM_THEME=/usr/share/sddm/themes/omarchy
STOCK_BG="#1a1b26"
STOCK_TEXT="#c0caf5"
DEFAULT_LOGO=aum
MENU_BEGIN="// >>> omarchy-aum-logo >>>"
MENU_END="// <<< omarchy-aum-logo <<<"

# The package ships the floating-terminal override and the uwsm env file that
# puts it first on PATH system-wide. A checkout installs both per user instead.
if [[ -x $ROOT/override/omarchy-show-logo ]]; then
  PACKAGED=true
  OVERRIDE_BIN="$ROOT/override/omarchy-show-logo"
  CMD=omarchy-aum-logo
else
  PACKAGED=false
  OVERRIDE_BIN="$HOME/.config/omarchy/bin/omarchy-show-logo"
  CMD="$ROOT/bin/omarchy-aum-logo"
fi
USER_ENV_FILE="$HOME/.config/uwsm/env.d/50-omarchy-aum-logo"

warn() {
  echo "warning: $*" >&2
}

die() {
  echo "error: $*" >&2
  exit 1
}

# Names of all logos: your own in ~/.config/omarchy-aum-logo/logos first, then the
# bundled ones. A name in both places means your own file.
logo_names() {
  local dir file
  for dir in "$USER_LOGOS_DIR" "$ROOT/logos"; do
    for file in "$dir"/*.txt; do
      [[ -f $file ]] && basename "$file" .txt
    done
  done | awk '!seen[$0]++'
}

# Path of a logo given by name or as a path to a .txt file.
logo_file() {
  local logo=$1
  if [[ $logo != */* && -f $USER_LOGOS_DIR/$logo.txt ]]; then
    echo "$USER_LOGOS_DIR/$logo.txt"
  elif [[ $logo != */* && -f $ROOT/logos/$logo.txt ]]; then
    echo "$ROOT/logos/$logo.txt"
  elif [[ $logo == */* && -f $logo ]]; then
    realpath -- "$logo"
  else
    die "no logo \"$logo\": use one of $(logo_names | paste -sd, | sed 's/,/, /g'), or a path to a .txt file"
  fi
}

# The logo chosen with `omarchy-aum-logo set`, if any.
active_logo() {
  cat "$SETTING_FILE" 2>/dev/null
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

# True if a JSONC file parses the way the Omarchy menu reads it: full-line //
# comments and trailing commas are dropped, the rest must be a JSON object.
menu_jsonc_valid() {
  sed -E '/^[[:space:]]*\/\//d' "$1" | sed -zE 's/,([[:space:]]*[]}])/\1/g' | jq -e 'type == "object"' >/dev/null 2>&1
}
