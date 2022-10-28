format  MZ ;allows multiple segments

        entry main:start ;the beginning of the program

;=========================================================================================================================================================================
segment main

c               db      10
d               db      4
e               db      3
task            db      'Task: C^2-B^3 >> E$'
message1        db      10, 13, 'Using stack: $'
message2        db      10, 13, 'Using paramenters: $'
message3        db      10, 13, 'Using global values: $'

start:

        mov     ax, cs ;updating the pointer to the data segment (because "MOV DS, CS" is not a legal 8086 instruction)
        mov     ds, ax ;real offset of the segment in which the data resides

        mov     di, task
        push    di
        call    typeProcedure

        ;=================================================================================================================================================================
        mov     di, message1
        push    di
        call    typeProcedure

        mov     di, word [c]
        push    di
        mov     di, word [d]
        push    di
        mov     di, word [e]
        push    di

        call    stackProcedure
        push    ax
        call    outputProcedure

        ;==================================================================================================================================================================
        mov     di, message2
        push    di
        call    typeProcedure

        mov     al, [c]
        mov     cl, [d]
        call    far Procedures: regProcedure
        push    ax
        call    outputProcedure

        ;==================================================================================================================================================================
        mov     di, message3
        push    di
        call    typeProcedure

        call    far Procedures: valProcedure
        push    ax
        call    outputProcedure

        mov     ah, 08h ;wait to close window on key press
        int     21h

        mov     ah, 4ch ;program terminates control to the operating system
        int     21h

stackProcedure:
        push    bp
        mov     bp, sp

        ; C^2
        mov     bl, [bp+8]
        mov     al, bl
        mul     bl
        mov     cl, al

        ; D^3
        mov     al, [bp+6]
        mov     bl, al
        mul     bl
        mul     bl

        ; C^2 - B^3
        sub     cl, al

        ; C^2 - B^3 >> E
        mov     bh, [bp+4]
        sar     cl, 3
        mov     al, cl

        pop     bp
        ret     4

typeProcedure:
        push    bp
        mov     bp, sp
        mov     dx, [bp+4]
        mov     ah, $09
        int     21h
        pop     bp
        ret     2

outputProcedure:
        push    bp
        mov     bp, sp
        mov     ax, [bp+4]

        xor      cx, cx
        mov      bx, 10
 
pushing:
        xor     dx, dx
        div     bx
        add     dl, '0'
        push    dx
        inc     cx

        test    ax, ax
        jnz     pushing
 
poping:
        pop     dx
        mov     ah, $02
        int     21h
        loop    poping
        pop     bp

        ret     2

;=========================================================================================================================================================================
segment Procedures

;outputProcedure:
        mov     dl, al
        mov     ah, $02
        add     dl, '0'
        int     21h
        retf

regProcedure:
        mov     bl, al
        mul     bl

        mov     bl, cl
        mov     cl, al
        mov     al, bl
        mul     bl
        mul     bl

        sub     cl, al
        sar     cl, 3
        mov     al, cl

        retf

valProcedure:
        mov     bl, [c]
        mov     al, bl
        mul     bl
        mov     cl, al

        mov     bl, [d]
        mov     al, bl
        mul     bl
        mul     bl

        sub     cl, al
        sar     cl, 3
        mov     al, cl
        retf