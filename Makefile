all: malloc-stats.dylib

malloc-stats.dylib: malloc-stats.o
	$(CC) -dynamiclib malloc-stats.c -o malloc-stats.dylib

clean:
	$(RM) malloc-stats.dylib
