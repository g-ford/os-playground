# Programs to use
NASM = nasm
NASM_FLAGS = -f bin


QEMU = qemu-system-i386
# QEMU_FLAGS = -hda


# Source file
SOURCE = bootloader.asm

# Output file
OUTPUT = bootloader.bin

all: clean run

build: $(SOURCE)
	$(NASM) $(NASM_FLAGS) -o $(OUTPUT) $(SOURCE)

run: build
	$(QEMU) $(QEMU_FLAGS) $(OUTPUT)

clean:
	rm -f $(OUTPUT)