# Installs omarchy-aum-logo as a package would. The PKGBUILD runs:
#   make DESTDIR="$pkgdir" PREFIX=/usr install
PREFIX ?= /usr
DESTDIR ?=
SHARE := $(DESTDIR)$(PREFIX)/share/omarchy-aum-logo

.PHONY: install icon

install:
	install -Dm755 bin/omarchy-aum-logo $(SHARE)/bin/omarchy-aum-logo
	install -Dm644 lib/common.sh $(SHARE)/lib/common.sh
	install -Dm755 lib/render-logo $(SHARE)/lib/render-logo
	install -Dm644 -t $(SHARE)/logos logos/*.txt
	install -Dm644 share/menu.jsonc $(SHARE)/share/menu.jsonc
	install -Dm755 share/omarchy-show-logo $(SHARE)/override/omarchy-show-logo
	install -d $(DESTDIR)$(PREFIX)/bin
	ln -sf ../share/omarchy-aum-logo/bin/omarchy-aum-logo $(DESTDIR)$(PREFIX)/bin/omarchy-aum-logo
	install -d $(DESTDIR)$(PREFIX)/share/uwsm/env.d
	sed 's|@OVERRIDE_DIR@|$(PREFIX)/share/omarchy-aum-logo/override|g' share/uwsm-env.in \
		>$(DESTDIR)$(PREFIX)/share/uwsm/env.d/50-omarchy-aum-logo
	chmod 644 $(DESTDIR)$(PREFIX)/share/uwsm/env.d/50-omarchy-aum-logo
	install -Dm644 share/omarchy-aum-logo.desktop $(DESTDIR)$(PREFIX)/share/applications/omarchy-aum-logo.desktop
	install -Dm644 share/omarchy-aum-logo.svg $(DESTDIR)$(PREFIX)/share/icons/hicolor/scalable/apps/omarchy-aum-logo.svg
	install -Dm644 README.md $(DESTDIR)$(PREFIX)/share/doc/omarchy-aum-logo/README.md
	install -Dm644 LICENSE $(DESTDIR)$(PREFIX)/share/licenses/omarchy-aum-logo/LICENSE

# Redraws share/omarchy-aum-logo.svg after logos/aum.txt changes.
icon:
	tools/make-icon logos/aum.txt share/omarchy-aum-logo.svg
