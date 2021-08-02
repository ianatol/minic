	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_isqrt                  @ -- Begin function _isqrt
	.p2align	2
	.type	_isqrt,%function
	.code	32                      @ @_isqrt
_isqrt:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r1, .LCPI0_0
	ldr	r2, .LCPI0_1
	str	r0, [r11, #-4]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
.LBB0_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #8]
	ldr	r1, [r11, #-4]
	cmp	r0, r1
	bgt	.LBB0_3
@ %bb.2:                                @   in Loop: Header=BB0_1 Depth=1
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #4]
	add	r0, r0, r1
	str	r0, [sp, #8]
	ldr	r0, [sp, #4]
	add	r0, r0, #2
	str	r0, [sp, #4]
	b	.LBB0_1
.LBB0_3:
	ldr	r1, .LCPI0_2
	ldr	r0, [sp, #4]
	sub	r0, r0, #1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI0_0:
	.long	3                       @ 0x3
.LCPI0_1:
	.long	1                       @ 0x1
.LCPI0_2:
	.long	2                       @ 0x2
.Lfunc_end0:
	.size	_isqrt, .Lfunc_end0-_isqrt
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_prime                  @ -- Begin function _prime
	.p2align	2
	.type	_prime,%function
	.code	32                      @ @_prime
_prime:
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
	cmp	r0, #2
	bge	.LBB1_2
@ %bb.1:
	ldr	r0, .LCPI1_2
	str	r0, [r11, #-4]
	b	.LBB1_8
.LBB1_2:
	ldr	r0, [r11, #-8]
	bl	_isqrt
	ldr	lr, .LCPI1_0
	str	r0, [sp, #12]
	str	lr, [sp, #8]
.LBB1_3:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #12]
	cmp	r0, r1
	bgt	.LBB1_7
@ %bb.4:                                @   in Loop: Header=BB1_3 Depth=1
	ldr	r0, [r11, #-8]
	ldr	r1, [r11, #-8]
	ldr	r2, [sp, #8]
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #8]
	mul	r0, r0, r1
	ldr	r1, [sp]                @ 4-byte Reload
	sub	r0, r1, r0
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	cmp	r0, #0
	bne	.LBB1_6
@ %bb.5:
	ldr	r0, .LCPI1_2
	str	r0, [r11, #-4]
	b	.LBB1_8
.LBB1_6:                                @   in Loop: Header=BB1_3 Depth=1
	ldr	r0, [sp, #8]
	add	r0, r0, #1
	str	r0, [sp, #8]
	b	.LBB1_3
.LBB1_7:
	ldr	r0, .LCPI1_1
	str	r0, [r11, #-4]
.LBB1_8:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.9:
.LCPI1_0:
	.long	2                       @ 0x2
.LCPI1_1:
	.long	1                       @ 0x1
.LCPI1_2:
	.long	0                       @ 0x0
.Lfunc_end1:
	.size	_prime, .Lfunc_end1-_prime
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
	ldr	r0, .LCPI2_1
	sub	r1, r11, #4
	bl	__isoc99_scanf
	ldr	r1, .LCPI2_0
	str	r1, [sp, #8]
	str	r0, [sp, #4]            @ 4-byte Spill
.LBB2_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #8]
	ldr	r1, [r11, #-4]
	cmp	r0, r1
	bgt	.LBB2_5
@ %bb.2:                                @   in Loop: Header=BB2_1 Depth=1
	ldr	r0, [sp, #8]
	bl	_prime
	cmp	r0, #0
	beq	.LBB2_4
@ %bb.3:                                @   in Loop: Header=BB2_1 Depth=1
	ldr	r0, .LCPI2_2
	ldr	r1, [sp, #8]
	bl	printf
	str	r0, [sp]                @ 4-byte Spill
.LBB2_4:                                @   in Loop: Header=BB2_1 Depth=1
	ldr	r0, [sp, #8]
	add	r0, r0, #1
	str	r0, [sp, #8]
	b	.LBB2_1
.LBB2_5:
	ldr	r0, .LCPI2_0
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.6:
.LCPI2_0:
	.long	0                       @ 0x0
.LCPI2_1:
	.long	.L.str
.LCPI2_2:
	.long	.L.str.1
.Lfunc_end2:
	.size	_main, .Lfunc_end2-_main
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
	ldr	r0, .LCPI3_0
	str	r0, [sp, #4]
	bl	_main
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI3_0:
	.long	0                       @ 0x0
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
	.cantunwind
	.fnend
                                        @ -- End function
	.type	.L.str,%object          @ @.str
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str:
	.asciz	"%d"
	.size	.L.str, 3

	.type	.L.str.1,%object        @ @.str.1
.L.str.1:
	.asciz	"%d\n"
	.size	.L.str.1, 4


	.ident	"clang version 7.0.1-8+rpi3 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym _isqrt
	.addrsig_sym _prime
	.addrsig_sym _main
	.addrsig_sym __isoc99_scanf
	.addrsig_sym printf
	.addrsig_sym main
