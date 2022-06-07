;;; numbers-from-0-to-99.asm

global _start

extern write
extern read
extern reduceReadSize
extern nullTerminatorToNewline
extern exit0
extern showNumbers

section .text
_start:
        push getN1Msg
        push getN1MsgLen
        call write

        mov ecx, 11
        sub esp, ecx
        push esp
        push ecx
        call read
        call reduceReadSize
        call nullTerminatorToNewline

        call showNumbers

        call exit0

section .data
        getN1Msg db "From: "
        getN1MsgLen equ $-getN1Msg
