#!/usr/bin/env bash
# Installs a logo straight from this checkout, without the package: the
# screensaver text, the floating terminal logo, the login screens, and
# Style > Logo in the Omarchy menu. Safe to re-run after editing a logo.
#
# Usage: [LOGO=<name|file>] ./install.sh [--skip-login]
#   --skip-login  don't install the login logo (the only step that needs sudo)

set -euo pipefail

# Which logo to install: a name from logos/ (aum = ॐarchy, om = oṃarchy with
# a dot below the "m") or a path to your own .txt file.
LOGO=${LOGO:-aum}

bin="$(dirname "${BASH_SOURCE[0]}")/bin/omarchy-aum-logo"
"$bin" set "$LOGO" "$@"
"$bin" setup
