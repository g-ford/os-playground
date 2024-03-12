# Programs to use
NASM = nasm
BOCHS = bochs

# NASM flags
NASM_FLAGS = -f bin

# Source file
SOURCE = bootloader.asm

# Output file
OUTPUT = bootloader.bin

all: build

build: $(SOURCE)
	$(NASM) $(NASM_FLAGS) -o $(OUTPUT) $(SOURCE)

run: build
	$(BOCHS) -f .bochsrc

clean:
	rm -f $(OUTPUT)