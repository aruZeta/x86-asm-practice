;;; numbers-from-0-to-99.asm

global _start

extern write
extern exit0

section .text
_start:
        push msg
        push msg_len
        call showNumbers

        call exit0

showNumbers:
;; Writes the even numbers from 0 to 99
;; Args: address (where the string is stored),
;;       length (the length of the string)
        pop esi
        call write
        push esi

        add byte [msg+1], 2
        cmp byte [msg+1], 56
        je showNumbersIncTens
        jl showNumbers

        ret

showNumbersIncTens:
        pop esi
        call write
        push esi

        inc byte [msg]
        mov byte [msg+1], 48
        cmp byte [msg], 57
        jle showNumbers

        ret

section .data
        msg db "00", 0xA
        msg_len equ $-msg
