INCLUDE Irvine32.inc

.data
    a dw 5
    b db 6
    cd db 10
    d dw 5
    f dw 6
    g db 10
    h db 11
    i db 10
    interm dw ?
    rez db ?
    msgResult BYTE "Result: ", 0

.code
main PROC
    mov eax, 0
    mov al, b              ; AL = b
    imul cd                ; AX = b * cd
    add ax, a              ; AX = a + b * cd
    sub ax, d              ; AX = a + b * cd - d
    cwd                    ; sign extend AX into DX:AX
    idiv f                 ; AX = (a + b * cd - d) / f
    mov interm, ax         ; store intermediate result
    mov al, g              ; AL = g
    imul h                 ; AX = g * h
    add ax, interm         ; AX = interm + g * h
    idiv i                 ; AL = (interm + g * h) / i
    mov rez, al            ; store final result

    ; Output the result
    mov edx, OFFSET msgResult
    call WriteString
    movzx eax, rez         ; zero-extend to avoid garbage output and make them the same size
    call WriteInt
    call Crlf
    exit
main ENDP
END main
