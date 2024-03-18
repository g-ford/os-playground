; define Global Descriptor Table
; GDT tells the CPU how we want the memory laid out for 32-bit protected mode
[bits 16]
gdt_start:
    gdt_null:   dq 0        ; the mandatory null descriptor

    ; code segment descriptor
    gdt_code:   dw 0xFFFF       ; limit low bits
                dw 0            ; base low bits
                db 0            ; base middle bits
                ; 1 (present) 00 (privilege level) 1 (code/data) 1 (readable) 0 (conforming) 1 (code) 0 (accessed)
                db 10011010b    ; access and type flags
                ; 1 (granularity) 1 (32-bit) 0 (64-bit) 0 (AVL)
                db 11001111b    ; flags and limit high bits
                db 0            ; base high bits

    ; data segment descriptor
    gdt_data:   dw 0xFFFF       ; limit low bits
                dw 0            ; base low bits
                db 0            ; base middle bits
                ; 1 (present) 00 (privilege level) 1 (code/data) 0 (readable) 0 (conforming) 1 (data) 0 (accessed)
                db 10010010b    ; access and type flags
                ; 1 (granularity) 1 (32-bit) 0 (64-bit) 0 (AVL)
                db 11001111b    ; flags and limit high bits
                db 0            ; base high bits

gdt_end: ; helper for calculation lower down


; GDT Descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; size of GDT, minus 1
    dd gdt_start                ; start address of GDT

; Define some constants for the GDT segment selectors
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
