CC := $(HOME)/cheri/output/morello-sdk/utils/cheribsd-morello-purecap-clang
CXX := $(HOME)/cheri/output/morello-sdk/utils/cheribsd-morello-purecap-clang++
CFLAGS	:= -fsanitize=address -O1 -ggdb -fno-omit-frame-pointer
LDFLAGS	:= -fuse-ld=lld

BIN=build

CSRC = $(wildcard *.c)
CXXSRC = $(wildcard *.cpp)
CEXEC = $(CSRC:.c=)
CXXEXEC = $(CXXSRC:.cpp=)

all: $(CEXEC) $(CXXEXEC)

# Rule to compile each .c file into its own executable
%: %.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $(BIN)/$@ $<

# Rule to compile each .cpp file into its own executable
%: %.cpp
	$(CXX) $(CFLAGS) $(LDFLAGS) -o $(BIN)/$@ $<

clean:
	rm -f build/*
	rm -f build/*.o

.PHONY: clean all
