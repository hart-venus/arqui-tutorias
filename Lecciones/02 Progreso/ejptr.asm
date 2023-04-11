.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
    resultado dd 32 ; eax
    var1 dw 20 ; ax
    var2 dw 12
    var3 db 3 ; al, ah
    var4 dd 0CCAAFFEEh


.code
    main proc

        mov ebx, offset var1
        lea ecx, var1 ; mismo resultado que mov ecx, offset var1
        ; byte ptr, word ptr, dword ptr, qword ptr
        finit
        fild dword ptr [var3] ; carga var1 en la pila
        mov ax, word ptr var4 ; carga 16 bits de var4 en ax
        mov bx, word ptr [var4+2] ; carga los otros 16 bits de var4 en bx
        ; ojo que aca se usa little endian, asi que ax = 0xFFEE y bx = 0xCCAA

        invoke ExitProcess, 0
    main endp

end main

