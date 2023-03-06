.model small
.stack 100h

.data
    num1 dw 5 ; variable num1 de 16 bits
    num2 dw 0   ; variable num2 de 16 bits
    isnegative db 0 ; banderita de negativo (0 = no, 1 = si)

    div0msg db "no se puede dividir por 0. ", 0dh, 0ah, '$' ; mensaje de error
    overflowmsg db "resultado mayor a 16 bits. ", 0dh, 0ah, '$' ; mensaje de error

    newline db 0dh, 0ah, '$' ; salto de línea
.code

    start proc near ; procedimiento start

        mov ax, @data
        mov ds, ax

        ; 1. basicas
        inc num1 ; num1 += 1
        dec num1 ; num1 -= 1

        dec num2 ; num2 -= 1
        inc num2 ; num2 += 1

        ; 2. suma
        mov ax, num1 ; ax = num1
        add ax, num2 ; num1 += num2 (primer arg es un registro, segundo arg es una variable o un immediato)

        ; y que tal si se sale de rango? (16 bits -> 0-65535)
        jc overflow ; jump if carry, si hay carry, salta a overflow

        ; imprimir ax
        push ax
        call printNum ; llamada a la función printNum
                      ; hace un push de donde devolverá la ejecución
                      ; por lo tanto, nuestra pila es
                      ; DIR -> ARG -> BASURA -> ...
                      ; bp     bp+2   bp+4
                      ; los proc far hacen 2 pushes, uno para el segmento y otro para el offset
                      ; esto se va a repasar, no se preocupen
        ; 3. resta
        mov ax, num1 ; ax = num1
        sub ax, num2 ; num1 -= num2

                     ; y que tal si es negativo?
        jnc positive ; jump if not carry
                     ; si no salta a positive, es negative

        negative:
            mov isnegative, 1 ; banderita de negativo
        positive:

        push ax
        call printNum

        ; 4. multiplicación
        ; por ahora no consideraremos negativos
        ; proximamente veremos imul y idiv que si lo hacen
        ; otra forma de hacerlo es almacenando el signo individualmente
        ; y haciendo NEG*NEG = POS, NEG*POS = NEG, POS*POS = POS
        ; manejando el complemento a 2

        mov ax, num1 ; ax = num1
        mov bx, num2 ; bx = num2

               ; mul trabaja solo con ax como primer argumento. No se pone.
        mul bx ; dx:ax = num1 * num2 (dx valor alto, ax valor bajo)
               ; por ahora no nos molestaremos por imprimir en 32 bits asi que tiramos error si se sale de rango

        jc overflow ; jump if carry, si hay carry, salta a overflow
        push ax
        call printNum

        ; 5. división
        ; dos cosas con la división
        ; a. no se puede dividir por 0 (obvio)
        ; b. ocupas limpiar el registro dx antes de hacer la división

        xor dx, dx ; dx = 0
        mov ax, num1 ; ax = num1
        mov bx, num2 ; bx = num2
        cmp bx, 0 ; bx == 0?
        je div0 ; jump if equal, si es igual, salta a div0
        div bx ; ax = num1 / num2, dx = num1 % num2

        push ax
        call printNum

        jmp exit
        div0:
            mov ah, 09h
            mov dx, offset div0msg
            int 21h
            jmp exit
        overflow:
            mov ah, 09h
            mov dx, offset overflowmsg
            int 21h

        ; salir

        exit:
            mov ah, 4ch
            int 21h
    endp

    printNum proc near
        ; esto se va a volver a ver en la unidad de funciones
        ; 1. Sacamos el argumento de la pila
        mov bp, sp     ; se toca el bp, no el sp.
                       ; cx -> cuenta los digitos decimales
        xor cx, cx     ; cx = 0

        ; guardar num en ax
        mov ax, 2[bp] ; 2+bp
        push ax       ; guardamos ax en la pila = num

        ; imprimir si es negativo
        mov ah, [isnegative]
        cmp ah, 1
        pop ax ; recuperamos ax de la pila = num
        jne beginLoop

        esNegativo:

            push ax
            ; imprimiendo signo negativo
            mov ah, 02h
            mov dl, '-'
            int 21h

            pop ax ; recuperamos ax de la pila = num
            ; complemento a 2
            not ax
            inc ax
            ; finalmente, reseteamos la banderita
            mov [isnegative], 0

        beginLoop:
            inc cx
            ; mientras ax sea mayor a 0
            ; dividimos ax entre 10 y guardamos el residuo en al
            xor dx, dx ; dx = 0
            mov bx, 10 ; bx = 10
            div bx
            push dx ; guardamos el residuo en la pila


            cmp ax, 0
        jne beginLoop


        printLoop:
            pop dx ; sacamos el residuo de la pila
            add dl, '0' ; convertimos el residuo a ascii

            mov ah, 02h
            int 21h

        loop printLoop ; mientras cx sea mayor a 0, salta a printLoop

        fin:
            ; imprimir newline
            mov dx, offset newline
            mov ah, 09h
            int 21h
            ret 2 ; fin del proc, restaura el valor de la pila (2*n_de_argumentos) si son de 16 bits
    endp


end start
