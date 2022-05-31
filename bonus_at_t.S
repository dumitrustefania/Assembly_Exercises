#include "positions.h"

.macro SUBB POSITION, VALUE

	movl \POSITION, %eax
	movl \VALUE, %esi

	movl $10, %edi
	mul %ecx
	div %edi  // eax = 10 * POSITION / n
	sub %esi,(%ebx,%eax,4)  // v[eax] -= VALUE

.endm

.section .text
.global add_vect

/*
 * void add_vect(int *v1, int *v2, int n, int *v)
 *
 * add v1 and v2, that have both the length n, and store the result in v3.
 * also, substract from v3 the values provided in positions.S, as described
 * in the task
 */

add_vect:
	pushl 	%ebp
	movl	%esp, %ebp
	
	// save registers on stack
	pushl 	%eax
	pushl 	%ebx
	pushl 	%ecx
	pushl 	%edx

	movl 8(%ebp), %eax // v1 
	movl 12(%ebp), %ebx // v2 
	movl 16(%ebp), %ecx // n 
	movl 20(%ebp), %edx // v

	//  make v = v1 + v2
	dec %ecx 
loop_vect:
	movl (%eax, %ecx, 4), %edi // edi = v1[ecx]
	movl %edi,(%edx,%ecx,4) // v[ecx] = edi
	movl (%ebx, %ecx,4), %edi // edi = v2[ecx]
	add %edi,(%edx,%ecx,4) // v[ecx] += edi

	// check if i continue looping
	dec %ecx
	cmp $0, %ecx
	jge loop_vect

	movl 16(%ebp), %ecx // n
	movl 20(%ebp), %ebx // v

	//  call macro for subtracting values in positions.h file
	SUBB $FIRST_POSITION, $FIRST_VALUE
	SUBB $SECOND_POSITION, $SECOND_VALUE
	SUBB $THIRD_POSITION, $THIRD_VALUE

	// retrieve values form stack
	popl %edx
	popl %ecx
	popl %ebx
	popl %eax

	leave
	ret

