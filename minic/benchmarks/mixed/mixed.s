	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_tailrecursive          @ -- Begin function _tailrecursive
	.p2align	2
	.type	_tailrecursive,%function
	.code	32                      @ @_tailrecursive
_tailrecursive:
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
	cmp	r0, #0
	bgt	.LBB0_2
@ %bb.1:
	b	.LBB0_3
.LBB0_2:
	ldr	r0, [sp, #4]
	sub	r0, r0, #1
	bl	_tailrecursive
.LBB0_3:
	mov	sp, r11
	pop	{r11, pc}
.Lfunc_end0:
	.size	_tailrecursive, .Lfunc_end0-_tailrecursive
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
	.pad	#8
	sub	sp, sp, #8
	str	r0, [sp, #4]
	str	r1, [sp]
	ldr	r0, [sp, #4]
	ldr	r1, [sp]
	add	r0, r0, r1
	add	sp, sp, #8
	bx	lr
.Lfunc_end1:
	.size	_add, .Lfunc_end1-_add
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_domath                 @ -- Begin function _domath
	.p2align	2
	.type	_domath,%function
	.code	32                      @ @_domath
_domath:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r1, .LCPI2_2
	str	r0, [r11, #-4]
	mov	r0, r1
	bl	malloc
	ldr	r1, .LCPI2_1
	str	r0, [sp, #8]
	mov	r0, r1
	bl	malloc
	ldr	r1, .LCPI2_2
	ldr	lr, [sp, #8]
	str	r0, [lr, #8]
	mov	r0, r1
	bl	malloc
	ldr	r1, .LCPI2_1
	str	r0, [sp, #4]
	mov	r0, r1
	bl	malloc
	ldr	r1, .LCPI2_0
	ldr	lr, [sp, #4]
	str	r0, [lr, #8]
	ldr	r0, [r11, #-4]
	ldr	lr, [sp, #8]
	str	r0, [lr]
	ldr	r0, [sp, #4]
	str	r1, [r0]
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [sp, #8]
	ldr	r1, [r1, #8]
	str	r0, [r1]
	ldr	r0, [sp, #4]
	ldr	r0, [r0]
	ldr	r1, [sp, #4]
	ldr	r1, [r1, #8]
	str	r0, [r1]
.LBB2_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-4]
	cmp	r0, #0
	ble	.LBB2_3
@ %bb.2:                                @   in Loop: Header=BB2_1 Depth=1
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [sp, #4]
	ldr	r1, [r1]
	mul	r0, r0, r1
	str	r0, [sp]
	ldr	r0, [sp]
	ldr	r1, [sp, #8]
	ldr	r1, [r1, #8]
	ldr	r1, [r1]
	mul	r0, r0, r1
	ldr	r1, [sp, #4]
	ldr	r1, [r1]
	str	r0, [sp]
	ldr	r0, [sp, #4]
	ldr	r0, [r0, #8]
	ldr	r0, [r0]
	ldr	r1, [sp, #8]
	ldr	r1, [r1]
	bl	_add
	str	r0, [sp]
	ldr	r0, [sp, #4]
	ldr	r0, [r0]
	ldr	r1, [sp, #8]
	ldr	r1, [r1]
	sub	r0, r0, r1
	str	r0, [sp]
	ldr	r0, [r11, #-4]
	sub	r0, r0, #1
	str	r0, [r11, #-4]
	b	.LBB2_1
.LBB2_3:
	ldr	r0, [sp, #8]
	bl	free
	ldr	r0, [sp, #4]
	bl	free
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI2_0:
	.long	3                       @ 0x3
.LCPI2_1:
	.long	4                       @ 0x4
.LCPI2_2:
	.long	12                      @ 0xc
.Lfunc_end2:
	.size	_domath, .Lfunc_end2-_domath
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_objinstantiation       @ -- Begin function _objinstantiation
	.p2align	2
	.type	_objinstantiation,%function
	.code	32                      @ @_objinstantiation
_objinstantiation:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	str	r0, [sp, #4]
.LBB3_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #4]
	cmp	r0, #0
	ble	.LBB3_3
@ %bb.2:                                @   in Loop: Header=BB3_1 Depth=1
	ldr	r0, .LCPI3_0
	bl	malloc
	str	r0, [sp]
	ldr	r0, [sp]
	bl	free
	ldr	r0, [sp, #4]
	sub	r0, r0, #1
	str	r0, [sp, #4]
	b	.LBB3_1
.LBB3_3:
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI3_0:
	.long	12                      @ 0xc
.Lfunc_end3:
	.size	_objinstantiation, .Lfunc_end3-_objinstantiation
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_ackermann              @ -- Begin function _ackermann
	.p2align	2
	.type	_ackermann,%function
	.code	32                      @ @_ackermann
_ackermann:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#24
	sub	sp, sp, #24
	str	r0, [r11, #-8]
	str	r1, [sp, #12]
	ldr	r0, [r11, #-8]
	cmp	r0, #0
	bne	.LBB4_2
@ %bb.1:
	ldr	r0, [sp, #12]
	add	r0, r0, #1
	str	r0, [r11, #-4]
	b	.LBB4_5
.LBB4_2:
	ldr	r0, [sp, #12]
	cmp	r0, #0
	bne	.LBB4_4
@ %bb.3:
	ldr	r1, .LCPI4_0
	ldr	r0, [r11, #-8]
	sub	r0, r0, #1
	bl	_ackermann
	str	r0, [r11, #-4]
	b	.LBB4_5
.LBB4_4:
	ldr	r0, [r11, #-8]
	sub	r0, r0, #1
	ldr	r1, [r11, #-8]
	ldr	r2, [sp, #12]
	sub	r2, r2, #1
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	_ackermann
	ldr	r1, [sp, #8]            @ 4-byte Reload
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #4]            @ 4-byte Reload
	bl	_ackermann
	str	r0, [r11, #-4]
.LBB4_5:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.6:
.LCPI4_0:
	.long	1                       @ 0x1
.Lfunc_end4:
	.size	_ackermann, .Lfunc_end4-_ackermann
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
	.pad	#64
	sub	sp, sp, #64
	ldr	r0, .LCPI5_9
	sub	r1, r11, #4
	bl	__isoc99_scanf
	ldr	r1, .LCPI5_8
	str	r0, [r11, #-24]         @ 4-byte Spill
	mov	r0, r1
	sub	r1, r11, #8
	bl	__isoc99_scanf
	ldr	r1, .LCPI5_7
	str	r0, [r11, #-28]         @ 4-byte Spill
	mov	r0, r1
	sub	r1, r11, #12
	bl	__isoc99_scanf
	ldr	r1, .LCPI5_6
	str	r0, [sp, #32]           @ 4-byte Spill
	mov	r0, r1
	sub	r1, r11, #16
	bl	__isoc99_scanf
	ldr	r1, .LCPI5_5
	str	r0, [sp, #28]           @ 4-byte Spill
	mov	r0, r1
	sub	r1, r11, #20
	bl	__isoc99_scanf
	ldr	r1, [r11, #-4]
	str	r0, [sp, #24]           @ 4-byte Spill
	mov	r0, r1
	bl	_tailrecursive
	ldr	r0, .LCPI5_4
	ldr	r1, [r11, #-4]
	bl	printf
	ldr	r1, [r11, #-8]
	str	r0, [sp, #20]           @ 4-byte Spill
	mov	r0, r1
	bl	_domath
	ldr	r0, .LCPI5_3
	ldr	r1, [r11, #-8]
	bl	printf
	ldr	r1, [r11, #-12]
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, r1
	bl	_objinstantiation
	ldr	r0, .LCPI5_2
	ldr	r1, [r11, #-12]
	bl	printf
	ldr	r1, [r11, #-16]
	ldr	lr, [r11, #-20]
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	_ackermann
	ldr	r1, .LCPI5_1
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #8]            @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI5_0
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI5_0:
	.long	0                       @ 0x0
.LCPI5_1:
	.long	.L.str.1
.LCPI5_2:
	.long	.L.str.1
.LCPI5_3:
	.long	.L.str.1
.LCPI5_4:
	.long	.L.str.1
.LCPI5_5:
	.long	.L.str
.LCPI5_6:
	.long	.L.str
.LCPI5_7:
	.long	.L.str
.LCPI5_8:
	.long	.L.str
.LCPI5_9:
	.long	.L.str
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
	.asciz	"%d"
	.size	.L.str, 3

	.type	.L.str.1,%object        @ @.str.1
.L.str.1:
	.asciz	"%d\n"
	.size	.L.str.1, 4

	.type	EV_globalfoo,%object    @ @EV_globalfoo
	.comm	EV_globalfoo,4,4

	.ident	"clang version 7.0.1-8+rpi3 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym _tailrecursive
	.addrsig_sym _add
	.addrsig_sym _domath
	.addrsig_sym malloc
	.addrsig_sym free
	.addrsig_sym _objinstantiation
	.addrsig_sym _ackermann
	.addrsig_sym _main
	.addrsig_sym __isoc99_scanf
	.addrsig_sym printf
	.addrsig_sym main
	.addrsig_sym EV_globalfoo
