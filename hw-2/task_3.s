	.globl array
	.data
fmt_in:	.string "%lf"
fmt_out:.string	"%lg "
fmt_sum:.string "%.10lf\n"
fmt_d:	.string "%d"
a:	.double	1.2
b:	.double 2.1
	
	.bss
array:	.space 400
i:	.space 4
N:	.space 4

	.text
	.globl	main
main:
	pushl	%ebp
	movl	%esp, %ebp

	pushl	$N
	pushl	$fmt_d
	call scanf
	addl	$8,	%esp

	pushl	$array
	pushl	N
	call scan_array
	addl	$8,	%esp	

#	pushl	$array
#	pushl	N
#	call print_array
#	addl	$8,	%esp
	
	pushl	$array
	pushl	N
	call sumof_array
	pushl	$fmt_sum
	call printf
	addl	$8,	%esp
		
	movl	$0, %eax
	leave
	ret

	.globl 	scan_array
	.type 	scan_array, @function
scan_array:
	pushl	%ebp
	pushl	%eax
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%edi
	pushl	%esi
	movl	%esp,	%ebp
	
	movl 32(%ebp), 	%edi
	movl 36(%ebp), 	%esi
	movl	$0,	%ebx
.circle:
	leal	(%esi,%ebx,8),	%eax	# array(,%ebx,8), %eax
	pushl	%eax
	pushl	$fmt_in
	call scanf
	addl	$8,	%esp
	
	inc	%ebx
	cmpl	%edi,	%ebx
	jl	.circle
	
	movl	%ebp,	%esp
	popl	%esi
	popl	%edi
	popl	%edx
	popl	%ecx
	popl	%ebx
	popl	%eax
	popl	%ebp
	ret

	.globl 	print_array
	.type 	print_array, @function
print_array:
	pushl	%ebp
	pushl	%eax
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%edi
	pushl	%esi
	movl	%esp,	%ebp
	
	movl 32(%ebp), 	%edi
	movl 36(%ebp), 	%esi
	movl	$0,	%ebx
	
	finit
.cycle:
	fldl	(%esi,%ebx,8)
	subl	$8,	%esp
	fstpl	(%esp)
	pushl	$fmt_out
	call printf
	addl	$12,	%esp
	
	inc	%ebx
	cmpl	%edi,	%ebx
	jl	.cycle
	
	movl	%ebp,	%esp
	popl	%esi
	popl	%edi
	popl	%edx
	popl	%ecx
	popl	%ebx
	popl	%eax
	popl	%ebp
	ret
	
	.globl 	sumof_array
	.type 	sumof_array, @function
sumof_array:
	pushl	%ebp
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%edi
	pushl	%esi
	movl	%esp,	%ebp
	
	movl 28(%ebp), 	%edi
	movl 32(%ebp), 	%esi
	finit
	fldl	(%esi)
	movl	$1,	%ebx
.start:
	fldl	(%esi,%ebx,8)	
	faddp
	
	inc	%ebx
	cmpl	%edi,	%ebx
	jl	.start
	
	fstpl 	28(%ebp)

	movl	%ebp,	%esp
	popl	%esi
	popl	%edi
	popl	%edx
	popl	%ecx
	popl	%ebx
	popl	%ebp
	ret




