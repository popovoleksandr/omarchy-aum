# Publishing omarchy-aum-logo to the AUR

The AUR package builds from a tagged GitHub release: `PKGBUILD` downloads `v<version>.tar.gz` from GitHub and installs it with `make install`.

## One-time setup

1. Create an account at <https://aur.archlinux.org/register>.
2. Add your SSH public key to the account (**My Account → SSH Public Key**):
   ```sh
   cat ~/.ssh/id_ed25519.pub
   ```
3. Tell SSH to use that key for the AUR, in `~/.ssh/config`:
   ```
   Host aur.archlinux.org
     IdentityFile ~/.ssh/id_ed25519
     User aur
   ```
4. Check it: `ssh aur@aur.archlinux.org help` should list the AUR commands.

## Releasing a version

1. Commit, then tag and push the release, for example `1.0.0`:
   ```sh
   git tag -a v1.0.0 -m "omarchy-aum-logo 1.0.0"
   git push origin master v1.0.0
   ```
2. Fill in the checksum and `.SRCINFO`, and test-build from the GitHub tarball:
   ```sh
   packaging/aur/update.sh 1.0.0
   ```
3. Commit the updated `PKGBUILD` and `.SRCINFO` in this repository.
4. Publish to the AUR:
   ```sh
   packaging/aur/publish.sh
   ```
   The first run clones `ssh://aur@aur.archlinux.org/omarchy-aum-logo.git` (empty for a new package) into `~/Projects/aur-omarchy-aum-logo`. Pushing to it creates the package. Later runs push updates.

The package page is then <https://aur.archlinux.org/packages/omarchy-aum-logo>, and anyone can install it with `omarchy pkg aur add omarchy-aum-logo` or `yay -S omarchy-aum-logo`.

## Changing only the packaging

For a fix to `PKGBUILD` or `omarchy-aum-logo.install` without a new release, bump `pkgrel` in `PKGBUILD`, run `makepkg --printsrcinfo > .SRCINFO` here, then `publish.sh`.

## Notes

- The AUR repository may only contain `PKGBUILD`, `.SRCINFO`, `omarchy-aum-logo.install` and similar small files. The code comes from the GitHub tarball.
- `depends` lists only packages from the official repositories (bash, imagemagick, jq). `omarchy` itself comes from Omarchy's own repository, so the code checks for it when it runs, not the package.
- pacman can't undo changes in users' home folders, so `omarchy-aum-logo.install` tells users to run `omarchy-aum-logo reset` and `omarchy-aum-logo unsetup` before removing the package.
