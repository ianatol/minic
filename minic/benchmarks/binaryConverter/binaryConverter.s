	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_wait                   @ -- Begin function _wait
	.p2align	2
	.type	_wait,%function
	.code	32                      @ @_wait
_wait:
	.fnstart
@ %bb.0:
	.pad	#4
	sub	sp, sp, #4
	str	r0, [sp]
.LBB0_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp]
	cmp	r0, #0
	ble	.LBB0_3
@ %bb.2:                                @   in Loop: Header=BB0_1 Depth=1
	ldr	r0, [sp]
	sub	r0, r0, #1
	str	r0, [sp]
	b	.LBB0_1
.LBB0_3:
	ldr	r0, .LCPI0_0
	add	sp, sp, #4
	bx	lr
	.p2align	2
@ %bb.4:
.LCPI0_0:
	.long	0                       @ 0x0
.Lfunc_end0:
	.size	_wait, .Lfunc_end0-_wait
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_power                  @ -- Begin function _power
	.p2align	2
	.type	_power,%function
	.code	32                      @ @_power
_power:
	.fnstart
@ %bb.0:
	.pad	#12
	sub	sp, sp, #12
	ldr	r2, .LCPI1_0
	str	r0, [sp, #8]
	str	r1, [sp, #4]
	str	r2, [sp]
.LBB1_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #4]
	cmp	r0, #0
	ble	.LBB1_3
@ %bb.2:                                @   in Loop: Header=BB1_1 Depth=1
	ldr	r0, [sp]
	ldr	r1, [sp, #8]
	mul	r0, r0, r1
	str	r0, [sp]
	ldr	r0, [sp, #4]
	sub	r0, r0, #1
	str	r0, [sp, #4]
	b	.LBB1_1
.LBB1_3:
	ldr	r0, [sp]
	add	sp, sp, #12
	bx	lr
	.p2align	2
@ %bb.4:
.LCPI1_0:
	.long	1                       @ 0x1
.Lfunc_end1:
	.size	_power, .Lfunc_end1-_power
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_recursiveDecimalSum    @ -- Begin function _recursiveDecimalSum
	.p2align	2
	.type	_recursiveDecimalSum,%function
	.code	32                      @ @_recursiveDecimalSum
_recursiveDecimalSum:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#40
	sub	sp, sp, #40
	str	r0, [r11, #-8]
	str	r1, [r11, #-12]
	str	r2, [r11, #-16]
	ldr	r0, [r11, #-8]
	cmp	r0, #0
	ble	.LBB2_4
@ %bb.1:
	ldr	r0, .LCPI2_0
	ldr	r1, .LCPI2_1
	str	r1, [sp, #16]
	ldr	r1, [r11, #-8]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #8]            @ 4-byte Reload
	str	r0, [sp, #20]
	ldr	r0, [sp, #20]
	ldr	r1, [sp, #8]            @ 4-byte Reload
	mul	r0, r0, r1
	str	r0, [sp, #20]
	ldr	r0, [r11, #-8]
	ldr	lr, [sp, #20]
	sub	r0, r0, lr
	str	r0, [sp, #20]
	ldr	r0, [sp, #20]
	cmp	r0, #1
	bne	.LBB2_3
@ %bb.2:
	ldr	r0, [r11, #-12]
	ldr	r1, [sp, #16]
	ldr	r2, [r11, #-16]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	_power
	ldr	r1, [sp, #4]            @ 4-byte Reload
	add	r0, r1, r0
	str	r0, [r11, #-12]
.LBB2_3:
	ldr	r1, .LCPI2_0
	ldr	r0, [r11, #-8]
	ldr	r1, [r11, #-12]
	ldr	lr, [r11, #-16]
	add	r2, lr, #1
	bl	_recursiveDecimalSum
	str	r0, [r11, #-4]
	b	.LBB2_5
.LBB2_4:
	ldr	r0, [r11, #-12]
	str	r0, [r11, #-4]
.LBB2_5:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.6:
.LCPI2_0:
	.long	10                      @ 0xa
.LCPI2_1:
	.long	2                       @ 0x2
.Lfunc_end2:
	.size	_recursiveDecimalSum, .Lfunc_end2-_recursiveDecimalSum
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_convertToDecimal       @ -- Begin function _convertToDecimal
	.p2align	2
	.type	_convertToDecimal,%function
	.code	32                      @ @_convertToDecimal
_convertToDecimal:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r1, .LCPI3_0
	str	r0, [r11, #-4]
	str	r1, [sp, #8]
	str	r1, [sp, #4]
	ldr	r0, [r11, #-4]
	ldr	r1, [sp, #4]
	ldr	r2, [sp, #8]
	bl	_recursiveDecimalSum
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI3_0:
	.long	0                       @ 0x0
.Lfunc_end3:
	.size	_convertToDecimal, .Lfunc_end3-_convertToDecimal
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
	.pad	#24
	sub	sp, sp, #24
	ldr	r0, .LCPI4_0
	sub	r1, r11, #4
	bl	__isoc99_scanf
	ldr	r1, [r11, #-4]
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r1
	bl	_convertToDecimal
	str	r0, [r11, #-4]
	ldr	r0, [r11, #-4]
	ldr	r1, [r11, #-4]
	mul	r0, r0, r1
	str	r0, [r11, #-8]
.LBB4_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-8]
	cmp	r0, #0
	ble	.LBB4_3
@ %bb.2:                                @   in Loop: Header=BB4_1 Depth=1
	ldr	r0, [r11, #-8]
	bl	_wait
	ldr	lr, [r11, #-8]
	sub	lr, lr, #1
	str	lr, [r11, #-8]
	str	r0, [sp, #8]            @ 4-byte Spill
	b	.LBB4_1
.LBB4_3:
	ldr	r0, .LCPI4_2
	ldr	r1, [r11, #-4]
	bl	printf
	ldr	r1, .LCPI4_1
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI4_0:
	.long	.L.str
.LCPI4_1:
	.long	0                       @ 0x0
.LCPI4_2:
	.long	.L.str.1
.Lfunc_end4:
	.size	_main, .Lfunc_end4-_main
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
	ldr	r0, .LCPI5_0
	str	r0, [sp, #4]
	bl	_main
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI5_0:
	.long	0                       @ 0x0
.Lfunc_end5:
	.size	main, .Lfunc_end5-main
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
	.addrsig_sym _wait
	.addrsig_sym _power
	.addrsig_sym _recursiveDecimalSum
	.addrsig_sym _convertToDecimal
	.addrsig_sym _main
	.addrsig_sym __isoc99_scanf
	.addrsig_sym printf
	.addrsig_sym main
