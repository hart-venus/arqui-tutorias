.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    maskks db 11111111b ; 11001000x -> 0000000x
    isZero db 0
.code
    main proc
        mov al, maskks
        mov bl, 0

        test al, bl
        jnz exit

        itszero:
            mov isZero, 1

        exit:
            invoke ExitProcess, 0
    main endp

end main
