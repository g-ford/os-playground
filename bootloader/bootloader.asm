; A simple boot sector
[bits 16]
[org 0x7C00] ; The BIOS loads the boot sector into memory at 0x7C00.
KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl ; Save the boot drive number.

mov bp, 0x9000
mov sp, bp

mov bx, MSG_SWITCH_PM
call print_msg_nl

call load_kernal

call switch_to_pm
jmp $

[bits 16]
load_kernal:
    mov bx, MSG_LOAD_KERNEL
    call print_msg_nl

    mov bx, KERNEL_OFFSET
    mov dh, 3
    mov dl, [BOOT_DRIVE]

    call disk_load
    ret

[bits 16]
switch_to_pm:

    mov bx, MSG_GDT
    call print_msg

    cli                         ; Clear all interrupts.
    lgdt [gdt_descriptor]       ; Load the global descriptor table.

    mov bx, MSG_DONE
    call print_msg_nl

    mov eax, cr0                ; Get the value of the control register 0.
    or eax, 0x1                 ; Set the first bit of the control register 0 to 1.
    mov cr0, eax                ; Write the new value of the control register 0.
    ; This is to enable protected mode. The CPU is now in 32-bit mode.

    ; use a far jump to clear the prefetch queue/pipeline
    jmp CODE_SEG:boot_main      ; Jump to the main part of the boot loader.


MSG_SWITCH_PM: db "Preparing to switch to protected mode...", 0
MSG_GDT: db "Loading GDT...", 0
MSG_DONE: db "Done!", 0
MSG_LOAD_KERNEL: db "Loading kernel...", 0
BOOT_DRIVE: db 0 ; The boot drive number will be stored here.

%include "disk.asm"
%include "utils.asm"
%include "gdt.asm"
%include "protected.asm"


times 510-($-$$) db 0 ; Pad the rest of the sector with 0s. This is to make the file 512 bytes long.
                      ; The file must be 512 bytes long to be a valid boot sector.
                      ; Minus the last two bytes, which are the magic number, 0xAA55.

dw 0xAA55 ; The magic number that makes this a boot sector.
