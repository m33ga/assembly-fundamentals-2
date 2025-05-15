.386
.model flat, stdcall
.stack 4096

.data
	alfa WORD 3 DUP(?)

.code
main proc
	mov ax,17
	mov ax,10101b
	mov ax,11b
	mov ax,21o
	mov ebx,offset alfa
	mov alfa,ax
	mov cx,ax ; exchange of the contents of the AX and BX registers
	mov ax,bx ; use cx
	mov ax,cx
	xchg ax,bx
	mov esi,2
	mov alfa[esi],ax
	mov ebx,offset alfa
	lea ebx,alfa
	mov esi,2
	mov cx,[ebx][esi]
	mov cx,alfa[2]
	mov cx,[alfa+2]
	mov edi,4
	mov byte ptr [ebx][edi],55h
	mov esi,2
	mov ebx,3
	mov alfa[ebx][esi],33h
	mov alfa[ebx+esi],33h
	mov [alfa+ebx+esi],33h
	mov [ebx][esi]+alfa,33h
	ret
main ENDP
END main