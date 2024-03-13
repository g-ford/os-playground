; Read from DH sectors of the disk to ES:BX from drive DL
; The BIOS will move the data into ES:BX
;    mov bx, 0xA000      ; Destination address
;    mov es, bx
;    mov bx, 0x1234
; Data will be read to ES:BX which in this example is 0xA000:0x1234 which gives us 0xA1234
disk_load:
    pusha
    push dx
    push bx             ; this is where we want to write to, but also used for printing

    mov bx, DISK_LOADING_MSG
    call print_msg
    call print_hex      ; already in dx
    call print_newline

    mov ah, 0x02        ; BIOS Read Sector function
    mov al, dh          ; Number of sectors to read
    ;mov dl, 0x80       ; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
    mov dh, 0x00        ; Head 0
    mov ch, 0x00        ; Track 0
    mov cl, 0x02        ; Start at sector 2 (not the boot sector)

    pop bx              ; make sure we are moving this to the expected offset
    int 0x13            ; Call BIOS (should be read disk)
    jc read_error       ; If the carry flag is set, there was an error

    ; check if the data was read correctly
    pop dx
    cmp al, dh          ; al will hold the number of sectors actually read
    jne read_error_2

    push bx
    mov bx, DISK_READ_MSG
    call print_msg_nl
    pop bx

    popa
    ret

read_error:
    mov bx, DISK_ERROR_MSG
    call print_msg
    mov dh, ah      ; ah = error code, dl = disk drive that dropped the error
    call print_hex
    jmp $

read_error_2:
    mov bx, DISK_ERROR_MSG_2
    call print_msg
    jmp $

; strings
DISK_ERROR_MSG db "Disk read error ", 0
DISK_ERROR_MSG_2 db "Disk sectors not read correctly ", 0
DISK_LOADING_MSG db "Loading disk sectors ", 0
DISK_READ_MSG db "Finished reading ", 0

