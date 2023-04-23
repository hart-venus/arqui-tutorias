.global main
.extern printfa

main:
    @ load variables
    ldr r3, =decimal
    ldr r2, [r3]
    
    ldr r5, =hexadecimal
    ldr r3, [r5]

    @ add numbers
    add r1, r2, r3
    
    @ print instruction corrupts registers, we gotta save the ones we need
    ldr r0, =string
    push {r0, r2, r3}
    bl printf
    pop {r0, r2, r3}

    @ subtract numbers
    sub r1, r3, r2
    push {r0, r2, r3}
    bl printf
    pop {r0, r2, r3}

    @ multiply numbers
    mul r1, r2, r3
    push {r0, r2, r3}
    bl printf
    pop {r0, r2, r3}

    @ whole division
    sdiv r1, r2, r3
    push {r0, r2, r3}
    bl printf
    pop {r0, r2, r3}

    @ exit the program
    mov r7, #1
    mov r0, #0
    svc 0


.data 
    string: .asciz "The result is %d\n"
    decimal: .word 123
    hexadecimal: .word 0xF


