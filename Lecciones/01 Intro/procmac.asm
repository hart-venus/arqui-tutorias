.386
.model flat,stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD ; prototipo de funcion con su argumento.
                                    ; ver mas en masm.asm

.data


.code

    ; definiendo una macro
    add_two MACRO num1, num2 ; macro y argumentos
        mov eax, num1
        add eax, num2
    endm ; termina la macro (eax contaminado)

    ; definiendo un proc
    add_two_proc PROC num1:DWORD, num2:DWORD ; dword -> 32 bits para numeros
        mov eax, num1
        add eax, num2
                ; los argumentos fueron sacados de la pila, por lo tanto, ocupamos reajustarla
        ret 4*2 ; 4 bytes * 2 args (lo mismo que hacer pop 2 veces)
    add_two_proc endp

    main PROC

        add_two 10, 20 ; eax = 30

        push 10 ; segundo arg
        push 20 ; primer arg
        call add_two_proc

        ; Salir del programa
        invoke ExitProcess, 0
    main ENDP
END main
