;;; read-stdin.asm

global read

section .text
read:
;; Reads from stdin
;; Args: address (where to store it),
;;       length (includes final null-char)
;; Returns: number of bytes read
        mov eax, 3
        mov ebx, 0
        mov ecx, [esp+8]
        mov edx, [esp+4]
        int 0x80

        mov byte [ecx+eax-1], 0x0 ; Make last char a null-char

        ret
