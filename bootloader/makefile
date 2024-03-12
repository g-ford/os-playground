# Programs to use
NASM = nasm
NASM_FLAGS = -f bin


QEMU = qemu-system-i386
# QEMU_FLAGS = -hda


# Source file
SOURCE = bootloader.asm

# Output file
OUTPUT = bootloader.bin

all: build

build: $(SOURCE)
	$(NASM) $(NASM_FLAGS) -o $(OUTPUT) $(SOURCE)

run: build
	$(QEMU) -drive file=$(OUTPUT),format=raw,index=0,media=disk

clean:
	rm -f $(OUTPUT)