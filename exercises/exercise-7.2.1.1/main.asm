.386
.model flat, stdcall
.stack 4096

INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD

.data
    mes1    BYTE "Enter the X:", 0
    mes2    BYTE "Enter the Y:", 0
    mes3    BYTE "Result:", 0
    vrx     DWORD 0
    vry     DWORD 0
    rez     DWORD 0

.code
main PROC
    ; Prompt for X
    mov edx, OFFSET mes1
    call WriteString
    call ReadDec
    mov vrx, eax

    ; Prompt for Y
    mov edx, OFFSET mes2
    call WriteString
    call ReadDec
    mov vry, eax

    ; Perform comparison and calculation
    mov eax, vry
    mov bx, 2
    mul bx                   ; EAX = vry * 2
    cmp vrx, eax
    jb  con1                 ; if vrx < vry*2, jump to con1

    ; Else branch
    mov eax, vry
    mov bx, 2
    mul bx                   ; EAX = vry * 2
    sub eax, 60
    mov rez, eax
    jmp ex

con1:
    mov eax, vrx
    mov bx, 8
    xor edx, edx             ; Clear EDX before division
    div bx                   ; EAX = vrx / 8
    add eax, 32
    sub eax, vry
    mov rez, eax

ex:
    mov edx, OFFSET mes3
    call WriteString
    mov eax, rez
    call WriteInt
    call Crlf

    INVOKE ExitProcess, 0
main ENDP

END main
