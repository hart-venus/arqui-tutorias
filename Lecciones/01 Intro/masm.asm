.386
.model flat,stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD
GetStdHandle PROTO, nStdHandle:DWORD
WriteConsoleA PROTO, \
    hConsoleOutput:DWORD, \
    lpBuffer:PTR BYTE, \
    nNumberOfCharsToWrite:DWORD, \
    lpNumberOfCharsWritten:PTR DWORD, \
    lpReserved:DWORD

.data
    HelloWorld DB 'Hola Mundo!', 0
    BytesWritten DD 0  ; Declarar un DWORD para almacenar el número de caracteres escritos

.code
    main PROC
        ; Obtener la salida estándar (STDOUT)
        invoke GetStdHandle, -11
        mov ebx, eax ; ebx = STDOUT

        ; Escribir la cadena "Hola Mundo!" en la salida estándar
        invoke WriteConsoleA, ebx, OFFSET HelloWorld, 11, ADDR BytesWritten, 0

        ; Salir del programa
        invoke ExitProcess, 0
    main ENDP
END main
