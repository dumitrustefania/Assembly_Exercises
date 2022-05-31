section .text
	global cmmmc

;; int cmmmc(int a, int b)
;
;; calculate least common multiple for 2 numbers, a and b
cmmmc:
	push ebp
	; mov ebp, esp
	push esp 
	pop ebp

	; save ebx on stack
	push ebx 

	; save parameters a and b in eax and ebx
	push dword [ebp + 8] ; a
	pop eax
	push dword [ebp + 12] ; b
	pop ebx

	; if eax = ebx, we know that cmmdc = eax
	cmp eax, ebx
	je cmmdc

; compute cmmdc(a,b) by subtraction
while_loop:
	cmp eax, ebx
	jg greater

	sub ebx, eax
	jmp check

greater:
	sub eax, ebx

check:
	cmp eax, ebx
	jne while_loop

cmmdc:
	; save cmmdc on stack
	push eax
	
	; save parameters a and b in eax and ebx
	push dword [ebp + 8]
	pop eax
	push dword [ebp + 12]
	pop ebx

	mul ebx ; eax = eax * ebx = a*b
	pop ebx ; ebx = cmmdc(a,b)
	div ebx ; eax = eax/ebx = a*b/cmmdc(a,b)

	pop ebx ; retreive old ebx from stack
	
	;leave
	push esp
	pop ebp
	pop ebp
	ret
