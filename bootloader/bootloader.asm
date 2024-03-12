; A simple looping boot sector program

loop:
    jmp loop

times 510-($-$$) db 0 ; Pad the rest of the sector with 0s. This is to make the file 512 bytes long.
                      ; The file must be 512 bytes long to be a valid boot sector.
                      ; Minus the last two bytes, which are the magic number, 0xAA55.

dw 0xAA55 ; The magic number that makes this a boot sector.