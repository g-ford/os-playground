; A simple boot sector that prints "Hello!" to the screen.

[org 0x7C00] ; The BIOS loads the boot sector into memory at 0x7C00.


mov bx, loading     ; this is the address, not the message itself
call print_msg

loop:
    jmp loop

print_msg:
    pusha
print_msg_inner:
    mov ax, [bx]
    cmp ax, 0
    je print_msg_return ; we hit the 0 terminator
    call print_char
    add bx, 1           ; move to next char
    jmp print_msg_inner ; start the loop again
print_msg_return:
    popa
    ret

print_char:
    ; the lower part in a register is the ASCII we want to print
    ; but we need to reset the upper bit to ensure it prints correctly each time
    mov ah, 0x0E ; BIOS teletype function
    int 0x10
    ret

loading:
    db 'Booting OS...', 0 ; null terminated string



times 510-($-$$) db 0 ; Pad the rest of the sector with 0s. This is to make the file 512 bytes long.
                      ; The file must be 512 bytes long to be a valid boot sector.
                      ; Minus the last two bytes, which are the magic number, 0xAA55.

dw 0xAA55 ; The magic number that makes this a boot sector.