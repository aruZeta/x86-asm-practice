;;; read-stdin.asm

global write

section .text
write:
;; Writes to stdout
;; Args: address (where the string is stored),
;;       length (includes final null-char or \n if there is any)
        mov eax, 4
        mov ebx, 1
        mov ecx, [esp+8]
        mov edx, [esp+4]
        int 0x80

        ret
