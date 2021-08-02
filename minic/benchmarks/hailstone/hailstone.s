	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_mod                    @ -- Begin function _mod
	.p2align	2
	.type	_mod,%function
	.code	32                      @ @_mod
_mod:
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
	ldr	r0, [r11, #-4]
	ldr	r1, [r11, #-4]
	ldr	r2, [sp, #8]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	ldr	r1, [sp, #8]
	mul	r0, r0, r1
	ldr	r1, [sp, #4]            @ 4-byte Reload
	sub	r0, r1, r0
	mov	sp, r11
	pop	{r11, pc}
.Lfunc_end0:
	.size	_mod, .Lfunc_end0-_mod
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_hailstone              @ -- Begin function _hailstone
	.p2align	2
	.type	_hailstone,%function
	.code	32                      @ @_hailstone
_hailstone:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	str	r0, [r11, #-4]
.LBB1_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI1_1
	ldr	r1, [r11, #-4]
	bl	printf
	ldr	r1, .LCPI1_0
	ldr	lr, [r11, #-4]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, lr
	bl	_mod
	cmp	r0, #1
	bne	.LBB1_3
@ %bb.2:                                @   in Loop: Header=BB1_1 Depth=1
	ldr	r0, .LCPI1_2
	ldr	r1, [r11, #-4]
	mul	r0, r1, r0
	add	r0, r0, #1
	str	r0, [r11, #-4]
	b	.LBB1_4
.LBB1_3:                                @   in Loop: Header=BB1_1 Depth=1
	ldr	r1, .LCPI1_0
	ldr	r0, [r11, #-4]
	str	r0, [r11, #-4]
.LBB1_4:                                @   in Loop: Header=BB1_1 Depth=1
	ldr	r0, [r11, #-4]
	cmp	r0, #1
	bgt	.LBB1_6
@ %bb.5:
	ldr	r0, .LCPI1_3
	ldr	r1, [r11, #-4]
	bl	printf
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	sp, r11
	pop	{r11, pc}
.LBB1_6:                                @   in Loop: Header=BB1_1 Depth=1
	b	.LBB1_1
	.p2align	2
@ %bb.7:
.LCPI1_0:
	.long	2                       @ 0x2
.LCPI1_1:
	.long	.L.str
.LCPI1_2:
	.long	3                       @ 0x3
.LCPI1_3:
	.long	.L.str.1
.Lfunc_end1:
	.size	_hailstone, .Lfunc_end1-_hailstone
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
	.pad	#8
	sub	sp, sp, #8
	ldr	r0, .LCPI2_1
	add	r1, sp, #4
	bl	__isoc99_scanf
	ldr	r1, [sp, #4]
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	bl	_hailstone
	ldr	r0, .LCPI2_0
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI2_0:
	.long	0                       @ 0x0
.LCPI2_1:
	.long	.L.str.2
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
	.addrsig_sym _mod
	.addrsig_sym _hailstone
	.addrsig_sym printf
	.addrsig_sym _main
	.addrsig_sym __isoc99_scanf
	.addrsig_sym main
