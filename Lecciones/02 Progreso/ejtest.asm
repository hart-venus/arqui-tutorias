.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    maskks db 00000001b ; 11001000x -> 0000000x
    isEven db 0
.code
    main proc
        mov al, maskks
        mov bl, 1

        test al, bl
        jnz exit

        itseven:
            mov isEven, 1

        exit:
            invoke ExitProcess, 0
    main endp

end main

