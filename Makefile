CC := $(HOME)/cheri/output/morello-sdk/utils/cheribsd-morello-purecap-clang
CXX := $(HOME)/cheri/output/morello-sdk/utils/cheribsd-morello-purecap-clang++
CFLAGS	:= -fsanitize=address -O0 -ggdb -fno-omit-frame-pointer -Xclang -cheri-bounds=subobject-safe
LDFLAGS	:= -fuse-ld=lld
ASANFLAGS := -mllvm -asan-globals=0

BIN=build

CSRC = $(wildcard *.c)
CXXSRC = $(wildcard *.cpp)
CEXEC = $(CSRC:.c=)
CXXEXEC = $(CXXSRC:.cpp=)

all: $(CEXEC) $(CXXEXEC)

# we will always recompile all the testcases

# Rule to compile each .c file into its own executable
%: %.c
	$(CC) $(CFLAGS) $(ASANFLAGS) $(LDFLAGS) -o $(BIN)/$@ $<

# Rule to compile each .cpp file into its own executable
%: %.cpp
	$(CXX) $(CFLAGS) $(ASANFLAGS) $(LDFLAGS) -o $(BIN)/$@ $<

clean:
	rm -f build/*
	rm -f build/*.o

.PHONY: clean all
