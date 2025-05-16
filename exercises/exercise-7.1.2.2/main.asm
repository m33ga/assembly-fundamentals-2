INCLUDE Irvine32.inc

.data
    a DWORD 5
    b DWORD 6
    z DWORD ?
    temp1 DWORD ?
    temp2 DWORD ?
    msgResult BYTE "Result: ", 0

.code
main PROC
    mov eax, a              ; EAX = a
    imul eax, 5             ; EAX = 5 * a
    mov temp1, eax          ; store in temp1

    mov eax, b              ; EAX = b
    cdq                     ; extend EAX into EDX:EAX
    mov ecx, 7              ; Divisor = 7
    idiv ecx                ; EAX = b / 7
    mov temp2, eax          ; store in temp2

    mov eax, temp1          ; EAX = part1
    sub eax, temp2          ; EAX = part1 - part2
    mov temp1, eax          ; numerator in temp1

    mov eax, 3              ; EAX = 3
    cdq                     ; extend
    mov ecx, b              ; ECX = b
    idiv ecx                ; EAX = 3 / b
    mov temp2, eax          ; part3 in temp2

    mov eax, a              ; EAX = a
    imul eax, a             ; EAX = a * a

    add eax, temp2          ; EAX = part3 + part4
    mov ecx, eax            ; save denominator in ECX

    mov eax, temp1          ; EAX = numerator
    cdq                     ; extend for division
    idiv ecx                ; EAX = numerator / denominator
    mov z, eax              ; result in z


    mov edx, OFFSET msgResult
    call WriteString
    mov eax, z
    call WriteInt
    call Crlf

    exit
main ENDP
END main
