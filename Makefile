DESTDIR ?= /usr
FILTER_PATH ?= $(DESTDIR)/lib/cups/filter
PPD_PATH ?= $(DESTDIR)/share/ppd/okidata

PPDS = $(wildcard */*.ppd.gz */*/*/*.ppd.gz */*/*/*/*.ppd.gz)

install:
	install -m 755 filters/* $(FILTER_PATH)
	mkdir -p $(PPD_PATH)
	install -m 644 $(PPDS) $(PPD_PATH)
