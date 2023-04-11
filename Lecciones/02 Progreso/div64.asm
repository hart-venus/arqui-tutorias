.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword
; 64 bit division
.data
    var dq 1234567891234567
.code
    main proc

        mov ebx, dword ptr var+4
        mov eax, dword ptr var
        mov ecx, 5
        div64:
            xor edx, edx
            xchg eax, ebx
            div ecx
            xchg eax, ebx
            div ecx

        invoke ExitProcess, 0
    main endp

end main
