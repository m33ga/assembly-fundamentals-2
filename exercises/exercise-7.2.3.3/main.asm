.386
.model flat, stdcall
.stack 4096

INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD

.data
    stringBuffer BYTE 101 DUP(0)       ; Max 100 chars + null terminator
    msg BYTE "Random String: ", 0

.code
main PROC
    call Randomize

    mov ecx, 20            ; Loop 20 times
gen_loop:
    ; Set length = 10 (can be varied or randomized)
    mov eax, 10
    mov edx, OFFSET stringBuffer
    call GenerateRandomString

    ; Print label
    mov edx, OFFSET msg
    call WriteString

    ; Print generated string
    mov edx, OFFSET stringBuffer
    call WriteString
    call Crlf

    loop gen_loop

    INVOKE ExitProcess, 0
main ENDP

; -------------------------------------
; Procedure: GenerateRandomString
; EAX = length of string
; EDX = destination buffer
; -------------------------------------
GenerateRandomString PROC
    push ecx
    push eax
    mov ecx, eax            ; ECX = length

    ; EDX = destination pointer
gen_loop:
    mov eax, 26
    call RandomRange        ; EAX = 0 to 25
    add al, 'A'             ; Convert to ASCII A–Z
    mov [edx], al           ; Store in buffer
    inc edx
    loop gen_loop

    mov BYTE PTR [edx], 0   ; Null terminator
    pop eax
    pop ecx
    ret
GenerateRandomString ENDP

END main
