	.text
	.syntax unified
	.cpu	mpcore
	.fpu	vfpv2
	.globl	_concatLists            @ -- Begin function _concatLists
	.p2align	2
	.type	_concatLists,%function
	.code	32                      @ @_concatLists
_concatLists:
	.fnstart
@ %bb.0:
	.pad	#16
	sub	sp, sp, #16
	ldr	r2, .LCPI0_0
	str	r0, [sp, #8]
	str	r1, [sp, #4]
	ldr	r0, [sp, #8]
	str	r0, [sp]
	ldr	r0, [sp, #8]
	cmp	r0, r2
	bne	.LBB0_2
@ %bb.1:
	ldr	r0, [sp, #4]
	str	r0, [sp, #12]
	b	.LBB0_6
.LBB0_2:
	b	.LBB0_3
.LBB0_3:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI0_0
	ldr	r1, [sp]
	ldr	r1, [r1, #4]
	cmp	r1, r0
	beq	.LBB0_5
@ %bb.4:                                @   in Loop: Header=BB0_3 Depth=1
	ldr	r0, [sp]
	ldr	r0, [r0, #4]
	str	r0, [sp]
	b	.LBB0_3
.LBB0_5:
	ldr	r0, [sp, #4]
	ldr	r1, [sp]
	str	r0, [r1, #4]
	ldr	r0, [sp, #8]
	str	r0, [sp, #12]
.LBB0_6:
	ldr	r0, [sp, #12]
	add	sp, sp, #16
	bx	lr
	.p2align	2
@ %bb.7:
.LCPI0_0:
	.long	0                       @ 0x0
.Lfunc_end0:
	.size	_concatLists, .Lfunc_end0-_concatLists
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
	.pad	#16
	sub	sp, sp, #16
	ldr	r2, .LCPI1_0
	str	r0, [r11, #-4]
	str	r1, [sp, #8]
	mov	r0, r2
	bl	malloc
	str	r0, [sp, #4]
	ldr	r0, [sp, #8]
	ldr	r1, [sp, #4]
	str	r0, [r1]
	ldr	r0, [r11, #-4]
	ldr	r1, [sp, #4]
	str	r0, [r1, #4]
	ldr	r0, [sp, #4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI1_0:
	.long	8                       @ 0x8
.Lfunc_end1:
	.size	_add, .Lfunc_end1-_add
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_size                   @ -- Begin function _size
	.p2align	2
	.type	_size,%function
	.code	32                      @ @_size
_size:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r1, .LCPI2_0
	str	r0, [sp]
	ldr	r0, [sp]
	cmp	r0, r1
	bne	.LBB2_2
@ %bb.1:
	ldr	r0, .LCPI2_0
	str	r0, [sp, #4]
	b	.LBB2_3
.LBB2_2:
	ldr	r0, [sp]
	ldr	r0, [r0, #4]
	bl	_size
	add	r0, r0, #1
	str	r0, [sp, #4]
.LBB2_3:
	ldr	r0, [sp, #4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI2_0:
	.long	0                       @ 0x0
.Lfunc_end2:
	.size	_size, .Lfunc_end2-_size
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_get                    @ -- Begin function _get
	.p2align	2
	.type	_get,%function
	.code	32                      @ @_get
_get:
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
	ldr	r0, [sp, #4]
	cmp	r0, #0
	bne	.LBB3_2
@ %bb.1:
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	str	r0, [r11, #-4]
	b	.LBB3_3
.LBB3_2:
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	ldr	r1, [sp, #4]
	sub	r1, r1, #1
	bl	_get
	str	r0, [r11, #-4]
.LBB3_3:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
.Lfunc_end3:
	.size	_get, .Lfunc_end3-_get
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_pop                    @ -- Begin function _pop
	.p2align	2
	.type	_pop,%function
	.code	32                      @ @_pop
_pop:
	.fnstart
@ %bb.0:
	.pad	#4
	sub	sp, sp, #4
	str	r0, [sp]
	ldr	r0, [sp]
	ldr	r0, [r0, #4]
	str	r0, [sp]
	ldr	r0, [sp]
	add	sp, sp, #4
	bx	lr
.Lfunc_end4:
	.size	_pop, .Lfunc_end4-_pop
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_printList              @ -- Begin function _printList
	.p2align	2
	.type	_printList,%function
	.code	32                      @ @_printList
_printList:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r1, .LCPI5_0
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	cmp	r0, r1
	beq	.LBB5_2
@ %bb.1:
	ldr	r0, .LCPI5_1
	ldr	r1, [sp, #4]
	ldr	r1, [r1]
	bl	printf
	ldr	r1, [sp, #4]
	ldr	r1, [r1, #4]
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	bl	_printList
.LBB5_2:
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.3:
.LCPI5_0:
	.long	0                       @ 0x0
.LCPI5_1:
	.long	.L.str
.Lfunc_end5:
	.size	_printList, .Lfunc_end5-_printList
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_treeprint              @ -- Begin function _treeprint
	.p2align	2
	.type	_treeprint,%function
	.code	32                      @ @_treeprint
_treeprint:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r1, .LCPI6_0
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	cmp	r0, r1
	beq	.LBB6_2
@ %bb.1:
	ldr	r0, [sp, #4]
	ldr	r0, [r0, #4]
	bl	_treeprint
	ldr	r0, .LCPI6_1
	ldr	lr, [sp, #4]
	ldr	r1, [lr]
	bl	printf
	ldr	r1, [sp, #4]
	ldr	r1, [r1, #8]
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	bl	_treeprint
.LBB6_2:
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.3:
.LCPI6_0:
	.long	0                       @ 0x0
.LCPI6_1:
	.long	.L.str
.Lfunc_end6:
	.size	_treeprint, .Lfunc_end6-_treeprint
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_freeList               @ -- Begin function _freeList
	.p2align	2
	.type	_freeList,%function
	.code	32                      @ @_freeList
_freeList:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r1, .LCPI7_0
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	cmp	r0, r1
	beq	.LBB7_2
@ %bb.1:
	ldr	r0, [sp, #4]
	ldr	r0, [r0, #4]
	bl	_freeList
	ldr	r0, [sp, #4]
	bl	free
.LBB7_2:
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.3:
.LCPI7_0:
	.long	0                       @ 0x0
.Lfunc_end7:
	.size	_freeList, .Lfunc_end7-_freeList
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_freeTree               @ -- Begin function _freeTree
	.p2align	2
	.type	_freeTree,%function
	.code	32                      @ @_freeTree
_freeTree:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#8
	sub	sp, sp, #8
	ldr	r1, .LCPI8_0
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	cmp	r0, r1
	beq	.LBB8_2
@ %bb.1:
	ldr	r0, [sp, #4]
	ldr	r0, [r0, #4]
	bl	_freeTree
	ldr	r0, [sp, #4]
	ldr	r0, [r0, #8]
	bl	_freeTree
	ldr	r0, [sp, #4]
	bl	free
.LBB8_2:
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.3:
.LCPI8_0:
	.long	0                       @ 0x0
.Lfunc_end8:
	.size	_freeTree, .Lfunc_end8-_freeTree
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_postOrder              @ -- Begin function _postOrder
	.p2align	2
	.type	_postOrder,%function
	.code	32                      @ @_postOrder
_postOrder:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#24
	sub	sp, sp, #24
	ldr	r1, .LCPI9_0
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	cmp	r0, r1
	beq	.LBB9_2
@ %bb.1:
	ldr	r0, .LCPI9_1
	bl	malloc
	ldr	lr, .LCPI9_0
	str	r0, [sp, #12]
	ldr	r0, [r11, #-8]
	ldr	r0, [r0]
	ldr	r1, [sp, #12]
	str	r0, [r1]
	ldr	r0, [sp, #12]
	str	lr, [r0, #4]
	ldr	r0, [r11, #-8]
	ldr	r0, [r0, #4]
	bl	_postOrder
	ldr	r1, [r11, #-8]
	ldr	r1, [r1, #8]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	bl	_postOrder
	ldr	r1, [sp, #8]            @ 4-byte Reload
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #4]            @ 4-byte Reload
	bl	_concatLists
	ldr	r1, [sp, #12]
	bl	_concatLists
	str	r0, [r11, #-4]
	b	.LBB9_3
.LBB9_2:
	ldr	r0, .LCPI9_0
	str	r0, [r11, #-4]
.LBB9_3:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI9_0:
	.long	0                       @ 0x0
.LCPI9_1:
	.long	8                       @ 0x8
.Lfunc_end9:
	.size	_postOrder, .Lfunc_end9-_postOrder
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_treeadd                @ -- Begin function _treeadd
	.p2align	2
	.type	_treeadd,%function
	.code	32                      @ @_treeadd
_treeadd:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r2, .LCPI10_0
	str	r0, [sp, #8]
	str	r1, [sp, #4]
	ldr	r0, [sp, #8]
	cmp	r0, r2
	bne	.LBB10_2
@ %bb.1:
	ldr	r0, .LCPI10_1
	bl	malloc
	ldr	lr, .LCPI10_0
	str	r0, [sp]
	ldr	r0, [sp, #4]
	ldr	r1, [sp]
	str	r0, [r1]
	ldr	r0, [sp]
	str	lr, [r0, #4]
	ldr	r0, [sp]
	str	lr, [r0, #8]
	ldr	r0, [sp]
	str	r0, [r11, #-4]
	b	.LBB10_6
.LBB10_2:
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	ldr	r1, [r1]
	cmp	r0, r1
	bge	.LBB10_4
@ %bb.3:
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	ldr	r1, [sp, #4]
	bl	_treeadd
	ldr	r1, [sp, #8]
	str	r0, [r1, #4]
	b	.LBB10_5
.LBB10_4:
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #8]
	ldr	r1, [sp, #4]
	bl	_treeadd
	ldr	r1, [sp, #8]
	str	r0, [r1, #8]
.LBB10_5:
	ldr	r0, [sp, #8]
	str	r0, [r11, #-4]
.LBB10_6:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.7:
.LCPI10_0:
	.long	0                       @ 0x0
.LCPI10_1:
	.long	12                      @ 0xc
.Lfunc_end10:
	.size	_treeadd, .Lfunc_end10-_treeadd
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_quickSort              @ -- Begin function _quickSort
	.p2align	2
	.type	_quickSort,%function
	.code	32                      @ @_quickSort
_quickSort:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#64
	sub	sp, sp, #64
	ldr	r1, .LCPI11_0
	str	r0, [r11, #-8]
	str	r1, [r11, #-20]
	str	r1, [r11, #-24]
	ldr	r0, [r11, #-8]
	bl	_size
	cmp	r0, #1
	bgt	.LBB11_2
@ %bb.1:
	ldr	r0, [r11, #-8]
	str	r0, [r11, #-4]
	b	.LBB11_9
.LBB11_2:
	ldr	r1, .LCPI11_0
	ldr	r0, [r11, #-8]
	bl	_get
	ldr	r1, [r11, #-8]
	ldr	lr, [r11, #-8]
	str	r0, [sp, #32]           @ 4-byte Spill
	mov	r0, lr
	str	r1, [sp, #28]           @ 4-byte Spill
	bl	_size
	sub	r1, r0, #1
	ldr	r0, [sp, #28]           @ 4-byte Reload
	bl	_get
	ldr	r1, .LCPI11_0
	ldr	lr, .LCPI11_1
	ldr	r2, [sp, #32]           @ 4-byte Reload
	add	r0, r2, r0
	str	r1, [sp, #24]           @ 4-byte Spill
	mov	r1, lr
	str	r0, [r11, #-12]
	ldr	r0, [r11, #-8]
	str	r0, [r11, #-28]
	ldr	r0, [sp, #24]           @ 4-byte Reload
	str	r0, [r11, #-16]
.LBB11_3:                               @ =>This Inner Loop Header: Depth=1
	ldr	r0, .LCPI11_0
	ldr	r1, [r11, #-28]
	cmp	r1, r0
	beq	.LBB11_8
@ %bb.4:                                @   in Loop: Header=BB11_3 Depth=1
	ldr	r0, [r11, #-8]
	ldr	r1, [r11, #-16]
	bl	_get
	ldr	r1, [r11, #-12]
	cmp	r0, r1
	ble	.LBB11_6
@ %bb.5:                                @   in Loop: Header=BB11_3 Depth=1
	ldr	r0, [r11, #-24]
	ldr	r1, [r11, #-8]
	ldr	r2, [r11, #-16]
	str	r0, [sp, #20]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	_get
	ldr	r1, [sp, #20]           @ 4-byte Reload
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #16]           @ 4-byte Reload
	bl	_add
	str	r0, [r11, #-24]
	b	.LBB11_7
.LBB11_6:                               @   in Loop: Header=BB11_3 Depth=1
	ldr	r0, [r11, #-20]
	ldr	r1, [r11, #-8]
	ldr	r2, [r11, #-16]
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	_get
	ldr	r1, [sp, #12]           @ 4-byte Reload
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #8]            @ 4-byte Reload
	bl	_add
	str	r0, [r11, #-20]
.LBB11_7:                               @   in Loop: Header=BB11_3 Depth=1
	ldr	r0, [r11, #-28]
	ldr	r0, [r0, #4]
	str	r0, [r11, #-28]
	ldr	r0, [r11, #-16]
	add	r0, r0, #1
	str	r0, [r11, #-16]
	b	.LBB11_3
.LBB11_8:
	ldr	r0, [r11, #-8]
	bl	_freeList
	ldr	r0, [r11, #-20]
	bl	_quickSort
	ldr	lr, [r11, #-24]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, lr
	bl	_quickSort
	ldr	lr, [sp, #4]            @ 4-byte Reload
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, lr
	ldr	r1, [sp]                @ 4-byte Reload
	bl	_concatLists
	str	r0, [r11, #-4]
.LBB11_9:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.10:
.LCPI11_0:
	.long	0                       @ 0x0
.LCPI11_1:
	.long	2                       @ 0x2
.Lfunc_end11:
	.size	_quickSort, .Lfunc_end11-_quickSort
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_quickSortMain          @ -- Begin function _quickSortMain
	.p2align	2
	.type	_quickSortMain,%function
	.code	32                      @ @_quickSortMain
_quickSortMain:
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
	bl	_printList
	ldr	r0, .LCPI12_4
	ldr	r1, .LCPI12_2
	bl	printf
	ldr	r1, [r11, #-4]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	bl	_printList
	ldr	r0, .LCPI12_3
	ldr	r1, .LCPI12_2
	bl	printf
	ldr	r1, [r11, #-4]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	bl	_printList
	ldr	r0, .LCPI12_1
	ldr	r1, .LCPI12_2
	bl	printf
	ldr	r1, .LCPI12_0
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI12_0:
	.long	0                       @ 0x0
.LCPI12_1:
	.long	.L.str
.LCPI12_2:
	.long	4294966297              @ 0xfffffc19
.LCPI12_3:
	.long	.L.str
.LCPI12_4:
	.long	.L.str
.Lfunc_end12:
	.size	_quickSortMain, .Lfunc_end12-_quickSortMain
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_treesearch             @ -- Begin function _treesearch
	.p2align	2
	.type	_treesearch,%function
	.code	32                      @ @_treesearch
_treesearch:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r2, .LCPI13_1
	ldr	r3, .LCPI13_2
	str	r0, [sp, #8]
	str	r1, [sp, #4]
	mov	r0, r2
	mov	r1, r3
	bl	printf
	ldr	r1, .LCPI13_0
	ldr	r2, [sp, #8]
	cmp	r2, r1
	str	r0, [sp]                @ 4-byte Spill
	beq	.LBB13_8
@ %bb.1:
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [sp, #4]
	cmp	r0, r1
	bne	.LBB13_3
@ %bb.2:
	ldr	r0, .LCPI13_3
	str	r0, [r11, #-4]
	b	.LBB13_9
.LBB13_3:
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	ldr	r1, [sp, #4]
	bl	_treesearch
	cmp	r0, #1
	bne	.LBB13_5
@ %bb.4:
	ldr	r0, .LCPI13_3
	str	r0, [r11, #-4]
	b	.LBB13_9
.LBB13_5:
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #8]
	ldr	r1, [sp, #4]
	bl	_treesearch
	cmp	r0, #1
	bne	.LBB13_7
@ %bb.6:
	ldr	r0, .LCPI13_3
	str	r0, [r11, #-4]
	b	.LBB13_9
.LBB13_7:
	ldr	r0, .LCPI13_0
	str	r0, [r11, #-4]
	b	.LBB13_9
.LBB13_8:
	ldr	r0, .LCPI13_0
	str	r0, [r11, #-4]
.LBB13_9:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.10:
.LCPI13_0:
	.long	0                       @ 0x0
.LCPI13_1:
	.long	.L.str
.LCPI13_2:
	.long	4294967295              @ 0xffffffff
.LCPI13_3:
	.long	1                       @ 0x1
.Lfunc_end13:
	.size	_treesearch, .Lfunc_end13-_treesearch
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_inOrder                @ -- Begin function _inOrder
	.p2align	2
	.type	_inOrder,%function
	.code	32                      @ @_inOrder
_inOrder:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#32
	sub	sp, sp, #32
	ldr	r1, .LCPI14_0
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	cmp	r0, r1
	beq	.LBB14_2
@ %bb.1:
	ldr	r0, .LCPI14_1
	bl	malloc
	ldr	lr, .LCPI14_0
	str	r0, [r11, #-12]
	ldr	r0, [r11, #-8]
	ldr	r0, [r0]
	ldr	r1, [r11, #-12]
	str	r0, [r1]
	ldr	r0, [r11, #-12]
	str	lr, [r0, #4]
	ldr	r0, [r11, #-8]
	ldr	r0, [r0, #4]
	bl	_inOrder
	ldr	r1, [r11, #-12]
	ldr	lr, [r11, #-8]
	ldr	lr, [lr, #8]
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, lr
	str	r1, [sp, #12]           @ 4-byte Spill
	bl	_inOrder
	ldr	r1, [sp, #12]           @ 4-byte Reload
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #8]            @ 4-byte Reload
	bl	_concatLists
	ldr	r1, [sp, #16]           @ 4-byte Reload
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #4]            @ 4-byte Reload
	bl	_concatLists
	str	r0, [r11, #-4]
	b	.LBB14_3
.LBB14_2:
	ldr	r0, .LCPI14_0
	str	r0, [r11, #-4]
.LBB14_3:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI14_0:
	.long	0                       @ 0x0
.LCPI14_1:
	.long	8                       @ 0x8
.Lfunc_end14:
	.size	_inOrder, .Lfunc_end14-_inOrder
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_bintreesearch          @ -- Begin function _bintreesearch
	.p2align	2
	.type	_bintreesearch,%function
	.code	32                      @ @_bintreesearch
_bintreesearch:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r2, .LCPI15_1
	ldr	r3, .LCPI15_2
	str	r0, [sp, #8]
	str	r1, [sp, #4]
	mov	r0, r2
	mov	r1, r3
	bl	printf
	ldr	r1, .LCPI15_0
	ldr	r2, [sp, #8]
	cmp	r2, r1
	str	r0, [sp]                @ 4-byte Spill
	beq	.LBB15_6
@ %bb.1:
	ldr	r0, [sp, #8]
	ldr	r0, [r0]
	ldr	r1, [sp, #4]
	cmp	r0, r1
	bne	.LBB15_3
@ %bb.2:
	ldr	r0, .LCPI15_3
	str	r0, [r11, #-4]
	b	.LBB15_7
.LBB15_3:
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #8]
	ldr	r1, [r1]
	cmp	r0, r1
	bge	.LBB15_5
@ %bb.4:
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #4]
	ldr	r1, [sp, #4]
	bl	_bintreesearch
	str	r0, [r11, #-4]
	b	.LBB15_7
.LBB15_5:
	ldr	r0, [sp, #8]
	ldr	r0, [r0, #8]
	ldr	r1, [sp, #4]
	bl	_bintreesearch
	str	r0, [r11, #-4]
	b	.LBB15_7
.LBB15_6:
	ldr	r0, .LCPI15_0
	str	r0, [r11, #-4]
.LBB15_7:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.8:
.LCPI15_0:
	.long	0                       @ 0x0
.LCPI15_1:
	.long	.L.str
.LCPI15_2:
	.long	4294967295              @ 0xffffffff
.LCPI15_3:
	.long	1                       @ 0x1
.Lfunc_end15:
	.size	_bintreesearch, .Lfunc_end15-_bintreesearch
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_buildTree              @ -- Begin function _buildTree
	.p2align	2
	.type	_buildTree,%function
	.code	32                      @ @_buildTree
_buildTree:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#24
	sub	sp, sp, #24
	ldr	r1, .LCPI16_0
	str	r0, [r11, #-4]
	str	r1, [sp, #12]
	str	r1, [r11, #-8]
.LBB16_1:                               @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-8]
	ldr	r1, [r11, #-4]
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	bl	_size
	ldr	r1, [sp, #8]            @ 4-byte Reload
	cmp	r1, r0
	bge	.LBB16_3
@ %bb.2:                                @   in Loop: Header=BB16_1 Depth=1
	ldr	r0, [sp, #12]
	ldr	r1, [r11, #-4]
	ldr	r2, [r11, #-8]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, r2
	bl	_get
	ldr	r1, [sp, #4]            @ 4-byte Reload
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp]                @ 4-byte Reload
	bl	_treeadd
	str	r0, [sp, #12]
	ldr	r0, [r11, #-8]
	add	r0, r0, #1
	str	r0, [r11, #-8]
	b	.LBB16_1
.LBB16_3:
	ldr	r0, [sp, #12]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI16_0:
	.long	0                       @ 0x0
.Lfunc_end16:
	.size	_buildTree, .Lfunc_end16-_buildTree
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_treeMain               @ -- Begin function _treeMain
	.p2align	2
	.type	_treeMain,%function
	.code	32                      @ @_treeMain
_treeMain:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#200
	sub	sp, sp, #200
	str	r0, [r11, #-4]
	ldr	r0, [r11, #-4]
	bl	_buildTree
	str	r0, [r11, #-8]
	ldr	r0, [r11, #-8]
	bl	_treeprint
	ldr	r0, .LCPI17_38
	ldr	r1, .LCPI17_1
	bl	printf
	ldr	r1, [r11, #-8]
	str	r0, [r11, #-20]         @ 4-byte Spill
	mov	r0, r1
	bl	_inOrder
	str	r0, [r11, #-12]
	ldr	r0, [r11, #-12]
	bl	_printList
	ldr	r0, .LCPI17_37
	ldr	r1, .LCPI17_1
	bl	printf
	ldr	r1, [r11, #-12]
	str	r0, [r11, #-24]         @ 4-byte Spill
	mov	r0, r1
	bl	_freeList
	ldr	r0, [r11, #-8]
	bl	_postOrder
	str	r0, [r11, #-16]
	ldr	r0, [r11, #-16]
	bl	_printList
	ldr	r0, .LCPI17_36
	ldr	r1, .LCPI17_1
	bl	printf
	ldr	r1, [r11, #-16]
	str	r0, [r11, #-28]         @ 4-byte Spill
	mov	r0, r1
	bl	_freeList
	ldr	r1, .LCPI17_21
	ldr	r0, [r11, #-8]
	bl	_treesearch
	ldr	r1, .LCPI17_35
	str	r0, [r11, #-32]         @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [r11, #-32]         @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_34
	ldr	lr, .LCPI17_1
	str	r0, [r11, #-36]         @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI17_18
	ldr	lr, [r11, #-8]
	str	r0, [r11, #-40]         @ 4-byte Spill
	mov	r0, lr
	bl	_treesearch
	ldr	r1, .LCPI17_33
	str	r0, [r11, #-44]         @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [r11, #-44]         @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_32
	ldr	lr, .LCPI17_1
	str	r0, [r11, #-48]         @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI17_15
	ldr	lr, [r11, #-8]
	str	r0, [r11, #-52]         @ 4-byte Spill
	mov	r0, lr
	bl	_treesearch
	ldr	r1, .LCPI17_31
	str	r0, [r11, #-56]         @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [r11, #-56]         @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_30
	ldr	lr, .LCPI17_1
	str	r0, [r11, #-60]         @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI17_12
	ldr	lr, [r11, #-8]
	str	r0, [r11, #-64]         @ 4-byte Spill
	mov	r0, lr
	bl	_treesearch
	ldr	r1, .LCPI17_29
	str	r0, [r11, #-68]         @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [r11, #-68]         @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_28
	ldr	lr, .LCPI17_1
	str	r0, [r11, #-72]         @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI17_9
	ldr	lr, [r11, #-8]
	str	r0, [r11, #-76]         @ 4-byte Spill
	mov	r0, lr
	bl	_treesearch
	ldr	r1, .LCPI17_27
	str	r0, [r11, #-80]         @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [r11, #-80]         @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_26
	ldr	lr, .LCPI17_1
	str	r0, [r11, #-84]         @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI17_6
	ldr	lr, [r11, #-8]
	str	r0, [r11, #-88]         @ 4-byte Spill
	mov	r0, lr
	bl	_treesearch
	ldr	r1, .LCPI17_25
	str	r0, [r11, #-92]         @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [r11, #-92]         @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_24
	ldr	lr, .LCPI17_1
	str	r0, [r11, #-96]         @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI17_3
	ldr	lr, [r11, #-8]
	str	r0, [sp, #100]          @ 4-byte Spill
	mov	r0, lr
	bl	_treesearch
	ldr	r1, .LCPI17_23
	str	r0, [sp, #96]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #96]           @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_22
	ldr	lr, .LCPI17_1
	str	r0, [sp, #92]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI17_21
	ldr	lr, [r11, #-8]
	str	r0, [sp, #88]           @ 4-byte Spill
	mov	r0, lr
	bl	_bintreesearch
	ldr	r1, .LCPI17_20
	str	r0, [sp, #84]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #84]           @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_19
	ldr	lr, .LCPI17_1
	str	r0, [sp, #80]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI17_18
	ldr	lr, [r11, #-8]
	str	r0, [sp, #76]           @ 4-byte Spill
	mov	r0, lr
	bl	_bintreesearch
	ldr	r1, .LCPI17_17
	str	r0, [sp, #72]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #72]           @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_16
	ldr	lr, .LCPI17_1
	str	r0, [sp, #68]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI17_15
	ldr	lr, [r11, #-8]
	str	r0, [sp, #64]           @ 4-byte Spill
	mov	r0, lr
	bl	_bintreesearch
	ldr	r1, .LCPI17_14
	str	r0, [sp, #60]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #60]           @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_13
	ldr	lr, .LCPI17_1
	str	r0, [sp, #56]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI17_12
	ldr	lr, [r11, #-8]
	str	r0, [sp, #52]           @ 4-byte Spill
	mov	r0, lr
	bl	_bintreesearch
	ldr	r1, .LCPI17_11
	str	r0, [sp, #48]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #48]           @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_10
	ldr	lr, .LCPI17_1
	str	r0, [sp, #44]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI17_9
	ldr	lr, [r11, #-8]
	str	r0, [sp, #40]           @ 4-byte Spill
	mov	r0, lr
	bl	_bintreesearch
	ldr	r1, .LCPI17_8
	str	r0, [sp, #36]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #36]           @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_7
	ldr	lr, .LCPI17_1
	str	r0, [sp, #32]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI17_6
	ldr	lr, [r11, #-8]
	str	r0, [sp, #28]           @ 4-byte Spill
	mov	r0, lr
	bl	_bintreesearch
	ldr	r1, .LCPI17_5
	str	r0, [sp, #24]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #24]           @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_4
	ldr	lr, .LCPI17_1
	str	r0, [sp, #20]           @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, .LCPI17_3
	ldr	lr, [r11, #-8]
	str	r0, [sp, #16]           @ 4-byte Spill
	mov	r0, lr
	bl	_bintreesearch
	ldr	r1, .LCPI17_2
	str	r0, [sp, #12]           @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp, #12]           @ 4-byte Reload
	bl	printf
	ldr	r1, .LCPI17_0
	ldr	lr, .LCPI17_1
	str	r0, [sp, #8]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	printf
	ldr	r1, [r11, #-8]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	bl	_freeTree
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI17_0:
	.long	.L.str
.LCPI17_1:
	.long	4294966297              @ 0xfffffc19
.LCPI17_2:
	.long	.L.str
.LCPI17_3:
	.long	1                       @ 0x1
.LCPI17_4:
	.long	.L.str
.LCPI17_5:
	.long	.L.str
.LCPI17_6:
	.long	9                       @ 0x9
.LCPI17_7:
	.long	.L.str
.LCPI17_8:
	.long	.L.str
.LCPI17_9:
	.long	3                       @ 0x3
.LCPI17_10:
	.long	.L.str
.LCPI17_11:
	.long	.L.str
.LCPI17_12:
	.long	2                       @ 0x2
.LCPI17_13:
	.long	.L.str
.LCPI17_14:
	.long	.L.str
.LCPI17_15:
	.long	4294967294              @ 0xfffffffe
.LCPI17_16:
	.long	.L.str
.LCPI17_17:
	.long	.L.str
.LCPI17_18:
	.long	10                      @ 0xa
.LCPI17_19:
	.long	.L.str
.LCPI17_20:
	.long	.L.str
.LCPI17_21:
	.long	0                       @ 0x0
.LCPI17_22:
	.long	.L.str
.LCPI17_23:
	.long	.L.str
.LCPI17_24:
	.long	.L.str
.LCPI17_25:
	.long	.L.str
.LCPI17_26:
	.long	.L.str
.LCPI17_27:
	.long	.L.str
.LCPI17_28:
	.long	.L.str
.LCPI17_29:
	.long	.L.str
.LCPI17_30:
	.long	.L.str
.LCPI17_31:
	.long	.L.str
.LCPI17_32:
	.long	.L.str
.LCPI17_33:
	.long	.L.str
.LCPI17_34:
	.long	.L.str
.LCPI17_35:
	.long	.L.str
.LCPI17_36:
	.long	.L.str
.LCPI17_37:
	.long	.L.str
.LCPI17_38:
	.long	.L.str
.Lfunc_end17:
	.size	_treeMain, .Lfunc_end17-_treeMain
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	_myCopy                 @ -- Begin function _myCopy
	.p2align	2
	.type	_myCopy,%function
	.code	32                      @ @_myCopy
_myCopy:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#16
	sub	sp, sp, #16
	ldr	r1, .LCPI18_0
	str	r0, [sp, #8]
	ldr	r0, [sp, #8]
	cmp	r0, r1
	bne	.LBB18_2
@ %bb.1:
	ldr	r0, .LCPI18_0
	str	r0, [r11, #-4]
	b	.LBB18_3
.LBB18_2:
	ldr	r0, .LCPI18_0
	ldr	r1, [sp, #8]
	ldr	r1, [r1]
	bl	_add
	ldr	r1, [sp, #8]
	ldr	r1, [r1, #4]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	bl	_myCopy
	ldr	r1, [sp, #4]            @ 4-byte Reload
	str	r0, [sp]                @ 4-byte Spill
	mov	r0, r1
	ldr	r1, [sp]                @ 4-byte Reload
	bl	_concatLists
	str	r0, [r11, #-4]
.LBB18_3:
	ldr	r0, [r11, #-4]
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI18_0:
	.long	0                       @ 0x0
.Lfunc_end18:
	.size	_myCopy, .Lfunc_end18-_myCopy
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
	ldr	r0, .LCPI19_0
	str	r0, [r11, #-12]
	str	r0, [sp, #16]
	str	r0, [sp, #12]
	str	r0, [r11, #-4]
.LBB19_1:                               @ =>This Inner Loop Header: Depth=1
	ldr	r0, [r11, #-4]
	cmp	r0, #10
	bge	.LBB19_3
@ %bb.2:                                @   in Loop: Header=BB19_1 Depth=1
	ldr	r0, .LCPI19_1
	sub	r1, r11, #8
	bl	__isoc99_scanf
	ldr	r1, [r11, #-12]
	ldr	lr, [r11, #-8]
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1
	mov	r1, lr
	bl	_add
	str	r0, [r11, #-12]
	ldr	r0, [r11, #-12]
	bl	_myCopy
	str	r0, [sp, #16]
	ldr	r0, [r11, #-12]
	bl	_myCopy
	str	r0, [sp, #12]
	ldr	r0, [sp, #16]
	bl	_quickSortMain
	str	r0, [sp, #8]
	ldr	r0, [sp, #8]
	bl	_freeList
	ldr	r0, [sp, #12]
	bl	_treeMain
	ldr	r0, [r11, #-4]
	add	r0, r0, #1
	str	r0, [r11, #-4]
	b	.LBB19_1
.LBB19_3:
	ldr	r0, [r11, #-12]
	bl	_freeList
	ldr	r0, [sp, #16]
	bl	_freeList
	ldr	r0, [sp, #12]
	bl	_freeList
	ldr	r0, .LCPI19_0
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.4:
.LCPI19_0:
	.long	0                       @ 0x0
.LCPI19_1:
	.long	.L.str.1
.Lfunc_end19:
	.size	_main, .Lfunc_end19-_main
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
	ldr	r0, .LCPI20_0
	str	r0, [sp, #4]
	bl	_main
	mov	sp, r11
	pop	{r11, pc}
	.p2align	2
@ %bb.1:
.LCPI20_0:
	.long	0                       @ 0x0
.Lfunc_end20:
	.size	main, .Lfunc_end20-main
	.cantunwind
	.fnend
                                        @ -- End function
	.type	.L.str,%object          @ @.str
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str:
	.asciz	"%d\n"
	.size	.L.str, 4

	.type	.L.str.1,%object        @ @.str.1
.L.str.1:
	.asciz	"%d"
	.size	.L.str.1, 3

	.type	EV_a,%object            @ @EV_a
	.comm	EV_a,4,4
	.type	EV_b,%object            @ @EV_b
	.comm	EV_b,4,4
	.type	EV_i,%object            @ @EV_i
	.comm	EV_i,4,4

	.ident	"clang version 7.0.1-8+rpi3 (tags/RELEASE_701/final)"
	.section	".note.GNU-stack","",%progbits
	.addrsig
	.addrsig_sym _concatLists
	.addrsig_sym _add
	.addrsig_sym malloc
	.addrsig_sym _size
	.addrsig_sym _get
	.addrsig_sym _pop
	.addrsig_sym _printList
	.addrsig_sym printf
	.addrsig_sym _treeprint
	.addrsig_sym _freeList
	.addrsig_sym free
	.addrsig_sym _freeTree
	.addrsig_sym _postOrder
	.addrsig_sym _treeadd
	.addrsig_sym _quickSort
	.addrsig_sym _quickSortMain
	.addrsig_sym _treesearch
	.addrsig_sym _inOrder
	.addrsig_sym _bintreesearch
	.addrsig_sym _buildTree
	.addrsig_sym _treeMain
	.addrsig_sym _myCopy
	.addrsig_sym _main
	.addrsig_sym __isoc99_scanf
	.addrsig_sym main
	.addrsig_sym EV_a
	.addrsig_sym EV_b
	.addrsig_sym EV_i
