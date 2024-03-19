CC=gcc
CCFLAGS=-ffreestanding -nostdlib -lgcc -m32 -fno-pie
TARGET=linux-i686
DOCKER=docker
dc=dockcross

docker: clean
	$(DOCKER) run --rm $(dc)/$(TARGET) > ./$(dc)
	chmod +x ./$(dc)


build: test.c docker
	./$(dc) $(CC) $(CCFLAGS) -c test.c -o test.o

link: build
	./$(dc) bash -c "ld -m elf_i386 -o test.bin -Ttext 0x0 --oformat binary test.o"

dis: link
	ndisasm -b 32 test.bin > test.asm

clean:
	rm -f test.o a.out test.bin test.asm

full_clean: clean
	rm -f $(dc)
