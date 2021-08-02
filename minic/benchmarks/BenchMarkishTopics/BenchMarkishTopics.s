	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_length                 @ -- Begin function _length
	.p2align	2
	.type	_length,%function
	.code	32                      @ @_length
_length:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r1, .LCPI0_0
	str	r0, [sp]
	ldr	r0, [sp]
	cmp	r0, r1
	bne	.LBB0_2
@ %bb.1:
	ldr	r0, .LCPI0_0
	str	r0, [sp, #4]
	b	.LBB0_3
.LBB0_2:
	ldr	r0, [sp]
	ldr	r0, [r0, #4]
	bl	_length
	add	r0, r0, #1
	str	r0, [sp, #4]
.LBB0_3:
	ldr	r0, [sp, #4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI0_0:
	.long	0                       @ 0x0
.Lfunc_end0:
	.size	_length, .Lfunc_end0-_length
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_addToFront             @ -- Begin function _addToFront
	.p2align	2
	.type	_addToFront,%function
	.code	32                      @ @_addToFront
_addToFront:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r2, .LCPI1_0
	str	r0, [sp, #8]
	str	r1, [sp, #4]
	ldr	r0, [sp, #8]
	cmp	r0, r2
	bne	.LBB1_2
@ %bb.1:
	ldr	r0, .LCPI1_1
	bl	malloc
	ldr	lr, .LCPI1_0
	str	r0, [sp, #8]
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	str	r0, [r1]
	ldr	r0, [sp, #8]
	str	lr, [r0, #4]
	ldr	r0, [sp, #8]
	str	r0, [r11, #-4]
	b	.LBB1_3
.LBB1_2:
	ldr	r0, .LCPI1_1
	bl	malloc
	str	r0, [sp]
	ldr	r0, [sp, #4]
	ldr	lr, [sp]
	str	r0, [lr]
	ldr	r0, [sp, #8]
	ldr	lr, [sp]
	str	r0, [lr, #4]
	ldr	r0, [sp]
	str	r0, [r11, #-4]
.LBB1_3:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI1_0:
	.long	0                       @ 0x0
.LCPI1_1:
	.long	8                       @ 0x8
.Lfunc_end1:
	.size	_addToFront, .Lfunc_end1-_addToFront
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_deleteFirst            @ -- Begin function _deleteFirst
	.p2align	2
	.type	_deleteFirst,%function
	.code	32                      @ @_deleteFirst
_deleteFirst:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r1, .LCPI2_0
	str	r0, [sp, #8]
	ldr	r0, [sp, #8]
	cmp	r0, r1
	bne	.LBB2_2
@ %bb.1:
	ldr	r0, .LCPI2_0
	str	r0, [r11, #-4]
	b	.LBB2_3
.LBB2_2:
	ldr	r0, [sp, #8]
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	str	r0, [sp, #8]
	ldr	r0, [sp, #4]
	bl	free
	ldr	r0, [sp, #8]
	str	r0, [r11, #-4]
.LBB2_3:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI2_0:
	.long	0                       @ 0x0
.Lfunc_end2:
	.size	_deleteFirst, .Lfunc_end2-_deleteFirst
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
	ldr	r0, .LCPI3_1
	ldr	r1, .LCPI3_2
	bl	__isoc99_scanf
	ldr	r1, .LCPI3_0
	str	r1, [r11, #-8]
	str	r1, [r11, #-4]
	str	r0, [r11, #-12]         @ 4-byte Spill
.LBB3_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI3_3
	ldr	r0, [r0]
	cmp	r0, #0
	ble	.LBB3_3
@ %bb.2:                                @   in Loop: Header=BB3_1 Depth=1
	ldr	r0, .LCPI3_9
	ldr	r1, [r11, #-4]
	ldr	r0, [r0]
	str	r0, [r11, #-16]         @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [r11, #-16]         @ 4-byte Reload
	bl	_addToFront
	ldr	r1, .LCPI3_8
	str	r0, [r11, #-4]
	ldr	r0, [r11, #-4]
	ldr	r0, [r0]
	str	r0, [r11, #-20]         @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [r11, #-20]         @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI3_7
	ldr	lr, [r1]
	sub	lr, lr, #1
	str	lr, [r1]
	str	r0, [sp, #24]           @ 4-byte Spill
	b	.LBB3_1
.LBB3_3:
	ldr	r0, [r11, #-4]
	bl	_length
	ldr	lr, .LCPI3_4
	str	r0, [sp, #20]           @ 4-byte Spill
	mov	r0, lr
	ldr	r1, [sp, #20]           @ 4-byte Reload
	bl	printf
	str	r0, [sp, #16]           @ 4-byte Spill
.LBB3_4:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-4]
	bl	_length
	cmp	r0, #0
	ble	.LBB3_6
@ %bb.5:                                @   in Loop: Header=BB3_4 Depth=1
	ldr	r0, [r11, #-8]
	ldr	r1, [r11, #-4]
	ldr	r1, [r1]
	add	r0, r0, r1
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-4]
	bl	_length
	ldr	r1, .LCPI3_6
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #12]           @ 4-byte Reload
	bl	printf
	ldr	r1, [r11, #-4]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	bl	_deleteFirst
	str	r0, [r11, #-4]
	b	.LBB3_4
.LBB3_6:
	ldr	r0, .LCPI3_5
	ldr	r1, [r11, #-8]
	bl	printf
	ldr	r1, .LCPI3_0
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.7:
.LCPI3_0:
	.long	0                       @ 0x0
.LCPI3_1:
	.long	.L.str
.LCPI3_2:
	.long	EV_intList
.LCPI3_3:
	.long	EV_intList
.LCPI3_4:
	.long	.L.str.1
.LCPI3_5:
	.long	.L.str.2
.LCPI3_6:
	.long	.L.str.1
.LCPI3_7:
	.long	EV_intList
.LCPI3_8:
	.long	.L.str.1
.LCPI3_9:
	.long	EV_intList
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

	.type	EV_intList,%object      @ @EV_intList
	.comm	EV_intList,4,4
	.type	.L.str.1,%object        @ @.str.1
.L.str.1:
	.asciz	"%d "
	.size	.L.str.1, 4

	.type	.L.str.2,%object        @ @.str.2
.L.str.2:
	.asciz	"%d\n"
	.size	.L.str.2, 4


	.ident	"clang version 7.0.1-8+rpi3 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym _length
	.addrsig_sym _addToFront
	.addrsig_sym malloc
	.addrsig_sym _deleteFirst
	.addrsig_sym free
	.addrsig_sym _main
	.addrsig_sym __isoc99_scanf
	.addrsig_sym printf
	.addrsig_sym main
	.addrsig_sym EV_intList
