;;; numbers-from-0-to-99.asm

global _start

extern write
extern exit0
extern exitN

section .text
_start:
        push msg
        push msg_len
        call showNumbersN

        call exit0

showNumbersN:
;; Writes numbers from the number stored till the all digits are 9
;; Example: number 141 will print from 141 to 999
;; Args: address (where the string is stored),
;;       length (the length of the string)
        pop esi

showNumbersNLoop:
        call write

        mov ecx, [esp]
        inc byte [msg+ecx-2]

        cmp byte [msg+ecx-2], 58
        jl showNumbersNLoop
        je showNumbersNIncPrev

showNumbersNEnd:
        push esi
        ret

showNumbersNIncPrev:
        cmp ecx, 2
        je showNumbersNEnd

        mov byte [msg+ecx-2], 48

        dec ecx
        inc byte [msg+ecx-2]
        cmp byte [msg+ecx-2], 58
        jl showNumbersNLoop
        je showNumbersNIncPrev

        ;; If this executes something bad happened ...
        push 1
        call exitN

section .data
        msg db "62", 0xA
        msg_len equ $-msg
