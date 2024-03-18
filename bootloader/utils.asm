[bits 16]
; Takes an address in bx and prints the string at that address
; The string must be null terminated
print:
print_msg:
    pusha
print_msg_inner:
    mov al, [bx]
    cmp al, 0
    je print_msg_return ; we hit the 0 terminator
    call print_char
    inc bx              ; move to next char
    jmp print_msg_inner ; start the loop again
print_msg_return:
    popa
    ret

print_msg_nl:
    pusha
    call print_msg
    call print_nl
    popa
    ret

print_newline:
print_nl:
    mov al, 0x0A
    call print_char
    mov al, 0x0D
    call print_char
    ret

print_char:
    ; the lower part in a register is the ASCII we want to print
    ; but we need to reset the upper bit to ensure it prints correctly each time
    mov ah, 0x0E ; BIOS teletype function
    int 0x10
    ret

; Takes a value in dx and prints it as a hex number
print_hex:
    pusha
    mov cx, 0           ; keep an index for looping

print_hex_loop:
    cmp cx, 4
    je hex_ready_to_print  ; we've printed all 4 bytes

    ; get the last 4 bits and
    ; if they are 0-9, add 0x30 to get the ASCII value
    ; if they are 10-15, add 0x37 to get the ASCII value
    mov ax, dx
    and al, 0x000F      ; get the last 4 bits
    cmp al, 0x000A      ; check if it's 10 or more
    jl hex_char
    add al, 0x0037      ; if it's 10 or more, add 0x37
    jmp update_data
hex_char:
    add al, 0x0030      ; if it's 9 or less, add 0x30
update_data:
    mov bx, HEX_OUT + 5
    sub bx, cx          ; move to the correct position in the string depending on the loop index
    mov [bx], al        ; mov the value into the destintation string
    inc cx              ; increment the loop index
    shr dx, 4           ; shift the next 4 bits into place
    jmp print_hex_loop

hex_ready_to_print:
    ; at this point HEX_OUT contains the hex value in ASCII
    mov bx, HEX_OUT
    call print_msg
    popa
    ret

HEX_OUT db "0x0000" ,0

A_REG: db "A: ", 0
B_REG: db "B: ", 0
C_REG: db "C: ", 0
D_REG: db "D: ", 0