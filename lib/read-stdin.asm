;;; read-stdin.asm

global read
global write

section .text
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
