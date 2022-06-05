;;; hello_world.asm

global _start                   ; Stating that _start is the main function

extern write
extern exit0

;;; Instructions section
section .text
_start:
        push message        ; use the message as the buffer
        push message_length ; and supply the length
        call write

        call exit0

;;; Variable section
section .data
        message db "Hello World!", 0xA ; String ending in \n
        message_length equ $-message    ; Length of the string above
