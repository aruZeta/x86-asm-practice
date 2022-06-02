;;; numbers-from-0-to-9.asm

global _start

section .text
_start:

showNumbers:
        add byte [msg], 48      ; To ascii

        mov eax, 4
        mov ebx, 1
        mov ecx, msg
        mov edx, msg_len
        int 0x80

        sub byte [msg], 48      ; Back to normal

        inc byte [msg]          ; Increment the number
        cmp byte [msg], 10      ; Compare number with 10
        jl showNumbers          ; If smaller than ten, repeat

        mov eax, 1
        mov ebx, 0
        int 0x80

section .data
        msg db 0, 0xA           ; A string with a 0 and a \n
        msg_len equ $-msg
