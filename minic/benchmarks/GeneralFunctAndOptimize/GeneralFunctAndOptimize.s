	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_multBy4xTimes          @ -- Begin function _multBy4xTimes
	.p2align	2
	.type	_multBy4xTimes,%function
	.code	32                      @ @_multBy4xTimes
_multBy4xTimes:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#24
	sub	sp, sp, #24
	str	r0, [r11, #-8]
	str	r1, [sp, #12]
	ldr	r0, [sp, #12]
	cmp	r0, #0
	bgt	.LBB0_2
@ %bb.1:
	ldr	r0, [r11, #-8]
	ldr	r0, [r0]
	str	r0, [r11, #-4]
	b	.LBB0_3
.LBB0_2:
	ldr	r0, .LCPI0_0
	ldr	r1, [r11, #-8]
	ldr	r1, [r1]
	lsl	r1, r1, #2
	ldr	r2, [r11, #-8]
	str	r1, [r2]
	ldr	r1, [r11, #-8]
	ldr	r2, [sp, #12]
	sub	r2, r2, #1
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	_multBy4xTimes
	ldr	r1, [r11, #-8]
	ldr	r1, [r1]
	str	r1, [r11, #-4]
	str	r0, [sp, #4]            @ 4-byte Spill
.LBB0_3:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI0_0:
	.long	2                       @ 0x2
.Lfunc_end0:
	.size	_multBy4xTimes, .Lfunc_end0-_multBy4xTimes
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_divideBy8              @ -- Begin function _divideBy8
	.p2align	2
	.type	_divideBy8,%function
	.code	32                      @ @_divideBy8
_divideBy8:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r1, .LCPI1_0
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	ldr	r0, [r0]
	str	r1, [sp]                @ 4-byte Spill
	ldr	r1, [sp, #4]
	str	r0, [r1]
	ldr	r0, [sp, #4]
	ldr	r0, [r0]
	ldr	r1, [sp]                @ 4-byte Reload
	ldr	r1, [sp, #4]
	str	r0, [r1]
	ldr	r0, [sp, #4]
	ldr	r0, [r0]
	ldr	r1, [sp]                @ 4-byte Reload
	ldr	r1, [sp, #4]
	str	r0, [r1]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI1_0:
	.long	2                       @ 0x2
.Lfunc_end1:
	.size	_divideBy8, .Lfunc_end1-_divideBy8
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
	.pad	#64
	sub	sp, sp, #64
	ldr	r0, .LCPI2_9
	bl	malloc
	ldr	lr, .LCPI2_6
	ldr	r1, .LCPI2_7
	ldr	r2, .LCPI2_8
	str	r0, [r11, #-28]
	str	r1, [r2]
	mov	r0, lr
	sub	r1, r11, #4
	bl	__isoc99_scanf
	ldr	r1, .LCPI2_4
	ldr	r2, .LCPI2_5
	str	r0, [sp, #24]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	__isoc99_scanf
	ldr	r1, .LCPI2_3
	ldr	r2, [r11, #-4]
	str	r0, [sp, #20]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	printf
	ldr	r1, .LCPI2_1
	ldr	r2, .LCPI2_2
	ldr	r2, [r2]
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	printf
	ldr	r1, .LCPI2_0
	str	r1, [r11, #-8]
	str	r1, [r11, #-12]
	str	r1, [r11, #-16]
	str	r0, [sp, #12]           @ 4-byte Spill
.LBB2_1:                                @ =>This Loop Header: Depth=1
                                        @     Child Loop BB2_3 Depth 2
	ldr	r0, [r11, #-8]
	cmp	r0, #50
	bge	.LBB2_8
@ %bb.2:                                @   in Loop: Header=BB2_1 Depth=1
	ldr	r0, .LCPI2_0
	str	r0, [r11, #-12]
.LBB2_3:                                @   Parent Loop BB2_1 Depth=1
                                        @ =>  This Inner Loop Header: Depth=2
	ldr	r0, .LCPI2_12
	ldr	r1, [r11, #-12]
	ldr	r0, [r0]
	cmp	r1, r0
	bgt	.LBB2_7
@ %bb.4:                                @   in Loop: Header=BB2_3 Depth=2
	ldr	r1, .LCPI2_14
	ldr	r0, .LCPI2_15
	str	r0, [r11, #-16]
	ldr	r0, [r11, #-12]
	add	r0, r0, #1
	str	r0, [r11, #-12]
	ldr	r0, [r11, #-12]
	ldr	r2, [r11, #-28]
	str	r0, [r2]
	ldr	r0, [r11, #-28]
	ldr	r0, [r0]
	str	r0, [r11, #-20]
	ldr	r0, [r11, #-28]
	bl	_multBy4xTimes
	ldr	r1, [r11, #-28]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	bl	_divideBy8
	ldr	r0, .LCPI2_13
	ldr	r0, [r0]
	sub	r0, r0, #1
	str	r0, [r11, #-24]
	ldr	r0, [r11, #-24]
	cmp	r0, #0
	ldr	r0, .LCPI2_0
	movle	r0, #1
	and	r0, r0, #1
	str	r0, [sp, #32]
	ldr	r0, [r11, #-24]
	cmp	r0, #0
	bgt	.LBB2_6
@ %bb.5:                                @   in Loop: Header=BB2_3 Depth=2
	ldr	r0, .LCPI2_16
	str	r0, [r11, #-24]
.LBB2_6:                                @   in Loop: Header=BB2_3 Depth=2
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-24]
	add	r0, r0, r1
	str	r0, [r11, #-12]
	b	.LBB2_3
.LBB2_7:                                @   in Loop: Header=BB2_1 Depth=1
	ldr	r0, [r11, #-8]
	add	r0, r0, #1
	str	r0, [r11, #-8]
	b	.LBB2_1
.LBB2_8:
	ldr	r0, .LCPI2_11
	ldr	r1, [r11, #-12]
	bl	printf
	ldr	r1, .LCPI2_10
	ldr	lr, [r11, #-16]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI2_0
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.9:
.LCPI2_0:
	.long	0                       @ 0x0
.LCPI2_1:
	.long	.L.str.1
.LCPI2_2:
	.long	EV_interval
.LCPI2_3:
	.long	.L.str.1
.LCPI2_4:
	.long	.L.str
.LCPI2_5:
	.long	EV_interval
.LCPI2_6:
	.long	.L.str
.LCPI2_7:
	.long	1000000                 @ 0xf4240
.LCPI2_8:
	.long	EV_end
.LCPI2_9:
	.long	4                       @ 0x4
.LCPI2_10:
	.long	.L.str.1
.LCPI2_11:
	.long	.L.str.1
.LCPI2_12:
	.long	EV_end
.LCPI2_13:
	.long	EV_interval
.LCPI2_14:
	.long	2                       @ 0x2
.LCPI2_15:
	.long	39916800                @ 0x2611500
.LCPI2_16:
	.long	1                       @ 0x1
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
	.type	EV_end,%object          @ @EV_end
	.comm	EV_end,4,4
	.type	.L.str,%object          @ @.str
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str:
	.asciz	"%d"
	.size	.L.str, 3

	.type	EV_interval,%object     @ @EV_interval
	.comm	EV_interval,4,4
	.type	.L.str.1,%object        @ @.str.1
.L.str.1:
	.asciz	"%d\n"
	.size	.L.str.1, 4


	.ident	"clang version 7.0.1-8+rpi3 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym _multBy4xTimes
	.addrsig_sym _divideBy8
	.addrsig_sym _main
	.addrsig_sym malloc
	.addrsig_sym __isoc99_scanf
	.addrsig_sym printf
	.addrsig_sym main
	.addrsig_sym EV_end
	.addrsig_sym EV_interval
