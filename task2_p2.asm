section .data
	count: dd 0

section .text
	global par

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression
par:
	push ebp
	; mov ebp, esp
	push esp 
	pop ebp

	; save ebx on stack
	push ebx

	; [ebp + 8] ; str_length	
	; save parameter str in ebx
	push dword [ebp + 12] ; str
	pop ebx


	xor ecx,ecx
loop_string:
	push dword [ebx + ecx]
	xor eax, eax
	pop eax ; eax = str[ecx]

	cmp al, 40 ; if eax = '('
	je incr

	; count--
	dec dword [count]
	jmp out

incr:
	inc dword [count] ;count++


out:
	; check if I continue looping
	inc ecx
	cmp ecx, [ebp + 8]
	jl loop_string

	; if count == 0 => correct
	cmp dword [count], 0
	je ok

	; eax = 0
	xor eax,eax
	jmp end

ok:
	; eax = 1
	push dword 1
	pop eax


end:
	pop ebx ; retreive old ebx from stack

	;leave
	push esp
	pop ebp
	pop ebp
	ret
