;;; exit.asm

global exit0
global exitN

section .text
exit0:
;; Exits with 0 (success)
        mov eax, 1
        mov ebx, 0
        int 0x80

exitN:
;; Exits with the passed code
;; Args: exit code
        mov eax, 1
        mov ebx, [esp+4]
        int 0x80
