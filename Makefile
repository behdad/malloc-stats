UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
TARGET = malloc-stats.dylib
SHARED_FLAGS = -dynamiclib
LDLIBS =
else
TARGET = malloc-stats.so
SHARED_FLAGS = -shared
LDLIBS = -ldl
endif

all: $(TARGET)

malloc-stats.o: malloc-stats.c
	$(CC) -c -fPIC -o $@ $<

$(TARGET): malloc-stats.o
	$(CC) $(SHARED_FLAGS) -o $@ $< $(LDLIBS)

clean:
	$(RM) malloc-stats.o malloc-stats.so malloc-stats.dylib
