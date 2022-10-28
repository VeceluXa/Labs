        org 100h
start:


        mov bx, 0
        mov ch, 0                                      ;Sum of odd numbers
        mov cl, 0                                      ;Sum of even numbers
sumLoop:
        cmp byte[arr + bx], '$'                        ;if last el - exit
        je convert

        test byte[arr+bx], 00000001b                   ;Check if last byte is 1 or 0
        jnz add_odd                                    ;If 1 - odd
        jmp add_even                                   ;Else - even


add_odd:                                                ;Add odd number to the sum
        add ch, byte[arr+bx]
        inc bx
        jmp sumLoop

add_even:                                               ;Add even number to the sum
        add cl, byte[arr+bx]
        inc bx
        jmp sumLoop


convert:

        ;Move ch to bx
        mov al, ch
        cbw
        mov bx, ax

        ;Move cl to cx
        mov al, cl
        cbw
        mov cx, ax

        ;Output 'Sum of odd numbers:'
        mov ah, 09h
        mov dx, line1
        int 21h

        ;Output sum of odd numbers
        push bx
        call toDecimal                                  ;Convert odd to decimal

        ;Move to new line
        mov ah, 09h
        mov dx, newLine
        int 21h

        ;Output 'Sum of even numbers:'
        mov ah, 09h
        mov dx, line2
        int 21h

        ;Output sum of even numbers
        push cx
        call toDecimal                                  ;Convert even to decimal

        jmp exit

toDecimal:
        push ax                                         ;ah - remainder, al - division
        push cx
        push bx
        push bp

        mov bp, sp
        mov ax, [bp+10]                                  ;ax - binary to divide

        xor cx, cx

        ;bx - base of 10
        mov bx, 10
.toDec2:
        ;Divide ax by bx, move remainder to bx
        xor dx, dx
        div bx

        ;Push dx to stack to output later
        push dx
        inc cx

        test ax, ax
        jnz .toDec2

        mov ah, 02h
.toDec3:
        pop dx
        add dl, '0'
        int 21h

        loop .toDec3

.exit:
        pop bp
        pop bx
        pop cx
        pop ax
        ret 02h


exit:


        mov ax, 0c08h
        int 21h
        test al, al
        jnz @F
        mov ah, 08h
        int 21h
@@:
        ret

line1   db 'Sum of odd numbers:',13,10,'$'      ;=23
line2   db 'Sum of even numbers:',13,10,'$'     ;=30
newLine db 13,10,'$'
arr     db 1,5,2,5,6,1,2,5,1,2,4,5,4,2,6,2,'$'
odd     db 11, 0, 12 dup ('$')
even    db 11, 0, 12 dup ('$')