;;; numbers-from-0-to-9.asm

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
;; Writes numbers from 0 to 9
;; Args: address (where the string is stored),
;;       length (the length of the string)
        pop esi                 ; So write uses the passed args
        call write              ; we remove the instruction pointer
        push esi                ; and then get it back

        inc byte [msg]          ; Increment the number
        cmp byte [msg], 58      ; Compare number with 10
        jl showNumbers          ; If smaller than ten, repeat

        ret

section .data
        msg db 48, 0xA           ; A string with a 0 (in ascii) and a \n
        msg_len equ $-msg
