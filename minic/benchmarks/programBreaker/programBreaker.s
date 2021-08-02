	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_fun2                   @ -- Begin function _fun2
	.p2align	2
	.type	_fun2,%function
	.code	32                      @ @_fun2
_fun2:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	str	r0, [sp, #8]
	str	r1, [sp, #4]
	ldr	r0, [sp, #8]
	cmp	r0, #0
	bne	.LBB0_2
@ %bb.1:
	ldr	r0, [sp, #4]
	str	r0, [r11, #-4]
	b	.LBB0_3
.LBB0_2:
	ldr	r0, [sp, #8]
	sub	r0, r0, #1
	ldr	r1, [sp, #4]
	bl	_fun2
	str	r0, [r11, #-4]
.LBB0_3:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
.Lfunc_end0:
	.size	_fun2, .Lfunc_end0-_fun2
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_fun1                   @ -- Begin function _fun1
	.p2align	2
	.type	_fun1,%function
	.code	32                      @ @_fun1
_fun1:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#32
	sub	sp, sp, #32
	ldr	r3, .LCPI1_0
	ldr	r12, .LCPI1_1
	ldr	lr, .LCPI1_2
	str	r0, [r11, #-8]
	str	r1, [r11, #-12]
	str	r2, [sp, #16]
	ldr	r0, [r11, #-8]
	lsl	r0, r0, #1
	sub	r0, r12, r0
	ldr	r1, [r11, #-12]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r3
	str	lr, [sp, #4]            @ 4-byte Spill
	ldr	r1, [sp, #8]            @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [sp, #16]
	add	r0, r0, r1
	str	r0, [sp, #12]
	ldr	r0, [sp, #12]
	ldr	r1, [r11, #-12]
	cmp	r0, r1
	ble	.LBB1_2
@ %bb.1:
	ldr	r0, [sp, #12]
	ldr	r1, [r11, #-8]
	bl	_fun2
	str	r0, [r11, #-4]
	b	.LBB1_6
.LBB1_2:
	ldr	r0, [sp, #12]
	ldr	r1, [r11, #-12]
	cmp	r0, r1
	bgt	.LBB1_4
@ %bb.3:
	ldr	r0, [sp, #12]
	ldr	r1, [r11, #-12]
	bl	_fun2
	str	r0, [r11, #-4]
	b	.LBB1_6
.LBB1_4:
	b	.LBB1_5
.LBB1_5:
	ldr	r0, [sp, #12]
	str	r0, [r11, #-4]
.LBB1_6:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.7:
.LCPI1_0:
	.long	4                       @ 0x4
.LCPI1_1:
	.long	11                      @ 0xb
.LCPI1_2:
	.long	1                       @ 0x1
.Lfunc_end1:
	.size	_fun1, .Lfunc_end1-_fun1
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
	ldr	r0, .LCPI2_0
	ldr	r1, .LCPI2_1
	str	r1, [r11, #-4]
	sub	r1, r11, #4
	bl	__isoc99_scanf
	str	r0, [sp, #8]            @ 4-byte Spill
.LBB2_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI2_2
	ldr	r1, [r11, #-4]
	cmp	r1, r0
	bge	.LBB2_3
@ %bb.2:                                @   in Loop: Header=BB2_1 Depth=1
	ldr	r0, .LCPI2_4
	ldr	r2, .LCPI2_5
	ldr	r1, [r11, #-4]
	bl	_fun1
	ldr	r1, .LCPI2_3
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #4]            @ 4-byte Reload
	bl	printf
	ldr	r1, [r11, #-4]
	add	r1, r1, #1
	str	r1, [r11, #-4]
	str	r0, [sp]                @ 4-byte Spill
	b	.LBB2_1
.LBB2_3:
	ldr	r0, .LCPI2_1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI2_0:
	.long	.L.str
.LCPI2_1:
	.long	0                       @ 0x0
.LCPI2_2:
	.long	10000                   @ 0x2710
.LCPI2_3:
	.long	.L.str.1
.LCPI2_4:
	.long	3                       @ 0x3
.LCPI2_5:
	.long	5                       @ 0x5
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

	.type	EV_GLOBAL,%object       @ @EV_GLOBAL
	.comm	EV_GLOBAL,4,4
	.type	EV_count,%object        @ @EV_count
	.comm	EV_count,4,4

	.ident	"clang version 7.0.1-8+rpi3 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym _fun2
	.addrsig_sym _fun1
	.addrsig_sym _main
	.addrsig_sym __isoc99_scanf
	.addrsig_sym printf
	.addrsig_sym main
	.addrsig_sym EV_GLOBAL
	.addrsig_sym EV_count
