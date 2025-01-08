CC := $(HOME)/cheri/output/morello-sdk/bin/clang
CXX := $(HOME)/cheri/output/morello-sdk/bin/clang++
CFLAGS	:= -fsanitize=address -O0 -ggdb -fno-omit-frame-pointer -Xclang -cheri-bounds=subobject-safe
LDFLAGS	:= -fuse-ld=lld
ASANFLAGS := -mllvm -asan-globals=0 -mllvm -asan-opt-cheri-stack=1

BIN=build

CSRC = $(wildcard *.c)
CXXSRC = $(wildcard *.cpp)
CEXEC = $(CSRC:.c=)
CXXEXEC = $(CXXSRC:.cpp=)

HYBRID_FLAGS := --config $(HOME)/cheri/output/morello-sdk/bin/cheribsd-morello-hybrid-for-purecap-rootfs.cfg
PURECAP_FLAGS := --config $(HOME)/cheri/output/morello-sdk/bin/cheribsd-morello-purecap.cfg

all: $(CEXEC) $(CXXEXEC)

all-hybrid: CFLAGS += $(HYBRID_FLAGS)
all-hybrid: all

all-purecap: CFLAGS += $(PURECAP_FLAGS)
all-purecap: all


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
