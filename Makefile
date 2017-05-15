PREFIX ?= /usr/local

FILTER_PATH ?= $(DESTDIR)$(PREFIX)/lib/cups/filter
PPD_PATH ?= $(DESTDIR)$(PREFIX)/share/ppd/okidata

PPDS = $(wildcard */*.ppd */*/*/*.ppd */*/*/*/*.ppd)

all:

install:
	install -m 755 filters/* $(FILTER_PATH)
	mkdir -p $(PPD_PATH)
	install -m 644 $(PPDS) $(PPD_PATH)
