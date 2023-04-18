.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data

    max dd ?
    aux dd ?
.code


    ; stack frame
    ; ebp[4] -> numargs
    ; ebp[8] -> arg1
    ; ebp[(n*4) + 4] -> argn

    maxpila proc

        mov ebp, esp
        mov eax, [ebp+8] ; eax = max actual

        mov ecx, [ebp+4]
        ; ya quitamos un argumento,
        dec ecx
        add ebp, 12 ; dir -> numargs -> num1 -> num2 ....

        comparar:
            mov ebx, [ebp]
            add ebp, 4
            cmp eax, ebx
            jg salirCiclo
            je salirCiclo
            ; sabemos si llego aca, que eax es menor que ebx
            mov eax, ebx

            salirCiclo:
                loop comparar


           ; restaurar pila

           mov ebp, esp
           mov [ebp+4], eax
           ret
    maxpila endp

    main proc
        mov ecx, 420
        mov aux, ecx

        push 69
        push 30
        push 40
        push 72
        push 4
        call maxpila
        pop ebx

        mov ecx, [aux]

        mov eax, 1
        exit:
            invoke ExitProcess, 0
    main endp

end main
