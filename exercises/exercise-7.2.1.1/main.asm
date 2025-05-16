INCLUDE Irvine32.inc

.data
    mes1    BYTE "Enter the X:", 0     ; Prompt for X input
    mes2    BYTE "Enter the Y:", 0     ; Prompt for Y input
    mes3    BYTE "Result:", 0          ; Message to print before result
    vrx     DWORD 0                    ; Variable to store X
    vry     DWORD 0                    ; Variable to store Y
    rez     DWORD 0                    ; Variable to store final result

.code
main PROC
    ; Prompt and read X
    mov edx, OFFSET mes1
    call WriteString
    call ReadDec
    mov vrx, eax                       ; Store input in vrx

    ; Prompt and read Y
    mov edx, OFFSET mes2
    call WriteString
    call ReadDec
    mov vry, eax                       ; Store input in vry

    ; Compute 2 * Y
    mov eax, vry
    mov bx, 2
    mul bx                             ; EAX = vry * 2

    ; Compare X < 2 * Y
    cmp vrx, eax
    jb  con1                           ; If X < 2*Y, jump to con1

    ; ELSE branch: result = 2 * Y - 60
    mov eax, vry
    mov bx, 2
    mul bx                             ; EAX = vry * 2
    sub eax, 60                        ; EAX = 2 * Y - 60
    mov rez, eax                       ; Store result in rez
    jmp ex                             ; Skip to output

con1:
    ; IF branch: result = (X / 8) + 32 - Y
    mov eax, vrx                       ; EAX = X
    mov bx, 8
    xor edx, edx                       ; Clear EDX before division
    div bx                             ; EAX = X / 8
    add eax, 32                        ; EAX = X / 8 + 32
    sub eax, vry                       ; EAX = (X / 8 + 32) - Y
    mov rez, eax                       ; Store result in rez

ex:
    ; Output the result
    mov edx, OFFSET mes3
    call WriteString
    mov eax, rez
    call WriteInt
    call Crlf

    exit
main ENDP

END main
