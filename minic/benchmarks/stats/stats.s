	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_getRands               @ -- Begin function _getRands
	.p2align	2
	.type	_getRands,%function
	.code	32                      @ @_getRands
_getRands:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#40
	sub	sp, sp, #40
	ldr	r2, .LCPI0_1
	ldr	r3, .LCPI0_0
	str	r0, [r11, #-4]
	str	r1, [r11, #-8]
	str	r3, [sp, #20]
	ldr	r0, [r11, #-4]
	ldr	r1, [r11, #-4]
	mul	r0, r0, r1
	str	r0, [r11, #-12]
	mov	r0, r2
	bl	malloc
	ldr	r1, .LCPI0_0
	str	r0, [sp, #16]
	ldr	r0, [r11, #-12]
	ldr	r2, [sp, #16]
	str	r0, [r2]
	ldr	r0, [sp, #16]
	str	r1, [r0, #4]
	ldr	r0, [r11, #-8]
	sub	r0, r0, #1
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-12]
	str	r0, [r11, #-16]
.LBB0_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-8]
	cmp	r0, #0
	ble	.LBB0_3
@ %bb.2:                                @   in Loop: Header=BB0_1 Depth=1
	ldr	r0, .LCPI0_1
	ldr	r1, .LCPI0_2
	ldr	r2, [r11, #-16]
	ldr	r3, [r11, #-16]
	mul	r2, r2, r3
	ldr	r3, [r11, #-4]
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r2
	str	r1, [sp, #8]            @ 4-byte Spill
	mov	r1, r3
	ldr	r1, [r11, #-4]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #8]            @ 4-byte Reload
	ldr	r1, [sp, #4]            @ 4-byte Reload
	mul	r0, r1, r0
	add	r0, r0, #1
	str	r0, [r11, #-12]
	ldr	r0, [sp, #12]           @ 4-byte Reload
	bl	malloc
	str	r0, [sp, #20]
	ldr	r0, [r11, #-12]
	ldr	r1, [sp, #20]
	str	r0, [r1]
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #20]
	str	r0, [r1, #4]
	ldr	r0, [sp, #20]
	str	r0, [sp, #16]
	ldr	r0, [r11, #-8]
	sub	r0, r0, #1
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-12]
	str	r0, [r11, #-16]
	b	.LBB0_1
.LBB0_3:
	ldr	r0, [sp, #20]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI0_0:
	.long	0                       @ 0x0
.LCPI0_1:
	.long	8                       @ 0x8
.LCPI0_2:
	.long	2                       @ 0x2
.Lfunc_end0:
	.size	_getRands, .Lfunc_end0-_getRands
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_calcMean               @ -- Begin function _calcMean
	.p2align	2
	.type	_calcMean,%function
	.code	32                      @ @_calcMean
_calcMean:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r1, .LCPI1_0
	str	r0, [r11, #-4]
	str	r1, [sp, #8]
	str	r1, [sp, #4]
	str	r1, [sp]
.LBB1_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI1_0
	ldr	r1, [r11, #-4]
	cmp	r1, r0
	beq	.LBB1_3
@ %bb.2:                                @   in Loop: Header=BB1_1 Depth=1
	ldr	r0, [sp, #4]
	add	r0, r0, #1
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r1, [r11, #-4]
	ldr	r1, [r1]
	add	r0, r0, r1
	str	r0, [sp, #8]
	ldr	r0, [r11, #-4]
	ldr	r0, [r0, #4]
	str	r0, [r11, #-4]
	b	.LBB1_1
.LBB1_3:
	ldr	r0, [sp, #4]
	cmp	r0, #0
	beq	.LBB1_5
@ %bb.4:
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #4]
	str	r0, [sp]
.LBB1_5:
	ldr	r0, [sp]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.6:
.LCPI1_0:
	.long	0                       @ 0x0
.Lfunc_end1:
	.size	_calcMean, .Lfunc_end1-_calcMean
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_approxSqrt             @ -- Begin function _approxSqrt
	.p2align	2
	.type	_approxSqrt,%function
	.code	32                      @ @_approxSqrt
_approxSqrt:
	.fnstart
@ %bb.0:
	.pad	#16
	sub	sp, sp, #16
	ldr	r1, .LCPI2_0
	ldr	r2, .LCPI2_1
	str	r0, [sp, #12]
	str	r2, [sp, #8]
	ldr	r0, [sp, #8]
	str	r0, [sp]
	str	r1, [sp, #4]
.LBB2_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #12]
	cmp	r0, r1
	bge	.LBB2_3
@ %bb.2:                                @   in Loop: Header=BB2_1 Depth=1
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #8]
	mul	r0, r0, r1
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	str	r0, [sp]
	ldr	r0, [sp, #8]
	add	r0, r0, #1
	str	r0, [sp, #8]
	b	.LBB2_1
.LBB2_3:
	ldr	r0, [sp]
	add	sp, sp, #16
	bx	lr
	.p2align	2
@ %bb.4:
.LCPI2_0:
	.long	0                       @ 0x0
.LCPI2_1:
	.long	1                       @ 0x1
.Lfunc_end2:
	.size	_approxSqrt, .Lfunc_end2-_approxSqrt
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_approxSqrtAll          @ -- Begin function _approxSqrtAll
	.p2align	2
	.type	_approxSqrtAll,%function
	.code	32                      @ @_approxSqrtAll
_approxSqrtAll:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	str	r0, [r11, #-4]
.LBB3_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI3_0
	ldr	r1, [r11, #-4]
	cmp	r1, r0
	beq	.LBB3_3
@ %bb.2:                                @   in Loop: Header=BB3_1 Depth=1
	ldr	r0, [r11, #-4]
	ldr	r0, [r0]
	bl	_approxSqrt
	ldr	lr, .LCPI3_1
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, lr
	ldr	r1, [sp, #8]            @ 4-byte Reload
	bl	printf
	ldr	r1, [r11, #-4]
	ldr	r1, [r1, #4]
	str	r1, [r11, #-4]
	str	r0, [sp, #4]            @ 4-byte Spill
	b	.LBB3_1
.LBB3_3:
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI3_0:
	.long	0                       @ 0x0
.LCPI3_1:
	.long	.L.str
.Lfunc_end3:
	.size	_approxSqrtAll, .Lfunc_end3-_approxSqrtAll
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_range                  @ -- Begin function _range
	.p2align	2
	.type	_range,%function
	.code	32                      @ @_range
_range:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#24
	sub	sp, sp, #24
	ldr	r1, .LCPI4_0
	ldr	r2, .LCPI4_1
	str	r0, [r11, #-4]
	str	r2, [r11, #-8]
	str	r2, [sp, #12]
	str	r1, [sp, #8]
.LBB4_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI4_1
	ldr	r1, [r11, #-4]
	cmp	r1, r0
	beq	.LBB4_11
@ %bb.2:                                @   in Loop: Header=BB4_1 Depth=1
	ldr	r0, [sp, #8]
	cmp	r0, #0
	beq	.LBB4_4
@ %bb.3:                                @   in Loop: Header=BB4_1 Depth=1
	ldr	r0, .LCPI4_1
	ldr	r1, [r11, #-4]
	ldr	r1, [r1]
	str	r1, [r11, #-8]
	ldr	r1, [r11, #-4]
	ldr	r1, [r1]
	str	r1, [sp, #12]
	str	r0, [sp, #8]
	b	.LBB4_10
.LBB4_4:                                @   in Loop: Header=BB4_1 Depth=1
	ldr	r0, [r11, #-4]
	ldr	r0, [r0]
	ldr	r1, [r11, #-8]
	cmp	r0, r1
	bge	.LBB4_6
@ %bb.5:                                @   in Loop: Header=BB4_1 Depth=1
	ldr	r0, [r11, #-4]
	ldr	r0, [r0]
	str	r0, [r11, #-8]
	b	.LBB4_9
.LBB4_6:                                @   in Loop: Header=BB4_1 Depth=1
	ldr	r0, [r11, #-4]
	ldr	r0, [r0]
	ldr	r1, [sp, #12]
	cmp	r0, r1
	ble	.LBB4_8
@ %bb.7:                                @   in Loop: Header=BB4_1 Depth=1
	ldr	r0, [r11, #-4]
	ldr	r0, [r0]
	str	r0, [sp, #12]
.LBB4_8:                                @   in Loop: Header=BB4_1 Depth=1
	b	.LBB4_9
.LBB4_9:                                @   in Loop: Header=BB4_1 Depth=1
	b	.LBB4_10
.LBB4_10:                               @   in Loop: Header=BB4_1 Depth=1
	ldr	r0, [r11, #-4]
	ldr	r0, [r0, #4]
	str	r0, [r11, #-4]
	b	.LBB4_1
.LBB4_11:
	ldr	r0, .LCPI4_3
	ldr	r1, [r11, #-8]
	bl	printf
	ldr	r1, .LCPI4_2
	ldr	lr, [sp, #12]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	str	r0, [sp]                @ 4-byte Spill
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.12:
.LCPI4_0:
	.long	1                       @ 0x1
.LCPI4_1:
	.long	0                       @ 0x0
.LCPI4_2:
	.long	.L.str
.LCPI4_3:
	.long	.L.str
.Lfunc_end4:
	.size	_range, .Lfunc_end4-_range
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
	.pad	#32
	sub	sp, sp, #32
	ldr	r0, .LCPI5_3
	sub	r1, r11, #4
	bl	__isoc99_scanf
	ldr	r1, .LCPI5_2
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r1
	sub	r1, r11, #8
	bl	__isoc99_scanf
	ldr	r1, [r11, #-4]
	ldr	lr, [r11, #-8]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	_getRands
	str	r0, [sp, #16]
	ldr	r0, [sp, #16]
	bl	_calcMean
	ldr	r1, .LCPI5_1
	str	r0, [r11, #-12]
	ldr	r0, [r11, #-12]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #4]            @ 4-byte Reload
	bl	printf
	ldr	r1, [sp, #16]
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	bl	_range
	ldr	r0, [sp, #16]
	bl	_approxSqrtAll
	ldr	r0, .LCPI5_0
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI5_0:
	.long	0                       @ 0x0
.LCPI5_1:
	.long	.L.str
.LCPI5_2:
	.long	.L.str.1
.LCPI5_3:
	.long	.L.str.1
.Lfunc_end5:
	.size	_main, .Lfunc_end5-_main
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
	ldr	r0, .LCPI6_0
	str	r0, [sp, #4]
	bl	_main
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI6_0:
	.long	0                       @ 0x0
.Lfunc_end6:
	.size	main, .Lfunc_end6-main
	.cantunwind
	.fnend
                                        @ -- End function
	.type	.L.str,%object          @ @.str
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str:
	.asciz	"%d\n"
	.size	.L.str, 4

	.type	.L.str.1,%object        @ @.str.1
.L.str.1:
	.asciz	"%d"
	.size	.L.str.1, 3


	.ident	"clang version 7.0.1-8+rpi3 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym _getRands
	.addrsig_sym malloc
	.addrsig_sym _calcMean
	.addrsig_sym _approxSqrt
	.addrsig_sym _approxSqrtAll
	.addrsig_sym printf
	.addrsig_sym _range
	.addrsig_sym _main
	.addrsig_sym __isoc99_scanf
	.addrsig_sym main
