        org 100h

start:


        mov al, [array]3                                   ;Set arr[0] as max
        mov bx, 0                                         ;Move index of the first element
        mov cx, 0                                         ;Max element's index

FindMax:
        inc bx                                            ;Increment dx

        cmp byte[array+bx], '$'                           ;Check if last element
        je Sum                                            ;Jump to Sum loop

        cmp al, byte[array + bx]                          ;Compare arr[max] and arr[bx]
        jb @F                                             ;If arr[bx] > arr[max] jmp @F

        jmp FindMax                                       ;Repeat loop1

@@:
        mov al, byte[array+bx]                            ;Set arr[bx] as max
        mov cx, bx
        jmp FindMax                                       ;Repeat loop1


Sum:
        mov bx, cx
        mov al, [array+bx+1]
        mov si, cx
        inc si

SumLoop:
        inc si

        cmp byte[array+si], '$'
        je return

        add al, byte[array+si]

        jmp SumLoop

out_res:
        mov ah, 02h
        mov dl, al
        int 21h


exit:
        mov ax, 0c08h
        int 21h
        test al, al
        jnz @F
        mov ah, 08h
        int 21h
@@:
        ret

array:
        mas db 4, 3, 8, 2, 6, 4, 2, 4, '$'