# omarchy-aum-logo

A custom version of the [Omarchy](https://omarchy.org/) logo, shown everywhere Omarchy shows its logo: the screensaver, the boot/disk unlock screen, the SDDM login screen, and the floating "Omarchy" terminal that runs installers and updates.

You pick the logo from **Style > Logo** in the Omarchy menu, or with the `omarchy-aum-logo` command. Each logo is a text file of block characters (`█ ▀ ▄`) in [`logos/`](logos), and you can add your own:

- **`aum`** (the default): ॐarchy. A pixel-art ॐ replaces the "om", in the letters' height and stroke width:
  ```
             ▄  ▄██▄
             ▀█▄ ▀▀  ▄▄██
      ▄▄▄███▄▄ ▀▀█████▀▀
     █████▀▀██▄     ▄▄▄▄      ▄███████   ▄███████   ▄███████   ▄█   █▄    ▄█   █▄
      ▀      ██  ▄████▀▀██   ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
        ▄▄███▀  ▄███▀    ██  ███   ███  ███   ███  ███   █▀   ███   ███  ███   ███
  ▄     ▀████▄▄███▀      ██ ▄███▄▄▄███ ▄███▄▄▄██▀  ███       ▄███▄▄▄███▄ ███▄▄▄███
  █▄         ██▄ ▄      ▄██ ▀███▀▀▀███ ▀███▀▀▀▀    ███      ▀▀███▀▀▀███  ▀▀▀▀▀▀███
  ▀█▄        ███ ▀█▄▄▄████▀  ███   ███ ██████████  ███   █▄   ███   ███  ▄██   ███
    ▀██▄▄▄▄▄███▀  ▀██████    ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
      ▀██████▀               ███   █▀   ███   ███  ███████▀   ███   █▀    ▀█████▀
                                        ███   █▀
  ```
- **`om`**: oṃarchy. The stock logo with a stub on top of the "O" and a dot below the "m" (anusvara, as in *oṃ*):
  ```
     ▄▄▄
   ▄█████▄    ▄███████████▄    ▄███████   ▄███████   ▄███████   ▄█   █▄    ▄█   █▄
  ███   ███  ███   ███   ███  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
  ███   ███  ███   ███   ███  ███   ███  ███   ███  ███   █▀   ███   ███  ███   ███
  ███   ███  ███   ███   ███ ▄███▄▄▄███ ▄███▄▄▄██▀  ███       ▄███▄▄▄███▄ ███▄▄▄███
  ███   ███  ███   ███   ███ ▀███▀▀▀███ ▀███▀▀▀▀    ███      ▀▀███▀▀▀███  ▀▀▀▀▀▀███
  ███   ███  ███   ███   ███  ███   ███ ██████████  ███   █▄   ███   ███  ▄██   ███
  ███   ███  ███   ███   ███  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
   ▀█████▀    ▀█   ███   █▀   ███   █▀   ███   ███  ███████▀   ███   █▀    ▀█████▀
                                         ███   █▀
                   ███
  ```
- **`aumkar`**: ॐkārchy. ॐ followed by a "k" drawn in the letters' style and an "ā" (a macron over the "a"), as in *oṃkāra*:
  ```
             ▄  ▄██▄
             ▀█▄ ▀▀  ▄▄██                ███████
      ▄▄▄███▄▄ ▀▀█████▀▀
     █████▀▀██▄     ▄▄▄▄      ▄█    ▄█   ▄███████   ▄███████   ▄███████   ▄█   █▄    ▄█   █▄
      ▀      ██  ▄████▀▀██   ███  ▄██▀  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
        ▄▄███▀  ▄███▀    ██  ███▄██▀    ███   ███  ███   ███  ███   █▀   ███   ███  ███   ███
  ▄     ▀████▄▄███▀      ██  █████▄▄▄  ▄███▄▄▄███ ▄███▄▄▄██▀  ███       ▄███▄▄▄███▄ ███▄▄▄███
  █▄         ██▄ ▄      ▄██ ▀███▀███   ▀███▀▀▀███ ▀███▀▀▀▀    ███      ▀▀███▀▀▀███  ▀▀▀▀▀▀███
  ▀█▄        ███ ▀█▄▄▄████▀  ███  ███   ███   ███ ██████████  ███   █▄   ███   ███  ▄██   ███
    ▀██▄▄▄▄▄███▀  ▀██████    ███   ███  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
      ▀██████▀               ███   █▀   ███   █▀   ███   ███  ███████▀   ███   █▀    ▀█████▀
                                                   ███   █▀
  ```
- **`omkar`**: oṃkārchy. oṃarchy with the same "k" and "ā":
  ```
                                          ███████
     ▄▄▄
   ▄█████▄    ▄███████████▄    ▄█    ▄█   ▄███████   ▄███████   ▄███████   ▄█   █▄    ▄█   █▄
  ███   ███  ███   ███   ███  ███  ▄██▀  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
  ███   ███  ███   ███   ███  ███▄██▀    ███   ███  ███   ███  ███   █▀   ███   ███  ███   ███
  ███   ███  ███   ███   ███  █████▄▄▄  ▄███▄▄▄███ ▄███▄▄▄██▀  ███       ▄███▄▄▄███▄ ███▄▄▄███
  ███   ███  ███   ███   ███ ▀███▀███   ▀███▀▀▀███ ▀███▀▀▀▀    ███      ▀▀███▀▀▀███  ▀▀▀▀▀▀███
  ███   ███  ███   ███   ███  ███  ███   ███   ███ ██████████  ███   █▄   ███   ███  ▄██   ███
  ███   ███  ███   ███   ███  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
   ▀█████▀    ▀█   ███   █▀   ███   █▀   ███   █▀   ███   ███  ███████▀   ███   █▀    ▀█████▀
                                                    ███   █▀
                   ███
  ```

Everything is per user, and no Omarchy files are edited. The login logo goes in through Omarchy's own `omarchy plymouth set`.

## Install

### Package from the GitHub release

The AUR package isn't published yet, because new AUR account registration is paused (as of 2026-09-26). Until then, install the package attached to the [latest release](https://github.com/popovoleksandr/omarchy-aum-logo/releases/latest):

```sh
curl -LO https://github.com/popovoleksandr/omarchy-aum-logo/releases/download/v1.0.1/omarchy-aum-logo-1.0.1-1-any.pkg.tar.zst
sha256sum omarchy-aum-logo-1.0.1-1-any.pkg.tar.zst    # compare with the release notes
sudo pacman -U omarchy-aum-logo-1.0.1-1-any.pkg.tar.zst
```

Download it first: `pacman -U` with a link wants a signature file (`.sig`) next to the package, and the release has none, so it fails with a 404. Local files don't need one on a default Arch setup.

Or build the same package yourself. makepkg downloads the tagged release from GitHub and checks it against the checksum in the PKGBUILD:

```sh
git clone https://github.com/popovoleksandr/omarchy-aum-logo.git
cd omarchy-aum-logo/packaging/aur
makepkg -si
```

Once it's on the AUR, installing will be:

```sh
omarchy pkg aur add omarchy-aum-logo     # or: yay -S omarchy-aum-logo
```

pacman sees the AUR package as the same package, so a copy installed from the release upgrades normally.

Then:

1. Open **Omarchy Aum Logo** from the app launcher (it has an ॐ icon). The first time, it adds **Style > Logo** to the Omarchy menu and opens it.
2. Pick **ॐarchy**, **ॐkārchy**, **oṃarchy** or **oṃkārchy**. A floating terminal asks for your sudo password once, to put the logo on the boot and login screens, and rebuilds the initramfs.
3. **Log out and back in** once after installing the package, so the floating Omarchy terminal can show the logo. **Reboot** to see it on the boot/unlock screen.

### From a checkout

Without the package, run it straight from the repository:

```sh
git clone https://github.com/popovoleksandr/omarchy-aum-logo.git ~/Projects/omarchy-aum-logo
cd ~/Projects/omarchy-aum-logo
./install.sh              # ॐarchy
LOGO=om ./install.sh      # or oṃarchy
```

`install.sh` picks the logo from the `LOGO` variable at its top (default `aum`; a path to your own `.txt` file also works). It runs `bin/omarchy-aum-logo set` and then adds Style > Logo to the menu, pointing at the checkout. `./status.sh`, `./preview.sh` and `./uninstall.sh` wrap the other commands. Use `--skip-login` with `install.sh` or `uninstall.sh` to leave the login screens alone, with no sudo.

### Requirements

- Omarchy (tested on 4.0.4) with its Plymouth and SDDM themes, and Hyprland started by uwsm.
- ImageMagick and jq. Omarchy has both; the package depends on them.
- sudo rights, for the login screens only.

## Style > Logo

| Row | What it does |
|---|---|
| ॐarchy, ॐkārchy, oṃarchy, oṃkārchy | Shows that logo everywhere. The active one has a ✓. Opens a floating terminal, because the login screens need sudo. |
| Custom | Shows your own logo. Appears once you've used Edit Custom Text. |
| Edit Custom Text | Opens `~/.config/omarchy-aum-logo/logos/custom.txt` in your editor. The first time, it starts as a copy of the active logo. Pick **Custom** afterwards to use it. |
| Preview ▸ | Opens a picture of the unlock screen with any of the logos or Custom, without changing anything |
| Status | Checks every place, in a floating terminal |
| Restore Default | Puts the stock Omarchy logo back everywhere. The Logo menu stays so you can pick again. |

The rows live in a marked block (`// >>> omarchy-aum-logo >>>`) in `~/.config/omarchy/extensions/omarchy-menu.jsonc`, the menu's user extension file. Omarchy has no system-wide folder for menu extensions, so the package can't add them by itself. The first `omarchy-aum-logo menu` (the app) or `omarchy-aum-logo setup` adds them, after saving a backup as `omarchy-menu.jsonc.bak.omarchy-aum-logo`. The block is validated with the same rules the menu parser uses before it's written. The Logo row hides itself if the `omarchy-aum-logo` command is gone.

## Command line

| Command | What it does |
|---|---|
| `omarchy-aum-logo menu` | Adds Style > Logo if needed and opens it (what the app runs) |
| `omarchy-aum-logo set <logo>` | Shows `<logo>` on the screensaver, login screens and floating terminal. `--skip-login` skips the login screens. |
| `omarchy-aum-logo reset` | Puts the stock logo back. `--skip-login` leaves the login screens alone. |
| `omarchy-aum-logo edit` | Edits your custom logo |
| `omarchy-aum-logo preview [logo]` | Opens an unlock-screen picture with a logo (default: the active one) |
| `omarchy-aum-logo status` | Checks every place |
| `omarchy-aum-logo list` / `current` | Lists logos (`*` marks the active one) / prints the active one |
| `omarchy-aum-logo setup` / `unsetup` | Adds / removes Style > Logo |

A `<logo>` is a name from `omarchy-aum-logo list` or a path to a `.txt` file. Your choice is saved in `~/.config/omarchy-aum-logo/logo`.

- The login screens keep whatever background and text colors they have now. To use other colors, set `LOGIN_BG` and `LOGIN_TEXT`, for example `LOGIN_BG='#1d2021' LOGIN_TEXT='#ebdbb2' omarchy-aum-logo set aum`.
- The logo color is the stock green, `#a8cd76`. Set `LOGO_COLOR` to change it.

## Your own logo

Any `~/.config/omarchy-aum-logo/logos/<name>.txt` becomes a logo named `<name>`. A file there with the same name as a bundled logo (`aum`, `aumkar`, `om`, `omkar`) replaces it. **Edit Custom Text** uses `custom.txt`.

- Use only `█`, `▀`, `▄` and spaces. Each character is one column; each line is two pixel rows (`▀` top half, `▄` bottom half). The letters are 16 pixel rows (8 lines) tall.
- `omarchy-aum-logo preview <name>` shows it before you use it.
- If you edit the installed screensaver text instead (for example with `omarchy branding screensaver text`), the next `set` puts the logo file's version back. `omarchy-aum-logo status` reports when the two differ.

## What it changes

| Where the logo shows | How | Files |
|---|---|---|
| Screensaver | Copies the logo over the screensaver branding text, the file `omarchy branding screensaver text` edits. A different previous text is saved as `screensaver.txt.bak.<timestamp>`. | `~/.config/omarchy/branding/screensaver.txt` |
| Boot/disk unlock screen (Plymouth) and SDDM login screen | Renders the logo to a PNG, then installs it with `omarchy plymouth set`, keeping the current colors. That asks for sudo and rebuilds the initramfs; it's skipped when the screens already show the logo. | `~/.cache/omarchy-aum-logo/login.png` → `/usr/share/plymouth/themes/omarchy/logo.png`, `/usr/share/sddm/themes/omarchy/logo.png` |
| Floating Omarchy terminal | An override of `omarchy-show-logo`, put first on `PATH` by a uwsm env file. It prints the screensaver text when you've picked a logo, and runs Omarchy's own otherwise. | Package: `/usr/share/omarchy-aum-logo/override/omarchy-show-logo`, `/usr/share/uwsm/env.d/50-omarchy-aum-logo`. Checkout: `~/.config/omarchy/bin/omarchy-show-logo`, `~/.config/uwsm/env.d/50-omarchy-aum-logo` |
| Omarchy menu | Style > Logo | `~/.config/omarchy/extensions/omarchy-menu.jsonc` |

## Removing

Run these first, because pacman can't undo changes in your home folder:

```sh
omarchy-aum-logo reset       # stock logo back (asks for sudo for the login screens)
omarchy-aum-logo unsetup     # Style > Logo out of the menu
omarchy pkg drop omarchy-aum-logo       # or: sudo pacman -R omarchy-aum-logo
```

If the package is already gone, `omarchy plymouth reset` and `omarchy branding screensaver reset` put the stock logo back; the Logo row has already hidden itself. From a checkout, `./uninstall.sh` does both steps.

## How it works

### Login logo

Omarchy's stock `logo.png` (800×188) is its `logo.txt` drawn at 10 px per column and per half-row (81 columns × 19 half-rows = 810×190), then resized to 800×188. `lib/render-logo` does the same with ImageMagick. Rendering the stock `logo.txt` this way reproduces the stock image: no pixel's opacity differs by more than half. So a custom logo keeps the stock scale and style. The image size follows the art: `om` is 800×208 because of the stub above the "O" and the dot below the "m", `aum` is 790×237 because of the crescent and dot above ॐ, and the "k" and the macron over the "a" make `aumkar` 899×237 and `omkar` 909×237. The floating Omarchy terminal (875×600 px, about 117 columns with the default font) fits all of them.

The PNG is installed with `omarchy plymouth set <bg> <text> <logo.png>`. That's the same command Omarchy uses for theme unlock screens. It writes the logo into both the Plymouth and the SDDM theme, sets the colors, and rebuilds the initramfs, because the boot screen loads from there. Both screens center the logo and size it from the image, so a taller logo needs no layout change.

### Floating terminal logo

The floating terminal (`omarchy launch floating terminal with presentation`) runs `omarchy-show-logo` before its command. That script prints `$OMARCHY_PATH/logo.txt`, a packaged file that can't be configured. omarchy-aum-logo's override prints `~/.config/omarchy/branding/screensaver.txt` when `~/.config/omarchy-aum-logo/logo` exists, and otherwise runs Omarchy's own script. So it only changes anything for users who picked a logo.

For the terminal to find the override first, its directory has to come before `/usr/bin` on `PATH`. uwsm sources `env.d` files from `/usr/share/uwsm/env.d/` (where Omarchy's own `10-omarchy` lives) and then from `~/.config/uwsm/env.d/`, when the session starts. The package puts `50-omarchy-aum-logo` in the first, a checkout in the second. The override's directory holds nothing else, so no other command changes. `~/.local/bin` wouldn't work: Omarchy appends it after the system directories on purpose.

`omarchy show logo` still prints the stock logo, because the `omarchy` dispatcher runs commands from its own directory, not from `PATH`.

### Menu and app

`omarchy-aum-logo menu` adds the Style > Logo block and runs `omarchy menu summon style.logo`. The ✓ comes from each row's `checked` condition (`omarchy-aum-logo is-active <logo>`), which the menu evaluates when it opens. The app is `/usr/share/applications/omarchy-aum-logo.desktop`; its icon is drawn from the ॐ in `logos/aum.txt` by `tools/make-icon` (`make icon`).

## Things that put the stock logo back

- `omarchy plymouth reset`, `omarchy refresh plymouth`, `omarchy refresh sddm`, or `omarchy plymouth set by theme <theme>` replace the login logo. Pick the logo again in Style > Logo.
- `omarchy branding screensaver reset` or `omarchy branding screensaver image` replace the screensaver text. The terminal follows the screensaver text, so it changes too.
- Changing the Omarchy theme and running `omarchy update` leave all of it alone.

## Files

| File | Purpose |
|---|---|
| `logos/aum.txt`, `logos/aumkar.txt`, `logos/om.txt`, `logos/omkar.txt` | ॐarchy (default), ॐkārchy, oṃarchy and oṃkārchy |
| `bin/omarchy-aum-logo` | The command; all the logic lives here |
| `lib/common.sh`, `lib/render-logo` | Shared helpers; the logo-to-PNG renderer |
| `share/menu.jsonc` | The Style > Logo block (`@CMD@` becomes the command) |
| `share/omarchy-show-logo`, `share/uwsm-env.in` | Floating-terminal override and the env file that puts it first on `PATH` |
| `share/omarchy-aum-logo.desktop`, `share/omarchy-aum-logo.svg` | App launcher entry and icon |
| `install.sh`, `status.sh`, `uninstall.sh`, `preview.sh` | Checkout wrappers around `bin/omarchy-aum-logo` |
| `Makefile` | `make DESTDIR=… PREFIX=/usr install`, used by the PKGBUILD; `make icon` redraws the icon |
| `packaging/aur/` | PKGBUILD, install messages, `.SRCINFO`, and the release scripts ([how to publish](packaging/aur/README.md)) |
| `tools/make-icon` | Draws the icon from `logos/aum.txt` |

## Tested

Tested on 2026-09-26 with Omarchy 4.0.4, Hyprland 0.56.2, uwsm 0.26.7, Plymouth 26.134.222, SDDM 0.21.0 (autologin), ImageMagick 7.1.2.31, and Limine with limine-mkinitcpio-hook 1.38.0.

- Verified with an earlier `om` logo (dot above the "m"): `omarchy plymouth set` installed the rendered logo into both themes and `limine-mkinitcpio` finished without errors. The Omarchy unlock-screen preview showed it centered above the password box.
- Verified: a real uninstall ran `omarchy plymouth reset`, which rebuilt the unified kernel image. Every Plymouth and SDDM theme file then matched Omarchy's defaults byte for byte.
- Verified: rendering the stock `logo.txt` reproduces the stock `logo.png`. A logo that differs by only the three-cell dot is reported as different.
- Verified: the menu block was parsed with Omarchy's own `MenuModel.js`. All 11 rows land under Style > Logo with the right parents, and `unsetup` restores the file byte for byte. Adding works for a missing file and for a file with entries of its own. A file without a `{` line is refused and left unchanged.
- Verified: `makepkg` builds the package, and `desktop-file-validate` accepts the desktop entry. From the unpacked package, `set` uses the bundled logos and removes checkout copies, and the menu rows call `omarchy-aum-logo`.
- Verified in an empty home folder: `set` (bundled and custom logos), `list`, `current`, `edit` seeding `custom.txt`, `preview`, `status` and `reset`. The terminal override shows the picked logo, and Omarchy's own when none is picked.
- Verified live on 2026-09-26 with the installed package: clicking "Omarchy Aum Logo" in the launcher added Style > Logo and opened it. The rows, icons and the ॐ/ṃ labels render in the menu. Picking ॐarchy there put it on the screensaver and both login screens, and `omarchy-aum-logo status` confirmed every place.
- Verified: the v1.0.0 release package installs with download, `sha256sum` check, then `pacman -U` of the local file, and upgrades a 0.1.0 test build. `pacman -U <link>` fails on a default Arch setup, because remote files need a `.sig`.
- Not yet verified: the floating terminal after a real re-login, and the ✓ mark on screen (`omarchy-aum-logo is-active aum` succeeds, which is what the menu checks).

## License

[MIT](LICENSE). This project is not affiliated with Omarchy.
