;;; numbers-from-0-to-99.asm

global _start

extern exit0
extern showNumbers

section .text
_start:
        push msg
        push msg_len
        call showNumbers

        call exit0

section .data
        msg db "62", 0xA
        msg_len equ $-msg
