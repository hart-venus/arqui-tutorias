.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword
; STRCPY script
.data
    var1 dd 0CCAAFFEEh
    var2 dd ?
.code
    main proc
        lea esi, var1
        lea edi, var2

        mov ecx, 4
        ; move ES to DS
        push es
        mov eax, ds
        mov es, eax

        ; copy 4 bytes

        ;copy:
        ;    mov al, [esi]
		;	mov [edi], al
		;	inc esi
		;	inc edi
		;loop copy

        rep movsb
        ; rep movsd
        ; rep movsw

        ; restore ES
        pop es

        invoke ExitProcess, 0
    main endp

end main

