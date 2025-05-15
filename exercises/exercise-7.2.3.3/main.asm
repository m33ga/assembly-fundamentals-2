.386
.model flat, stdcall
.stack 4096

INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD

.data
    stringBuffer BYTE 101 DUP(0)       ; Max 100 chars + null terminator
    msgPrompt BYTE "Enter string length (max 100): ", 0
    msg BYTE "Random String: ", 0
    strLen DWORD ?

.code
main PROC
    call Randomize

    ; Prompt for string length
    mov edx, OFFSET msgPrompt
    call WriteString
    call ReadDec            ; EAX = user input
    cmp eax, 100
    jbe store_length
    mov eax, 100            ; Cap at 100
store_length:
    mov strLen, eax

    ; Generate 20 strings of that length
    mov ecx, 20
GenLoop:
    mov eax, strLen
    mov edx, OFFSET stringBuffer
    call GenerateRandomString

    ; Print label
    mov edx, OFFSET msg
    call WriteString

    ; Print generated string
    mov edx, OFFSET stringBuffer
    call WriteString
    call Crlf

    loop GenLoop

    INVOKE ExitProcess, 0
main ENDP

; -------------------------------------
; Procedure: GenerateRandomString
; EAX = length of string
; EDX = destination buffer
; Output: null-terminated random A–Z string
; -------------------------------------
GenerateRandomString PROC
    push ecx
    push eax
    mov ecx, eax            ; ECX = length

GenCharLoop:
    mov eax, 26
    call RandomRange        ; EAX = 0..25
    add al, 'A'             ; Convert to ASCII A–Z
    mov [edx], al
    inc edx
    loop GenCharLoop

    mov BYTE PTR [edx], 0   ; Null terminator
    pop eax
    pop ecx
    ret
GenerateRandomString ENDP

END main
