# Programs to use
NASM = nasm
QEMU = qemu-system-i386

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
	$(QEMU) $(OUTPUT)

clean:
	rm -f $(OUTPUT)