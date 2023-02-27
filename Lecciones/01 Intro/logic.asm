.model small
.stack 100h
.data
    miLoop db "Me imprimo 10 veces - ", '$' ; 0dh = CR, 0ah = LF, '$' = fin de cadena
    endl db 0dh, 0ah, '$' ; 0dh = CR, 0ah = LF, '$' = fin de cadena

    Agana db "A es mas grande.", '$'
    Bgana db "B es mas grande.", '$'
    Iguales db "A y B son iguales.", '$'

    A db 20
    B db 25 ; cuidado con el tamanio de los numeros, 8 bits alcanzan para 255.
.code
    main proc near
        ; inicializamos el segmento de datos
        mov ax, @data
        mov ds, ax

        mov cx, 10 ; contador de repeticiones
        mov si, 30h   ; indice inicial (nuestro int i = 40h;)
        ; notese que 30h no es 0, es '0' en ascii.

        ciclo:

            mov dx, offset miLoop ; dirección de la cadena
            mov ah, 09h ; función de impresión de cadena
            int 21h     ; llamada al sistema
            ; imprimamos si
            mov ah, 02h ; función de impresión de caracter
            mov dx, si ; movemos el indice a dl
            int 21h     ; llamada al sistema
            ; imprimamos endl
            mov dx, offset endl ; dirección de la cadena
            mov ah, 09h ; función de impresión de cadena
            int 21h     ; llamada al sistema

            inc si  ; incrementamos el indice (nuestro i++)
                    ; no es necesario, pero conviene tener un indice.

        loop ciclo ; cx = cx - 1; if (cx != 0) goto ciclo;

        ; comparacion de A y B

        mov al, A
        mov bl, B
        cmp al, bl ; comparacion de A y B

        ; si A es mas grande
        jg A_grande  ; JG -> jump if greater
        je A_igual_B ; JE -> jump if equal
        jmp B_grande ; esto siempre se ejecuta si no se cumple ninguna de las otras condiciones

        ; existen otras comparaciones, como jz, jnz, jne, etc.

        ; preparandonos para imprimir
        mov ah, 09h
        A_grande:
            mov dx, offset Agana ; dirección de la cadena
            int 21h     ; llamada al sistema
            jmp fin
        A_igual_B:
            mov dx, offset Iguales ; dirección de la cadena
            int 21h     ; llamada al sistema
            jmp fin
        B_grande:
            mov dx, offset Bgana ; dirección de la cadena
            int 21h     ; llamada al sistema

        ; notese que los labels no terminan, sin los jmp fin, el programa se ejecutaria hasta el final.
        fin:
            ; terminamos el programa.
            mov ax, 4c00h
            int 21h
    endp
end main
