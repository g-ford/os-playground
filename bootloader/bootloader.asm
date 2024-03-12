; A simple boot sector that prints "Hello!" to the screen.
; [org 0x7C00] ; The BIOS loads the boot sector into memory at 0x7C00.

mov ah, 0x0e ;

; this wont print the secret as it is in the wrong segment
mov al, [the_secret]
int 0x10

; set the data segement to 0x7c0 (where we know the code is)
; move will by default use the ds register offset
mov bx, 0X7c0;
mov ds, bx;
mov al, [the_secret]
int 0x10

; here we are explicitly using the extra segment register, with the the_secret offset
; but we have not set the es register to 0x7c0 so it will load from 0
mov al, [es:the_secret]
int 0x10

; here we set the es register to 0x7c0 and then load the secret
mov es, bx
mov al, [es:the_secret]
int 0x10

; the rest of this will work as the data segment is set to 0x7c0

mov bx, loading     ; this is the address, not the message itself
call print_msg

mov dx , 0x1fb6 ; store the value to print in dx
call print_hex ; call the function

loop:
    jmp loop

the_secret:
    db "X"

loading:
    db 'Booting OS...', 0 ; null terminated string

%include "utils.asm"

times 510-($-$$) db 0 ; Pad the rest of the sector with 0s. This is to make the file 512 bytes long.
                      ; The file must be 512 bytes long to be a valid boot sector.
                      ; Minus the last two bytes, which are the magic number, 0xAA55.

dw 0xAA55 ; The magic number that makes this a boot sector.