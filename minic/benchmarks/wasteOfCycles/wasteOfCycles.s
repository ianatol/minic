	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_function               @ -- Begin function _function
	.p2align	2
	.type	_function,%function
	.code	32                      @ @_function
_function:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#24
	sub	sp, sp, #24
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	cmp	r0, #0
	bgt	.LBB0_2
@ %bb.1:
	ldr	r0, .LCPI0_0
	str	r0, [r11, #-4]
	b	.LBB0_6
.LBB0_2:
	ldr	r0, .LCPI0_0
	str	r0, [sp, #12]
.LBB0_3:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #12]
	ldr	r1, [r11, #-8]
	ldr	r2, [r11, #-8]
	mul	r1, r1, r2
	cmp	r0, r1
	bge	.LBB0_5
@ %bb.4:                                @   in Loop: Header=BB0_3 Depth=1
	ldr	r0, .LCPI0_1
	ldr	r1, [sp, #12]
	ldr	r2, [r11, #-8]
	add	r1, r1, r2
	str	r1, [sp, #8]
	ldr	r1, [sp, #8]
	bl	printf
	ldr	r1, [sp, #12]
	add	r1, r1, #1
	str	r1, [sp, #12]
	str	r0, [sp, #4]            @ 4-byte Spill
	b	.LBB0_3
.LBB0_5:
	ldr	r0, [r11, #-8]
	sub	r0, r0, #1
	bl	_function
	str	r0, [r11, #-4]
.LBB0_6:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.7:
.LCPI0_0:
	.long	0                       @ 0x0
.LCPI0_1:
	.long	.L.str
.Lfunc_end0:
	.size	_function, .Lfunc_end0-_function
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_main                   @ -- Begin function _main
	.p2align	2
	.type	_main,%function
	.code	32                      @ @_main
_main:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r0, .LCPI1_2
	sub	r1, r11, #4
	bl	__isoc99_scanf
	ldr	r1, [r11, #-4]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	bl	_function
	ldr	r1, .LCPI1_1
	ldr	lr, .LCPI1_0
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI1_0
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI1_0:
	.long	0                       @ 0x0
.LCPI1_1:
	.long	.L.str.2
.LCPI1_2:
	.long	.L.str.1
.Lfunc_end1:
	.size	_main, .Lfunc_end1-_main
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	main                    @ -- Begin function main
	.p2align	2
	.type	main,%function
	.code	32                      @ @main
main:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r0, .LCPI2_0
	str	r0, [sp, #4]
	bl	_main
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI2_0:
	.long	0                       @ 0x0
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cantunwind
	.fnend
                                        @ -- End function
	.type	.L.str,%object          @ @.str
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str:
	.asciz	"%d "
	.size	.L.str, 4

	.type	.L.str.1,%object        @ @.str.1
.L.str.1:
	.asciz	"%d"
	.size	.L.str.1, 3

	.type	.L.str.2,%object        @ @.str.2
.L.str.2:
	.asciz	"%d\n"
	.size	.L.str.2, 4


	.ident	"clang version 7.0.1-8+rpi3 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym _function
	.addrsig_sym printf
	.addrsig_sym _main
	.addrsig_sym __isoc99_scanf
	.addrsig_sym main
