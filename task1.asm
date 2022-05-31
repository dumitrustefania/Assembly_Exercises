section .data
    last_pos: dd 0
    pos: dd 0
    pos_of_1: dd 0

section .text
	global sort

struc node
   val:   resd 1 
   next:  resd 1
endstruc

; int func(int x);
; @params: x -> value of searched node  
; @returns: position in array where is node with value x
func:
    push ebp
    mov ebp, esp
    push ecx ; save ecx value on stack

    mov ecx, 0
loop_array_to_find_x:
    mov edx , [esi +node_size*ecx +val] ; node[ecx].val
    cmp edx, [ebp + 8] ; if I found element, exit function
    je out

    ; check if I continue looping
    inc ecx
    cmp ecx, ebx
    jl loop_array_to_find_x

out:
    mov eax, ecx ; position of element x

    pop ecx
    leave
    ret

; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list
sort:
    push ebp
    mov ebp, esp
    
    ; save ebx, esi, edi on stack
    push ebx
    push esi
    push edi

    mov ebx, [ebp + 8]      ; n
    mov esi, [ebp + 12]     ; struct node* node

    ; search position for node with value 1
    ; using the function above
    mov ecx, 1 
    push ecx
    call func
    add esp, 4

    ; save position in global variables
    mov [last_pos], eax
    mov [pos_of_1], eax

    mov ecx, 2
    cmp ecx, ebx
    jg bye
selection_sort:
    
    ; search postition for node with value ecx (2, 3, .. n)
    push ecx 
    call func 
    add esp, 4
    
    ; save position in global variable
    mov [pos], eax

    push esi ;save esi on stack

    ; eax becomes a pointer to the start of
    ; the node on position last_pos
    mov eax, [last_pos]
    mov edi, node_size
    mul edi
    add esi, eax
    mov eax, esi

    ; retrieve and save again esi on stack
    pop esi
    push esi
    ; save eax on stack
    push eax

    ; eax becomes a pointer to the start of
    ; the node on position pos
    mov eax, [pos]
    mov edi, node_size
    mul edi
    add esi, eax
    mov eax, esi

    ; retrieve the pointer to node last_pos
    pop edx
    ; move to its field "next" and place there
    ; the pointer to node at pos
    add edx, next
    mov [edx], eax
    ; retrieve esi
    pop esi

    ; last_pos = pos
    mov eax, [pos]
    mov [last_pos], eax

    ; check if I continue looping
    inc ecx
    cmp ecx, ebx
    jle selection_sort


bye:
    ; place in return register eax a pointer
    ; to the start of the node with value 1
    mov eax, [pos_of_1]
    mov edi, node_size
    mul edi
    add esi, eax
    mov eax, esi

    ; retrieve saved registers    
    pop edi
    pop esi
    pop ebx
    
    leave
    ret

