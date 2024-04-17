[bits 32]
boot_main:
    ; the old data segment is not correct so we need to reset it
    mov ax, DATA_SEG
    mov ds, ax      ; set the data segment to the new value
    mov es, ax      ; set the extra segment to the new value
    mov fs, ax      ; set the fs segment to the new value
    mov gs, ax      ; set the gs segment to the new value

    mov ebp, 0x90000    ; reset the stack pointer to 0x90000 (why this magic number?)
                        ; I think because it is higher than the VGA memory
    mov esp, ebp        ; set the stack pointer to base pointer

    call begin

[bits 32]
begin:
    ; messy as it writes on top of Real Mode messages
    ; but not sure how to clear the screen in 32-bit mode (yet)
    mov ebx, MSG_PROT_MODE
    call print32

    call KERNEL_OFFSET
    jmp $


MSG_PROT_MODE: db "Protected mode enabled!", 0

%include "string32.asm"