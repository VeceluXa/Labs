        org 100h
start:
        mov ah, 09h             ;Output strStart
        mov dx, strStart
        int 21h

        mov ah, 0ah             ;Input string
        mov dx, strInp
        int 21h

        mov dh, 4               ;Set bound of string
        mov al, byte [strInp+1]
        cmp al, dh              ;Compare with length
        jl @F

        mov al, [strInp+2] ;Check if strInp[1] == strInp[4]
        cmp al, [strInp+5]
        jne @F

        mov dh, '0'             ;Check if strInp[2] is digit
        mov dl, '9'
        mov al, [strInp+3]
        cmp al, dh
        jl @F
        cmp al, dl
        ja @F

        mov bh, 0
        mov bl, [strInp+1]      ;Check if strInp[L-1] is digit
        mov al, [strInp+bx]
        cmp al, dh
        jl @F
        cmp al, dl
        ja @F

        mov ah, 09h             ;Output if line is valid
        mov dx, strFinish
        int 21h


        mov ax, 0c08h
        int 21h
        test al, al
        jnz @F
        mov ah, 08h
        int 21h
@@:
        ret

strStart:
        db 'Enter string (4 <= Length <= 10):',10,13,'$'
strFinish:
        db 10, 13, 'String is valid$'
strInp:
        db 11, 0, 12 dup ($')



