include config.mk

BIN ?= pngquant
OBJS = pngquant.o rwpng.o

all: $(BIN)

lib/libimagequant.a::
	$(MAKE) CC=$(CC) CFLAGS="$(CFLAGS)" -C lib static

$(BIN): $(OBJS) lib/libimagequant.a
	$(CC) $(OBJS) $(LDFLAGS) -o $@

$(OBJS): rwpng.h

clean:
	rm -f $(BIN) $(OBJS) config.mk
	$(MAKE) -C lib clean

config.mk:
	./configure

.PHONY: all clean
.DELETE_ON_ERROR:
