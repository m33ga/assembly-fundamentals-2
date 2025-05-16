INCLUDE Irvine32.inc

.data
    a DWORD 5
    b DWORD 6
    z DWORD ?
    temp1 DWORD ?
    temp2 DWORD ?
    result DWORD ?

.code
main PROC
    ;  part1 = 5 * a 
    mov eax, a
    imul eax, 5         ; EAX = 5 * a
    mov temp1, eax      ; Store part1

    ;  part2 = b / 7 
    mov eax, b
    cdq
    mov ecx, 7
    idiv ecx            ; EAX = b / 7
    mov temp2, eax      ; Store part2

    ;  numerator = part1 - part2 
    mov eax, temp1
    sub eax, temp2      ; EAX = 5 * a - b / 7
    mov temp1, eax      ; Store numerator

    ;  part3 = 3 / b 
    mov eax, 3
    cdq
    mov ecx, b
    idiv ecx            ; EAX = 3 / b
    mov temp2, eax      ; Store part3

    ;  part4 = a * a 
    mov eax, a
    imul eax, a         ; EAX = a * a

    ;  denominator = part3 + part4 
    add eax, temp2      ; EAX = 3 / b + a * a
    mov ecx, eax        ; Save denominator in ECX

    ;  z = numerator / denominator 
    mov eax, temp1      ; numerator
    cdq
    idiv ecx            ; EAX = final result
    mov z, eax

    exit
main ENDP

END main
