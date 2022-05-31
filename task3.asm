section .data
    p dd 0
    separator db " ,.", 10, 0
    words_pos dd 0
    l1 dd 0
    l2 dd 0

global get_words
global compare_func
global sort


section .text
    extern strtok
    extern qsort
    extern strlen
    extern strcmp

; int my_strlen(char *str) -> strlen but count no of characters
; ntil finding one of ' .,\n\0'
my_strlen:
    enter 0,0
    mov edx, [ebp + 8]

    mov eax,0
loop_strlen:
    inc eax

    cmp byte [edx], 0x20 ; space
    je out_strlen
    cmp byte [edx], 0x2e ; .
    je out_strlen
    cmp byte [edx], 0x2c ; ,
    je out_strlen
    cmp byte [edx], 0x10 ; \n
    je out_strlen
    cmp byte [edx], 0 ; \0
    je out_strlen
    
    inc edx
    jmp loop_strlen

out_strlen:
    dec eax
    leave
    ret

;; sort(char **words, int number_of_words, int size)
;  sort after length and then lexicographically using qsort
sort:
    enter 0, 0

    push compare_strings
    push dword [ebp + 16] ; size
    push dword [ebp + 12] ; number_of_words
    push dword [ebp + 8] ; words
    call qsort
    add esp, 16

    leave
    ret

compare_strings:
    enter 0,0
    ; save ebx on stack
    push ebx

    mov ebx, [ebp +8]
    push dword [ebx]
    call my_strlen
    add esp,4
    mov [l1], eax ; l1 = strlen(s1)

    mov ebx, [ebp +12]
    push dword [ebx]
    call my_strlen
    add esp,4
    mov [l2], eax ; l2 = strlen(s2)
    
    mov eax, 0
    mov ebx, [l1]
    mov ecx, [l2]
    cmp ebx, ecx
    jg swap ; if l1 > l2 => swap
    je cmp_lexicographic ; if l1 == l2 => compare lexic. 
    jmp out

cmp_lexicographic:
    mov ebx, [ebp + 8]
    mov ecx, [ebp +12]

    push dword [ecx]
    push dword [ebx]
    call strcmp ; eax = strcmp(s1, s2);
    add esp,8

    cmp eax, 0
    mov eax, 0
    jg swap ; if eax > 0 => s1 > s2 lexicog. => swap
    jmp out

swap:
    mov eax, 1 ; return 1 => swap

out:
    pop ebx ; retreieve ebx from stack
    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    enter 0, 0

    push separator
    push dword [ebp+8]    
    call strtok
    add esp, 8
    mov [p], eax ; p = strtok(s, separator);

find_words:
    jmp add_word ; add word to words array

next_word:
    push separator
    push dword 0    
    call strtok
    add esp, 8
    mov [p], eax ; p = strtok(NULL, separator);

    cmp dword [p], 0 ; while p != NULL
    jne find_words

    jmp end

add_word:
    ; we keep the word in [p]
    ; have to add it at [ebp +12]
    mov eax, [ebp + 12] ; words array
    add eax, [words_pos] ; place new word at its position
    
    mov ecx, [p]
    mov dword [eax], ecx
    
    add dword [words_pos], 4
    
    ;inapoi
    jmp next_word

end:
    leave
    ret
