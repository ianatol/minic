	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_computeFib             @ -- Begin function _computeFib
	.p2align	2
	.type	_computeFib,%function
	.code	32                      @ @_computeFib
_computeFib:
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
	bne	.LBB0_2
@ %bb.1:
	ldr	r0, .LCPI0_1
	str	r0, [r11, #-4]
	b	.LBB0_5
.LBB0_2:
	ldr	r0, [sp, #8]
	cmp	r0, #2
	bgt	.LBB0_4
@ %bb.3:
	ldr	r0, .LCPI0_0
	str	r0, [r11, #-4]
	b	.LBB0_5
.LBB0_4:
	ldr	r0, [sp, #8]
	sub	r0, r0, #1
	bl	_computeFib
	ldr	lr, [sp, #8]
	sub	lr, lr, #2
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, lr
	bl	_computeFib
	ldr	lr, [sp, #4]            @ 4-byte Reload
	add	r0, lr, r0
	str	r0, [r11, #-4]
.LBB0_5:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.6:
.LCPI0_0:
	.long	1                       @ 0x1
.LCPI0_1:
	.long	0                       @ 0x0
.Lfunc_end0:
	.size	_computeFib, .Lfunc_end0-_computeFib
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
	ldr	r0, .LCPI1_2
	sub	r1, r11, #4
	bl	__isoc99_scanf
	ldr	r1, [r11, #-4]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	bl	_computeFib
	ldr	r1, .LCPI1_1
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #4]            @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI1_0
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI1_0:
	.long	0                       @ 0x0
.LCPI1_1:
	.long	.L.str.1
.LCPI1_2:
	.long	.L.str
.Lfunc_end1:
	.size	_main, .Lfunc_end1-_main
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
	ldr	r0, .LCPI2_0
	str	r0, [sp, #4]
	bl	_main
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI2_0:
	.long	0                       @ 0x0
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
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
	.addrsig_sym _computeFib
	.addrsig_sym _main
	.addrsig_sym __isoc99_scanf
	.addrsig_sym printf
	.addrsig_sym main
