.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data

    max dd ?
.code


    maxpila proc num1:dword, num2:dword
        mov eax, num2
        cmp eax, num1

        jg exit ; if num1 > num2
        je exit  ; num1 = num2

        numUnoMasGrande:
            mov eax, num1
            mov num2, eax

        exit:
            ret 4 ; 4 bytes de retorno, el resultado queda en la pila
    maxpila endp

    main proc
        push 40
        push 30
        call maxpila


        pop eax
        mov max, eax
        exit:
            invoke ExitProcess, 0
    main endp

end main

