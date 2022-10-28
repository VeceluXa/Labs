        org 100h

start:
        mov ah, 01h                     ;Read char, put in AL
        int 21h

        mov bx, 0
        mov di, arr                     ;Put array's pointer in di


changeLoop:
        cmp byte[di], '$'
        je exit

        repne scasb                     ;Iterate through address till al is found
        jnz exit                        ;If not found exit
        dec di
        mov byte [di], '0'

        jmp changeLoop

exit:

        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ax, 0c08h
        int 21h
        test al, al
        jnz @F
        mov ah, 08h
        int 21h
@@:
        ret

newLine db 13, 10
arr     db 'ABCDABCD$'