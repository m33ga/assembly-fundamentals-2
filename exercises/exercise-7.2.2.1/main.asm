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

    ; Check if X is even or odd
    mov eax, vrx
    test eax, 1
    jnz odd_case           ; Jump if X is odd

    ; === EVEN CASE: Z = (Y - X)^2 - 121 ===
    mov eax, vry
    sub eax, vrx           ; eax = Y - X
    mov ebx, eax
    imul eax, ebx          ; eax = (Y - X)^2
    sub eax, 121
    mov rez, eax
    jmp done

odd_case:
    ; === ODD CASE: Z = 2*Y + X/4 ===
    mov eax, vry
    shl eax, 1             ; eax = 2*Y
    mov ebx, vrx
    shr ebx, 2             ; ebx = X / 4
    add eax, ebx
    mov rez, eax

done:
    ; Output Result
    mov edx, OFFSET mes3
    call WriteString
    mov eax, rez
    call WriteInt
    call Crlf

    INVOKE ExitProcess, 0
main ENDP

END main
