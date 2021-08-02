	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_cleanBoard             @ -- Begin function _cleanBoard
	.p2align	2
	.type	_cleanBoard,%function
	.code	32                      @ @_cleanBoard
_cleanBoard:
	.fnstart
@ %bb.0:
	.pad	#4
	sub	sp, sp, #4
	ldr	r1, .LCPI0_0
	str	r0, [sp]
	ldr	r0, [sp]
	str	r1, [r0]
	ldr	r0, [sp]
	str	r1, [r0, #4]
	ldr	r0, [sp]
	str	r1, [r0, #8]
	ldr	r0, [sp]
	str	r1, [r0, #12]
	ldr	r0, [sp]
	str	r1, [r0, #16]
	ldr	r0, [sp]
	str	r1, [r0, #20]
	ldr	r0, [sp]
	str	r1, [r0, #24]
	ldr	r0, [sp]
	str	r1, [r0, #28]
	ldr	r0, [sp]
	str	r1, [r0, #32]
	add	sp, sp, #4
	bx	lr
	.p2align	2
@ %bb.1:
.LCPI0_0:
	.long	0                       @ 0x0
.Lfunc_end0:
	.size	_cleanBoard, .Lfunc_end0-_cleanBoard
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_printBoard             @ -- Begin function _printBoard
	.p2align	2
	.type	_printBoard,%function
	.code	32                      @ @_printBoard
_printBoard:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#48
	sub	sp, sp, #48
	ldr	r1, .LCPI1_8
	str	r0, [r11, #-4]
	ldr	r0, [r11, #-4]
	ldr	r0, [r0]
	str	r0, [r11, #-8]          @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [r11, #-8]          @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI1_7
	ldr	lr, [r11, #-4]
	ldr	lr, [lr, #4]
	str	r0, [r11, #-12]         @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI1_6
	ldr	lr, [r11, #-4]
	ldr	lr, [lr, #8]
	str	r0, [r11, #-16]         @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI1_5
	ldr	lr, [r11, #-4]
	ldr	lr, [lr, #12]
	str	r0, [r11, #-20]         @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI1_4
	ldr	lr, [r11, #-4]
	ldr	lr, [lr, #16]
	str	r0, [sp, #24]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI1_3
	ldr	lr, [r11, #-4]
	ldr	lr, [lr, #20]
	str	r0, [sp, #20]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI1_2
	ldr	lr, [r11, #-4]
	ldr	lr, [lr, #24]
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI1_1
	ldr	lr, [r11, #-4]
	ldr	lr, [lr, #28]
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI1_0
	ldr	lr, [r11, #-4]
	ldr	lr, [lr, #32]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI1_0:
	.long	.L.str.1
.LCPI1_1:
	.long	.L.str
.LCPI1_2:
	.long	.L.str
.LCPI1_3:
	.long	.L.str.1
.LCPI1_4:
	.long	.L.str
.LCPI1_5:
	.long	.L.str
.LCPI1_6:
	.long	.L.str.1
.LCPI1_7:
	.long	.L.str
.LCPI1_8:
	.long	.L.str
.Lfunc_end1:
	.size	_printBoard, .Lfunc_end1-_printBoard
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_printMoveBoard         @ -- Begin function _printMoveBoard
	.p2align	2
	.type	_printMoveBoard,%function
	.code	32                      @ @_printMoveBoard
_printMoveBoard:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r0, .LCPI2_4
	ldr	r1, .LCPI2_5
	bl	printf
	ldr	r1, .LCPI2_2
	ldr	lr, .LCPI2_3
	str	r0, [r11, #-4]          @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI2_0
	ldr	lr, .LCPI2_1
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI2_0:
	.long	.L.str.1
.LCPI2_1:
	.long	789                     @ 0x315
.LCPI2_2:
	.long	.L.str.1
.LCPI2_3:
	.long	456                     @ 0x1c8
.LCPI2_4:
	.long	.L.str.1
.LCPI2_5:
	.long	123                     @ 0x7b
.Lfunc_end2:
	.size	_printMoveBoard, .Lfunc_end2-_printMoveBoard
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_placePiece             @ -- Begin function _placePiece
	.p2align	2
	.type	_placePiece,%function
	.code	32                      @ @_placePiece
_placePiece:
	.fnstart
@ %bb.0:
	.pad	#12
	sub	sp, sp, #12
	str	r0, [sp, #8]
	str	r1, [sp, #4]
	str	r2, [sp]
	ldr	r0, [sp]
	cmp	r0, #1
	bne	.LBB3_2
@ %bb.1:
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	str	r0, [r1]
	b	.LBB3_26
.LBB3_2:
	ldr	r0, [sp]
	cmp	r0, #2
	bne	.LBB3_4
@ %bb.3:
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	str	r0, [r1, #4]
	b	.LBB3_25
.LBB3_4:
	ldr	r0, [sp]
	cmp	r0, #3
	bne	.LBB3_6
@ %bb.5:
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	str	r0, [r1, #8]
	b	.LBB3_24
.LBB3_6:
	ldr	r0, [sp]
	cmp	r0, #4
	bne	.LBB3_8
@ %bb.7:
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	str	r0, [r1, #12]
	b	.LBB3_23
.LBB3_8:
	ldr	r0, [sp]
	cmp	r0, #5
	bne	.LBB3_10
@ %bb.9:
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	str	r0, [r1, #16]
	b	.LBB3_22
.LBB3_10:
	ldr	r0, [sp]
	cmp	r0, #6
	bne	.LBB3_12
@ %bb.11:
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	str	r0, [r1, #20]
	b	.LBB3_21
.LBB3_12:
	ldr	r0, [sp]
	cmp	r0, #7
	bne	.LBB3_14
@ %bb.13:
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	str	r0, [r1, #24]
	b	.LBB3_20
.LBB3_14:
	ldr	r0, [sp]
	cmp	r0, #8
	bne	.LBB3_16
@ %bb.15:
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	str	r0, [r1, #28]
	b	.LBB3_19
.LBB3_16:
	ldr	r0, [sp]
	cmp	r0, #9
	bne	.LBB3_18
@ %bb.17:
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	str	r0, [r1, #32]
.LBB3_18:
	b	.LBB3_19
.LBB3_19:
	b	.LBB3_20
.LBB3_20:
	b	.LBB3_21
.LBB3_21:
	b	.LBB3_22
.LBB3_22:
	b	.LBB3_23
.LBB3_23:
	b	.LBB3_24
.LBB3_24:
	b	.LBB3_25
.LBB3_25:
	b	.LBB3_26
.LBB3_26:
	add	sp, sp, #12
	bx	lr
.Lfunc_end3:
	.size	_placePiece, .Lfunc_end3-_placePiece
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_checkWinner            @ -- Begin function _checkWinner
	.p2align	2
	.type	_checkWinner,%function
	.code	32                      @ @_checkWinner
_checkWinner:
	.fnstart
@ %bb.0:
	.pad	#8
	sub	sp, sp, #8
	str	r0, [sp]
	ldr	r0, [sp]
	ldr	r0, [r0]
	cmp	r0, #1
	bne	.LBB4_6
@ %bb.1:
	ldr	r0, [sp]
	ldr	r0, [r0, #4]
	cmp	r0, #1
	bne	.LBB4_5
@ %bb.2:
	ldr	r0, [sp]
	ldr	r0, [r0, #8]
	cmp	r0, #1
	bne	.LBB4_4
@ %bb.3:
	ldr	r0, .LCPI4_2
	str	r0, [sp, #4]
	b	.LBB4_73
.LBB4_4:
	b	.LBB4_5
.LBB4_5:
	b	.LBB4_6
.LBB4_6:
	ldr	r0, [sp]
	ldr	r0, [r0]
	cmp	r0, #2
	bne	.LBB4_12
@ %bb.7:
	ldr	r0, [sp]
	ldr	r0, [r0, #4]
	cmp	r0, #2
	bne	.LBB4_11
@ %bb.8:
	ldr	r0, [sp]
	ldr	r0, [r0, #8]
	cmp	r0, #2
	bne	.LBB4_10
@ %bb.9:
	ldr	r0, .LCPI4_1
	str	r0, [sp, #4]
	b	.LBB4_73
.LBB4_10:
	b	.LBB4_11
.LBB4_11:
	b	.LBB4_12
.LBB4_12:
	ldr	r0, [sp]
	ldr	r0, [r0, #12]
	cmp	r0, #1
	bne	.LBB4_18
@ %bb.13:
	ldr	r0, [sp]
	ldr	r0, [r0, #16]
	cmp	r0, #1
	bne	.LBB4_17
@ %bb.14:
	ldr	r0, [sp]
	ldr	r0, [r0, #20]
	cmp	r0, #1
	bne	.LBB4_16
@ %bb.15:
	ldr	r0, .LCPI4_2
	str	r0, [sp, #4]
	b	.LBB4_73
.LBB4_16:
	b	.LBB4_17
.LBB4_17:
	b	.LBB4_18
.LBB4_18:
	ldr	r0, [sp]
	ldr	r0, [r0, #12]
	cmp	r0, #2
	bne	.LBB4_24
@ %bb.19:
	ldr	r0, [sp]
	ldr	r0, [r0, #16]
	cmp	r0, #2
	bne	.LBB4_23
@ %bb.20:
	ldr	r0, [sp]
	ldr	r0, [r0, #20]
	cmp	r0, #2
	bne	.LBB4_22
@ %bb.21:
	ldr	r0, .LCPI4_1
	str	r0, [sp, #4]
	b	.LBB4_73
.LBB4_22:
	b	.LBB4_23
.LBB4_23:
	b	.LBB4_24
.LBB4_24:
	ldr	r0, [sp]
	ldr	r0, [r0, #24]
	cmp	r0, #1
	bne	.LBB4_30
@ %bb.25:
	ldr	r0, [sp]
	ldr	r0, [r0, #28]
	cmp	r0, #1
	bne	.LBB4_29
@ %bb.26:
	ldr	r0, [sp]
	ldr	r0, [r0, #32]
	cmp	r0, #1
	bne	.LBB4_28
@ %bb.27:
	ldr	r0, .LCPI4_2
	str	r0, [sp, #4]
	b	.LBB4_73
.LBB4_28:
	b	.LBB4_29
.LBB4_29:
	b	.LBB4_30
.LBB4_30:
	ldr	r0, [sp]
	ldr	r0, [r0, #24]
	cmp	r0, #2
	bne	.LBB4_36
@ %bb.31:
	ldr	r0, [sp]
	ldr	r0, [r0, #28]
	cmp	r0, #2
	bne	.LBB4_35
@ %bb.32:
	ldr	r0, [sp]
	ldr	r0, [r0, #32]
	cmp	r0, #2
	bne	.LBB4_34
@ %bb.33:
	ldr	r0, .LCPI4_1
	str	r0, [sp, #4]
	b	.LBB4_73
.LBB4_34:
	b	.LBB4_35
.LBB4_35:
	b	.LBB4_36
.LBB4_36:
	ldr	r0, [sp]
	ldr	r0, [r0]
	cmp	r0, #1
	bne	.LBB4_42
@ %bb.37:
	ldr	r0, [sp]
	ldr	r0, [r0, #12]
	cmp	r0, #1
	bne	.LBB4_41
@ %bb.38:
	ldr	r0, [sp]
	ldr	r0, [r0, #24]
	cmp	r0, #1
	bne	.LBB4_40
@ %bb.39:
	ldr	r0, .LCPI4_2
	str	r0, [sp, #4]
	b	.LBB4_73
.LBB4_40:
	b	.LBB4_41
.LBB4_41:
	b	.LBB4_42
.LBB4_42:
	ldr	r0, [sp]
	ldr	r0, [r0]
	cmp	r0, #2
	bne	.LBB4_48
@ %bb.43:
	ldr	r0, [sp]
	ldr	r0, [r0, #12]
	cmp	r0, #2
	bne	.LBB4_47
@ %bb.44:
	ldr	r0, [sp]
	ldr	r0, [r0, #24]
	cmp	r0, #2
	bne	.LBB4_46
@ %bb.45:
	ldr	r0, .LCPI4_1
	str	r0, [sp, #4]
	b	.LBB4_73
.LBB4_46:
	b	.LBB4_47
.LBB4_47:
	b	.LBB4_48
.LBB4_48:
	ldr	r0, [sp]
	ldr	r0, [r0, #4]
	cmp	r0, #1
	bne	.LBB4_54
@ %bb.49:
	ldr	r0, [sp]
	ldr	r0, [r0, #16]
	cmp	r0, #1
	bne	.LBB4_53
@ %bb.50:
	ldr	r0, [sp]
	ldr	r0, [r0, #28]
	cmp	r0, #1
	bne	.LBB4_52
@ %bb.51:
	ldr	r0, .LCPI4_2
	str	r0, [sp, #4]
	b	.LBB4_73
.LBB4_52:
	b	.LBB4_53
.LBB4_53:
	b	.LBB4_54
.LBB4_54:
	ldr	r0, [sp]
	ldr	r0, [r0, #4]
	cmp	r0, #2
	bne	.LBB4_60
@ %bb.55:
	ldr	r0, [sp]
	ldr	r0, [r0, #16]
	cmp	r0, #2
	bne	.LBB4_59
@ %bb.56:
	ldr	r0, [sp]
	ldr	r0, [r0, #28]
	cmp	r0, #2
	bne	.LBB4_58
@ %bb.57:
	ldr	r0, .LCPI4_1
	str	r0, [sp, #4]
	b	.LBB4_73
.LBB4_58:
	b	.LBB4_59
.LBB4_59:
	b	.LBB4_60
.LBB4_60:
	ldr	r0, [sp]
	ldr	r0, [r0, #8]
	cmp	r0, #1
	bne	.LBB4_66
@ %bb.61:
	ldr	r0, [sp]
	ldr	r0, [r0, #20]
	cmp	r0, #1
	bne	.LBB4_65
@ %bb.62:
	ldr	r0, [sp]
	ldr	r0, [r0, #32]
	cmp	r0, #1
	bne	.LBB4_64
@ %bb.63:
	ldr	r0, .LCPI4_2
	str	r0, [sp, #4]
	b	.LBB4_73
.LBB4_64:
	b	.LBB4_65
.LBB4_65:
	b	.LBB4_66
.LBB4_66:
	ldr	r0, [sp]
	ldr	r0, [r0, #8]
	cmp	r0, #2
	bne	.LBB4_72
@ %bb.67:
	ldr	r0, [sp]
	ldr	r0, [r0, #20]
	cmp	r0, #2
	bne	.LBB4_71
@ %bb.68:
	ldr	r0, [sp]
	ldr	r0, [r0, #32]
	cmp	r0, #2
	bne	.LBB4_70
@ %bb.69:
	ldr	r0, .LCPI4_1
	str	r0, [sp, #4]
	b	.LBB4_73
.LBB4_70:
	b	.LBB4_71
.LBB4_71:
	b	.LBB4_72
.LBB4_72:
	ldr	r0, .LCPI4_0
	str	r0, [sp, #4]
.LBB4_73:
	ldr	r0, [sp, #4]
	add	sp, sp, #8
	bx	lr
	.p2align	2
@ %bb.74:
.LCPI4_0:
	.long	4294967295              @ 0xffffffff
.LCPI4_1:
	.long	1                       @ 0x1
.LCPI4_2:
	.long	0                       @ 0x0
.Lfunc_end4:
	.size	_checkWinner, .Lfunc_end4-_checkWinner
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
	ldr	r0, .LCPI5_0
	ldr	r1, .LCPI5_1
	ldr	r2, .LCPI5_2
	str	r2, [sp, #20]
	str	r2, [r11, #-4]
	str	r2, [r11, #-8]
	str	r2, [r11, #-12]
	str	r1, [r11, #-16]
	bl	malloc
	str	r0, [sp, #16]
	ldr	r0, [sp, #16]
	bl	_cleanBoard
.LBB5_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-16]
	mov	r1, #0
	cmn	r0, #1
	str	r1, [sp, #12]           @ 4-byte Spill
	bgt	.LBB5_3
	b	.LBB5_2
.LBB5_2:                                @   in Loop: Header=BB5_1 Depth=1
	ldr	r0, [sp, #20]
	cmp	r0, #8
	ldr	r0, .LCPI5_2
	movne	r0, #1
	str	r0, [sp, #12]           @ 4-byte Spill
.LBB5_3:                                @   in Loop: Header=BB5_1 Depth=1
	ldr	r0, [sp, #12]           @ 4-byte Reload
	tst	r0, #1
	beq	.LBB5_8
@ %bb.4:                                @   in Loop: Header=BB5_1 Depth=1
	ldr	r0, [sp, #16]
	bl	_printBoard
	ldr	r0, [r11, #-4]
	cmp	r0, #0
	bne	.LBB5_6
@ %bb.5:                                @   in Loop: Header=BB5_1 Depth=1
	ldr	r0, .LCPI5_7
	ldr	r1, [r11, #-4]
	add	r1, r1, #1
	str	r1, [r11, #-4]
	sub	r1, r11, #8
	bl	__isoc99_scanf
	ldr	r1, .LCPI5_6
	ldr	lr, [sp, #16]
	ldr	r2, [r11, #-8]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, lr
	bl	_placePiece
	b	.LBB5_7
.LBB5_6:                                @   in Loop: Header=BB5_1 Depth=1
	ldr	r0, .LCPI5_5
	ldr	r1, [r11, #-4]
	sub	r1, r1, #1
	str	r1, [r11, #-4]
	sub	r1, r11, #12
	bl	__isoc99_scanf
	ldr	r1, .LCPI5_4
	ldr	lr, [sp, #16]
	ldr	r2, [r11, #-12]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, lr
	bl	_placePiece
.LBB5_7:                                @   in Loop: Header=BB5_1 Depth=1
	ldr	r0, [sp, #16]
	bl	_checkWinner
	str	r0, [r11, #-16]
	ldr	r0, [sp, #20]
	add	r0, r0, #1
	str	r0, [sp, #20]
	b	.LBB5_1
.LBB5_8:
	ldr	r0, .LCPI5_3
	ldr	r1, [r11, #-16]
	add	r1, r1, #1
	bl	printf
	ldr	r1, .LCPI5_2
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.9:
.LCPI5_0:
	.long	36                      @ 0x24
.LCPI5_1:
	.long	4294967295              @ 0xffffffff
.LCPI5_2:
	.long	0                       @ 0x0
.LCPI5_3:
	.long	.L.str.1
.LCPI5_4:
	.long	2                       @ 0x2
.LCPI5_5:
	.long	.L.str.2
.LCPI5_6:
	.long	1                       @ 0x1
.LCPI5_7:
	.long	.L.str.2
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
	.asciz	"%d "
	.size	.L.str, 4

	.type	.L.str.1,%object        @ @.str.1
.L.str.1:
	.asciz	"%d\n"
	.size	.L.str.1, 4

	.type	.L.str.2,%object        @ @.str.2
.L.str.2:
	.asciz	"%d"
	.size	.L.str.2, 3


	.ident	"clang version 7.0.1-8+rpi3 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym _cleanBoard
	.addrsig_sym _printBoard
	.addrsig_sym printf
	.addrsig_sym _printMoveBoard
	.addrsig_sym _placePiece
	.addrsig_sym _checkWinner
	.addrsig_sym _main
	.addrsig_sym malloc
	.addrsig_sym __isoc99_scanf
	.addrsig_sym main
