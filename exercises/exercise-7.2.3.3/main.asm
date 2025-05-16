INCLUDE Irvine32.inc

.data
    stringBuffer BYTE 101 DUP(0)           ; Buffer for random string (100 chars max + null)
    msgPrompt     BYTE "Enter string length (max 100): ", 0
    msg           BYTE "Random String: ", 0
    strLen        DWORD ?                  ; Length of string entered by user

.code
main PROC
    call Randomize                         ; random seed

    ; Ask user for string length
    mov edx, OFFSET msgPrompt
    call WriteString
    call ReadDec                           ; read str len into EAX
    cmp eax, 100
    jbe store_length                       ; if input  100, keep
    mov eax, 100                           ; else max at 100
store_length:
    mov strLen, eax                        ; store length in strLen

    ; Generate and print 20 random strings
    mov ecx, 20
GenLoop:
    mov eax, strLen
    mov edx, OFFSET stringBuffer
    call GenerateRandomString              ; generate random string into buffer

    mov edx, OFFSET msg
    call WriteString                       

    mov edx, OFFSET stringBuffer
    call WriteString                       ; Print generated string
    call Crlf                              ; new line

    loop GenLoop                           ; Repeat 20 times

    exit
main ENDP


; procedure: GenerateRandomString
; in:
;   EAX = string length
;   EDX = ptr to output buffer
; out:
;   null-terminated string of random AZ characters

GenerateRandomString PROC
    push ecx                               ; save current value of ECX register on stack
    push eax                               ; save current value of EAX register on stack
    mov ecx, eax                           ; ECX = length of string to generate

GenCharLoop:
    mov eax, 26
    call RandomRange                       ; EAX = random number from 0 to 25
    add al, 'A'                            ; convert to ASCII letter (A-Z)
    mov [edx], al                          ; store character in buffer
    inc edx                                ; move to next position
    loop GenCharLoop                       ; repeat ECX times

    mov BYTE PTR [edx], 0                  ; add null terminator
    pop eax
    pop ecx
    ret
GenerateRandomString ENDP

END main
