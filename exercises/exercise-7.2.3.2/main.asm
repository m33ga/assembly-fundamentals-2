INCLUDE Irvine32.inc

.data
    wordArray WORD 1000, 2000, 3000, 4000, 5000   ; source 
    arraySize = ($ - wordArray) / 2              ; number of elements

    dwordArray DWORD arraySize DUP(?)            ; destination array 

    msgOriginal BYTE "Original WORD array:", 0   
    msgCopied   BYTE "Copied DWORD array:", 0    

.code
main PROC
    mov edx, OFFSET msgOriginal
    call WriteString                             
    call Crlf

    mov esi, OFFSET wordArray
    mov ecx, arraySize

print_word:
    movzx eax, WORD PTR [esi]                    ; load 16-bit value and zero-extend to 32-bit
    call WriteInt                                ; print value
    call Crlf
    add esi, 2                                    ; move to next WORD
    loop print_word                               ; repeat for all elements

    mov ecx, arraySize
    mov esi, OFFSET wordArray
    mov edi, OFFSET dwordArray

copy_loop:
    movzx eax, WORD PTR [esi]                    ; load 16-bit value into 32-bit register
    mov [edi], eax                               ; store as DWORD in destination array
    add esi, 2                                    ; move to next WORD
    add edi, 4                                    ; move to next DWORD
    loop copy_loop                                ; repeat for all elements

    mov edx, OFFSET msgCopied
    call WriteString                            
    call Crlf

    mov ecx, arraySize
    mov edi, OFFSET dwordArray

print_dword:
    mov eax, [edi]                               ; load 32-bit value
    call WriteInt                                
    call Crlf
    add edi, 4                                    ; move to next DWORD
    loop print_dword                              ; repeat for all

    exit
main ENDP

END main
