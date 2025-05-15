.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
    a DWORD 5
    b DWORD 6
    c1 DWORD 10
    d DWORD 5
    f DWORD 6
    g DWORD 10
    h DWORD 11
    i DWORD 10
    interm DWORD ?
    rez DWORD ?

.code
main PROC
    ; Compute b * c
    mov eax, b
    imul eax, c1      ; EAX = b * c

    ; Add a
    add eax, a       ; EAX = a + b * c

    ; Subtract d
    sub eax, d       ; EAX = a + b * c - d

    ; Divide by f
    cdq              ; Sign-extend into EDX:EAX
    idiv f           ; EAX = (a + b * c - d) / f
    mov interm, eax  ; Save intermediate result

    ; Compute g * h
    mov eax, g
    imul eax, h      ; EAX = g * h

    ; Add intermediate result
    add eax, interm

    ; Divide by i
    cdq
    idiv i           ; EAX = final result
    mov rez, eax     ; Store result

    INVOKE ExitProcess, eax
main ENDP

END main
