	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_printgroup             @ -- Begin function _printgroup
	.p2align	2
	.type	_printgroup,%function
	.code	32                      @ @_printgroup
_printgroup:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#32
	sub	sp, sp, #32
	ldr	r1, .LCPI0_8
	ldr	r2, .LCPI0_4
	str	r0, [r11, #-4]
	mov	r0, r1
	mov	r1, r2
	bl	printf
	ldr	r1, .LCPI0_7
	ldr	r2, .LCPI0_2
	str	r0, [r11, #-8]          @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	printf
	ldr	r1, .LCPI0_6
	ldr	r2, .LCPI0_4
	str	r0, [r11, #-12]         @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	printf
	ldr	r1, .LCPI0_5
	ldr	r2, .LCPI0_2
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	printf
	ldr	r1, .LCPI0_3
	ldr	r2, .LCPI0_4
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	printf
	ldr	r1, .LCPI0_1
	ldr	r2, .LCPI0_2
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	printf
	ldr	r1, .LCPI0_0
	ldr	r2, [r11, #-4]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	printf
	str	r0, [sp]                @ 4-byte Spill
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI0_0:
	.long	.L.str.1
.LCPI0_1:
	.long	.L.str
.LCPI0_2:
	.long	0                       @ 0x0
.LCPI0_3:
	.long	.L.str
.LCPI0_4:
	.long	1                       @ 0x1
.LCPI0_5:
	.long	.L.str
.LCPI0_6:
	.long	.L.str
.LCPI0_7:
	.long	.L.str
.LCPI0_8:
	.long	.L.str
.Lfunc_end0:
	.size	_printgroup, .Lfunc_end0-_printgroup
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_setcounter             @ -- Begin function _setcounter
	.p2align	2
	.type	_setcounter,%function
	.code	32                      @ @_setcounter
_setcounter:
	.fnstart
@ %bb.0:
	.pad	#4
	sub	sp, sp, #4
	ldr	r1, .LCPI1_0
	ldr	r2, .LCPI1_1
	str	r0, [sp]
	ldr	r0, [sp]
	str	r0, [r2]
	mov	r0, r1
	add	sp, sp, #4
	bx	lr
	.p2align	2
@ %bb.1:
.LCPI1_0:
	.long	1                       @ 0x1
.LCPI1_1:
	.long	EV_counter
.Lfunc_end1:
	.size	_setcounter, .Lfunc_end1-_setcounter
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_takealltypes           @ -- Begin function _takealltypes
	.p2align	2
	.type	_takealltypes,%function
	.code	32                      @ @_takealltypes
_takealltypes:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#40
	sub	sp, sp, #40
	str	r0, [r11, #-4]
	str	r1, [r11, #-8]
	str	r2, [r11, #-12]
	ldr	r0, [r11, #-4]
	cmp	r0, #3
	bne	.LBB2_2
@ %bb.1:
	ldr	r0, .LCPI2_2
	ldr	r1, .LCPI2_3
	bl	printf
	str	r0, [r11, #-16]         @ 4-byte Spill
	b	.LBB2_3
.LBB2_2:
	ldr	r0, .LCPI2_0
	ldr	r1, .LCPI2_1
	bl	printf
	str	r0, [sp, #20]           @ 4-byte Spill
.LBB2_3:
	ldr	r0, [r11, #-8]
	cmp	r0, #0
	beq	.LBB2_5
@ %bb.4:
	ldr	r0, .LCPI2_5
	ldr	r1, .LCPI2_3
	bl	printf
	str	r0, [sp, #16]           @ 4-byte Spill
	b	.LBB2_6
.LBB2_5:
	ldr	r0, .LCPI2_4
	ldr	r1, .LCPI2_1
	bl	printf
	str	r0, [sp, #12]           @ 4-byte Spill
.LBB2_6:
	ldr	r0, [r11, #-12]
	ldr	r0, [r0, #4]
	cmp	r0, #0
	beq	.LBB2_8
@ %bb.7:
	ldr	r0, .LCPI2_7
	ldr	r1, .LCPI2_3
	bl	printf
	str	r0, [sp, #8]            @ 4-byte Spill
	b	.LBB2_9
.LBB2_8:
	ldr	r0, .LCPI2_6
	ldr	r1, .LCPI2_1
	bl	printf
	str	r0, [sp, #4]            @ 4-byte Spill
.LBB2_9:
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.10:
.LCPI2_0:
	.long	.L.str.1
.LCPI2_1:
	.long	0                       @ 0x0
.LCPI2_2:
	.long	.L.str.1
.LCPI2_3:
	.long	1                       @ 0x1
.LCPI2_4:
	.long	.L.str.1
.LCPI2_5:
	.long	.L.str.1
.LCPI2_6:
	.long	.L.str.1
.LCPI2_7:
	.long	.L.str.1
.Lfunc_end2:
	.size	_takealltypes, .Lfunc_end2-_takealltypes
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_tonofargs              @ -- Begin function _tonofargs
	.p2align	2
	.type	_tonofargs,%function
	.code	32                      @ @_tonofargs
_tonofargs:
	.fnstart
@ %bb.0:
	.save	{r4, r5, r11, lr}
	push	{r4, r5, r11, lr}
	.setfp	r11, sp, #8
	add	r11, sp, #8
	.pad	#80
	sub	sp, sp, #80
	ldr	r12, [r11, #20]
	ldr	lr, [r11, #16]
	ldr	r4, [r11, #12]
	ldr	r5, [r11, #8]
	str	r0, [r11, #-12]
	str	r1, [r11, #-16]
	str	r2, [r11, #-20]
	str	r3, [r11, #-24]
	ldr	r0, [r11, #8]
	cmp	r0, #5
	str	r5, [r11, #-28]         @ 4-byte Spill
	str	r12, [r11, #-32]        @ 4-byte Spill
	str	lr, [r11, #-36]         @ 4-byte Spill
	str	r4, [r11, #-40]         @ 4-byte Spill
	bne	.LBB3_2
@ %bb.1:
	ldr	r0, .LCPI3_3
	ldr	r1, .LCPI3_4
	bl	printf
	str	r0, [sp, #44]           @ 4-byte Spill
	b	.LBB3_3
.LBB3_2:
	ldr	r0, .LCPI3_1
	ldr	r1, .LCPI3_2
	bl	printf
	ldr	r1, .LCPI3_0
	ldr	lr, [r11, #8]
	str	r0, [sp, #40]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	str	r0, [sp, #36]           @ 4-byte Spill
.LBB3_3:
	ldr	r0, [r11, #12]
	cmp	r0, #6
	bne	.LBB3_5
@ %bb.4:
	ldr	r0, .LCPI3_7
	ldr	r1, .LCPI3_4
	bl	printf
	str	r0, [sp, #32]           @ 4-byte Spill
	b	.LBB3_6
.LBB3_5:
	ldr	r0, .LCPI3_6
	ldr	r1, .LCPI3_2
	bl	printf
	ldr	r1, .LCPI3_5
	ldr	lr, [r11, #12]
	str	r0, [sp, #28]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	str	r0, [sp, #24]           @ 4-byte Spill
.LBB3_6:
	ldr	r0, [r11, #16]
	cmp	r0, #7
	bne	.LBB3_8
@ %bb.7:
	ldr	r0, .LCPI3_10
	ldr	r1, .LCPI3_4
	bl	printf
	str	r0, [sp, #20]           @ 4-byte Spill
	b	.LBB3_9
.LBB3_8:
	ldr	r0, .LCPI3_9
	ldr	r1, .LCPI3_2
	bl	printf
	ldr	r1, .LCPI3_8
	ldr	lr, [r11, #16]
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	str	r0, [sp, #12]           @ 4-byte Spill
.LBB3_9:
	ldr	r0, [r11, #20]
	cmp	r0, #8
	bne	.LBB3_11
@ %bb.10:
	ldr	r0, .LCPI3_13
	ldr	r1, .LCPI3_4
	bl	printf
	str	r0, [sp, #8]            @ 4-byte Spill
	b	.LBB3_12
.LBB3_11:
	ldr	r0, .LCPI3_12
	ldr	r1, .LCPI3_2
	bl	printf
	ldr	r1, .LCPI3_11
	ldr	lr, [r11, #20]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	str	r0, [sp]                @ 4-byte Spill
.LBB3_12:
	sub	sp, r11, #8
	pop	{r4, r5, r11, pc}
	.p2align	2
@ %bb.13:
.LCPI3_0:
	.long	.L.str.1
.LCPI3_1:
	.long	.L.str
.LCPI3_2:
	.long	0                       @ 0x0
.LCPI3_3:
	.long	.L.str.1
.LCPI3_4:
	.long	1                       @ 0x1
.LCPI3_5:
	.long	.L.str.1
.LCPI3_6:
	.long	.L.str
.LCPI3_7:
	.long	.L.str.1
.LCPI3_8:
	.long	.L.str.1
.LCPI3_9:
	.long	.L.str
.LCPI3_10:
	.long	.L.str.1
.LCPI3_11:
	.long	.L.str.1
.LCPI3_12:
	.long	.L.str
.LCPI3_13:
	.long	.L.str.1
.Lfunc_end3:
	.size	_tonofargs, .Lfunc_end3-_tonofargs
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_returnint              @ -- Begin function _returnint
	.p2align	2
	.type	_returnint,%function
	.code	32                      @ @_returnint
_returnint:
	.fnstart
@ %bb.0:
	.pad	#4
	sub	sp, sp, #4
	str	r0, [sp]
	ldr	r0, [sp]
	add	sp, sp, #4
	bx	lr
.Lfunc_end4:
	.size	_returnint, .Lfunc_end4-_returnint
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_returnbool             @ -- Begin function _returnbool
	.p2align	2
	.type	_returnbool,%function
	.code	32                      @ @_returnbool
_returnbool:
	.fnstart
@ %bb.0:
	.pad	#4
	sub	sp, sp, #4
	str	r0, [sp]
	ldr	r0, [sp]
	add	sp, sp, #4
	bx	lr
.Lfunc_end5:
	.size	_returnbool, .Lfunc_end5-_returnbool
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_returnstruct           @ -- Begin function _returnstruct
	.p2align	2
	.type	_returnstruct,%function
	.code	32                      @ @_returnstruct
_returnstruct:
	.fnstart
@ %bb.0:
	.pad	#4
	sub	sp, sp, #4
	str	r0, [sp]
	ldr	r0, [sp]
	add	sp, sp, #4
	bx	lr
.Lfunc_end6:
	.size	_returnstruct, .Lfunc_end6-_returnstruct
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
	.save	{r4, r5, r6, r10, r11, lr}
	push	{r4, r5, r6, r10, r11, lr}
	.setfp	r11, sp, #16
	add	r11, sp, #16
	.pad	#400
	sub	sp, sp, #400
	ldr	r0, .LCPI7_1
	ldr	r1, .LCPI7_0
	ldr	r2, .LCPI7_2
	str	r1, [r2]
	bl	_printgroup
	ldr	r0, .LCPI7_0
	str	r0, [r11, #-20]
	str	r0, [r11, #-24]
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	beq	.LBB7_3
@ %bb.1:
	ldr	r0, [r11, #-24]
	cmp	r0, #0
	beq	.LBB7_3
@ %bb.2:
	ldr	r0, .LCPI7_4
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [r11, #-48]         @ 4-byte Spill
	b	.LBB7_4
.LBB7_3:
	ldr	r0, .LCPI7_3
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [r11, #-52]         @ 4-byte Spill
.LBB7_4:
	ldr	r0, .LCPI7_0
	ldr	r1, .LCPI7_1
	str	r1, [r11, #-20]
	str	r0, [r11, #-24]
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	beq	.LBB7_7
@ %bb.5:
	ldr	r0, [r11, #-24]
	cmp	r0, #0
	beq	.LBB7_7
@ %bb.6:
	ldr	r0, .LCPI7_6
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [r11, #-56]         @ 4-byte Spill
	b	.LBB7_8
.LBB7_7:
	ldr	r0, .LCPI7_5
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [r11, #-60]         @ 4-byte Spill
.LBB7_8:
	ldr	r0, .LCPI7_1
	ldr	r1, .LCPI7_0
	str	r1, [r11, #-20]
	str	r0, [r11, #-24]
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	beq	.LBB7_11
@ %bb.9:
	ldr	r0, [r11, #-24]
	cmp	r0, #0
	beq	.LBB7_11
@ %bb.10:
	ldr	r0, .LCPI7_8
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [r11, #-64]         @ 4-byte Spill
	b	.LBB7_12
.LBB7_11:
	ldr	r0, .LCPI7_7
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [r11, #-68]         @ 4-byte Spill
.LBB7_12:
	ldr	r0, .LCPI7_1
	str	r0, [r11, #-20]
	str	r0, [r11, #-24]
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	beq	.LBB7_15
@ %bb.13:
	ldr	r0, [r11, #-24]
	cmp	r0, #0
	beq	.LBB7_15
@ %bb.14:
	ldr	r0, .LCPI7_10
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [r11, #-72]         @ 4-byte Spill
	b	.LBB7_16
.LBB7_15:
	ldr	r0, .LCPI7_9
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [r11, #-76]         @ 4-byte Spill
.LBB7_16:
	ldr	r0, .LCPI7_11
	ldr	r1, .LCPI7_0
	ldr	r2, .LCPI7_12
	str	r1, [r2]
	bl	_printgroup
	ldr	r0, .LCPI7_1
	str	r0, [r11, #-20]
	str	r0, [r11, #-24]
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	bne	.LBB7_18
@ %bb.17:
	ldr	r0, [r11, #-24]
	cmp	r0, #0
	beq	.LBB7_19
.LBB7_18:
	ldr	r0, .LCPI7_14
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [r11, #-80]         @ 4-byte Spill
	b	.LBB7_20
.LBB7_19:
	ldr	r0, .LCPI7_13
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [r11, #-84]         @ 4-byte Spill
.LBB7_20:
	ldr	r0, .LCPI7_0
	ldr	r1, .LCPI7_1
	str	r1, [r11, #-20]
	str	r0, [r11, #-24]
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	bne	.LBB7_22
@ %bb.21:
	ldr	r0, [r11, #-24]
	cmp	r0, #0
	beq	.LBB7_23
.LBB7_22:
	ldr	r0, .LCPI7_16
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [r11, #-88]         @ 4-byte Spill
	b	.LBB7_24
.LBB7_23:
	ldr	r0, .LCPI7_15
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [r11, #-92]         @ 4-byte Spill
.LBB7_24:
	ldr	r0, .LCPI7_1
	ldr	r1, .LCPI7_0
	str	r1, [r11, #-20]
	str	r0, [r11, #-24]
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	bne	.LBB7_26
@ %bb.25:
	ldr	r0, [r11, #-24]
	cmp	r0, #0
	beq	.LBB7_27
.LBB7_26:
	ldr	r0, .LCPI7_18
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [r11, #-96]         @ 4-byte Spill
	b	.LBB7_28
.LBB7_27:
	ldr	r0, .LCPI7_17
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [r11, #-100]        @ 4-byte Spill
.LBB7_28:
	ldr	r0, .LCPI7_0
	str	r0, [r11, #-20]
	str	r0, [r11, #-24]
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	bne	.LBB7_30
@ %bb.29:
	ldr	r0, [r11, #-24]
	cmp	r0, #0
	beq	.LBB7_31
.LBB7_30:
	ldr	r0, .LCPI7_20
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [r11, #-104]        @ 4-byte Spill
	b	.LBB7_32
.LBB7_31:
	ldr	r0, .LCPI7_19
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [r11, #-108]        @ 4-byte Spill
.LBB7_32:
	ldr	r0, .LCPI7_40
	bl	_printgroup
	ldr	r0, .LCPI7_39
	ldr	r1, .LCPI7_1
	bl	printf
	ldr	r1, .LCPI7_38
	ldr	lr, .LCPI7_1
	str	r0, [r11, #-112]        @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI7_37
	ldr	lr, .LCPI7_1
	str	r0, [r11, #-116]        @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI7_36
	ldr	lr, .LCPI7_1
	str	r0, [r11, #-120]        @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI7_35
	ldr	lr, .LCPI7_1
	str	r0, [r11, #-124]        @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI7_34
	ldr	lr, .LCPI7_1
	str	r0, [r11, #-128]        @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI7_33
	ldr	lr, .LCPI7_1
	str	r0, [r11, #-132]        @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI7_32
	ldr	lr, .LCPI7_1
	str	r0, [r11, #-136]        @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI7_31
	ldr	lr, .LCPI7_1
	str	r0, [r11, #-140]        @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI7_30
	ldr	lr, .LCPI7_1
	str	r0, [r11, #-144]        @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI7_29
	ldr	lr, .LCPI7_1
	str	r0, [r11, #-148]        @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI7_28
	str	r0, [r11, #-152]        @ 4-byte Spill
	mov	r0, r1
	bl	_printgroup
	ldr	r0, .LCPI7_27
	ldr	r1, .LCPI7_1
	bl	printf
	ldr	r1, .LCPI7_26
	ldr	lr, .LCPI7_1
	str	r0, [r11, #-156]        @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI7_25
	ldr	lr, .LCPI7_1
	str	r0, [r11, #-160]        @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI7_24
	ldr	lr, .LCPI7_1
	str	r0, [r11, #-164]        @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI7_23
	ldr	lr, .LCPI7_1
	str	r0, [r11, #-168]        @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI7_22
	str	r0, [r11, #-172]        @ 4-byte Spill
	mov	r0, r1
	bl	_printgroup
	ldr	r0, .LCPI7_21
	str	r0, [r11, #-28]
	ldr	r0, [r11, #-28]
	cmp	r0, #42
	bne	.LBB7_34
@ %bb.33:
	ldr	r0, .LCPI7_42
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [r11, #-176]        @ 4-byte Spill
	b	.LBB7_35
.LBB7_34:
	ldr	r0, .LCPI7_41
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [r11, #-180]        @ 4-byte Spill
.LBB7_35:
	ldr	r0, .LCPI7_11
	ldr	r1, .LCPI7_40
	str	r1, [r11, #-28]
	str	r0, [r11, #-32]
	ldr	r0, [r11, #-28]
	ldr	r1, [r11, #-32]
	add	r0, r0, r1
	str	r0, [r11, #-36]
	ldr	r0, [r11, #-36]
	cmp	r0, #5
	bne	.LBB7_37
@ %bb.36:
	ldr	r0, .LCPI7_44
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [r11, #-184]        @ 4-byte Spill
	b	.LBB7_38
.LBB7_37:
	ldr	r0, .LCPI7_43
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [r11, #-188]        @ 4-byte Spill
.LBB7_38:
	ldr	r0, .LCPI7_1
	str	r0, [r11, #-20]
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	beq	.LBB7_40
@ %bb.39:
	ldr	r0, .LCPI7_46
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [r11, #-192]        @ 4-byte Spill
	b	.LBB7_41
.LBB7_40:
	ldr	r0, .LCPI7_45
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [r11, #-196]        @ 4-byte Spill
.LBB7_41:
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	bne	.LBB7_43
@ %bb.42:
	ldr	r0, .LCPI7_47
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [r11, #-200]        @ 4-byte Spill
	b	.LBB7_44
.LBB7_43:
	ldr	r0, .LCPI7_48
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [r11, #-204]        @ 4-byte Spill
.LBB7_44:
	ldr	r0, .LCPI7_0
	str	r0, [r11, #-20]
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	beq	.LBB7_46
@ %bb.45:
	ldr	r0, .LCPI7_50
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [sp, #208]          @ 4-byte Spill
	b	.LBB7_47
.LBB7_46:
	ldr	r0, .LCPI7_49
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #204]          @ 4-byte Spill
.LBB7_47:
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	bne	.LBB7_49
@ %bb.48:
	ldr	r0, .LCPI7_51
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #200]          @ 4-byte Spill
	b	.LBB7_50
.LBB7_49:
	ldr	r0, .LCPI7_52
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [sp, #196]          @ 4-byte Spill
.LBB7_50:
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	beq	.LBB7_52
@ %bb.51:
	ldr	r0, .LCPI7_54
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [sp, #192]          @ 4-byte Spill
	b	.LBB7_53
.LBB7_52:
	ldr	r0, .LCPI7_53
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #188]          @ 4-byte Spill
.LBB7_53:
	ldr	r0, .LCPI7_55
	bl	_printgroup
	ldr	r0, .LCPI7_0
	str	r0, [r11, #-28]
.LBB7_54:                               @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-28]
	cmp	r0, #5
	bge	.LBB7_58
@ %bb.55:                               @   in Loop: Header=BB7_54 Depth=1
	ldr	r0, [r11, #-28]
	cmp	r0, #5
	blt	.LBB7_57
@ %bb.56:                               @   in Loop: Header=BB7_54 Depth=1
	ldr	r0, .LCPI7_116
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [sp, #184]          @ 4-byte Spill
.LBB7_57:                               @   in Loop: Header=BB7_54 Depth=1
	ldr	r0, [r11, #-28]
	add	r0, r0, #5
	str	r0, [r11, #-28]
	b	.LBB7_54
.LBB7_58:
	ldr	r0, [r11, #-28]
	cmp	r0, #5
	bne	.LBB7_60
@ %bb.59:
	ldr	r0, .LCPI7_58
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #180]          @ 4-byte Spill
	b	.LBB7_61
.LBB7_60:
	ldr	r0, .LCPI7_57
	ldr	r1, .LCPI7_0
	bl	printf
	ldr	r1, .LCPI7_56
	ldr	lr, [r11, #-28]
	str	r0, [sp, #176]          @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	str	r0, [sp, #172]          @ 4-byte Spill
.LBB7_61:
	ldr	r0, .LCPI7_60
	bl	_printgroup
	ldr	r0, .LCPI7_59
	bl	malloc
	ldr	lr, .LCPI7_1
	ldr	r1, .LCPI7_21
	str	r0, [r11, #-40]
	ldr	r0, [r11, #-40]
	str	r1, [r0]
	ldr	r0, [r11, #-40]
	str	lr, [r0, #4]
	ldr	r0, [r11, #-40]
	ldr	r0, [r0]
	cmp	r0, #42
	bne	.LBB7_63
@ %bb.62:
	ldr	r0, .LCPI7_63
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #168]          @ 4-byte Spill
	b	.LBB7_64
.LBB7_63:
	ldr	r0, .LCPI7_62
	ldr	r1, .LCPI7_0
	bl	printf
	ldr	r1, .LCPI7_61
	ldr	lr, [r11, #-40]
	ldr	lr, [lr]
	str	r0, [sp, #164]          @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	str	r0, [sp, #160]          @ 4-byte Spill
.LBB7_64:
	ldr	r0, [r11, #-40]
	ldr	r0, [r0, #4]
	cmp	r0, #0
	beq	.LBB7_66
@ %bb.65:
	ldr	r0, .LCPI7_65
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #156]          @ 4-byte Spill
	b	.LBB7_67
.LBB7_66:
	ldr	r0, .LCPI7_64
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [sp, #152]          @ 4-byte Spill
.LBB7_67:
	ldr	r0, .LCPI7_59
	bl	malloc
	ldr	lr, .LCPI7_0
	ldr	r1, .LCPI7_66
	ldr	r2, [r11, #-40]
	str	r0, [r2, #8]
	ldr	r0, [r11, #-40]
	ldr	r0, [r0, #8]
	str	r1, [r0]
	ldr	r0, [r11, #-40]
	ldr	r0, [r0, #8]
	str	lr, [r0, #4]
	ldr	r0, [r11, #-40]
	ldr	r0, [r0, #8]
	ldr	r0, [r0]
	cmp	r0, #13
	bne	.LBB7_69
@ %bb.68:
	ldr	r0, .LCPI7_69
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #148]          @ 4-byte Spill
	b	.LBB7_70
.LBB7_69:
	ldr	r0, .LCPI7_68
	ldr	r1, .LCPI7_0
	bl	printf
	ldr	r1, .LCPI7_67
	ldr	lr, [r11, #-40]
	ldr	lr, [lr, #8]
	ldr	lr, [lr]
	str	r0, [sp, #144]          @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	str	r0, [sp, #140]          @ 4-byte Spill
.LBB7_70:
	ldr	r0, [r11, #-40]
	ldr	r0, [r0, #8]
	ldr	r0, [r0, #4]
	cmp	r0, #0
	bne	.LBB7_72
@ %bb.71:
	ldr	r0, .LCPI7_70
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #136]          @ 4-byte Spill
	b	.LBB7_73
.LBB7_72:
	ldr	r0, .LCPI7_71
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [sp, #132]          @ 4-byte Spill
.LBB7_73:
	ldr	r0, [r11, #-40]
	ldr	r1, [r11, #-40]
	cmp	r0, r1
	bne	.LBB7_75
@ %bb.74:
	ldr	r0, .LCPI7_73
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #128]          @ 4-byte Spill
	b	.LBB7_76
.LBB7_75:
	ldr	r0, .LCPI7_72
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [sp, #124]          @ 4-byte Spill
.LBB7_76:
	ldr	r0, [r11, #-40]
	ldr	r1, [r11, #-40]
	ldr	r1, [r1, #8]
	cmp	r0, r1
	beq	.LBB7_78
@ %bb.77:
	ldr	r0, .LCPI7_75
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #120]          @ 4-byte Spill
	b	.LBB7_79
.LBB7_78:
	ldr	r0, .LCPI7_74
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [sp, #116]          @ 4-byte Spill
.LBB7_79:
	ldr	r0, [r11, #-40]
	ldr	r0, [r0, #8]
	bl	free
	ldr	r0, [r11, #-40]
	bl	free
	ldr	r0, .LCPI7_77
	bl	_printgroup
	ldr	r0, .LCPI7_76
	ldr	lr, .LCPI7_60
	str	lr, [r0]
	ldr	r0, [r0]
	cmp	r0, #7
	bne	.LBB7_81
@ %bb.80:
	ldr	r0, .LCPI7_81
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #112]          @ 4-byte Spill
	b	.LBB7_82
.LBB7_81:
	ldr	r0, .LCPI7_80
	ldr	r1, .LCPI7_0
	bl	printf
	ldr	r1, .LCPI7_78
	ldr	lr, .LCPI7_79
	ldr	lr, [lr]
	str	r0, [sp, #108]          @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	str	r0, [sp, #104]          @ 4-byte Spill
.LBB7_82:
	ldr	r0, .LCPI7_82
	ldr	r1, .LCPI7_1
	str	r1, [r0]
	ldr	r0, [r0]
	cmp	r0, #0
	beq	.LBB7_84
@ %bb.83:
	ldr	r0, .LCPI7_84
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #100]          @ 4-byte Spill
	b	.LBB7_85
.LBB7_84:
	ldr	r0, .LCPI7_83
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [sp, #96]           @ 4-byte Spill
.LBB7_85:
	ldr	r0, .LCPI7_59
	bl	malloc
	ldr	lr, .LCPI7_85
	ldr	r1, .LCPI7_0
	ldr	r2, .LCPI7_86
	str	r0, [lr]
	ldr	r0, [lr]
	str	r2, [r0]
	ldr	r0, [lr]
	str	r1, [r0, #4]
	ldr	r0, [lr]
	ldr	r0, [r0]
	cmp	r0, #34
	bne	.LBB7_87
@ %bb.86:
	ldr	r0, .LCPI7_90
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #92]           @ 4-byte Spill
	b	.LBB7_88
.LBB7_87:
	ldr	r0, .LCPI7_89
	ldr	r1, .LCPI7_0
	bl	printf
	ldr	r1, .LCPI7_87
	ldr	lr, .LCPI7_88
	ldr	lr, [lr]
	ldr	lr, [lr]
	str	r0, [sp, #88]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	str	r0, [sp, #84]           @ 4-byte Spill
.LBB7_88:
	ldr	r0, .LCPI7_91
	ldr	r0, [r0]
	ldr	r0, [r0, #4]
	cmp	r0, #0
	bne	.LBB7_90
@ %bb.89:
	ldr	r0, .LCPI7_92
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #80]           @ 4-byte Spill
	b	.LBB7_91
.LBB7_90:
	ldr	r0, .LCPI7_93
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [sp, #76]           @ 4-byte Spill
.LBB7_91:
	ldr	r0, .LCPI7_59
	bl	malloc
	ldr	lr, .LCPI7_94
	ldr	r1, .LCPI7_1
	ldr	r2, .LCPI7_95
	ldr	r3, [lr]
	str	r0, [r3, #8]
	ldr	r0, [lr]
	ldr	r0, [r0, #8]
	str	r2, [r0]
	ldr	r0, [lr]
	ldr	r0, [r0, #8]
	str	r1, [r0, #4]
	ldr	r0, [lr]
	ldr	r0, [r0, #8]
	ldr	r0, [r0]
	cmp	r0, #16
	bne	.LBB7_93
@ %bb.92:
	ldr	r0, .LCPI7_99
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #72]           @ 4-byte Spill
	b	.LBB7_94
.LBB7_93:
	ldr	r0, .LCPI7_98
	ldr	r1, .LCPI7_0
	bl	printf
	ldr	r1, .LCPI7_96
	ldr	lr, .LCPI7_97
	ldr	lr, [lr]
	ldr	lr, [lr, #8]
	ldr	lr, [lr]
	str	r0, [sp, #68]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	str	r0, [sp, #64]           @ 4-byte Spill
.LBB7_94:
	ldr	r0, .LCPI7_100
	ldr	r0, [r0]
	ldr	r0, [r0, #8]
	ldr	r0, [r0, #4]
	cmp	r0, #0
	beq	.LBB7_96
@ %bb.95:
	ldr	r0, .LCPI7_102
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #60]           @ 4-byte Spill
	b	.LBB7_97
.LBB7_96:
	ldr	r0, .LCPI7_101
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [sp, #56]           @ 4-byte Spill
.LBB7_97:
	ldr	r0, .LCPI7_107
	ldr	r0, [r0]
	ldr	r0, [r0, #8]
	bl	free
	ldr	r0, .LCPI7_106
	ldr	r0, [r0]
	bl	free
	ldr	r0, .LCPI7_105
	bl	_printgroup
	ldr	r0, .LCPI7_59
	bl	malloc
	ldr	lr, .LCPI7_40
	ldr	r1, .LCPI7_1
	str	r0, [r11, #-40]
	ldr	r0, [r11, #-40]
	str	r1, [r0, #4]
	ldr	r2, [r11, #-40]
	mov	r0, lr
	bl	_takealltypes
	ldr	r0, .LCPI7_104
	ldr	r1, .LCPI7_11
	bl	printf
	ldr	r1, .LCPI7_1
	ldr	r2, .LCPI7_11
	ldr	lr, .LCPI7_40
	ldr	r3, .LCPI7_28
	ldr	r12, .LCPI7_22
	ldr	r4, .LCPI7_55
	ldr	r5, .LCPI7_60
	ldr	r6, .LCPI7_77
	str	r0, [sp, #52]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	mov	r2, lr
	str	r12, [sp]
	str	r4, [sp, #4]
	str	r5, [sp, #8]
	str	r6, [sp, #12]
	bl	_tonofargs
	ldr	r0, .LCPI7_103
	ldr	r1, .LCPI7_40
	bl	printf
	ldr	r1, .LCPI7_40
	str	r0, [sp, #48]           @ 4-byte Spill
	mov	r0, r1
	bl	_returnint
	str	r0, [r11, #-28]
	ldr	r0, [r11, #-28]
	cmp	r0, #3
	bne	.LBB7_99
@ %bb.98:
	ldr	r0, .LCPI7_110
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #44]           @ 4-byte Spill
	b	.LBB7_100
.LBB7_99:
	ldr	r0, .LCPI7_109
	ldr	r1, .LCPI7_0
	bl	printf
	ldr	r1, .LCPI7_108
	ldr	lr, [r11, #-28]
	str	r0, [sp, #40]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	str	r0, [sp, #36]           @ 4-byte Spill
.LBB7_100:
	ldr	r0, .LCPI7_1
	bl	_returnbool
	str	r0, [r11, #-20]
	ldr	r0, [r11, #-20]
	cmp	r0, #0
	beq	.LBB7_102
@ %bb.101:
	ldr	r0, .LCPI7_112
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #32]           @ 4-byte Spill
	b	.LBB7_103
.LBB7_102:
	ldr	r0, .LCPI7_111
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [sp, #28]           @ 4-byte Spill
.LBB7_103:
	ldr	r0, .LCPI7_59
	bl	malloc
	str	r0, [r11, #-40]
	ldr	r0, [r11, #-40]
	bl	_returnstruct
	str	r0, [r11, #-44]
	ldr	r0, [r11, #-40]
	ldr	lr, [r11, #-44]
	cmp	r0, lr
	bne	.LBB7_105
@ %bb.104:
	ldr	r0, .LCPI7_114
	ldr	r1, .LCPI7_1
	bl	printf
	str	r0, [sp, #24]           @ 4-byte Spill
	b	.LBB7_106
.LBB7_105:
	ldr	r0, .LCPI7_113
	ldr	r1, .LCPI7_0
	bl	printf
	str	r0, [sp, #20]           @ 4-byte Spill
.LBB7_106:
	ldr	r0, .LCPI7_115
	bl	_printgroup
	ldr	r0, .LCPI7_0
	sub	sp, r11, #16
	pop	{r4, r5, r6, r10, r11, pc}
	.p2align	2
@ %bb.107:
.LCPI7_0:
	.long	0                       @ 0x0
.LCPI7_1:
	.long	1                       @ 0x1
.LCPI7_2:
	.long	EV_counter
.LCPI7_3:
	.long	.L.str.1
.LCPI7_4:
	.long	.L.str.1
.LCPI7_5:
	.long	.L.str.1
.LCPI7_6:
	.long	.L.str.1
.LCPI7_7:
	.long	.L.str.1
.LCPI7_8:
	.long	.L.str.1
.LCPI7_9:
	.long	.L.str.1
.LCPI7_10:
	.long	.L.str.1
.LCPI7_11:
	.long	2                       @ 0x2
.LCPI7_12:
	.long	EV_counter
.LCPI7_13:
	.long	.L.str.1
.LCPI7_14:
	.long	.L.str.1
.LCPI7_15:
	.long	.L.str.1
.LCPI7_16:
	.long	.L.str.1
.LCPI7_17:
	.long	.L.str.1
.LCPI7_18:
	.long	.L.str.1
.LCPI7_19:
	.long	.L.str.1
.LCPI7_20:
	.long	.L.str.1
.LCPI7_21:
	.long	42                      @ 0x2a
.LCPI7_22:
	.long	5                       @ 0x5
.LCPI7_23:
	.long	.L.str.1
.LCPI7_24:
	.long	.L.str.1
.LCPI7_25:
	.long	.L.str.1
.LCPI7_26:
	.long	.L.str.1
.LCPI7_27:
	.long	.L.str.1
.LCPI7_28:
	.long	4                       @ 0x4
.LCPI7_29:
	.long	.L.str.1
.LCPI7_30:
	.long	.L.str.1
.LCPI7_31:
	.long	.L.str.1
.LCPI7_32:
	.long	.L.str.1
.LCPI7_33:
	.long	.L.str.1
.LCPI7_34:
	.long	.L.str.1
.LCPI7_35:
	.long	.L.str.1
.LCPI7_36:
	.long	.L.str.1
.LCPI7_37:
	.long	.L.str.1
.LCPI7_38:
	.long	.L.str.1
.LCPI7_39:
	.long	.L.str.1
.LCPI7_40:
	.long	3                       @ 0x3
.LCPI7_41:
	.long	.L.str.1
.LCPI7_42:
	.long	.L.str.1
.LCPI7_43:
	.long	.L.str.1
.LCPI7_44:
	.long	.L.str.1
.LCPI7_45:
	.long	.L.str.1
.LCPI7_46:
	.long	.L.str.1
.LCPI7_47:
	.long	.L.str.1
.LCPI7_48:
	.long	.L.str.1
.LCPI7_49:
	.long	.L.str.1
.LCPI7_50:
	.long	.L.str.1
.LCPI7_51:
	.long	.L.str.1
.LCPI7_52:
	.long	.L.str.1
.LCPI7_53:
	.long	.L.str.1
.LCPI7_54:
	.long	.L.str.1
.LCPI7_55:
	.long	6                       @ 0x6
.LCPI7_56:
	.long	.L.str.1
.LCPI7_57:
	.long	.L.str
.LCPI7_58:
	.long	.L.str.1
.LCPI7_59:
	.long	12                      @ 0xc
.LCPI7_60:
	.long	7                       @ 0x7
.LCPI7_61:
	.long	.L.str.1
.LCPI7_62:
	.long	.L.str
.LCPI7_63:
	.long	.L.str.1
.LCPI7_64:
	.long	.L.str.1
.LCPI7_65:
	.long	.L.str.1
.LCPI7_66:
	.long	13                      @ 0xd
.LCPI7_67:
	.long	.L.str.1
.LCPI7_68:
	.long	.L.str
.LCPI7_69:
	.long	.L.str.1
.LCPI7_70:
	.long	.L.str.1
.LCPI7_71:
	.long	.L.str.1
.LCPI7_72:
	.long	.L.str.1
.LCPI7_73:
	.long	.L.str.1
.LCPI7_74:
	.long	.L.str.1
.LCPI7_75:
	.long	.L.str.1
.LCPI7_76:
	.long	EV_gi1
.LCPI7_77:
	.long	8                       @ 0x8
.LCPI7_78:
	.long	.L.str.1
.LCPI7_79:
	.long	EV_gi1
.LCPI7_80:
	.long	.L.str
.LCPI7_81:
	.long	.L.str.1
.LCPI7_82:
	.long	EV_gb1
.LCPI7_83:
	.long	.L.str.1
.LCPI7_84:
	.long	.L.str.1
.LCPI7_85:
	.long	EV_gs1
.LCPI7_86:
	.long	34                      @ 0x22
.LCPI7_87:
	.long	.L.str.1
.LCPI7_88:
	.long	EV_gs1
.LCPI7_89:
	.long	.L.str
.LCPI7_90:
	.long	.L.str.1
.LCPI7_91:
	.long	EV_gs1
.LCPI7_92:
	.long	.L.str.1
.LCPI7_93:
	.long	.L.str.1
.LCPI7_94:
	.long	EV_gs1
.LCPI7_95:
	.long	16                      @ 0x10
.LCPI7_96:
	.long	.L.str.1
.LCPI7_97:
	.long	EV_gs1
.LCPI7_98:
	.long	.L.str
.LCPI7_99:
	.long	.L.str.1
.LCPI7_100:
	.long	EV_gs1
.LCPI7_101:
	.long	.L.str.1
.LCPI7_102:
	.long	.L.str.1
.LCPI7_103:
	.long	.L.str.1
.LCPI7_104:
	.long	.L.str.1
.LCPI7_105:
	.long	9                       @ 0x9
.LCPI7_106:
	.long	EV_gs1
.LCPI7_107:
	.long	EV_gs1
.LCPI7_108:
	.long	.L.str.1
.LCPI7_109:
	.long	.L.str
.LCPI7_110:
	.long	.L.str.1
.LCPI7_111:
	.long	.L.str.1
.LCPI7_112:
	.long	.L.str.1
.LCPI7_113:
	.long	.L.str.1
.LCPI7_114:
	.long	.L.str.1
.LCPI7_115:
	.long	10                      @ 0xa
.LCPI7_116:
	.long	.L.str.1
.Lfunc_end7:
	.size	_main, .Lfunc_end7-_main
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
	ldr	r0, .LCPI8_0
	str	r0, [sp, #4]
	bl	_main
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI8_0:
	.long	0                       @ 0x0
.Lfunc_end8:
	.size	main, .Lfunc_end8-main
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

	.type	EV_counter,%object      @ @EV_counter
	.comm	EV_counter,4,4
	.type	EV_gi1,%object          @ @EV_gi1
	.comm	EV_gi1,4,4
	.type	EV_gb1,%object          @ @EV_gb1
	.comm	EV_gb1,4,4
	.type	EV_gs1,%object          @ @EV_gs1
	.comm	EV_gs1,4,4

	.ident	"clang version 7.0.1-8+rpi3 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym _printgroup
	.addrsig_sym printf
	.addrsig_sym _setcounter
	.addrsig_sym _takealltypes
	.addrsig_sym _tonofargs
	.addrsig_sym _returnint
	.addrsig_sym _returnbool
	.addrsig_sym _returnstruct
	.addrsig_sym _main
	.addrsig_sym malloc
	.addrsig_sym free
	.addrsig_sym main
	.addrsig_sym EV_counter
	.addrsig_sym EV_gi1
	.addrsig_sym EV_gb1
	.addrsig_sym EV_gs1
