.386
.model flat,stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
    x dd 4.0
    y dd 12.0
    resultado dd 0.0

.code
    main proc    ; implementa x^y como 2^(y*log2(x))
        fld y
        fld x
        fyl2x    ; y * log2(x) = st(0)
        fld1      ; y * log2(x) = st(1), 1=st(0)
        fld st(1) ; y*log2(x) = st(0) = st(2), 1=st(1)
        fprem    ; f2xm1 se calcula por resto parcial.
        f2xm1    ; st(0) = 2^st(0) - 1
        faddp st(1),st(0) ; andaiendole de vuelta el 1, resultado se guarda en st(0).
        fscale            ; st(0) *= 2^st(1), deshaciendo el fprem
        fstp resultado    ; guarda st(0).

        invoke ExitProcess, 0
    main endp
end main
