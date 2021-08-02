	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_sum                    @ -- Begin function _sum
	.p2align	2
	.type	_sum,%function
	.code	32                      @ @_sum
_sum:
	.fnstart
@ %bb.0:
	.pad	#8
	sub	sp, sp, #8
	str	r0, [sp, #4]
	str	r1, [sp]
	ldr	r0, [sp, #4]
	ldr	r1, [sp]
	add	r0, r0, r1
	add	sp, sp, #8
	bx	lr
.Lfunc_end0:
	.size	_sum, .Lfunc_end0-_sum
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_fact                   @ -- Begin function _fact
	.p2align	2
	.type	_fact,%function
	.code	32                      @ @_fact
_fact:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	str	r0, [sp, #8]
	ldr	r0, [sp, #8]
	cmp	r0, #1
	beq	.LBB1_2
@ %bb.1:
	ldr	r0, [sp, #8]
	cmp	r0, #0
	bne	.LBB1_3
.LBB1_2:
	ldr	r0, .LCPI1_1
	str	r0, [r11, #-4]
	b	.LBB1_6
.LBB1_3:
	ldr	r0, [sp, #8]
	cmp	r0, #1
	bgt	.LBB1_5
@ %bb.4:
	ldr	r0, .LCPI1_0
	ldr	r1, [sp, #8]
	mul	r0, r1, r0
	bl	_fact
	str	r0, [r11, #-4]
	b	.LBB1_6
.LBB1_5:
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #8]
	sub	r1, r1, #1
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	bl	_fact
	ldr	r1, [sp]                @ 4-byte Reload
	mul	r0, r1, r0
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	str	r0, [r11, #-4]
.LBB1_6:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.7:
.LCPI1_0:
	.long	4294967295              @ 0xffffffff
.LCPI1_1:
	.long	1                       @ 0x1
.Lfunc_end1:
	.size	_fact, .Lfunc_end1-_fact
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
	ldr	r0, .LCPI2_0
	str	r0, [r11, #-12]
.LBB2_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-12]
	cmn	r0, #1
	beq	.LBB2_3
@ %bb.2:                                @   in Loop: Header=BB2_1 Depth=1
	ldr	r0, .LCPI2_4
	sub	r1, r11, #4
	bl	__isoc99_scanf
	ldr	r1, .LCPI2_3
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, r1
	sub	r1, r11, #8
	bl	__isoc99_scanf
	ldr	r1, [r11, #-4]
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r1
	bl	_fact
	str	r0, [r11, #-4]
	ldr	r0, [r11, #-8]
	bl	_fact
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-4]
	ldr	r1, [r11, #-8]
	bl	_sum
	ldr	r1, .LCPI2_2
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #8]            @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI2_1
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	sub	r1, r11, #12
	bl	__isoc99_scanf
	str	r0, [sp]                @ 4-byte Spill
	b	.LBB2_1
.LBB2_3:
	ldr	r0, .LCPI2_0
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI2_0:
	.long	0                       @ 0x0
.LCPI2_1:
	.long	.L.str
.LCPI2_2:
	.long	.L.str.1
.LCPI2_3:
	.long	.L.str
.LCPI2_4:
	.long	.L.str
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
	.addrsig_sym _sum
	.addrsig_sym _fact
	.addrsig_sym _main
	.addrsig_sym __isoc99_scanf
	.addrsig_sym printf
	.addrsig_sym main
