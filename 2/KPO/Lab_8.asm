        org     100h
start:
        ;Save current video mode
        mov      ah, 0fh
        ;ah - video mode, al - width of screen
        ;push     ax
        ;push     bx
        mov      [bOldMode], al
        mov      [bOldPage], bh

        ;Change video mode to 03h (Text video mode)
        ;mov ah, 00h
        ;mov al, 03h
        mov      ax, 0013h
        int 10h

        ;Set segment to draw
        push $A000
        pop es
        ;mov al, 60h
        ;mov cx, 320*200
        ;rep stosb                                                                    1

        ;Draw white strip
        ;xor di, di
        ;mov al, 0fh
        ;mov cx, 320*
        ;rep stosb

        ;Draw red strip
        ;xor di, di
        ;mov di, 320*100
        mov al, 4h
        mov cx, 320*200
        rep stosb

        mov al, 0fh
        mov di, 320*90
        mov cx, 320*20
        rep stosb


        xor bx, bx
        xor si, si



        mov ah, 0ch
        mov cx, 110
        mov dx, 0
.CrossLoop1:
        inc cx
        int 10h
        cmp cx, 131
        jne .CrossLoop1

        mov cx, 110
        inc dx
        cmp dx, 200
        jne .CrossLoop1

exit:
        mov      ax, 0c08h
        int      21h
        test     al, al
        jnz      @F
        mov      ah, 08h
        int      21h
@@:
        ;Return saved video mode
        ;pop ax
        movzx   ax, [bOldMode]
        int     10h
        mov     ah, 05h
        mov     al, [bOldPage]
        int     10h

        ret

bOldMode        db      ?
bOldPage        db      ?