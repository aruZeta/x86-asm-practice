;;; test.asm
;;; Testing linking other asm files

global _start

extern read
extern write
extern exit0

section .text
_start:
        sub esp, 11             ; Reserve 11 bytes for the string
        push esp                ; String address
        push 11                 ; Read max 10 chars
        call read

        ; No need to push to stack the args, reusing last args
        call write

        call exit0
