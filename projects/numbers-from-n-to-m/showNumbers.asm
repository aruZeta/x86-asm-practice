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

showNumbersLoop:
        call write

        mov ecx, [esp]
        sub ecx, 2
        mov edx, [esp+4]
        inc byte [edx+ecx]

        cmp byte [edx+ecx], 58
        jl showNumbersLoop
        je showNumbersIncPrev

showNumbersEnd:
        push esi
        ret

showNumbersIncPrev:
        cmp ecx, 0
        je showNumbersEnd

        mov byte [edx+ecx], 48

        dec ecx
        inc byte [edx+ecx]
        cmp byte [edx+ecx], 58
        jl showNumbersLoop
        je showNumbersIncPrev

        ;; If this executes something bad happened ...
        push 1
        call exitN
