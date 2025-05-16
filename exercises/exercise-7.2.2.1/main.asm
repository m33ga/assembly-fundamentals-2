INCLUDE Irvine32.inc

.data
    mes1    BYTE "Enter the X:", 0     
    mes2    BYTE "Enter the Y:", 0     
    mes3    BYTE "Result:", 0          
    vrx     DWORD 0                    ; variable X
    vry     DWORD 0                    ; variable Y
    rez     DWORD 0                    ; result

.code
main PROC
    mov edx, OFFSET mes1
    call WriteString
    call ReadDec
    mov vrx, eax                       ; read X

    mov edx, OFFSET mes2
    call WriteString
    call ReadDec
    mov vry, eax                       ; read Y

    mov eax, vrx
    test eax, 1                        ; test if X is odd
    jnz odd_case                       ; jump if not zero (X is odd)

    mov eax, vry
    sub eax, vrx                       ; eax = Y - X
    mov ebx, eax
    imul eax, ebx                      ; eax = (Y - X)^2
    sub eax, 121                       ; subtract 121
    mov rez, eax                       ; store result
    jmp done                           ; jump to done

odd_case:
    mov eax, vry
    shl eax, 1                         ; eax = 2 * Y
    mov ebx, vrx
    shr ebx, 2                         ; ebx = X / 4
    add eax, ebx                       ; eax = 2 * Y + X / 4
    mov rez, eax                       ; store result

done:
    mov edx, OFFSET mes3
    call WriteString
    mov eax, rez
    call WriteInt
    call Crlf

    exit
main ENDP

END main
