INCLUDE Irvine32.inc

.data
    array DWORD 10, 20, 30, 40, 50, 60    
    arraySize = ($ - array) / 4           ; number of elements in array (current position - arr address)
    msgBefore BYTE "Before swapping:", 0  ; message before swap
    msgAfter  BYTE "After swapping:", 0   ; message after swap

.code
main PROC
    mov edx, OFFSET msgBefore
    call WriteString                      ; print message
    call Crlf

    mov esi, OFFSET array
    mov ecx, arraySize

print_before:
    mov eax, [esi]                        ; load current element
    call WriteInt                         ; print element
    call Crlf
    add esi, 4                            ; move to next element
    loop print_before                     ; repeat for all elements

    mov esi, OFFSET array
    mov ecx, arraySize
    shr ecx, 1                            ; divide count by 2 (swap in pairs)

swap_loop:
    mov eax, [esi]                        ; load first element of pair
    mov ebx, [esi+4]                      ; load second element of pair
    mov [esi], ebx                        ; store second into first
    mov [esi+4], eax                      ; store first into second

    add esi, 8                            ; move to next pair
    loop swap_loop                        ; repeat for arraySize / 2 times

    mov edx, OFFSET msgAfter
    call WriteString                      ; print message
    call Crlf

    mov esi, OFFSET array
    mov ecx, arraySize

print_after:
    mov eax, [esi]                        ; load current element
    call WriteInt                         ; print element
    call Crlf
    add esi, 4                            ; move to next element
    loop print_after                      ; repeat for all elements

    exit
main ENDP

END main
