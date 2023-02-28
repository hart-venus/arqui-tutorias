; Estructura basica de x86
; Ariel Leyva

.model small

; esta directiva indica el modelo de memoria que se va a utilizar
; https://en.wikipedia.org/wiki/X86_memory_models#Memory_models

.stack 69h ; alocamos 69h bytes de memoria para la pila

; segmentos: ds, ss, cs, es
.data
    ; empieza mi segmento de datos

    ; CONSTANTES
    sonrisa equ 1
    ; VARIABLES
    string db "Hola mundo$" ; para indicar el fin de la cadena se usa el caracter $
    newline db 0ah, 0dh, '$' ; un enter y un retorno de carro
    num db 16
    ; db -> un byte a la vez
    ; dw -> dos bytes a la vez
    ; dd -> cuatro bytes a la vez
    ; dq -> ocho bytes a la vez
    ; ...

.code ; segmento de codigo

    main: ; indica donde comienza, puede tener cualquier nombre.

        mov ax, @data ; movemos el segmento de datos a ax  ax = @data
        mov ds, ax    ; movemos el segmento de datos a ds
                      ; ds es donde se almacenan la direccion de los datos

        ; ax bx cx dx | ahal bhbl chcl dhdl
        ; las interrupciones se comunican con I/O.
        ; tienen codigos y "parametros" que esperan.
        ; la int ah=09h, 21h es la funcion de imprimir una cadena


        mov ah, 09h   ; movemos el codigo de la funcion a ah (la mitad de ax)
        ; 09h = 09d = 1001b
        mov dx, offset string ; movemos la direccion de la cadena a dx
        int 21h               ; llamamos a la funcion 21h de la bios
        ; int 21h, ah=09h
        xor dx, dx ; limpiamos dx (no es necesario)
        mov dx, offset newline
        int 21h

        ; imprimiendo un solo caracter
        mov ah, 02h
        mov dl, sonrisa
        int 21h
        ; terminamos, pero ocupamos terminar el programa
        mov ah, 76d
        int 21h

    end main ; indica el fin del archivo y donde empezar.

