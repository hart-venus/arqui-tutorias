.model flat,stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD ; prototipo de funcion con su argumento.
                                    ; ver mas en masm.asm
.data
; db byte -> dw word -> dd dword -> dq qword (64 bits)

.code

    ; definiendo una macro (copy paste de instrucciones)
    add_two MACRO num1, num2 ; macro y argumentos
        local hola ; ocupan definirse labels locales para que no haya error de redefinir, ya que ambos van a la misma parte del codigo.
        hola:
            mov eax, num1
            add eax, num2
    endm ; termina la macro (eax contaminado)

    ; definiendo un proc
    add_two_proc PROC num1:DWORD, num2:DWORD ; dword -> 32 bits para numeros
        hola: ; no hay problema con esto, ya que solo existen en una parte, aca.
            mov eax, num1
            add eax, num2
                    ; los argumentos fueron sacados de la pila, por lo tanto, ocupamos reajustarla
            ret 4*2 ; 4 bytes * 2 args (lo mismo que hacer pop 2 veces)
    add_two_proc endp

    main PROC

        add_two 10, 20 ; eax = 30
        add_two 30, 60

        push 10 ; segundo arg
        push 20 ; primer arg
        call add_two_proc ; step into si puede depurar esta funcion.

        ; Salir del programa
        invoke ExitProcess, 0
    main ENDP
END main
