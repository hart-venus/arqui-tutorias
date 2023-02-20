; plantilla de ensamblador, DOS 16 bits

stack segment para 'stack' ; Segmento de pila
    dw 100h dup (?) ; 100h palabras de pila
stack ends

datos segment
    ; Datos de la aplicación
    msj db 'Hola mundo', 13, 10, '$' ; 13, 10 es el código de retorno de carro y salto de línea
datos ends

code segment
    ; Código de la aplicación
    start:
        ; Inicio de la aplicación
        mov ax, datos
        mov ds, ax

        ; Hola mundo -> puedes borrarlo
        mov ah, 09h ; 09h es el código de la función de impresión de cadena
        mov dx, offset msj ; offset es la dirección de memoria de la cadena
        int 21h

        mov ax, 4c00h ; 4c00h es el código de salida de la aplicación
        int 21h
    code ends
end start ; Fin de la aplicación
