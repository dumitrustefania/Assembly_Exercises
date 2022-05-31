section .text
	global cpu_manufact_id
	global features
	global l2_cache_info

;; void cpu_manufact_id(char *id_string);
;
;  reads the manufacturer id string from cpuid and stores it in id_string
cpu_manufact_id:
	enter 	0, 0
	push ebx
	push ecx
	push edx

	mov eax, 0
	cpuid

	; move string with vendor name to the address at eax
	mov eax, [ebp + 8]
	mov [eax], ebx
	mov [eax + 4], edx
	mov [eax + 8], ecx

	pop edx
	pop ecx
	pop ebx
	leave
	ret

;; void features(int *apic, int *rdrand, int *mpx, int *svm)
;
;  checks whether apic, rdrand and mpx / svm are supported by the CPU
;  MPX should be checked only for Intel CPUs; otherwise, the mpx variable
;  should have the value -1
;  SVM should be checked only for AMD CPUs; otherwise, the svm variable
;  should have the value -1
features:
	enter 	0, 0
	push ebx
	push ecx
	push edx

	; initialise values
	mov eax, [ebp + 8]
	mov dword [eax], 0 ; apic = 0
	mov eax, [ebp + 12]
	mov dword [eax], 0 ; rdrand = 0
	mov eax, [ebp + 16]
	mov dword [eax], -1 ; mpx = -1
	mov eax, [ebp + 20]
	mov dword [eax], -1 ; svm = -1
	
	mov eax, 0
	cpuid
	push ebx ; to save procesor name

	mov eax, 1
	cpuid

check_apic:
	; apic = 1 => edx[9] = 1
	shr edx, 9
	and edx, 1
	cmp edx, 1
	je is_apic

check_rdrand:
	;rdrand = 1 =>  ecx[30] = 1
	mov edx, ecx
	shr edx, 30
	and edx, 1
	cmp edx, 1
	je is_rdrand

check_mpx: 
	pop ebx
	; PRINTF32 `%x\x0`, ebx
	cmp ebx, 0x68747541 ; check if it is amd procesor
	je check_svm

	mov eax, 7
	mov ecx, 0
	cpuid
	;mpx = 1 = > ebx[14] = 1
	mov edx, ebx
	shr edx, 14
	and edx, 1
	cmp edx, 1
	je is_mpx
	jne is_not_mpx
	
check_svm:
	mov eax, 80000001h
	cpuid
	;svm = 1 => ecx[2] = 1
	mov edx, ecx
	shr edx, 2
	and edx, 1
	cmp edx, 1
	je is_svm
	jne is_not_svm

is_apic:
	mov eax, [ebp + 8]
	mov dword [eax], 1 ; apic = 1
	jmp check_rdrand

is_rdrand:
	mov eax, [ebp + 12]
	mov dword [eax], 1 ; rdrand = 1
	jmp check_mpx

is_mpx:
	mov eax, [ebp + 16]
	mov dword [eax], 1 ; mpx = 1
	jmp end

is_not_mpx:
	mov eax, [ebp + 16]
	mov dword [eax], 0 ; mpx = 0
	jmp end

is_svm:
	mov eax, [ebp + 20]
	mov dword [eax], 1 ; svm = 1
	jmp end

is_not_svm:
	mov eax, [ebp + 20]
	mov dword [eax], 0 ; svm = 0
	jmp end

end:
	pop edx
	pop ecx
	pop ebx
	leave
	ret

;; void l2_cache_info(int *line_size, int *cache_size)
;
;  reads from cpuid the cache line size, and total cache size for the current
;  cpu, and stores them in the corresponding parameters
l2_cache_info:
	enter 	0, 0
	push ebx
	push ecx
	push edx

	mov eax, 0x80000006
	cpuid

	; cache line size => ecx[7-0]
	mov edx, ecx
	mov ebx, 0xff ; mask 00...0011111111
	and ebx, edx ; ebx = cache line size

	mov edx, [ebp + 8]
	mov [edx], ebx

	; cache size => ecx[31-16]
	mov edx, ecx
	shr edx, 16 ; so info is stored in [15 - 0]
	mov ebx, 0xffff ; mask 00..00 * 16 + 11..11 * 16
	and ebx, edx ; ebx = cache size

	mov edx, [ebp + 12]
	mov [edx], ebx

	pop edx
	pop ecx
	pop ebx
	leave
	ret
