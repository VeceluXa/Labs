        org     100h
Start:  
        mov     ah, 0Ah                  ;Input string length 10
        mov     dx, bufInp
        int     21h

        mov     ah, 09h                  ;New line
        mov     dx, NewLine
        int     21h

        mov     ch, byte [bufInp+3]      ;Swap s1 and s2
        mov     cl, byte [bufInp+2]
        mov     [bufInp+2], ch
        mov     [bufInp+3], cl

        mov     ch, byte [bufInp+2+4]    ;Calculate changes to s7
        add     ch, byte [bufInp+2+5]
        sub     ch, byte [bufInp+2+8]

        mov     [bufInp+8], ch           ;Move changes to S7

        mov     ah, 09h                  ;Output line
        mov     dx, bufInp+2
        int     21h

        mov     dx, bufInp+2

        mov     ah, 08h                  ;Wait
        int     21h

        ret

bufInp  db      10, 0, 10 dup (?)
NewLine db      10, 13, '$'
Result  db      ?


