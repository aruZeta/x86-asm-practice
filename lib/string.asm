;;; string.asm

global reduceReadSize
global nullTerminatorToNewline

reduceReadSize:
;; Reduce the size of allocated space for a string read by the read
;; syscall to the characters actually read + null char.
;; Args: recmmend to call this after using the read syscall, else:
;;       address (where the string is stored),
;;       length (includes final null-char)
;;       eax -> number of bytes read
        mov ecx, [esp+8]
        mov edx, [esp+4]

        cmp edx, eax
        je reduceReadSizeEnd

        mov ebx, 1
        lea edi, [ecx+edx]
        lea esi, [ecx+eax]
reduceReadSizeLoop:
        dec edi
        dec esi
        mov bl, [esi]
        mov byte [edi], bl

        cmp esi, ecx
        jg reduceReadSizeLoop

        pop ebx

        add ecx, edx
        sub ecx, eax
        mov esp, ecx

        mov edx, eax

        push ecx
        push edx
        push ebx
reduceReadSizeEnd:
        ret

nullTerminatorToNewline:
;; Converts the last char of a string (better when it is a null
;; terminator).
;; Args: address (where the string is stored),
;;       length (includes final null-char)
        mov ecx, [esp+8]
        mov edx, [esp+4]
        mov byte [ecx+edx-1], 0xA

        ret
