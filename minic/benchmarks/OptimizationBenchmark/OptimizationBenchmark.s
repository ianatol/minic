	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_constantFolding        @ -- Begin function _constantFolding
	.p2align	2
	.type	_constantFolding,%function
	.code	32                      @ @_constantFolding
_constantFolding:
	.fnstart
@ %bb.0:
	.pad	#4
	sub	sp, sp, #4
	ldr	r0, .LCPI0_0
	str	r0, [sp]
	ldr	r0, [sp]
	add	sp, sp, #4
	bx	lr
	.p2align	2
@ %bb.1:
.LCPI0_0:
	.long	226                     @ 0xe2
.Lfunc_end0:
	.size	_constantFolding, .Lfunc_end0-_constantFolding
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_constantPropagation    @ -- Begin function _constantPropagation
	.p2align	2
	.type	_constantPropagation,%function
	.code	32                      @ @_constantPropagation
_constantPropagation:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#112
	sub	sp, sp, #112
	ldr	r0, .LCPI1_0
	ldr	r1, .LCPI1_1
	ldr	r2, .LCPI1_2
	ldr	r3, .LCPI1_3
	ldr	r12, .LCPI1_4
	ldr	lr, .LCPI1_5
	str	lr, [r11, #-4]
	str	r12, [r11, #-8]
	str	r3, [r11, #-12]
	str	r2, [r11, #-16]
	str	r1, [r11, #-20]
	str	r0, [r11, #-24]
	ldr	r0, [r11, #-4]
	ldr	r1, [r11, #-8]
	add	r0, r0, r1
	str	r0, [r11, #-28]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	add	r0, r0, r1
	str	r0, [r11, #-32]
	ldr	r0, [r11, #-20]
	ldr	r1, [r11, #-24]
	add	r0, r0, r1
	str	r0, [r11, #-36]
	ldr	r0, [r11, #-28]
	ldr	r1, [r11, #-32]
	add	r0, r0, r1
	str	r0, [r11, #-40]
	ldr	r0, [r11, #-36]
	ldr	r1, [r11, #-40]
	mul	r0, r0, r1
	str	r0, [r11, #-44]
	ldr	r0, [r11, #-20]
	ldr	r1, [r11, #-32]
	ldr	r2, [r11, #-36]
	mul	r1, r1, r2
	add	r0, r0, r1
	ldr	r1, [r11, #-44]
	sub	r0, r0, r1
	str	r0, [r11, #-48]
	ldr	r0, [r11, #-32]
	ldr	r1, [r11, #-36]
	ldr	r2, [r11, #-40]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-44]
	ldr	r2, [r11, #-48]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #4]            @ 4-byte Reload
	add	r0, r1, r0
	str	r0, [r11, #-52]
	ldr	r0, [r11, #-20]
	ldr	r1, [r11, #-24]
	add	r0, r0, r1
	ldr	r1, [r11, #-28]
	add	r0, r0, r1
	ldr	r1, [r11, #-32]
	add	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	ldr	r1, [r11, #-40]
	sub	r0, r0, r1
	str	r0, [sp, #56]
	ldr	r0, [sp, #56]
	ldr	r1, [r11, #-52]
	sub	r0, r0, r1
	ldr	r1, [r11, #-32]
	add	r0, r0, r1
	ldr	r1, [r11, #-4]
	sub	r0, r0, r1
	ldr	r1, [r11, #-8]
	sub	r0, r0, r1
	str	r0, [sp, #52]
	ldr	r0, [r11, #-44]
	ldr	r1, [r11, #-48]
	add	r0, r0, r1
	ldr	r1, [r11, #-28]
	sub	r0, r0, r1
	ldr	r1, [r11, #-32]
	sub	r0, r0, r1
	str	r0, [sp, #48]
	ldr	r0, [r11, #-8]
	ldr	r1, [r11, #-4]
	sub	r0, r0, r1
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [r11, #-36]
	sub	r0, r0, r1
	str	r0, [sp, #44]
	ldr	r0, [r11, #-48]
	ldr	r1, [r11, #-12]
	mul	r0, r0, r1
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [sp, #52]
	add	r0, r0, r1
	str	r0, [sp, #40]
	ldr	r0, [r11, #-8]
	ldr	r1, [r11, #-4]
	mul	r0, r0, r1
	ldr	r1, [r11, #-12]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r1, [sp, #52]
	sub	r0, r0, r1
	str	r0, [sp, #36]
	ldr	r0, [r11, #-36]
	ldr	r1, [r11, #-44]
	add	r0, r0, r1
	ldr	r1, [r11, #-12]
	add	r0, r0, r1
	ldr	r1, [sp, #48]
	sub	r0, r0, r1
	str	r0, [sp, #32]
	ldr	r0, [sp, #56]
	ldr	r1, [sp, #52]
	add	r0, r0, r1
	ldr	r1, [r11, #-24]
	ldr	r2, [r11, #-4]
	mul	r1, r1, r2
	sub	r0, r0, r1
	str	r0, [sp, #28]
	ldr	r0, [r11, #-4]
	ldr	r1, [r11, #-8]
	mul	r0, r0, r1
	ldr	r1, [r11, #-44]
	sub	r0, r0, r1
	ldr	r1, [r11, #-48]
	sub	r0, r0, r1
	str	r0, [sp, #24]
	ldr	r0, [sp, #24]
	ldr	r1, [sp, #36]
	sub	r0, r0, r1
	ldr	r1, [sp, #40]
	ldr	r2, [r11, #-16]
	mul	r1, r1, r2
	sub	r0, r0, r1
	str	r0, [sp, #20]
	ldr	r0, [sp, #52]
	ldr	r1, [sp, #20]
	sub	r0, r0, r1
	ldr	r1, [sp, #24]
	sub	r0, r0, r1
	ldr	r1, [sp, #56]
	sub	r0, r0, r1
	str	r0, [sp, #16]
	ldr	r0, [sp, #48]
	ldr	r1, [sp, #16]
	mul	r0, r0, r1
	ldr	r1, [sp, #32]
	add	r0, r0, r1
	ldr	r1, [sp, #20]
	sub	r0, r0, r1
	str	r0, [sp, #12]
	ldr	r0, [sp, #20]
	ldr	r1, [sp, #16]
	sub	r0, r0, r1
	ldr	r1, [sp, #12]
	add	r0, r0, r1
	ldr	r1, [r11, #-44]
	add	r0, r0, r1
	str	r0, [sp, #8]
	ldr	r0, [sp, #8]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI1_0:
	.long	21                      @ 0x15
.LCPI1_1:
	.long	11                      @ 0xb
.LCPI1_2:
	.long	5                       @ 0x5
.LCPI1_3:
	.long	8                       @ 0x8
.LCPI1_4:
	.long	7                       @ 0x7
.LCPI1_5:
	.long	4                       @ 0x4
.Lfunc_end1:
	.size	_constantPropagation, .Lfunc_end1-_constantPropagation
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_deadCodeElimination    @ -- Begin function _deadCodeElimination
	.p2align	2
	.type	_deadCodeElimination,%function
	.code	32                      @ @_deadCodeElimination
_deadCodeElimination:
	.fnstart
@ %bb.0:
	.save	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	push	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	.setfp	r11, sp, #28
	add	r11, sp, #28
	.pad	#24
	sub	sp, sp, #24
	ldr	r0, .LCPI2_0
	ldr	r1, .LCPI2_1
	ldr	r2, .LCPI2_2
	ldr	r3, .LCPI2_3
	ldr	r12, .LCPI2_4
	ldr	lr, .LCPI2_5
	ldr	r4, .LCPI2_6
	ldr	r5, .LCPI2_7
	ldr	r6, .LCPI2_8
	ldr	r7, .LCPI2_9
	ldr	r8, .LCPI2_10
	ldr	r9, .LCPI2_11
	ldr	r10, .LCPI2_12
	str	r0, [sp]                @ 4-byte Spill
	ldr	r0, .LCPI2_13
	str	r0, [sp, #20]
	str	r2, [sp, #20]
	str	r10, [sp, #20]
	str	r8, [sp, #20]
	str	r9, [sp, #16]
	ldr	r0, [sp]                @ 4-byte Reload
	str	r0, [sp, #16]
	str	r5, [sp, #16]
	str	r8, [sp, #16]
	str	r12, [sp, #12]
	str	r7, [sp, #12]
	str	r0, [sp, #12]
	str	r6, [sp, #8]
	str	r5, [sp, #8]
	str	r4, [sp, #8]
	str	lr, [sp, #4]
	str	r12, [sp, #4]
	str	r3, [r1]
	str	r2, [r1]
	str	r0, [r1]
	ldr	r1, [sp, #20]
	ldr	r2, [sp, #16]
	add	r1, r1, r2
	ldr	r2, [sp, #12]
	add	r1, r1, r2
	ldr	r2, [sp, #8]
	add	r1, r1, r2
	ldr	r2, [sp, #4]
	add	r0, r1, r2
	sub	sp, r11, #28
	pop	{r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.p2align	2
@ %bb.1:
.LCPI2_0:
	.long	9                       @ 0x9
.LCPI2_1:
	.long	EV_global1
.LCPI2_2:
	.long	5                       @ 0x5
.LCPI2_3:
	.long	11                      @ 0xb
.LCPI2_4:
	.long	10                      @ 0xa
.LCPI2_5:
	.long	23                      @ 0x17
.LCPI2_6:
	.long	3                       @ 0x3
.LCPI2_7:
	.long	12                      @ 0xc
.LCPI2_8:
	.long	45                      @ 0x2d
.LCPI2_9:
	.long	13                      @ 0xd
.LCPI2_10:
	.long	8                       @ 0x8
.LCPI2_11:
	.long	6                       @ 0x6
.LCPI2_12:
	.long	7                       @ 0x7
.LCPI2_13:
	.long	4                       @ 0x4
.Lfunc_end2:
	.size	_deadCodeElimination, .Lfunc_end2-_deadCodeElimination
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_sum                    @ -- Begin function _sum
	.p2align	2
	.type	_sum,%function
	.code	32                      @ @_sum
_sum:
	.fnstart
@ %bb.0:
	.pad	#8
	sub	sp, sp, #8
	ldr	r1, .LCPI3_0
	str	r0, [sp, #4]
	str	r1, [sp]
.LBB3_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #4]
	cmp	r0, #0
	ble	.LBB3_3
@ %bb.2:                                @   in Loop: Header=BB3_1 Depth=1
	ldr	r0, [sp]
	ldr	r1, [sp, #4]
	add	r0, r0, r1
	str	r0, [sp]
	ldr	r0, [sp, #4]
	sub	r0, r0, #1
	str	r0, [sp, #4]
	b	.LBB3_1
.LBB3_3:
	ldr	r0, [sp]
	add	sp, sp, #8
	bx	lr
	.p2align	2
@ %bb.4:
.LCPI3_0:
	.long	0                       @ 0x0
.Lfunc_end3:
	.size	_sum, .Lfunc_end3-_sum
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_doesntModifyGlobals    @ -- Begin function _doesntModifyGlobals
	.p2align	2
	.type	_doesntModifyGlobals,%function
	.code	32                      @ @_doesntModifyGlobals
_doesntModifyGlobals:
	.fnstart
@ %bb.0:
	.pad	#8
	sub	sp, sp, #8
	ldr	r0, .LCPI4_0
	ldr	r1, .LCPI4_1
	str	r1, [sp, #4]
	str	r0, [sp]
	ldr	r0, [sp, #4]
	ldr	r1, [sp]
	add	r0, r0, r1
	add	sp, sp, #8
	bx	lr
	.p2align	2
@ %bb.1:
.LCPI4_0:
	.long	2                       @ 0x2
.LCPI4_1:
	.long	1                       @ 0x1
.Lfunc_end4:
	.size	_doesntModifyGlobals, .Lfunc_end4-_doesntModifyGlobals
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_interProceduralOptimization @ -- Begin function _interProceduralOptimization
	.p2align	2
	.type	_interProceduralOptimization,%function
	.code	32                      @ @_interProceduralOptimization
_interProceduralOptimization:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r0, .LCPI5_1
	ldr	r1, .LCPI5_2
	ldr	r2, .LCPI5_3
	ldr	r3, .LCPI5_4
	ldr	r12, .LCPI5_5
	ldr	lr, .LCPI5_6
	str	r12, [lr]
	str	r1, [r3]
	str	r1, [r2]
	bl	_sum
	ldr	r1, .LCPI5_0
	str	r0, [sp, #4]
	ldr	r0, [r1]
	cmp	r0, #1
	bne	.LBB5_2
@ %bb.1:
	ldr	r0, .LCPI5_11
	bl	_sum
	str	r0, [sp, #4]
	b	.LBB5_7
.LBB5_2:
	ldr	r0, .LCPI5_7
	ldr	r0, [r0]
	cmp	r0, #2
	bne	.LBB5_4
@ %bb.3:
	ldr	r0, .LCPI5_8
	bl	_sum
	str	r0, [sp, #4]
.LBB5_4:
	ldr	r0, .LCPI5_9
	ldr	r0, [r0]
	cmp	r0, #3
	bne	.LBB5_6
@ %bb.5:
	ldr	r0, .LCPI5_10
	bl	_sum
	str	r0, [sp, #4]
.LBB5_6:
	b	.LBB5_7
.LBB5_7:
	ldr	r0, [sp, #4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.8:
.LCPI5_0:
	.long	EV_global1
.LCPI5_1:
	.long	100                     @ 0x64
.LCPI5_2:
	.long	0                       @ 0x0
.LCPI5_3:
	.long	EV_global3
.LCPI5_4:
	.long	EV_global2
.LCPI5_5:
	.long	1                       @ 0x1
.LCPI5_6:
	.long	EV_global1
.LCPI5_7:
	.long	EV_global2
.LCPI5_8:
	.long	20000                   @ 0x4e20
.LCPI5_9:
	.long	EV_global3
.LCPI5_10:
	.long	30000                   @ 0x7530
.LCPI5_11:
	.long	10000                   @ 0x2710
.Lfunc_end5:
	.size	_interProceduralOptimization, .Lfunc_end5-_interProceduralOptimization
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_commonSubexpressionElimination @ -- Begin function _commonSubexpressionElimination
	.p2align	2
	.type	_commonSubexpressionElimination,%function
	.code	32                      @ @_commonSubexpressionElimination
_commonSubexpressionElimination:
	.fnstart
@ %bb.0:
	.save	{r4, r10, r11, lr}
	push	{r4, r10, r11, lr}
	.setfp	r11, sp, #8
	add	r11, sp, #8
	.pad	#168
	sub	sp, sp, #168
	ldr	r0, .LCPI6_0
	ldr	r1, .LCPI6_1
	ldr	r2, .LCPI6_2
	ldr	r3, .LCPI6_3
	ldr	r12, .LCPI6_4
	ldr	lr, .LCPI6_5
	ldr	r4, .LCPI6_6
	str	r4, [r11, #-12]
	str	lr, [r11, #-16]
	str	r12, [r11, #-20]
	str	r3, [r11, #-24]
	str	r2, [r11, #-28]
	str	r1, [r11, #-32]
	str	r0, [r11, #-36]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	str	r0, [r11, #-40]
	ldr	r0, [r11, #-20]
	ldr	r1, [r11, #-24]
	str	r0, [r11, #-44]
	ldr	r0, [r11, #-28]
	ldr	r1, [r11, #-32]
	mul	r0, r0, r1
	str	r0, [r11, #-48]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #60]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #60]           @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [r11, #-52]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #56]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #56]           @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [r11, #-56]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #52]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #52]           @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [r11, #-60]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #48]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #48]           @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [r11, #-64]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #44]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #44]           @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [r11, #-68]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #40]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #40]           @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [r11, #-72]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #36]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #36]           @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [r11, #-76]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #32]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #32]           @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [r11, #-80]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #28]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #28]           @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [r11, #-84]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #24]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #24]           @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [sp, #88]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #20]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #20]           @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [sp, #84]
	ldr	r0, [r11, #-16]
	ldr	r1, [r11, #-12]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #16]           @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [sp, #80]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #12]           @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-32]
	ldr	r2, [r11, #-28]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [sp, #76]
	ldr	r0, [r11, #-36]
	ldr	r1, [r11, #-12]
	ldr	r2, [r11, #-16]
	mul	r1, r1, r2
	add	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #8]            @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	str	r0, [sp, #72]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	mul	r0, r0, r1
	ldr	r1, [r11, #-20]
	ldr	r2, [r11, #-24]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #4]            @ 4-byte Reload
	add	r0, r1, r0
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [sp, #68]
	ldr	r0, [r11, #-20]
	ldr	r1, [r11, #-24]
	ldr	r1, [r11, #-12]
	ldr	r2, [r11, #-16]
	mul	r1, r1, r2
	add	r0, r0, r1
	ldr	r1, [r11, #-28]
	ldr	r2, [r11, #-32]
	mul	r1, r1, r2
	sub	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	str	r0, [sp, #64]
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-16]
	add	r0, r0, r1
	ldr	r1, [r11, #-20]
	add	r0, r0, r1
	ldr	r1, [r11, #-24]
	add	r0, r0, r1
	ldr	r1, [r11, #-28]
	add	r0, r0, r1
	ldr	r1, [r11, #-32]
	add	r0, r0, r1
	ldr	r1, [r11, #-36]
	add	r0, r0, r1
	ldr	r1, [r11, #-40]
	add	r0, r0, r1
	ldr	r1, [r11, #-44]
	add	r0, r0, r1
	ldr	r1, [r11, #-48]
	add	r0, r0, r1
	ldr	r1, [r11, #-52]
	add	r0, r0, r1
	ldr	r1, [r11, #-56]
	add	r0, r0, r1
	ldr	r1, [r11, #-60]
	add	r0, r0, r1
	ldr	r1, [r11, #-64]
	add	r0, r0, r1
	ldr	r1, [r11, #-68]
	add	r0, r0, r1
	ldr	r1, [r11, #-72]
	add	r0, r0, r1
	ldr	r1, [r11, #-76]
	add	r0, r0, r1
	ldr	r1, [r11, #-80]
	add	r0, r0, r1
	ldr	r1, [r11, #-84]
	add	r0, r0, r1
	ldr	r1, [sp, #88]
	add	r0, r0, r1
	ldr	r1, [sp, #84]
	add	r0, r0, r1
	ldr	r1, [sp, #80]
	add	r0, r0, r1
	ldr	r1, [sp, #76]
	add	r0, r0, r1
	ldr	r1, [sp, #72]
	add	r0, r0, r1
	ldr	r1, [sp, #68]
	add	r0, r0, r1
	ldr	r1, [sp, #64]
	add	r0, r0, r1
	sub	sp, r11, #8
	pop	{r4, r10, r11, pc}
	.p2align	2
@ %bb.1:
.LCPI6_0:
	.long	77                      @ 0x4d
.LCPI6_1:
	.long	66                      @ 0x42
.LCPI6_2:
	.long	55                      @ 0x37
.LCPI6_3:
	.long	44                      @ 0x2c
.LCPI6_4:
	.long	33                      @ 0x21
.LCPI6_5:
	.long	22                      @ 0x16
.LCPI6_6:
	.long	11                      @ 0xb
.Lfunc_end6:
	.size	_commonSubexpressionElimination, .Lfunc_end6-_commonSubexpressionElimination
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_hoisting               @ -- Begin function _hoisting
	.p2align	2
	.type	_hoisting,%function
	.code	32                      @ @_hoisting
_hoisting:
	.fnstart
@ %bb.0:
	.pad	#36
	sub	sp, sp, #36
	ldr	r0, .LCPI7_0
	ldr	r1, .LCPI7_1
	ldr	r2, .LCPI7_2
	ldr	r3, .LCPI7_3
	ldr	r12, .LCPI7_4
	str	r12, [sp, #32]
	str	r3, [sp, #28]
	str	r2, [sp, #24]
	str	r1, [sp, #20]
	str	r0, [sp]
.LBB7_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI7_5
	ldr	r1, [sp]
	cmp	r1, r0
	bge	.LBB7_3
@ %bb.2:                                @   in Loop: Header=BB7_1 Depth=1
	ldr	r0, .LCPI7_6
	str	r0, [sp, #16]
	ldr	r0, [sp, #32]
	ldr	r1, [sp, #28]
	add	r0, r0, r1
	ldr	r1, [sp, #24]
	add	r0, r0, r1
	str	r0, [sp, #8]
	ldr	r0, [sp, #24]
	ldr	r1, [sp, #20]
	add	r0, r0, r1
	ldr	r1, [sp, #8]
	add	r0, r0, r1
	str	r0, [sp, #4]
	ldr	r0, [sp]
	add	r0, r0, #1
	str	r0, [sp]
	b	.LBB7_1
.LBB7_3:
	ldr	r0, [sp, #28]
	add	sp, sp, #36
	bx	lr
	.p2align	2
@ %bb.4:
.LCPI7_0:
	.long	0                       @ 0x0
.LCPI7_1:
	.long	4                       @ 0x4
.LCPI7_2:
	.long	3                       @ 0x3
.LCPI7_3:
	.long	2                       @ 0x2
.LCPI7_4:
	.long	1                       @ 0x1
.LCPI7_5:
	.long	1000000                 @ 0xf4240
.LCPI7_6:
	.long	5                       @ 0x5
.Lfunc_end7:
	.size	_hoisting, .Lfunc_end7-_hoisting
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_doubleIf               @ -- Begin function _doubleIf
	.p2align	2
	.type	_doubleIf,%function
	.code	32                      @ @_doubleIf
_doubleIf:
	.fnstart
@ %bb.0:
	.pad	#16
	sub	sp, sp, #16
	ldr	r0, .LCPI8_0
	ldr	r1, .LCPI8_1
	ldr	r2, .LCPI8_2
	ldr	r3, .LCPI8_3
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp]
	ldr	r0, [sp, #12]
	cmp	r0, #1
	bne	.LBB8_5
@ %bb.1:
	ldr	r0, .LCPI8_4
	str	r0, [sp, #8]
	ldr	r0, [sp, #12]
	cmp	r0, #1
	bne	.LBB8_3
@ %bb.2:
	ldr	r0, .LCPI8_5
	ldr	r1, .LCPI8_6
	str	r1, [sp, #8]
	str	r0, [sp, #4]
	b	.LBB8_4
.LBB8_3:
	ldr	r0, .LCPI8_1
	ldr	r1, .LCPI8_2
	ldr	r2, .LCPI8_3
	str	r2, [sp, #12]
	str	r1, [sp, #8]
	str	r0, [sp, #4]
.LBB8_4:
	ldr	r0, .LCPI8_7
	str	r0, [sp]
.LBB8_5:
	ldr	r0, [sp]
	add	sp, sp, #16
	bx	lr
	.p2align	2
@ %bb.6:
.LCPI8_0:
	.long	0                       @ 0x0
.LCPI8_1:
	.long	3                       @ 0x3
.LCPI8_2:
	.long	2                       @ 0x2
.LCPI8_3:
	.long	1                       @ 0x1
.LCPI8_4:
	.long	20                      @ 0x14
.LCPI8_5:
	.long	300                     @ 0x12c
.LCPI8_6:
	.long	200                     @ 0xc8
.LCPI8_7:
	.long	50                      @ 0x32
.Lfunc_end8:
	.size	_doubleIf, .Lfunc_end8-_doubleIf
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_integerDivide          @ -- Begin function _integerDivide
	.p2align	2
	.type	_integerDivide,%function
	.code	32                      @ @_integerDivide
_integerDivide:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r1, .LCPI9_0
	ldr	r0, .LCPI9_1
	mov	r2, #952
	orr	r2, r2, #2048
	str	r2, [sp, #4]
	ldr	r2, [sp, #4]
	add	r2, r2, r2, lsr #31
	asr	r2, r2, #1
	str	r2, [sp, #4]
	ldr	r2, [sp, #4]
	lsl	r2, r2, #2
	str	r2, [sp, #4]
	ldr	r2, [sp, #4]
	asr	r3, r2, #31
	add	r2, r2, r3, lsr #29
	asr	r2, r2, #3
	str	r2, [sp, #4]
	ldr	r2, [sp, #4]
	asr	r3, r2, #31
	add	r2, r2, r3, lsr #28
	asr	r2, r2, #4
	str	r2, [sp, #4]
	ldr	r2, [sp, #4]
	lsl	r2, r2, #5
	str	r2, [sp, #4]
	ldr	r2, [sp, #4]
	asr	r3, r2, #31
	add	r2, r2, r3, lsr #26
	asr	r2, r2, #6
	str	r2, [sp, #4]
	ldr	r2, [sp, #4]
	lsl	r2, r2, #7
	str	r2, [sp, #4]
	ldr	r2, [sp, #4]
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r2
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI9_0:
	.long	4                       @ 0x4
.LCPI9_1:
	.long	7                       @ 0x7
.Lfunc_end9:
	.size	_integerDivide, .Lfunc_end9-_integerDivide
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_association            @ -- Begin function _association
	.p2align	2
	.type	_association,%function
	.code	32                      @ @_association
_association:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r0, .LCPI10_0
	ldr	r1, .LCPI10_1
	ldr	r2, .LCPI10_2
	mov	r3, #10
	str	r3, [r11, #-4]
	ldr	r3, [r11, #-4]
	lsl	r3, r3, #1
	str	r3, [r11, #-4]
	ldr	r3, [r11, #-4]
	add	r3, r3, r3, lsr #31
	asr	r3, r3, #1
	str	r3, [r11, #-4]
	ldr	r3, [r11, #-4]
	add	r3, r3, r3, lsl #1
	str	r3, [r11, #-4]
	ldr	r3, [r11, #-4]
	ldr	r12, .LCPI10_3
	smmul	r3, r3, r12
	add	r3, r3, r3, lsr #31
	str	r3, [r11, #-4]
	ldr	r3, [r11, #-4]
	lsl	r3, r3, #2
	str	r3, [r11, #-4]
	ldr	r3, [r11, #-4]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r3
	str	r2, [sp, #4]            @ 4-byte Spill
	str	r0, [r11, #-4]
	ldr	r0, [r11, #-4]
	add	r0, r0, #4
	str	r0, [r11, #-4]
	ldr	r0, [r11, #-4]
	sub	r0, r0, #4
	str	r0, [r11, #-4]
	ldr	r0, [r11, #-4]
	ldr	r1, [sp, #8]            @ 4-byte Reload
	mul	r0, r0, r1
	str	r0, [r11, #-4]
	ldr	r0, [r11, #-4]
	str	r0, [r11, #-4]
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI10_0:
	.long	50                      @ 0x32
.LCPI10_1:
	.long	4                       @ 0x4
.LCPI10_2:
	.long	2                       @ 0x2
.LCPI10_3:
	.long	1431655766              @ 0x55555556
.Lfunc_end10:
	.size	_association, .Lfunc_end10-_association
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_tailRecursionHelper    @ -- Begin function _tailRecursionHelper
	.p2align	2
	.type	_tailRecursionHelper,%function
	.code	32                      @ @_tailRecursionHelper
_tailRecursionHelper:
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
	bne	.LBB11_2
@ %bb.1:
	ldr	r0, [sp, #4]
	str	r0, [r11, #-4]
	b	.LBB11_3
.LBB11_2:
	ldr	r0, [sp, #8]
	sub	r0, r0, #1
	ldr	r1, [sp, #4]
	ldr	r2, [sp, #8]
	add	r1, r1, r2
	bl	_tailRecursionHelper
	str	r0, [r11, #-4]
.LBB11_3:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
.Lfunc_end11:
	.size	_tailRecursionHelper, .Lfunc_end11-_tailRecursionHelper
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_tailRecursion          @ -- Begin function _tailRecursion
	.p2align	2
	.type	_tailRecursion,%function
	.code	32                      @ @_tailRecursion
_tailRecursion:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r1, .LCPI12_0
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	bl	_tailRecursionHelper
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI12_0:
	.long	0                       @ 0x0
.Lfunc_end12:
	.size	_tailRecursion, .Lfunc_end12-_tailRecursion
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_unswitching            @ -- Begin function _unswitching
	.p2align	2
	.type	_unswitching,%function
	.code	32                      @ @_unswitching
_unswitching:
	.fnstart
@ %bb.0:
	.pad	#8
	sub	sp, sp, #8
	ldr	r0, .LCPI13_0
	ldr	r1, .LCPI13_1
	str	r1, [sp, #4]
	str	r0, [sp]
.LBB13_1:                               @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI13_2
	ldr	r1, [sp, #4]
	cmp	r1, r0
	bge	.LBB13_6
@ %bb.2:                                @   in Loop: Header=BB13_1 Depth=1
	ldr	r0, [sp]
	cmp	r0, #2
	bne	.LBB13_4
@ %bb.3:                                @   in Loop: Header=BB13_1 Depth=1
	ldr	r0, [sp, #4]
	add	r0, r0, #1
	str	r0, [sp, #4]
	b	.LBB13_5
.LBB13_4:                               @   in Loop: Header=BB13_1 Depth=1
	ldr	r0, [sp, #4]
	add	r0, r0, #2
	str	r0, [sp, #4]
.LBB13_5:                               @   in Loop: Header=BB13_1 Depth=1
	b	.LBB13_1
.LBB13_6:
	ldr	r0, [sp, #4]
	add	sp, sp, #8
	bx	lr
	.p2align	2
@ %bb.7:
.LCPI13_0:
	.long	2                       @ 0x2
.LCPI13_1:
	.long	1                       @ 0x1
.LCPI13_2:
	.long	1000000                 @ 0xf4240
.Lfunc_end13:
	.size	_unswitching, .Lfunc_end13-_unswitching
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_randomCalculation      @ -- Begin function _randomCalculation
	.p2align	2
	.type	_randomCalculation,%function
	.code	32                      @ @_randomCalculation
_randomCalculation:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#40
	sub	sp, sp, #40
	ldr	r1, .LCPI14_0
	str	r0, [r11, #-4]
	str	r1, [sp, #12]
	str	r1, [sp, #8]
.LBB14_1:                               @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #12]
	ldr	r1, [r11, #-4]
	cmp	r0, r1
	bge	.LBB14_3
@ %bb.2:                                @   in Loop: Header=BB14_1 Depth=1
	ldr	r1, .LCPI14_1
	ldr	r0, .LCPI14_2
	mov	r2, #4
	str	r2, [r11, #-8]
	mov	r2, #7
	str	r2, [r11, #-12]
	mov	r2, #8
	str	r2, [r11, #-16]
	ldr	r2, [r11, #-8]
	ldr	r3, [r11, #-12]
	add	r2, r2, r3
	str	r2, [sp, #20]
	ldr	r2, [sp, #20]
	ldr	r3, [r11, #-16]
	add	r2, r2, r3
	str	r2, [sp, #16]
	ldr	r2, [sp, #8]
	ldr	r3, [sp, #16]
	add	r2, r2, r3
	str	r2, [sp, #8]
	ldr	r2, [sp, #12]
	lsl	r2, r2, #1
	str	r2, [sp, #12]
	ldr	r2, [sp, #12]
	add	r2, r2, r2, lsr #31
	asr	r2, r2, #1
	str	r2, [sp, #12]
	ldr	r2, [sp, #12]
	add	r2, r2, r2, lsl #1
	str	r2, [sp, #12]
	ldr	r2, [sp, #12]
	ldr	r3, .LCPI14_3
	smmul	r2, r2, r3
	add	r2, r2, r2, lsr #31
	str	r2, [sp, #12]
	ldr	r2, [sp, #12]
	lsl	r2, r2, #2
	str	r2, [sp, #12]
	ldr	r2, [sp, #12]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r2
	str	r0, [sp, #12]
	ldr	r0, [sp, #12]
	add	r0, r0, #1
	str	r0, [sp, #12]
	b	.LBB14_1
.LBB14_3:
	ldr	r0, [sp, #8]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI14_0:
	.long	0                       @ 0x0
.LCPI14_1:
	.long	4                       @ 0x4
.LCPI14_2:
	.long	2                       @ 0x2
.LCPI14_3:
	.long	1431655766              @ 0x55555556
.Lfunc_end14:
	.size	_randomCalculation, .Lfunc_end14-_randomCalculation
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_iterativeFibonacci     @ -- Begin function _iterativeFibonacci
	.p2align	2
	.type	_iterativeFibonacci,%function
	.code	32                      @ @_iterativeFibonacci
_iterativeFibonacci:
	.fnstart
@ %bb.0:
	.pad	#24
	sub	sp, sp, #24
	ldr	r1, .LCPI15_0
	ldr	r2, .LCPI15_1
	ldr	r3, .LCPI15_2
	str	r0, [sp, #20]
	str	r3, [sp, #16]
	str	r2, [sp, #12]
	str	r1, [sp, #4]
.LBB15_1:                               @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #20]
	cmp	r0, r1
	bge	.LBB15_3
@ %bb.2:                                @   in Loop: Header=BB15_1 Depth=1
	ldr	r0, [sp, #12]
	ldr	r1, [sp, #16]
	add	r0, r0, r1
	str	r0, [sp]
	ldr	r0, [sp, #12]
	str	r0, [sp, #16]
	ldr	r0, [sp]
	str	r0, [sp, #12]
	ldr	r0, [sp, #4]
	add	r0, r0, #1
	str	r0, [sp, #4]
	b	.LBB15_1
.LBB15_3:
	ldr	r0, [sp, #12]
	add	sp, sp, #24
	bx	lr
	.p2align	2
@ %bb.4:
.LCPI15_0:
	.long	0                       @ 0x0
.LCPI15_1:
	.long	1                       @ 0x1
.LCPI15_2:
	.long	4294967295              @ 0xffffffff
.Lfunc_end15:
	.size	_iterativeFibonacci, .Lfunc_end15-_iterativeFibonacci
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_recursiveFibonacci     @ -- Begin function _recursiveFibonacci
	.p2align	2
	.type	_recursiveFibonacci,%function
	.code	32                      @ @_recursiveFibonacci
_recursiveFibonacci:
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
	cmp	r0, #0
	ble	.LBB16_2
@ %bb.1:
	ldr	r0, [sp, #8]
	cmp	r0, #1
	bne	.LBB16_3
.LBB16_2:
	ldr	r0, [sp, #8]
	str	r0, [r11, #-4]
	b	.LBB16_4
.LBB16_3:
	ldr	r0, [sp, #8]
	sub	r0, r0, #1
	bl	_recursiveFibonacci
	ldr	lr, [sp, #8]
	sub	lr, lr, #2
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, lr
	bl	_recursiveFibonacci
	ldr	lr, [sp, #4]            @ 4-byte Reload
	add	r0, lr, r0
	str	r0, [r11, #-4]
.LBB16_4:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
.Lfunc_end16:
	.size	_recursiveFibonacci, .Lfunc_end16-_recursiveFibonacci
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
	.pad	#128
	sub	sp, sp, #128
	ldr	r0, .LCPI17_1
	sub	r1, r11, #4
	bl	__isoc99_scanf
	ldr	r1, .LCPI17_0
	str	r1, [r11, #-12]
	str	r0, [r11, #-16]         @ 4-byte Spill
.LBB17_1:                               @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-12]
	ldr	r1, [r11, #-4]
	cmp	r0, r1
	bge	.LBB17_3
@ %bb.2:                                @   in Loop: Header=BB17_1 Depth=1
	bl	_constantFolding
	ldr	lr, .LCPI17_20
	str	r0, [r11, #-8]
	ldr	r1, [r11, #-8]
	mov	r0, lr
	bl	printf
	str	r0, [r11, #-20]         @ 4-byte Spill
	bl	_constantPropagation
	ldr	r1, .LCPI17_19
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	str	r0, [r11, #-24]         @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [r11, #-24]         @ 4-byte Reload
	bl	printf
	str	r0, [r11, #-28]         @ 4-byte Spill
	bl	_deadCodeElimination
	ldr	r1, .LCPI17_18
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	str	r0, [r11, #-32]         @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [r11, #-32]         @ 4-byte Reload
	bl	printf
	str	r0, [r11, #-36]         @ 4-byte Spill
	bl	_interProceduralOptimization
	ldr	r1, .LCPI17_17
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	str	r0, [r11, #-40]         @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [r11, #-40]         @ 4-byte Reload
	bl	printf
	str	r0, [r11, #-44]         @ 4-byte Spill
	bl	_commonSubexpressionElimination
	ldr	r1, .LCPI17_16
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	str	r0, [r11, #-48]         @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [r11, #-48]         @ 4-byte Reload
	bl	printf
	str	r0, [r11, #-52]         @ 4-byte Spill
	bl	_hoisting
	ldr	r1, .LCPI17_15
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	str	r0, [r11, #-56]         @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [r11, #-56]         @ 4-byte Reload
	bl	printf
	str	r0, [r11, #-60]         @ 4-byte Spill
	bl	_doubleIf
	ldr	r1, .LCPI17_14
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	str	r0, [sp, #64]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #64]           @ 4-byte Reload
	bl	printf
	str	r0, [sp, #60]           @ 4-byte Spill
	bl	_integerDivide
	ldr	r1, .LCPI17_13
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	str	r0, [sp, #56]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #56]           @ 4-byte Reload
	bl	printf
	str	r0, [sp, #52]           @ 4-byte Spill
	bl	_association
	ldr	r1, .LCPI17_12
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	str	r0, [sp, #48]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #48]           @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_6
	ldr	lr, [r11, #-4]
	str	r0, [sp, #44]           @ 4-byte Spill
	mov	r0, lr
	bl	_tailRecursion
	ldr	r1, .LCPI17_11
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	str	r0, [sp, #40]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #40]           @ 4-byte Reload
	bl	printf
	str	r0, [sp, #36]           @ 4-byte Spill
	bl	_unswitching
	ldr	r1, .LCPI17_10
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	str	r0, [sp, #32]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #32]           @ 4-byte Reload
	bl	printf
	ldr	r1, [r11, #-4]
	str	r0, [sp, #28]           @ 4-byte Spill
	mov	r0, r1
	bl	_randomCalculation
	ldr	r1, .LCPI17_9
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	str	r0, [sp, #24]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #24]           @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_8
	ldr	lr, [r11, #-4]
	str	r0, [sp, #20]           @ 4-byte Spill
	mov	r0, lr
	bl	_iterativeFibonacci
	ldr	r1, .LCPI17_7
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #16]           @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_6
	ldr	lr, [r11, #-4]
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, lr
	bl	_recursiveFibonacci
	ldr	r1, .LCPI17_5
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #8]            @ 4-byte Reload
	bl	printf
	ldr	r1, [r11, #-12]
	add	r1, r1, #1
	str	r1, [r11, #-12]
	str	r0, [sp, #4]            @ 4-byte Spill
	b	.LBB17_1
.LBB17_3:
	ldr	r0, .LCPI17_3
	ldr	r1, .LCPI17_4
	bl	printf
	ldr	r1, .LCPI17_2
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI17_0:
	.long	1                       @ 0x1
.LCPI17_1:
	.long	.L.str
.LCPI17_2:
	.long	0                       @ 0x0
.LCPI17_3:
	.long	.L.str.1
.LCPI17_4:
	.long	9999                    @ 0x270f
.LCPI17_5:
	.long	.L.str.1
.LCPI17_6:
	.long	1000                    @ 0x3e8
.LCPI17_7:
	.long	.L.str.1
.LCPI17_8:
	.long	5                       @ 0x5
.LCPI17_9:
	.long	.L.str.1
.LCPI17_10:
	.long	.L.str.1
.LCPI17_11:
	.long	.L.str.1
.LCPI17_12:
	.long	.L.str.1
.LCPI17_13:
	.long	.L.str.1
.LCPI17_14:
	.long	.L.str.1
.LCPI17_15:
	.long	.L.str.1
.LCPI17_16:
	.long	.L.str.1
.LCPI17_17:
	.long	.L.str.1
.LCPI17_18:
	.long	.L.str.1
.LCPI17_19:
	.long	.L.str.1
.LCPI17_20:
	.long	.L.str.1
.Lfunc_end17:
	.size	_main, .Lfunc_end17-_main
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
	ldr	r0, .LCPI18_0
	str	r0, [sp, #4]
	bl	_main
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI18_0:
	.long	0                       @ 0x0
.Lfunc_end18:
	.size	main, .Lfunc_end18-main
	.cantunwind
	.fnend
                                        @ -- End function
	.type	EV_global1,%object      @ @EV_global1
	.comm	EV_global1,4,4
	.type	EV_global2,%object      @ @EV_global2
	.comm	EV_global2,4,4
	.type	EV_global3,%object      @ @EV_global3
	.comm	EV_global3,4,4
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
	.addrsig_sym _constantFolding
	.addrsig_sym _constantPropagation
	.addrsig_sym _deadCodeElimination
	.addrsig_sym _sum
	.addrsig_sym _doesntModifyGlobals
	.addrsig_sym _interProceduralOptimization
	.addrsig_sym _commonSubexpressionElimination
	.addrsig_sym _hoisting
	.addrsig_sym _doubleIf
	.addrsig_sym _integerDivide
	.addrsig_sym _association
	.addrsig_sym _tailRecursionHelper
	.addrsig_sym _tailRecursion
	.addrsig_sym _unswitching
	.addrsig_sym _randomCalculation
	.addrsig_sym _iterativeFibonacci
	.addrsig_sym _recursiveFibonacci
	.addrsig_sym _main
	.addrsig_sym __isoc99_scanf
	.addrsig_sym printf
	.addrsig_sym main
	.addrsig_sym EV_global1
	.addrsig_sym EV_global2
	.addrsig_sym EV_global3
