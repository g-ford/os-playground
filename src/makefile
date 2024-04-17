CC=gcc
CCFLAGS=-ffreestanding -nostdlib -lgcc -m32 -fno-pie
TARGET=linux-i686
DOCKER=docker
dc=dockcross

FILES=$(wildcard *.c)
OUTNAME=kernal
docker: clean
	open -a Docker
	$(DOCKER) run --rm $(dc)/$(TARGET) > ./$(dc)
	chmod +x ./$(dc)


build: $(FILES) docker
	./$(dc) $(CC) $(CCFLAGS) -c $(FILES) -o $(OUTNAME).o

link: build
	./$(dc) bash -c "ld -m elf_i386 -o $(OUTNAME).bin -Ttext 0x1000 --oformat binary $(OUTNAME).o"

dis: link
	ndisasm -b 32 $(OUTNAME).bin > $(OUTNAME).asm

clean:
	rm -f *.out *.o *.bin *.asm

full_clean: clean
	rm -f $(dc)
