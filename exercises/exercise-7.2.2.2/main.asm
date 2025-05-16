INCLUDE Irvine32.inc

.data
    mes1    BYTE "Random X: ", 0       
    mes2    BYTE "Random Y: ", 0       
    mes3    BYTE "Result: ", 0         
    vrx     DWORD ?                    ; variable X
    vry     DWORD ?                    ; variable Y
    rez     DWORD ?                    ; result

.code
main PROC
    call Randomize                     ; initialize random seed

    mov eax, 100
    call RandomRange                   ; generate random number in [0, 99]
    mov vrx, eax                       ; store in X

    mov eax, 100
    call RandomRange                   ; generate random number in [0, 99]
    mov vry, eax                       ; store in Y

    mov edx, OFFSET mes1
    call WriteString
    mov eax, vrx
    call WriteInt                      ; print X
    call Crlf

    mov edx, OFFSET mes2
    call WriteString
    mov eax, vry
    call WriteInt                      ; print Y
    call Crlf

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
    call WriteInt                      ; print result
    call Crlf

    exit
main ENDP

END main
