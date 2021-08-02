	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_buildList              @ -- Begin function _buildList
	.p2align	2
	.type	_buildList,%function
	.code	32                      @ @_buildList
_buildList:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#56
	sub	sp, sp, #56
	ldr	r0, .LCPI0_7
	bl	malloc
	ldr	lr, .LCPI0_7
	str	r0, [r11, #-12]
	mov	r0, lr
	bl	malloc
	ldr	lr, .LCPI0_7
	str	r0, [r11, #-16]
	mov	r0, lr
	bl	malloc
	ldr	lr, .LCPI0_7
	str	r0, [r11, #-20]
	mov	r0, lr
	bl	malloc
	ldr	lr, .LCPI0_7
	str	r0, [r11, #-24]
	mov	r0, lr
	bl	malloc
	ldr	lr, .LCPI0_7
	str	r0, [sp, #28]
	mov	r0, lr
	bl	malloc
	ldr	lr, .LCPI0_6
	str	r0, [sp, #24]
	ldr	r1, [r11, #-12]
	mov	r0, lr
	bl	__isoc99_scanf
	ldr	r1, .LCPI0_5
	ldr	lr, [r11, #-16]
	str	r0, [sp, #20]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	__isoc99_scanf
	ldr	r1, .LCPI0_4
	ldr	lr, [r11, #-20]
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	__isoc99_scanf
	ldr	r1, .LCPI0_3
	ldr	lr, [r11, #-24]
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	__isoc99_scanf
	ldr	r1, .LCPI0_2
	ldr	lr, [sp, #28]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	__isoc99_scanf
	ldr	r1, .LCPI0_1
	ldr	lr, [sp, #24]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	__isoc99_scanf
	ldr	r1, .LCPI0_0
	ldr	lr, [r11, #-16]
	ldr	r2, [r11, #-12]
	str	lr, [r2, #4]
	ldr	r2, [r11, #-20]
	ldr	lr, [r11, #-16]
	str	r2, [lr, #4]
	ldr	r2, [r11, #-24]
	ldr	lr, [r11, #-20]
	str	r2, [lr, #4]
	ldr	r2, [sp, #28]
	ldr	lr, [r11, #-24]
	str	r2, [lr, #4]
	ldr	r2, [sp, #24]
	ldr	lr, [sp, #28]
	str	r2, [lr, #4]
	ldr	r2, [sp, #24]
	str	r1, [r2, #4]
	ldr	r1, [r11, #-12]
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI0_0:
	.long	0                       @ 0x0
.LCPI0_1:
	.long	.L.str
.LCPI0_2:
	.long	.L.str
.LCPI0_3:
	.long	.L.str
.LCPI0_4:
	.long	.L.str
.LCPI0_5:
	.long	.L.str
.LCPI0_6:
	.long	.L.str
.LCPI0_7:
	.long	8                       @ 0x8
.Lfunc_end0:
	.size	_buildList, .Lfunc_end0-_buildList
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_multiple               @ -- Begin function _multiple
	.p2align	2
	.type	_multiple,%function
	.code	32                      @ @_multiple
_multiple:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#24
	sub	sp, sp, #24
	ldr	r1, .LCPI1_0
	str	r0, [r11, #-4]
	str	r1, [r11, #-8]
	ldr	r0, [r11, #-4]
	str	r0, [sp, #8]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	str	r0, [sp, #12]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	str	r0, [sp, #8]
.LBB1_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-8]
	cmp	r0, #5
	bge	.LBB1_3
@ %bb.2:                                @   in Loop: Header=BB1_1 Depth=1
	ldr	r0, .LCPI1_1
	ldr	r1, [sp, #12]
	ldr	r2, [sp, #8]
	ldr	r2, [r2]
	mul	r1, r1, r2
	str	r1, [sp, #12]
	ldr	r1, [sp, #8]
	ldr	r1, [r1, #4]
	str	r1, [sp, #8]
	ldr	r1, [sp, #12]
	bl	printf
	ldr	r1, [r11, #-8]
	add	r1, r1, #1
	str	r1, [r11, #-8]
	str	r0, [sp, #4]            @ 4-byte Spill
	b	.LBB1_1
.LBB1_3:
	ldr	r0, [sp, #12]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI1_0:
	.long	0                       @ 0x0
.LCPI1_1:
	.long	.L.str.1
.Lfunc_end1:
	.size	_multiple, .Lfunc_end1-_multiple
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_add                    @ -- Begin function _add
	.p2align	2
	.type	_add,%function
	.code	32                      @ @_add
_add:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#24
	sub	sp, sp, #24
	ldr	r1, .LCPI2_0
	str	r0, [r11, #-4]
	str	r1, [r11, #-8]
	ldr	r0, [r11, #-4]
	str	r0, [sp, #8]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	str	r0, [sp, #12]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	str	r0, [sp, #8]
.LBB2_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-8]
	cmp	r0, #5
	bge	.LBB2_3
@ %bb.2:                                @   in Loop: Header=BB2_1 Depth=1
	ldr	r0, .LCPI2_1
	ldr	r1, [sp, #12]
	ldr	r2, [sp, #8]
	ldr	r2, [r2]
	add	r1, r1, r2
	str	r1, [sp, #12]
	ldr	r1, [sp, #8]
	ldr	r1, [r1, #4]
	str	r1, [sp, #8]
	ldr	r1, [sp, #12]
	bl	printf
	ldr	r1, [r11, #-8]
	add	r1, r1, #1
	str	r1, [r11, #-8]
	str	r0, [sp, #4]            @ 4-byte Spill
	b	.LBB2_1
.LBB2_3:
	ldr	r0, [sp, #12]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI2_0:
	.long	0                       @ 0x0
.LCPI2_1:
	.long	.L.str.1
.Lfunc_end2:
	.size	_add, .Lfunc_end2-_add
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_recurseList            @ -- Begin function _recurseList
	.p2align	2
	.type	_recurseList,%function
	.code	32                      @ @_recurseList
_recurseList:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r1, .LCPI3_0
	str	r0, [sp, #8]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	cmp	r0, r1
	bne	.LBB3_2
@ %bb.1:
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	str	r0, [r11, #-4]
	b	.LBB3_3
.LBB3_2:
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [sp, #8]
	ldr	r1, [r1, #4]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	bl	_recurseList
	ldr	r1, [sp, #4]            @ 4-byte Reload
	mul	r0, r1, r0
	str	r0, [r11, #-4]
.LBB3_3:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI3_0:
	.long	0                       @ 0x0
.Lfunc_end3:
	.size	_recurseList, .Lfunc_end3-_recurseList
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
	.pad	#48
	sub	sp, sp, #48
	ldr	r0, .LCPI4_1
	str	r0, [sp, #24]
	str	r0, [r11, #-20]
	bl	_buildList
	str	r0, [r11, #-4]
	ldr	r0, [r11, #-4]
	bl	_multiple
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-4]
	bl	_add
	ldr	r1, .LCPI4_0
	str	r0, [r11, #-12]
	ldr	r0, [r11, #-8]
	ldr	lr, [r11, #-12]
	str	r0, [sp, #20]           @ 4-byte Spill
	mov	r0, lr
	ldr	r1, [sp, #20]           @ 4-byte Reload
	sub	r0, r1, r0
	str	r0, [r11, #-16]
.LBB4_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #24]
	cmp	r0, #2
	bge	.LBB4_3
@ %bb.2:                                @   in Loop: Header=BB4_1 Depth=1
	ldr	r0, [r11, #-20]
	ldr	r1, [r11, #-4]
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, r1
	bl	_recurseList
	ldr	r1, [sp, #16]           @ 4-byte Reload
	add	r0, r1, r0
	str	r0, [r11, #-20]
	ldr	r0, [sp, #24]
	add	r0, r0, #1
	str	r0, [sp, #24]
	b	.LBB4_1
.LBB4_3:
	ldr	r0, .LCPI4_2
	ldr	r1, [r11, #-20]
	bl	printf
	str	r0, [sp, #12]           @ 4-byte Spill
.LBB4_4:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	beq	.LBB4_6
@ %bb.5:                                @   in Loop: Header=BB4_4 Depth=1
	ldr	r0, [r11, #-20]
	sub	r0, r0, #1
	str	r0, [r11, #-20]
	b	.LBB4_4
.LBB4_6:
	ldr	r0, .LCPI4_4
	ldr	r1, [r11, #-16]
	bl	printf
	ldr	r1, .LCPI4_3
	ldr	lr, [r11, #-20]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI4_1
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.7:
.LCPI4_0:
	.long	2                       @ 0x2
.LCPI4_1:
	.long	0                       @ 0x0
.LCPI4_2:
	.long	.L.str.1
.LCPI4_3:
	.long	.L.str.1
.LCPI4_4:
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
	.addrsig_sym _buildList
	.addrsig_sym malloc
	.addrsig_sym __isoc99_scanf
	.addrsig_sym _multiple
	.addrsig_sym printf
	.addrsig_sym _add
	.addrsig_sym _recurseList
	.addrsig_sym _main
	.addrsig_sym main
