	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_calcPower              @ -- Begin function _calcPower
	.p2align	2
	.type	_calcPower,%function
	.code	32                      @ @_calcPower
_calcPower:
	.fnstart
@ %bb.0:
	.pad	#12
	sub	sp, sp, #12
	ldr	r2, .LCPI0_0
	str	r0, [sp, #8]
	str	r1, [sp, #4]
	str	r2, [sp]
.LBB0_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #4]
	cmp	r0, #0
	ble	.LBB0_3
@ %bb.2:                                @   in Loop: Header=BB0_1 Depth=1
	ldr	r0, [sp]
	ldr	r1, [sp, #8]
	mul	r0, r0, r1
	str	r0, [sp]
	ldr	r0, [sp, #4]
	sub	r0, r0, #1
	str	r0, [sp, #4]
	b	.LBB0_1
.LBB0_3:
	ldr	r0, [sp]
	add	sp, sp, #12
	bx	lr
	.p2align	2
@ %bb.4:
.LCPI0_0:
	.long	1                       @ 0x1
.Lfunc_end0:
	.size	_calcPower, .Lfunc_end0-_calcPower
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
	.pad	#40
	sub	sp, sp, #40
	ldr	r0, .LCPI1_3
	bl	malloc
	ldr	lr, .LCPI1_1
	ldr	r1, .LCPI1_2
	str	r0, [r11, #-8]
	str	r1, [r11, #-16]
	mov	r0, lr
	sub	r1, r11, #12
	bl	__isoc99_scanf
	ldr	r1, .LCPI1_0
	ldr	lr, [r11, #-12]
	ldr	r2, [r11, #-8]
	str	lr, [r2]
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r1
	sub	r1, r11, #12
	bl	__isoc99_scanf
	ldr	r1, [r11, #-12]
	cmp	r1, #0
	str	r0, [sp, #8]            @ 4-byte Spill
	bge	.LBB1_2
@ %bb.1:
	ldr	r0, .LCPI1_7
	str	r0, [r11, #-4]
	b	.LBB1_6
.LBB1_2:
	ldr	r0, .LCPI1_2
	ldr	r1, [r11, #-12]
	ldr	r2, [r11, #-8]
	str	r1, [r2, #4]
	str	r0, [sp, #16]
.LBB1_3:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI1_4
	ldr	r1, [sp, #16]
	cmp	r1, r0
	bge	.LBB1_5
@ %bb.4:                                @   in Loop: Header=BB1_3 Depth=1
	ldr	r0, [sp, #16]
	add	r0, r0, #1
	str	r0, [sp, #16]
	ldr	r0, [r11, #-8]
	ldr	r0, [r0]
	ldr	r1, [r11, #-8]
	ldr	r1, [r1, #4]
	bl	_calcPower
	str	r0, [r11, #-16]
	b	.LBB1_3
.LBB1_5:
	ldr	r0, .LCPI1_6
	ldr	r1, [r11, #-16]
	bl	printf
	ldr	r1, .LCPI1_5
	str	r1, [r11, #-4]
	str	r0, [sp, #4]            @ 4-byte Spill
.LBB1_6:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.7:
.LCPI1_0:
	.long	.L.str
.LCPI1_1:
	.long	.L.str
.LCPI1_2:
	.long	0                       @ 0x0
.LCPI1_3:
	.long	8                       @ 0x8
.LCPI1_4:
	.long	1000000                 @ 0xf4240
.LCPI1_5:
	.long	1                       @ 0x1
.LCPI1_6:
	.long	.L.str.1
.LCPI1_7:
	.long	4294967295              @ 0xffffffff
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
	.asciz	"%d"
	.size	.L.str, 3

	.type	.L.str.1,%object        @ @.str.1
.L.str.1:
	.asciz	"%d\n"
	.size	.L.str.1, 4


	.ident	"clang version 7.0.1-8+rpi3 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym _calcPower
	.addrsig_sym _main
	.addrsig_sym malloc
	.addrsig_sym __isoc99_scanf
	.addrsig_sym printf
	.addrsig_sym main
