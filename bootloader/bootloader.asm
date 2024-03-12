; A simple boot sector that prints "Hello!" to the screen.

mov ah, 0x0E ; BIOS teletype function

; addressing example
mov al, the_secret
int 0x10

mov al, [the_secret]    ; in real mode, this is from the start of memory, not the start
                        ; of this the program (which is 0x7C00 the start of the boot sector)
int 0x10

mov bx, the_secret  ; first load 'offset' of the_secret into bx
add bx, 0x7C00      ; add the boot sector's start address to bx
mov al, [bx]        ; load the byte at the address in bx into al
int 0x10

mov al, [0x7C1B] ; known after building and checking which offset the_secret is at
int 0x10

the_secret:
    db 'S'

loop:
    jmp loop

times 510-($-$$) db 0 ; Pad the rest of the sector with 0s. This is to make the file 512 bytes long.
                      ; The file must be 512 bytes long to be a valid boot sector.
                      ; Minus the last two bytes, which are the magic number, 0xAA55.

dw 0xAA55 ; The magic number that makes this a boot sector.