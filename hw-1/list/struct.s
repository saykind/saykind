	.file	"struct.c"
	.comm	BigGuy,41,32
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$48, %esp
	movl	%gs:20, %eax
	movl	%eax, 44(%esp)
	xorl	%eax, %eax
	leal	3(%esp), %eax
	movl	$1818324307, (%eax)
	movw	$108, 4(%eax)
	leal	3(%esp), %eax
	addl	$20, %eax
	movl	$7958338, (%eax)
	movb	$7, 43(%esp)
	movl	$0, %eax
	movl	44(%esp), %edx
	xorl	%gs:20, %edx
	je	.L3
	call	__stack_chk_fail
.L3:
	leave
	ret
