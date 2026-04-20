.PHONY: install uninstall

PACKAGE_NAME     = kit-thesis
PACKAGE_VERSION  = 0.1.0
PREFIX          ?= $(HOME)/.local/share/typst/packages/local
INSTALLDIR       = $(PREFIX)/$(PACKAGE_NAME)/$(PACKAGE_VERSION)

install:
	mkdir -p $(INSTALLDIR)
	cp -r * $(INSTALLDIR)

uninstall:
	rm -rf $(INSTALLDIR)

