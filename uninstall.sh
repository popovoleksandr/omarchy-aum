#!/usr/bin/env bash
# Puts the stock Omarchy logo back everywhere and removes Style > Logo from the
# Omarchy menu.
#
# Usage: ./uninstall.sh [--skip-login]
#   --skip-login  leave the login screens alone (resetting them needs sudo)

set -euo pipefail

bin="$(dirname "${BASH_SOURCE[0]}")/bin/omarchy-aum-logo"
"$bin" reset "$@"
"$bin" unsetup
