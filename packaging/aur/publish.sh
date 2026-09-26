#!/usr/bin/env bash
# Copies PKGBUILD, .SRCINFO and omarchy-aum-logo.install into a clone of the AUR
# repository and pushes them. Needs an AUR account with your SSH key.
#
# Usage: packaging/aur/publish.sh [aur-clone-dir]   (default: ~/Projects/aur-omarchy-aum-logo)

set -euo pipefail

dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
clone=${1:-$HOME/Projects/aur-omarchy-aum-logo}

[[ -s $dir/.SRCINFO ]] || { echo "error: run packaging/aur/update.sh <version> first" >&2; exit 1; }
if [[ ! -d $clone/.git ]]; then
  git clone ssh://aur@aur.archlinux.org/omarchy-aum-logo.git "$clone"
fi

cp "$dir/PKGBUILD" "$dir/.SRCINFO" "$dir/omarchy-aum-logo.install" "$clone/"
cd "$clone"
git add PKGBUILD .SRCINFO omarchy-aum-logo.install
version=$(sed -n 's/^\tpkgver = //p' .SRCINFO)-$(sed -n 's/^\tpkgrel = //p' .SRCINFO)
if git diff --cached --quiet; then
  echo "Nothing changed in $clone"
  exit 0
fi
git commit -m "Update to $version"
git push origin HEAD:master
echo "Published omarchy-aum-logo $version: https://aur.archlinux.org/packages/omarchy-aum-logo"
