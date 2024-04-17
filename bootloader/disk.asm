
[bits 16]
disk_load:
    push dx ; beacuse we need to use dx

    push bx
    mov bx, DISK_LOADING
    call print_msg
    pop bx

    mov ah, 0x02 ; read sector
    mov al, dh ; sector number
    mov ch, 0x00 ; cylinder number
    mov cl, 0x02 ; sector number
    mov dh, 0x00 ; head number

    int 0x13 ; call bios

    jc disk_error ; if carry flag is set, there was an error

    pop dx ; restore dx
    cmp dh, al ; compare the read sector with the requested sector
    jne sector_error ; if they are not the same, there was an error

    push bx
    mov bx, MSG_DONE
    call print_msg_nl
    pop bx

    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_msg_nl
    jmp $

sector_error:
    mov bx, SECTOR_ERROR_MSG
    call print_msg_nl
    jmp $

DISK_ERROR_MSG db "Disk error", 0
DISK_LOADING db "Loading disk...", 0
SECTOR_ERROR_MSG db "Sector error", 0