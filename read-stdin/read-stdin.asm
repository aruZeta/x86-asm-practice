;;; read-stdin.asm

global _start

section .text
_start:
        sub esp, 11             ; Reserve 11 bytes for the string
        push esp                ; String address
        push 11                 ; Read max 10 chars
        call read

        ; No need to push to stack the args, reusing last args
        call write

        call exit0

read:
;; Reads from stdin
;; Args: address (where to store it),
;;       length (includes final null-char)
        mov eax, 3
        mov ebx, 0
        mov ecx, [esp+8]
        mov edx, [esp+4]
        int 0x80

        mov byte [ecx+eax-1], 0x0 ; Make last char a null-char

        ret

write:
;; Writes to stdout
;; Args: address (where the string is stored),
;;       length (includes final null-char)
        mov eax, 4
        mov ebx, 1
        mov ecx, [esp+8]
        mov edx, [esp+4]
        int 0x80

        ret

exit0:
;; Exits with 0 (success)
        mov eax, 1
        mov ebx, 0
        int 0x80
