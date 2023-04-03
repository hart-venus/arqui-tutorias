.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    v1 dd 2.0, -3.0, 42.5, -21.0, -10.0 ; cada punto flotante ocupa 4 bytes (32 bits)
    v2 dd 4.0, -10.0, 3.45, 2.0, 1.0
    len equ 5 ; longitud de los vectores
    vecbuf dd ?
    resultado dd ?

.code

    main proc
        ; inicializar fpu
        finit
        ; cargar suma
        fldz ; carga cero

        ; inicializar punteros
        lea ebx, v1
        lea esi, v2

        ; inicializar contador
        mov ecx, len

        ciclo:
            ; cargar v1[i] en st(0)
            mov edx, [ebx]
            mov vecbuf, edx
            fld vecbuf
            ; cargar v2[i] en st(0), v1[i] en st(1)
            mov edx, [esi]
            mov vecbuf, edx
            fld vecbuf
            ; multiplicar st(0) por st(1) y hacer pop, st(0) = v1[i]*v2[i]
            fmulp
            ; sumar st(0) con st(1) y hacer pop, para que la sumatoria se acumule.
            faddp
            ; finalmente, actualizar punteros.
            add ebx, 4
            add esi, 4 ; 4 bytes despues, va al siguiente num.
        loop ciclo

        ; finalmente, cargar resultado en la variable resultado
        fst resultado
        invoke ExitProcess, 0
    main endp

end main ; fin del programa
