; A simple boot sector that prints "Hello!" to the screen.

[org 0x7C00] ; The BIOS loads the boot sector into memory at 0x7C00.

mov ah, 0x0E ; BIOS teletype function

mov al, [the_secret]
int 0x10

the_secret:
    db 'S'

loop:
    jmp loop

times 510-($-$$) db 0 ; Pad the rest of the sector with 0s. This is to make the file 512 bytes long.
                      ; The file must be 512 bytes long to be a valid boot sector.
                      ; Minus the last two bytes, which are the magic number, 0xAA55.

dw 0xAA55 ; The magic number that makes this a boot sector.