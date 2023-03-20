; Introduccion a aritmetrica FPU
; Further reading: https://docs.oracle.com/cd/E18752_01/html/817-5477/eoizy.html

.386
.model flat,stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
    float1      dq 42.360
    float2      dq 27.040
    float3      dq -10.0
    float4      dq 1.0
    intprueba  dw 16

.code
    main PROC
        ; la FPU tiene muchas instrucciones, este codigo es mas para que
        ; vean la sintaxis general y como trabajar con los registros ST.
        ; la FPU corre bajo pila estricta, lo cual significa que LIFO es obligatorio
        ; aunque igual se pueden manejar como si fueran registros con la mayoria de instrucciones.

        ; recomiendo tener en depuracion los registros FPU,
        ; click derecho en registers -> Floating Point para Visual Studio.

        finit ; reinicia la FPU
        ; 1. aritmetrica basica con FPU
        fld float1 ; fld -> float load -> carga un numero en la pila exclusiva de FPU
                      ; ST(0) -> top, ST(i) -> i-esimo elemento hasta 7

        fld float2      ; ST(0) = float2, ST(1) = floatprueba

        ; notese que fld no acepta valores immediatos, cualquier "numero magico"
        ; que carguen ocupa estar definido en el segmento de datos como dd o dq.
        ; fld 6.9 <- no compila

        fsub float1 ; por defecto, le subtrae float a ST(0).
                   ; toda la aritmetrica se hace entre una variable y ST(0), o entre ST(i) y ST(0).

                   ; siempre que vean un P al final de la instruccion, hace pop.
                   ; para guardar un numero flotante, hacer fst/fstp si se ocupa hacer pop
        fstp float4 ; float4 = ST(0), ST(0) = ST(1)

        ; 2. artimetrica int-float
        finit              ; reiniciar
        fld float4
        fild intprueba     ; carga un int en ST(0) float int load
        fdiv ST(0), ST(1) ; divide intprueba por float4, ST(1) queda igual, ST(0) modificado!
        fistp intprueba    ; conviritiendolo de nuevo a int, pierdo decimales.

        ; 3. cargando numeros notables
        ; la FPU tiene una serie de instrucciones para cargar numeros
        ; especificos a ST(0).

        ; menciones honorables
        fld1 ; carga 1
        fldpi ; carga 3.141592...

        ; 4. calculando numero aureo
        fstp st(0) ; manera de hacer pop rapida sin corromper registros ni variables
        fstp st(0)
        fstp st(0) ; limpiando stack sin finit

        fld1   ; st(0) = 1
        mov [intprueba], 5
        fild intprueba ; st(1) = 1, st(0) = 5
        fsqrt         ; st(1) = 1, st(0) = sqrt(5)
        faddp st(1), st(0) ; st(1) = st(1)+st(0), st(0) = st(1)

        mov [intprueba], 2
        fild intprueba ; st(0) = 2, st(1) = 1+sqrt(5)
        fdivp st(1), st(0) ; st(1) = st(1)/st(0), st(0) = st(1)

        fstp float4 ; float4 = phi, st(0) = 0
        ; 5. x^2
        mov [intprueba], -5
        fild intprueba
        fmul st(0), st(0)
        fistp intprueba

        ; 6. comparando dos numeros (probando PI > 3)
        mov [intprueba], 3
        fild intprueba
        fldpi ; pi = st0, 3 = st1
        fcomip st(0), st(1) ; compara st0 con st1
        ja piGreater ; jump if above
        je piEqual   ; jump if equals
        jmp piLesser ; si no esta encima, y no es igual, es menos.

        piGreater:
            mov [intprueba], 1
            jmp exit ; necesario si no le cae al siguiente
        piEqual:
            mov [intprueba], 0
            jmp exit
        piLesser:
            mov [intprueba], -1

        exit:
            invoke ExitProcess, 0 ; Salir del programa
        ; estas no son todas las instrucciones FPU, hay bastantes mas,
        ; tan, cos, fxch, etc..
    main ENDP
END main
