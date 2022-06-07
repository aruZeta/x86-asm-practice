;;; showNumbers.asm

global showNumbers

extern write
extern exitN

showNumbers:
;; Writes numbers from the number stored till the all digits are 9
;; Example: number 141 will print from 141 to 999
;; Args: address (where the string is stored),
;;       length (the length of the string)
        pop esi

        mov ecx, [esp]
        mov edx, [esp+4]
        lea edi, [ecx+edx-2]

showNumbersLoop:
        call write

        inc byte [edi]
        cmp byte [edi], 58
        jl showNumbersLoop
        je showNumbersIncPrev

showNumbersEnd:
        push esi
        ret

showNumbersIncPrev:
        lea ecx, [edi]
_showNumbersIncPrev:
        cmp ecx, [esp+4]
        je showNumbersEnd

        mov byte [ecx], 48

        dec ecx
        inc byte [ecx]
        cmp byte [ecx], 58
        jl showNumbersLoop
        je _showNumbersIncPrev

        ;; If this executes something bad happened ...
        push 1
        call exitN
