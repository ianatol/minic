	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_move                   @ -- Begin function _move
	.p2align	2
	.type	_move,%function
	.code	32                      @ @_move
_move:
	.fnstart
@ %bb.0:
	.pad	#12
	sub	sp, sp, #12
	str	r0, [sp, #8]
	str	r1, [sp, #4]
	ldr	r0, [sp, #8]
	cmp	r0, #1
	bne	.LBB0_2
@ %bb.1:
	ldr	r0, .LCPI0_2
	ldr	r1, [r0]
	str	r1, [sp]
	ldr	r1, [r0]
	ldr	r1, [r1, #4]
	str	r1, [r0]
	b	.LBB0_6
.LBB0_2:
	ldr	r0, [sp, #8]
	cmp	r0, #2
	bne	.LBB0_4
@ %bb.3:
	ldr	r0, .LCPI0_1
	ldr	r1, [r0]
	str	r1, [sp]
	ldr	r1, [r0]
	ldr	r1, [r1, #4]
	str	r1, [r0]
	b	.LBB0_5
.LBB0_4:
	ldr	r0, .LCPI0_0
	ldr	r1, [r0]
	str	r1, [sp]
	ldr	r1, [r0]
	ldr	r1, [r1, #4]
	str	r1, [r0]
.LBB0_5:
	b	.LBB0_6
.LBB0_6:
	ldr	r0, [sp, #4]
	cmp	r0, #1
	bne	.LBB0_8
@ %bb.7:
	ldr	r0, .LCPI0_5
	ldr	r1, [r0]
	ldr	r2, [sp]
	str	r1, [r2, #4]
	ldr	r1, [sp]
	str	r1, [r0]
	b	.LBB0_12
.LBB0_8:
	ldr	r0, [sp, #4]
	cmp	r0, #2
	bne	.LBB0_10
@ %bb.9:
	ldr	r0, .LCPI0_4
	ldr	r1, [r0]
	ldr	r2, [sp]
	str	r1, [r2, #4]
	ldr	r1, [sp]
	str	r1, [r0]
	b	.LBB0_11
.LBB0_10:
	ldr	r0, .LCPI0_3
	ldr	r1, [r0]
	ldr	r2, [sp]
	str	r1, [r2, #4]
	ldr	r1, [sp]
	str	r1, [r0]
.LBB0_11:
	b	.LBB0_12
.LBB0_12:
	ldr	r0, .LCPI0_6
	ldr	r1, [r0]
	add	r1, r1, #1
	str	r1, [r0]
	add	sp, sp, #12
	bx	lr
	.p2align	2
@ %bb.13:
.LCPI0_0:
	.long	EV_peg3
.LCPI0_1:
	.long	EV_peg2
.LCPI0_2:
	.long	EV_peg1
.LCPI0_3:
	.long	EV_peg3
.LCPI0_4:
	.long	EV_peg2
.LCPI0_5:
	.long	EV_peg1
.LCPI0_6:
	.long	EV_numMoves
.Lfunc_end0:
	.size	_move, .Lfunc_end0-_move
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_hanoi                  @ -- Begin function _hanoi
	.p2align	2
	.type	_hanoi,%function
	.code	32                      @ @_hanoi
_hanoi:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	str	r0, [r11, #-4]
	str	r1, [sp, #8]
	str	r2, [sp, #4]
	str	r3, [sp]
	ldr	r0, [r11, #-4]
	cmp	r0, #1
	bne	.LBB1_2
@ %bb.1:
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #4]
	bl	_move
	b	.LBB1_3
.LBB1_2:
	ldr	r0, [r11, #-4]
	sub	r0, r0, #1
	ldr	r1, [sp, #8]
	ldr	r2, [sp]
	ldr	r3, [sp, #4]
	bl	_hanoi
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #4]
	bl	_move
	ldr	r0, [r11, #-4]
	sub	r0, r0, #1
	ldr	r1, [sp]
	ldr	r2, [sp, #4]
	ldr	r3, [sp, #8]
	bl	_hanoi
.LBB1_3:
	mov	sp, r11
	pop	{r11, pc}
.Lfunc_end1:
	.size	_hanoi, .Lfunc_end1-_hanoi
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_printPeg               @ -- Begin function _printPeg
	.p2align	2
	.type	_printPeg,%function
	.code	32                      @ @_printPeg
_printPeg:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	str	r0, [r11, #-4]
	ldr	r0, [r11, #-4]
	str	r0, [sp, #8]
.LBB2_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI2_0
	ldr	r1, [sp, #8]
	cmp	r1, r0
	beq	.LBB2_3
@ %bb.2:                                @   in Loop: Header=BB2_1 Depth=1
	ldr	r0, .LCPI2_1
	ldr	r1, [sp, #8]
	ldr	r1, [r1]
	bl	printf
	ldr	r1, [sp, #8]
	ldr	r1, [r1, #4]
	str	r1, [sp, #8]
	str	r0, [sp, #4]            @ 4-byte Spill
	b	.LBB2_1
.LBB2_3:
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI2_0:
	.long	0                       @ 0x0
.LCPI2_1:
	.long	.L.str
.Lfunc_end2:
	.size	_printPeg, .Lfunc_end2-_printPeg
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
	ldr	r0, .LCPI3_0
	ldr	r1, .LCPI3_1
	ldr	r2, .LCPI3_2
	ldr	r3, .LCPI3_3
	ldr	r12, .LCPI3_4
	ldr	lr, .LCPI3_5
	str	r1, [lr]
	str	r1, [r12]
	str	r1, [r3]
	str	r1, [r2]
	sub	r1, r11, #8
	bl	__isoc99_scanf
	ldr	r1, [r11, #-8]
	cmp	r1, #1
	str	r0, [r11, #-16]         @ 4-byte Spill
	blt	.LBB3_8
@ %bb.1:
	ldr	r0, [r11, #-8]
	str	r0, [r11, #-4]
.LBB3_2:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-4]
	cmp	r0, #0
	beq	.LBB3_4
@ %bb.3:                                @   in Loop: Header=BB3_2 Depth=1
	ldr	r0, .LCPI3_26
	bl	malloc
	ldr	lr, .LCPI3_25
	str	r0, [r11, #-12]
	ldr	r0, [r11, #-4]
	ldr	r1, [r11, #-12]
	str	r0, [r1]
	ldr	r0, [lr]
	ldr	r1, [r11, #-12]
	str	r0, [r1, #4]
	ldr	r0, [r11, #-12]
	str	r0, [lr]
	ldr	r0, [r11, #-4]
	sub	r0, r0, #1
	str	r0, [r11, #-4]
	b	.LBB3_2
.LBB3_4:
	ldr	r0, .LCPI3_22
	ldr	r1, .LCPI3_16
	bl	printf
	ldr	r1, .LCPI3_21
	ldr	r1, [r1]
	str	r0, [r11, #-20]         @ 4-byte Spill
	mov	r0, r1
	bl	_printPeg
	ldr	r0, .LCPI3_20
	ldr	r1, .LCPI3_13
	bl	printf
	ldr	r1, .LCPI3_19
	ldr	r1, [r1]
	str	r0, [sp, #24]           @ 4-byte Spill
	mov	r0, r1
	bl	_printPeg
	ldr	r0, .LCPI3_18
	ldr	r1, .LCPI3_10
	bl	printf
	ldr	r1, .LCPI3_17
	ldr	r1, [r1]
	str	r0, [sp, #20]           @ 4-byte Spill
	mov	r0, r1
	bl	_printPeg
	ldr	r1, .LCPI3_16
	ldr	r2, .LCPI3_10
	ldr	r3, .LCPI3_13
	ldr	r0, [r11, #-8]
	bl	_hanoi
	ldr	r0, .LCPI3_15
	ldr	r1, .LCPI3_16
	bl	printf
	ldr	r1, .LCPI3_14
	ldr	r1, [r1]
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, r1
	bl	_printPeg
	ldr	r0, .LCPI3_12
	ldr	r1, .LCPI3_13
	bl	printf
	ldr	r1, .LCPI3_11
	ldr	r1, [r1]
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r1
	bl	_printPeg
	ldr	r0, .LCPI3_9
	ldr	r1, .LCPI3_10
	bl	printf
	ldr	r1, .LCPI3_8
	ldr	r1, [r1]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	bl	_printPeg
	ldr	r0, .LCPI3_6
	ldr	r1, .LCPI3_7
	ldr	r1, [r1]
	bl	printf
	str	r0, [sp, #4]            @ 4-byte Spill
.LBB3_5:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI3_1
	ldr	r1, .LCPI3_23
	ldr	r1, [r1]
	cmp	r1, r0
	beq	.LBB3_7
@ %bb.6:                                @   in Loop: Header=BB3_5 Depth=1
	ldr	r0, .LCPI3_24
	ldr	r1, [r0]
	str	r1, [r11, #-12]
	ldr	r1, [r0]
	ldr	r1, [r1, #4]
	str	r1, [r0]
	ldr	r0, [r11, #-12]
	bl	free
	b	.LBB3_5
.LBB3_7:
	b	.LBB3_8
.LBB3_8:
	ldr	r0, .LCPI3_1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.9:
.LCPI3_0:
	.long	.L.str.1
.LCPI3_1:
	.long	0                       @ 0x0
.LCPI3_2:
	.long	EV_numMoves
.LCPI3_3:
	.long	EV_peg3
.LCPI3_4:
	.long	EV_peg2
.LCPI3_5:
	.long	EV_peg1
.LCPI3_6:
	.long	.L.str
.LCPI3_7:
	.long	EV_numMoves
.LCPI3_8:
	.long	EV_peg3
.LCPI3_9:
	.long	.L.str
.LCPI3_10:
	.long	3                       @ 0x3
.LCPI3_11:
	.long	EV_peg2
.LCPI3_12:
	.long	.L.str
.LCPI3_13:
	.long	2                       @ 0x2
.LCPI3_14:
	.long	EV_peg1
.LCPI3_15:
	.long	.L.str
.LCPI3_16:
	.long	1                       @ 0x1
.LCPI3_17:
	.long	EV_peg3
.LCPI3_18:
	.long	.L.str
.LCPI3_19:
	.long	EV_peg2
.LCPI3_20:
	.long	.L.str
.LCPI3_21:
	.long	EV_peg1
.LCPI3_22:
	.long	.L.str
.LCPI3_23:
	.long	EV_peg3
.LCPI3_24:
	.long	EV_peg3
.LCPI3_25:
	.long	EV_peg1
.LCPI3_26:
	.long	8                       @ 0x8
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
	.type	EV_peg1,%object         @ @EV_peg1
	.comm	EV_peg1,4,4
	.type	EV_peg2,%object         @ @EV_peg2
	.comm	EV_peg2,4,4
	.type	EV_peg3,%object         @ @EV_peg3
	.comm	EV_peg3,4,4
	.type	EV_numMoves,%object     @ @EV_numMoves
	.comm	EV_numMoves,4,4
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
	.addrsig_sym _move
	.addrsig_sym _hanoi
	.addrsig_sym _printPeg
	.addrsig_sym printf
	.addrsig_sym _main
	.addrsig_sym __isoc99_scanf
	.addrsig_sym malloc
	.addrsig_sym free
	.addrsig_sym main
	.addrsig_sym EV_peg1
	.addrsig_sym EV_peg2
	.addrsig_sym EV_peg3
	.addrsig_sym EV_numMoves
