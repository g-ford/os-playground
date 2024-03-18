; A simple boot sector
[org 0x7C00] ; The BIOS loads the boot sector into memory at 0x7C00.

mov bp, 0x9000        ; Set the stack pointer to 0x9000.
mov sp, bp            ; Set the stack pointer to 0x9000.

mov bx, MSG
call print_msg_nl

call switch_to_pm
jmp $

switch_to_pm:

    mov bx, MSG_GDT
    call print_msg

    cli                         ; Clear all interrupts.
    lgdt [gdt_descriptor]       ; Load the global descriptor table.

    mov bx, MSG_GDT_LOADED
    call print_msg_nl

    mov eax, cr0                ; Get the value of the control register 0.
    or eax, 0x1                 ; Set the first bit of the control register 0 to 1.
    mov cr0, eax                ; Write the new value of the control register 0.
    ; This is to enable protected mode. The CPU is now in 32-bit mode.

    ; use a far jump to clear the prefetch queue/pipeline
    jmp CODE_SEG:boot_main      ; Jump to the main part of the boot loader.


MSG: db "Preparing to switch to protected mode...", 0
MSG_GDT: db "Loading GDT...", 0
MSG_GDT_LOADED: db "Done!", 0

%include "utils.asm"
%include "gdt.asm"
%include "protected.asm"

times 510-($-$$) db 0 ; Pad the rest of the sector with 0s. This is to make the file 512 bytes long.
                      ; The file must be 512 bytes long to be a valid boot sector.
                      ; Minus the last two bytes, which are the magic number, 0xAA55.

dw 0xAA55 ; The magic number that makes this a boot sector.
