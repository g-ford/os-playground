; A simple boot sector
[org 0x7C00] ; The BIOS loads the boot sector into memory at 0x7C00.

mov [BOOT_DRIVE], dl ; Save the boot drive number

mov bx, LOADING
call print_msg_nl


; set up the stack
mov bp, 0x8000
mov sp, bp

; load the second sector of the boot drive into memory at 0x9000
; we haven't set up ES so all data will be loaded at raw addresses
mov bx, 0x9000
mov dh, 0x02 ; number of sectors to read (2 x 512 bytes)
mov dl, [BOOT_DRIVE]
call disk_load

; print the first byte of the first loaded sector
mov dx, [0x9000]
call print_hex      ; should be 0x1234
call print_nl

; print the first byte of the second loaded sector
mov dx, [0x9000 + 512]
call print_hex      ; should be 0x5678
call print_nl

jmp $ ; Infinite loop

LOADING db 'Booting OS...', 0 ; null terminated string
BOOT_DRIVE db 0

%include "utils.asm"
%include "disk.asm"

times 510-($-$$) db 0 ; Pad the rest of the sector with 0s. This is to make the file 512 bytes long.
                      ; The file must be 512 bytes long to be a valid boot sector.
                      ; Minus the last two bytes, which are the magic number, 0xAA55.

dw 0xAA55 ; The magic number that makes this a boot sector.

; the BIOS will only load the above assembly code into memory at 0x7C00 and execute it
; so we will pad out the next two sectors with known hex to test the disk_load function
; boot sector = sector 1 of cyl 0 of head 0 of hdd 0
; from now on = sector 2 ...
times 256 dw 0x1234 ; sector 2 = 512 bytes
times 256 dw 0x5678 ; sector 3 = 512 bytes
