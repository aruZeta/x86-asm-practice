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
;; Writes numbers from 0 to 99
;; Args: address (where the string is stored),
;;       length (the length of the string)
        pop esi                 ; So write uses the passed args
        call write              ; we remove the instruction pointer
        push esi                ; and then get it back

        inc byte [msg+1]        ; Increment the units
        cmp byte [msg+1], 57    ; Compare units with 9
        je showNumbersIncTens   ; If equal to 9 show and then increase tens
        jl showNumbers          ; If less show and then increase units

        ret

showNumbersIncTens:
        pop esi                 ; So write uses the passed args
        call write              ; we remove the instruction pointer
        push esi                ; and then get it back

        inc byte [msg]          ; Increment the tens
        mov byte [msg+1], 48    ; Make the units 0
        cmp byte [msg], 57      ; Compare tens with 9
        jle showNumbers         ; If less or equal show and increase units

        ret                     ; Else we have reached "100"

section .data
        msg db "00", 0xA           ; A string with 2 digits and a \n
        msg_len equ $-msg
