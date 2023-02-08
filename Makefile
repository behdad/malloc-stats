all: malloc-stats.so

malloc-stats.o: malloc-stats.c
	$(CC) -c -fPIC -o $@ $<

malloc-stats.so: malloc-stats.o
	$(LD) -shared -o $@ $< -ldl

clean:
	$(RM) malloc-stats.o malloc-stats.so
