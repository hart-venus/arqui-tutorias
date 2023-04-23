@ File: hola.s
@ Description: Un programa de ejemplo en ARM

.global _start

_start:
    @ Write the message to stdout
    mov r0, #1         @ File descriptor 1: stdout
    ldr r1, =message   @ The message to write
    ldr r2, =len       @ Length of the message
    mov r7, #4         @ System call for write()
    svc 0              @ Invoke the system call

    @ Exit the program
    mov r7, #1         @ System call for exit()
    mov r0, #0         @ Return value 0
    svc 0              @ Invoke the system call

.data
message:
    .ascii "Hello, world!\n"
    len = . - message
