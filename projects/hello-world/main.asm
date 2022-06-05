;;; hello_world.asm

global _start                   ; Stating that _start is the main function

;;; Instructions section
section .text
_start:
        mov eax, 4              ; use the write syscall
        mov ebx, 1              ; use stdout as the fd
        mov ecx, message        ; use the message as the buffer
        mov edx, message_length ; and supply the length
        int 0x80                ; invoke syscall

        ;; Exit
        mov eax, 1              ; use the exit syscall
        mov ebx, 0              ; exit succesfully
        int 0x80                ; invoke syscall

;;; Variable section
section .data
        message db "Hello World!", 0xA ; String ending in \n
        message_length equ $-message    ; Length of the string above
