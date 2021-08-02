	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_getIntList             @ -- Begin function _getIntList
	.p2align	2
	.type	_getIntList,%function
	.code	32                      @ @_getIntList
_getIntList:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r0, .LCPI0_1
	bl	malloc
	ldr	lr, .LCPI0_0
	str	r0, [sp, #8]
	mov	r0, lr
	add	r1, sp, #4
	bl	__isoc99_scanf
	ldr	r1, [sp, #4]
	cmn	r1, #1
	str	r0, [sp]                @ 4-byte Spill
	bne	.LBB0_2
@ %bb.1:
	ldr	r0, .LCPI0_2
	ldr	r1, [sp, #4]
	ldr	r2, [sp, #8]
	str	r1, [r2]
	ldr	r1, [sp, #8]
	str	r0, [r1, #4]
	ldr	r0, [sp, #8]
	str	r0, [r11, #-4]
	b	.LBB0_3
.LBB0_2:
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	str	r0, [r1]
	bl	_getIntList
	ldr	r1, [sp, #8]
	str	r0, [r1, #4]
	ldr	r0, [sp, #8]
	str	r0, [r11, #-4]
.LBB0_3:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI0_0:
	.long	.L.str
.LCPI0_1:
	.long	8                       @ 0x8
.LCPI0_2:
	.long	0                       @ 0x0
.Lfunc_end0:
	.size	_getIntList, .Lfunc_end0-_getIntList
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_biggest                @ -- Begin function _biggest
	.p2align	2
	.type	_biggest,%function
	.code	32                      @ @_biggest
_biggest:
	.fnstart
@ %bb.0:
	.pad	#12
	sub	sp, sp, #12
	str	r0, [sp, #4]
	str	r1, [sp]
	ldr	r0, [sp, #4]
	ldr	r1, [sp]
	cmp	r0, r1
	ble	.LBB1_2
@ %bb.1:
	ldr	r0, [sp, #4]
	str	r0, [sp, #8]
	b	.LBB1_3
.LBB1_2:
	ldr	r0, [sp]
	str	r0, [sp, #8]
.LBB1_3:
	ldr	r0, [sp, #8]
	add	sp, sp, #12
	bx	lr
.Lfunc_end1:
	.size	_biggest, .Lfunc_end1-_biggest
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_biggestInList          @ -- Begin function _biggestInList
	.p2align	2
	.type	_biggestInList,%function
	.code	32                      @ @_biggestInList
_biggestInList:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	ldr	r0, [r0]
	str	r0, [sp]
.LBB2_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI2_0
	ldr	r1, [sp, #4]
	ldr	r1, [r1, #4]
	cmp	r1, r0
	beq	.LBB2_3
@ %bb.2:                                @   in Loop: Header=BB2_1 Depth=1
	ldr	r0, [sp]
	ldr	r1, [sp, #4]
	ldr	r1, [r1]
	bl	_biggest
	str	r0, [sp]
	ldr	r0, [sp, #4]
	ldr	r0, [r0, #4]
	str	r0, [sp, #4]
	b	.LBB2_1
.LBB2_3:
	ldr	r0, [sp]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI2_0:
	.long	0                       @ 0x0
.Lfunc_end2:
	.size	_biggestInList, .Lfunc_end2-_biggestInList
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
	bl	_getIntList
	str	r0, [r11, #-4]
	ldr	r0, [r11, #-4]
	bl	_biggestInList
	ldr	lr, .LCPI3_1
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, lr
	ldr	r1, [sp, #8]            @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI3_0
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI3_0:
	.long	0                       @ 0x0
.LCPI3_1:
	.long	.L.str.1
.Lfunc_end3:
	.size	_main, .Lfunc_end3-_main
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
	ldr	r0, .LCPI4_0
	str	r0, [sp, #4]
	bl	_main
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI4_0:
	.long	0                       @ 0x0
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
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
	.addrsig_sym _getIntList
	.addrsig_sym malloc
	.addrsig_sym __isoc99_scanf
	.addrsig_sym _biggest
	.addrsig_sym _biggestInList
	.addrsig_sym _main
	.addrsig_sym printf
	.addrsig_sym main
