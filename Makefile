UNAME_S := $(shell uname -s)
.PHONY: all clean print-usage

ifeq ($(UNAME_S),Darwin)
TARGET = malloc-stats.dylib
SHARED_FLAGS = -dynamiclib
LDLIBS =
PRELOAD_ENV = DYLD_INSERT_LIBRARIES
else
TARGET = malloc-stats.so
SHARED_FLAGS = -shared
LDLIBS = -ldl
PRELOAD_ENV = LD_PRELOAD
endif

all: $(TARGET) print-usage

malloc-stats.o: malloc-stats.c
	$(CC) -c -fPIC -o $@ $<

$(TARGET): malloc-stats.o
	$(CC) $(SHARED_FLAGS) -o $@ $< $(LDLIBS)

print-usage:
	@echo
	@echo "Built $(TARGET)"
	@echo "Usage:"
	@echo "  $(PRELOAD_ENV)=$(CURDIR)/$(TARGET) your-binary args..."

clean:
	$(RM) malloc-stats.o malloc-stats.so malloc-stats.dylib
