	.file	"5.3.c"
	.text
	.globl	new_vec
	.type	new_vec, @function
new_vec:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, %rbp
	movl	$16, %edi
	call	malloc@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L1
	movq	%rbp, (%rax)
	testq	%rbp, %rbp
	jg	.L6
	movq	$0, 8(%rax)
.L1:
	movq	%rbx, %rax
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L6:
	.cfi_restore_state
	movl	$4, %esi
	movq	%rbp, %rdi
	call	calloc@PLT
	testq	%rax, %rax
	je	.L7
	movq	%rax, 8(%rbx)
	jmp	.L1
.L7:
	movq	%rbx, %rdi
	call	free@PLT
	movl	$0, %ebx
	jmp	.L1
	.cfi_endproc
.LFE18:
	.size	new_vec, .-new_vec
	.globl	get_vec_element
	.type	get_vec_element, @function
get_vec_element:
.LFB19:
	.cfi_startproc
	testq	%rsi, %rsi
	js	.L10
	cmpq	%rsi, (%rdi)
	jle	.L11
	movq	8(%rdi), %rax
	movl	(%rax,%rsi,4), %eax
	movl	%eax, (%rdx)
	movl	$1, %eax
	ret
.L10:
	movl	$0, %eax
	ret
.L11:
	movl	$0, %eax
	ret
	.cfi_endproc
.LFE19:
	.size	get_vec_element, .-get_vec_element
	.globl	vec_length
	.type	vec_length, @function
vec_length:
.LFB20:
	.cfi_startproc
	movq	(%rdi), %rax
	ret
	.cfi_endproc
.LFE20:
	.size	vec_length, .-vec_length
	.globl	combine1
	.type	combine1, @function

; vec_ptr v, data_t *dest)
; di: v, si: dest
combine1:
.LFB21:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	movq	%rdi, %r12 ; r12=v
	movq	%rsi, %rbp ; bp=dest
	movq	%fs:40, %rax ; 
	movq	%rax, 8(%rsp) ;
	xorl	%eax, %eax ; ax = 0
	movl	$0, (%rsi) ; *dest = 0;
	movl	$0, %ebx ; bx = 0 = i
	jmp	.L14
.L15:
	leaq	4(%rsp), %rdx ; dx=rsp+4
	movq	%rbx, %rsi ; si=bx=i
	movq	%r12, %rdi ; di=v
	call	get_vec_element ; 4(%rsp)=v->data[i]
	movl	4(%rsp), %eax ; ax=v->data[i]
	addl	%eax, 0(%rbp) ; *dest += v->data[i]
	addq	$1, %rbx ; bx += 1; i++
.L14:
	movq	%r12, %rdi ; di=v
	call	vec_length ; ax = v->len
	cmpq	%rbx, %rax ; bx < v->len
	jg	.L15
	movq	8(%rsp), %rax ; ax = 金丝雀
	xorq	%fs:40, %rax
	jne	.L18
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L18:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE21:
	.size	combine1, .-combine1
	.globl	a
	.data
	.align 4
	.type	a, @object
	.size	a, 4
a:
	.long	6
	.ident	"GCC: (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0"
	.section	.note.GNU-stack,"",@progbits
