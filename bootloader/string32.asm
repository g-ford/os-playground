[bits 32]

; equ acts like a #define or a constant
VIDEO_MEMORY: equ 0xb8000
WHITE_ON_BLACK: equ 0x0F

; print a string
; this will always start in the top left of screen
; and assume that the string is null terminated
print32:
    pusha
    mov edx, VIDEO_MEMORY

print32_inner:
    mov al, [ebx]           ; Store CHAR at ebx into al
    mov ah, WHITE_ON_BLACK  ; set character style

    cmp al, 0               ; if this is the null terminator
    je print32_end

    mov [edx], ax           ; set the char and styles in what is effectivly VRAM
    inc ebx                 ; next char in EBX
    add edx, 2              ; next VRAM location - why 2?

    jmp print32_inner

print32_end:
    popa
    ret