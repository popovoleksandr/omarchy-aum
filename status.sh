#!/usr/bin/env bash
# Checks that every place shows the active logo.
exec "$(dirname "${BASH_SOURCE[0]}")/bin/omarchy-aum-logo" status
