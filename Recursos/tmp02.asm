; plantilla de ensamblador DOS para el compilador TASM
.model small ; modelo de memoria pequeña

.stack 100h ; pila de 256 bytes
.data
    msg db "Hola mundo", 0dh, 0ah, "$" ; mensaje a mostrar

.code

    start proc near ; procedimiento start

        mov ax, @data ; carga el segmento de datos
        mov ds, ax ; en el registro DS

        mov ah, 9 ; función 9 de la BIOS
        mov dx, offset msg ; dirección del mensaje
        int 21h ; llamada a la BIOS

        mov ah, 4ch ; función 4ch de la BIOS
        int 21h ; llamada a la BIOS
    endp ; fin del procedimiento start

end start
