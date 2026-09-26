# omarchy-aum

A custom version of the [Omarchy](https://omarchy.org/) logo, shown everywhere Omarchy shows its logo: the screensaver, the boot/disk unlock screen, the SDDM login screen, and the floating "Omarchy" terminal that runs installers and updates.

The logo is one text file, [`logo.txt`](logo.txt), drawn with block characters (`█ ▀ ▄`). Compared with the stock logo, it adds a stub on top of the "O" and a square dot above the "m":

```
                 ███
   ▄▄▄
 ▄█████▄    ▄███████████▄    ▄███████   ▄███████   ▄███████   ▄█   █▄    ▄█   █▄
███   ███  ███   ███   ███  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
```

Everything is per user, and no Omarchy files are edited. The login logo goes in through Omarchy's own `omarchy plymouth set`.

## What it changes

| Where the logo shows | What install.sh does | File |
|---|---|---|
| Screensaver | Copies `logo.txt` over the screensaver branding text, the same file `omarchy branding screensaver text` edits | `~/.config/omarchy/branding/screensaver.txt` |
| Boot/disk unlock screen (Plymouth) and SDDM login screen | Renders `logo.txt` to a PNG, then installs it with `omarchy plymouth set`, keeping the current colors. That command asks for your sudo password and rebuilds the initramfs. | `~/.config/omarchy/branding/login.png` → `/usr/share/plymouth/themes/omarchy/logo.png`, `/usr/share/sddm/themes/omarchy/logo.png` |
| Floating Omarchy terminal | Installs a user copy of `omarchy-show-logo` that prints the screensaver text. It also installs a uwsm env file that puts it ahead of the packaged command on `PATH`. | `~/.config/omarchy/bin/omarchy-show-logo`, `~/.config/uwsm/env.d/50-omarchy-user-bin` |

## Requirements

- Omarchy (tested on 4.0.4) with its Plymouth and SDDM themes, and Hyprland started by uwsm.
- ImageMagick (`magick`). Omarchy installs it, and `omarchy plymouth set` needs it too.
- sudo rights, for the login logo only.

## Install

```sh
cd ~/Projects/omarchy-aum
./install.sh
```

- It asks for your sudo password once, to install the login logo. It skips that step when the login screens already show this logo.
- **Reboot** to see the new logo on the boot/unlock screen. SDDM autologin usually skips the SDDM screen itself.
- **Log out and back in** (a reboot also works) once, so the floating terminal picks up its override. The terminal reads `PATH` from your session, and that's set at login.

`install.sh` is safe to re-run. Before it replaces the screensaver text, it saves any different text as `screensaver.txt.bak.<timestamp>`. Use `./install.sh --skip-login` to install everything except the login logo, with no sudo.

Check the result:

```sh
./status.sh
```

## Changing the logo

1. Edit `logo.txt`. Use only `█`, `▀`, `▄` and spaces. Each character is one column; each line is two pixel rows (`▀` top half, `▄` bottom half).
2. Preview it without installing anything:
   ```sh
   ./preview.sh
   ```
   This prints the logo the way the terminal and screensaver show it, and opens a picture of the unlock screen with it.
3. Install it:
   ```sh
   ./install.sh
   ```

`logo.txt` is the source of truth. If you edit the installed copy instead (for example with `omarchy branding screensaver text`), copy your changes back into `logo.txt`. Otherwise the next `./install.sh` puts `logo.txt` back. `./status.sh` reports when the two differ.

- The login logo keeps whatever background and text colors the login screens have now. To use other colors, set `LOGIN_BG` and `LOGIN_TEXT`: `LOGIN_BG='#1d2021' LOGIN_TEXT='#ebdbb2' ./install.sh`.
- The logo color is the stock green, `#a8cd76`. Set `LOGO_COLOR` to change it.

## Uninstall

```sh
./uninstall.sh
```

This removes the terminal override and the uwsm env file, and resets the screensaver text to the stock logo. It then runs `omarchy plymouth reset`, which asks for sudo and restores the stock Plymouth and SDDM themes, including their stock colors. It leaves any file it doesn't recognise as its own alone. `--skip-login` leaves the login screens as they are. Log out and back in once afterwards.

## How it works

### Login logo

Omarchy's stock `logo.png` (800×188) is its `logo.txt` drawn at 10 px per column and per half-row (81 columns × 19 half-rows = 810×190), then resized to 800×188. `bin/omarchy-aum-render-logo` does the same with ImageMagick. Rendering the stock `logo.txt` this way reproduces the stock image: no pixel's opacity differs by more than half. So a custom logo keeps the stock scale and style. It only grows in size when the art has more lines or columns: this one is 800×218, because of the extra line above the letters.

The PNG is installed with `omarchy plymouth set <bg> <text> <logo.png>`. That's the same command Omarchy uses for theme unlock screens. It writes the logo into both the Plymouth and the SDDM theme, sets the colors, and rebuilds the initramfs, because the boot screen loads from there. Both screens center the logo and size it from the image, so a taller logo needs no layout change.

### Floating terminal logo

The floating terminal (`omarchy launch floating terminal with presentation`) runs `omarchy-show-logo` before its command. That script prints `$OMARCHY_PATH/logo.txt`, a packaged file that can't be configured. The user copy in `~/.config/omarchy/bin` prints `~/.config/omarchy/branding/screensaver.txt` instead, and falls back to the stock logo if that file is missing or empty. So the terminal always shows the same logo as the screensaver.

For the terminal to find that copy first, `~/.config/omarchy/bin` has to come before `/usr/bin` on `PATH`. Omarchy's session setup (`/usr/share/uwsm/env.d/10-omarchy`) says users should put overrides in `~/.config/uwsm/env.d/`. uwsm loads those files after the system ones, when the session starts. The env file puts only that directory in front, and nothing else lives there, so no other command changes. `~/.local/bin` wouldn't work: Omarchy appends it after the system directories on purpose.

`omarchy show logo` still prints the stock logo, because the `omarchy` dispatcher runs commands from its own directory, not from `PATH`.

## Things that put the stock logo back

- `omarchy plymouth reset`, `omarchy refresh plymouth`, `omarchy refresh sddm`, or `omarchy plymouth set by theme <theme>` replace the login logo. Run `./install.sh` again afterwards.
- `omarchy branding screensaver reset` or `omarchy branding screensaver image` replace the screensaver text. The terminal follows the screensaver text, so it changes too.
- Changing the Omarchy theme and running `omarchy update` leave all of it alone.

## Files

| File | Purpose |
|---|---|
| `logo.txt` | The logo |
| `install.sh`, `status.sh`, `uninstall.sh` | Install, check, remove |
| `preview.sh` | Show the logo and an unlock-screen picture without installing |
| `bin/omarchy-aum-render-logo` | Renders a block-character logo to the login PNG: `bin/omarchy-aum-render-logo logo.txt out.png` |
| `bin/omarchy-show-logo` | Installed to `~/.config/omarchy/bin/` for the floating terminal |
| `share/50-omarchy-user-bin` | Installed to `~/.config/uwsm/env.d/` to put that override first on `PATH` |
| `lib/common.sh` | Paths and helpers shared by the scripts |

## Tested

Tested on 2026-09-26 with Omarchy 4.0.4, Hyprland 0.56.2, uwsm 0.26.7, Plymouth 26.134.222, SDDM 0.21.0 (autologin), ImageMagick 7.1.2.31, and Limine with limine-mkinitcpio-hook 1.38.0.

- Verified: `omarchy plymouth set` installed the rendered logo into both themes and `limine-mkinitcpio` finished without errors. The Omarchy unlock-screen preview showed it centered above the password box. `./status.sh` confirmed every piece.
- Verified: rendering the stock `logo.txt` reproduces the stock `logo.png`. A logo that differs by only the three-cell dot is reported as different.
- Verified: `install.sh --skip-login` and `uninstall.sh --skip-login` in an empty home folder. The first install backs up a different screensaver text, and uninstall removes only its own files.
- Verified: after `install.sh`, a simulated uwsm environment load resolves `omarchy-show-logo` to the user copy.
- Verified: a real `./uninstall.sh`. It removed the override and the env file (plus the then-empty `~/.config/omarchy/bin` and `~/.config/uwsm`), reset the screensaver text, and ran `omarchy plymouth reset`, which rebuilt the unified kernel image. Every Plymouth and SDDM theme file then matched Omarchy's defaults byte for byte.
- Not yet verified: the floating terminal after a real re-login.

## License

[MIT](LICENSE). This project is not affiliated with Omarchy.
