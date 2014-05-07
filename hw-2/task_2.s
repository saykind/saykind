		.data
fmt_d:	.string "%d"	
fmt_c:	.string "%c"
fmt_x:	.string "%x"
fmt_s:	.string "%s"
fmt_dn:	.string "%d\n"
fmt_xn: .string "%x\n"
fmt_sn:	.string "%s\n"
int:	.space	4	

		.bss
str_in:	.space 1024
str_out:.space 1024
str_a:	.space 1024
str_b:	.space 1024

		.text
	.globl main
	.type main, @function	
main:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp
	
	pushl	$str_in
	pushl	$fmt_s
	call scanf
	addl	$8,	%esp
	 pushl	$str_in
	 pushl	$str_a
	 call strcop
	 addl	$8,	%esp
	pushl	$str_in
	pushl	$fmt_s
	call scanf
	addl	$8,	%esp
	 pushl	$str_in
	 pushl	$str_b
	 call strcop
	 addl	$8,	%esp

	pushl	$str_a
	pushl	$str_b
	call strise
	addl	$8,	%esp
	cmp	$0,	%eax
	je	.equal
	pushl	%eax	
	.equal:
	pushl	$str_equ
	call printf
	addl	$4,	%esp
	jmp	.afterequal

#	pushl	$str_out
#	pushl	$fmt_sn
#	call printf
#	addl	$8,	%esp
	pushl	$fmt_dn
	call printf
	addl	$8,	%esp
	

	movl	$0,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret

	.type strise, @function
strise:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp

	
	subl	$0x8,	%esp		# -4(%ebp) for length_1
					# -8(%ebp) for length_2
	cld
	movl  20(%ebp),	%edi
	xorl	%eax, 	%eax		# s
	movl	$0xffffffff,	%ecx	# t
	repne	scasb			# r
	notl	%ecx			# l
	decl	%ecx			# e
	movl	%ecx,	-4(%ebp)	# n

	cld
	movl  24(%ebp),	%edi
	xorl	%eax, 	%eax		# s
	movl	$0xffffffff,	%ecx	# t
	repne	scasb			# r
	notl	%ecx			# l
	decl	%ecx			# e
	movl	%ecx,	-8(%ebp)	# n

	movl	-4(%ebp),	%ebx	
	movl	-8(%ebp),	%ecx	
	cmpl	%ebx,	%ecx	
	jge	.skip
	movl	%ebx,	%ecx
	.skip:				# ecx = max(length_1,length_2)

	inc	%ecx
	movl  20(%ebp),	%esi
	movl  24(%ebp),	%edi
	cld
	repe cmpsb

	movl	%ecx,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret


	.type strcop, @function
strcop:
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl 	%ebp
	movl	%esp,	%ebp

	movl  20(%ebp),	%esi
	movl  24(%ebp),	%edi
	xorl	%ecx,	%ecx
	
  .loop:
	lodsb	
	cmpb	$0,	%al
	je	.out
	stosb
	incl	%ecx
	jmp	.loop
  .out:
	movl	%ecx,	%eax
	movl	%ebp,	%esp
	popl	%ebp
	popl	%edx
	popl	%ecx
	popl	%ebx
	ret


