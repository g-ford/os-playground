[bits 32]

boot_main:
    ;cli     ; disable interrupts (for now)

    ; the old data segment is not correct so we need to reset it
    mov ax, DATA_SEG
    mov ds, ax      ; set the data segment to the new value
    mov es, ax      ; set the extra segment to the new value
    mov fs, ax      ; set the fs segment to the new value
    mov gs, ax      ; set the gs segment to the new value

    mov ebp, 0x90000    ; set the stack pointer to 0x90000 (why this magic number?)
    mov esp, ebp        ; set the stack pointer to base pointer

    call begin


begin:
    MSG_PROT_MODE db "Protected mode enabled!", 0
    mov ebx, MSG_PROT_MODE
    call print32

    jmp $

%include "string32.asm"