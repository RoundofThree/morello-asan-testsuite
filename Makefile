CC := $(HOME)/cheri/output/morello-sdk/utils/cheribsd-morello-purecap-clang
CXX := $(HOME)/cheri/output/morello-sdk/utils/cheribsd-morello-purecap-clang++
CFLAGS	:= -fsanitize=address -O1 -ggdb -fno-omit-frame-pointer
LDFLAGS	:= -fuse-ld=lld

build/%: %.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ test1.c

build/%: %.cpp
	$(CXX) $(CFLAGS) $(LDFLAGS) -o $@ test1.c

clean:
	rm -f build/*
	rm -f build/*.o

.PHONY: clean
