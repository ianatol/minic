	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_compare                @ -- Begin function _compare
	.p2align	2
	.type	_compare,%function
	.code	32                      @ @_compare
_compare:
	.fnstart
@ %bb.0:
	.pad	#8
	sub	sp, sp, #8
	str	r0, [sp, #4]
	str	r1, [sp]
	ldr	r0, [sp, #4]
	ldr	r0, [r0]
	ldr	r1, [sp]
	ldr	r1, [r1]
	sub	r0, r0, r1
	add	sp, sp, #8
	bx	lr
.Lfunc_end0:
	.size	_compare, .Lfunc_end0-_compare
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_deathSort              @ -- Begin function _deathSort
	.p2align	2
	.type	_deathSort,%function
	.code	32                      @ @_deathSort
_deathSort:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r1, .LCPI1_0
	str	r0, [r11, #-4]
	str	r1, [sp, #8]
.LBB1_1:                                @ =>This Loop Header: Depth=1
                                        @     Child Loop BB1_3 Depth 2
	ldr	r0, [sp, #8]
	cmp	r0, #1
	bne	.LBB1_8
@ %bb.2:                                @   in Loop: Header=BB1_1 Depth=1
	ldr	r0, .LCPI1_1
	str	r0, [sp, #8]
	ldr	r0, [r11, #-4]
	str	r0, [sp]
.LBB1_3:                                @   Parent Loop BB1_1 Depth=1
                                        @ =>  This Inner Loop Header: Depth=2
	ldr	r0, [sp]
	ldr	r0, [r0, #8]
	ldr	r1, [r11, #-4]
	cmp	r0, r1
	beq	.LBB1_7
@ %bb.4:                                @   in Loop: Header=BB1_3 Depth=2
	ldr	r0, [sp]
	ldr	r1, [sp]
	ldr	r1, [r1, #8]
	bl	_compare
	cmp	r0, #0
	ble	.LBB1_6
@ %bb.5:                                @   in Loop: Header=BB1_3 Depth=2
	ldr	r0, .LCPI1_0
	ldr	r1, [sp]
	ldr	r1, [r1]
	str	r1, [sp, #4]
	ldr	r1, [sp]
	ldr	r1, [r1, #8]
	ldr	r1, [r1]
	ldr	r2, [sp]
	str	r1, [r2]
	ldr	r1, [sp, #4]
	ldr	r2, [sp]
	ldr	r2, [r2, #8]
	str	r1, [r2]
	str	r0, [sp, #8]
.LBB1_6:                                @   in Loop: Header=BB1_3 Depth=2
	ldr	r0, [sp]
	ldr	r0, [r0, #8]
	str	r0, [sp]
	b	.LBB1_3
.LBB1_7:                                @   in Loop: Header=BB1_1 Depth=1
	b	.LBB1_1
.LBB1_8:
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.9:
.LCPI1_0:
	.long	1                       @ 0x1
.LCPI1_1:
	.long	0                       @ 0x0
.Lfunc_end1:
	.size	_deathSort, .Lfunc_end1-_deathSort
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_printEVILList          @ -- Begin function _printEVILList
	.p2align	2
	.type	_printEVILList,%function
	.code	32                      @ @_printEVILList
_printEVILList:
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
	ldr	r0, [r11, #-4]
	ldr	r0, [r0, #8]
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-4]
	ldr	r0, [r0]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #8]            @ 4-byte Reload
	bl	printf
	ldr	r1, [r11, #-4]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	bl	free
.LBB2_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-8]
	ldr	r1, [r11, #-4]
	cmp	r0, r1
	beq	.LBB2_3
@ %bb.2:                                @   in Loop: Header=BB2_1 Depth=1
	ldr	r0, .LCPI2_1
	ldr	r1, [r11, #-8]
	str	r1, [sp, #12]
	ldr	r1, [r11, #-8]
	ldr	r1, [r1]
	bl	printf
	ldr	r1, [r11, #-8]
	ldr	r1, [r1, #8]
	str	r1, [r11, #-8]
	ldr	r1, [sp, #12]
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	bl	free
	b	.LBB2_1
.LBB2_3:
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI2_0:
	.long	.L.str
.LCPI2_1:
	.long	.L.str
.Lfunc_end2:
	.size	_printEVILList, .Lfunc_end2-_printEVILList
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
	ldr	r0, .LCPI3_0
	ldr	r1, .LCPI3_1
	ldr	r2, .LCPI3_2
	str	r1, [r2]
	sub	r1, r11, #8
	bl	__isoc99_scanf
	ldr	r1, [r11, #-8]
	cmp	r1, #0
	str	r0, [sp, #4]            @ 4-byte Spill
	bgt	.LBB3_2
@ %bb.1:
	ldr	r0, .LCPI3_7
	ldr	r1, .LCPI3_6
	bl	printf
	ldr	r1, .LCPI3_6
	str	r1, [r11, #-4]
	str	r0, [sp]                @ 4-byte Spill
	b	.LBB3_6
.LBB3_2:
	ldr	r0, .LCPI3_3
	ldr	r1, .LCPI3_4
	ldr	r2, [r11, #-8]
	mul	r1, r2, r1
	str	r1, [r11, #-8]
	ldr	r1, [r11, #-8]
	str	r1, [r11, #-12]
	bl	malloc
	str	r0, [sp, #12]
	ldr	r0, [r11, #-12]
	ldr	r1, [sp, #12]
	str	r0, [r1]
	ldr	r0, [sp, #12]
	ldr	r1, [sp, #12]
	str	r0, [r1, #4]
	ldr	r0, [sp, #12]
	ldr	r1, [sp, #12]
	str	r0, [r1, #8]
	ldr	r0, [r11, #-12]
	sub	r0, r0, #1
	str	r0, [r11, #-12]
	ldr	r0, [sp, #12]
	str	r0, [sp, #8]
.LBB3_3:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-12]
	cmp	r0, #0
	ble	.LBB3_5
@ %bb.4:                                @   in Loop: Header=BB3_3 Depth=1
	ldr	r0, .LCPI3_3
	bl	malloc
	str	r0, [sp, #16]
	ldr	r0, [r11, #-12]
	ldr	lr, [sp, #16]
	str	r0, [lr]
	ldr	r0, [sp, #8]
	ldr	lr, [sp, #16]
	str	r0, [lr, #4]
	ldr	r0, [sp, #12]
	ldr	lr, [sp, #16]
	str	r0, [lr, #8]
	ldr	r0, [sp, #16]
	ldr	lr, [sp, #8]
	str	r0, [lr, #8]
	ldr	r0, [sp, #16]
	str	r0, [sp, #8]
	ldr	r0, [r11, #-12]
	sub	r0, r0, #1
	str	r0, [r11, #-12]
	b	.LBB3_3
.LBB3_5:
	ldr	r0, [sp, #12]
	bl	_deathSort
	ldr	r0, [sp, #12]
	bl	_printEVILList
	ldr	r0, .LCPI3_5
	str	r0, [r11, #-4]
.LBB3_6:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.7:
.LCPI3_0:
	.long	.L.str.1
.LCPI3_1:
	.long	666                     @ 0x29a
.LCPI3_2:
	.long	EV_swapped
.LCPI3_3:
	.long	12                      @ 0xc
.LCPI3_4:
	.long	1000                    @ 0x3e8
.LCPI3_5:
	.long	0                       @ 0x0
.LCPI3_6:
	.long	4294967295              @ 0xffffffff
.LCPI3_7:
	.long	.L.str
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
	.asciz	"%d\n"
	.size	.L.str, 4

	.type	EV_swapped,%object      @ @EV_swapped
	.comm	EV_swapped,4,4
	.type	.L.str.1,%object        @ @.str.1
.L.str.1:
	.asciz	"%d"
	.size	.L.str.1, 3


	.ident	"clang version 7.0.1-8+rpi3 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym _compare
	.addrsig_sym _deathSort
	.addrsig_sym _printEVILList
	.addrsig_sym printf
	.addrsig_sym free
	.addrsig_sym _main
	.addrsig_sym __isoc99_scanf
	.addrsig_sym malloc
	.addrsig_sym main
	.addrsig_sym EV_swapped
