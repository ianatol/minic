   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.comm	EV_a,4,4
  17              		.comm	EV_b,4,4
  18              		.comm	EV_i,4,4
  19              		.align	2
  20              		.global	_concatLists
  21              		.arch armv6
  22              		.syntax unified
  23              		.arm
  24              		.fpu vfp
  26              	_concatLists:
  27              	.LFB6:
   1:bert.c        **** #include<stdio.h>
   2:bert.c        **** #include<stdlib.h>
   3:bert.c        **** struct EV_node
   4:bert.c        **** {
   5:bert.c        **** int EV_data;
   6:bert.c        **** struct EV_node * EV_next;
   7:bert.c        **** };
   8:bert.c        **** struct EV_tnode
   9:bert.c        **** {
  10:bert.c        **** int EV_data;
  11:bert.c        **** struct EV_tnode * EV_left;
  12:bert.c        **** struct EV_tnode * EV_right;
  13:bert.c        **** };
  14:bert.c        **** struct EV_i
  15:bert.c        **** {
  16:bert.c        **** int EV_i;
  17:bert.c        **** };
  18:bert.c        **** struct EV_myCopy
  19:bert.c        **** {
  20:bert.c        **** int EV_b;
  21:bert.c        **** };
  22:bert.c        **** int EV_a;
  23:bert.c        **** int EV_b;
  24:bert.c        **** struct EV_i * EV_i;
  25:bert.c        **** struct EV_node * _concatLists(struct EV_node * EV_first,struct EV_node * EV_second)
  26:bert.c        **** {
  31              		@ args = 0, pretend = 0, frame = 16
  32              		@ frame_needed = 1, uses_anonymous_args = 0
  33              		@ link register save eliminated.
  34 0000 04B02DE5 		str	fp, [sp, #-4]!
  37 0004 00B08DE2 		add	fp, sp, #0
  39 0008 14D04DE2 		sub	sp, sp, #20
  40 000c 10000BE5 		str	r0, [fp, #-16]
  41 0010 14100BE5 		str	r1, [fp, #-20]
  27:bert.c        **** struct EV_node * EV_temp;
  28:bert.c        **** EV_temp = EV_first;
  43 0014 10301BE5 		ldr	r3, [fp, #-16]
  44 0018 08300BE5 		str	r3, [fp, #-8]
  29:bert.c        **** if ((EV_first==NULL))
  46 001c 10301BE5 		ldr	r3, [fp, #-16]
  47 0020 000053E3 		cmp	r3, #0
  48 0024 0400001A 		bne	.L4
  30:bert.c        **** {
  31:bert.c        **** return EV_second;
  50 0028 14301BE5 		ldr	r3, [fp, #-20]
  51 002c 0A0000EA 		b	.L3
  52              	.L5:
  32:bert.c        **** }
  33:bert.c        **** while ((EV_temp->EV_next!=NULL))
  34:bert.c        **** {
  35:bert.c        **** EV_temp = EV_temp->EV_next;
  54 0030 08301BE5 		ldr	r3, [fp, #-8]
  55 0034 043093E5 		ldr	r3, [r3, #4]
  56 0038 08300BE5 		str	r3, [fp, #-8]
  57              	.L4:
  33:bert.c        **** {
  59 003c 08301BE5 		ldr	r3, [fp, #-8]
  60 0040 043093E5 		ldr	r3, [r3, #4]
  33:bert.c        **** {
  62 0044 000053E3 		cmp	r3, #0
  63 0048 F8FFFF1A 		bne	.L5
  36:bert.c        **** }
  37:bert.c        **** EV_temp->EV_next = EV_second;
  65 004c 08301BE5 		ldr	r3, [fp, #-8]
  66 0050 14201BE5 		ldr	r2, [fp, #-20]
  67 0054 042083E5 		str	r2, [r3, #4]
  38:bert.c        **** return EV_first;
  69 0058 10301BE5 		ldr	r3, [fp, #-16]
  70              	.L3:
  39:bert.c        **** }
  72 005c 0300A0E1 		mov	r0, r3
  73 0060 00D08BE2 		add	sp, fp, #0
  75              		@ sp needed
  76 0064 04B09DE4 		ldr	fp, [sp], #4
  79 0068 1EFF2FE1 		bx	lr
  81              	.LFE6:
  83              		.align	2
  84              		.global	_add
  85              		.syntax unified
  86              		.arm
  87              		.fpu vfp
  89              	_add:
  90              	.LFB7:
  40:bert.c        **** struct EV_node * _add(struct EV_node * EV_list,int EV_toAdd)
  41:bert.c        **** {
  93              		@ args = 0, pretend = 0, frame = 16
  94              		@ frame_needed = 1, uses_anonymous_args = 0
  95 006c 00482DE9 		push	{fp, lr}
  99 0070 04B08DE2 		add	fp, sp, #4
 101 0074 10D04DE2 		sub	sp, sp, #16
 102 0078 10000BE5 		str	r0, [fp, #-16]
 103 007c 14100BE5 		str	r1, [fp, #-20]
  42:bert.c        **** struct EV_node * EV_newNode;
  43:bert.c        **** EV_newNode = (struct EV_node*)malloc(sizeof(struct EV_node));
 105 0080 0800A0E3 		mov	r0, #8
 106 0084 FEFFFFEB 		bl	malloc
 107 0088 0030A0E1 		mov	r3, r0
 108 008c 08300BE5 		str	r3, [fp, #-8]
  44:bert.c        **** EV_newNode->EV_data = EV_toAdd;
 110 0090 08301BE5 		ldr	r3, [fp, #-8]
 111 0094 14201BE5 		ldr	r2, [fp, #-20]
 112 0098 002083E5 		str	r2, [r3]
  45:bert.c        **** EV_newNode->EV_next = EV_list;
 114 009c 08301BE5 		ldr	r3, [fp, #-8]
 115 00a0 10201BE5 		ldr	r2, [fp, #-16]
 116 00a4 042083E5 		str	r2, [r3, #4]
  46:bert.c        **** return EV_newNode;
 118 00a8 08301BE5 		ldr	r3, [fp, #-8]
  47:bert.c        **** }
 120 00ac 0300A0E1 		mov	r0, r3
 121 00b0 04D04BE2 		sub	sp, fp, #4
 123              		@ sp needed
 124 00b4 0088BDE8 		pop	{fp, pc}
 126              	.LFE7:
 128              		.align	2
 129              		.global	_size
 130              		.syntax unified
 131              		.arm
 132              		.fpu vfp
 134              	_size:
 135              	.LFB8:
  48:bert.c        **** int _size(struct EV_node * EV_list)
  49:bert.c        **** {
 138              		@ args = 0, pretend = 0, frame = 8
 139              		@ frame_needed = 1, uses_anonymous_args = 0
 140 00b8 00482DE9 		push	{fp, lr}
 144 00bc 04B08DE2 		add	fp, sp, #4
 146 00c0 08D04DE2 		sub	sp, sp, #8
 147 00c4 08000BE5 		str	r0, [fp, #-8]
  50:bert.c        **** if ((EV_list==NULL))
 149 00c8 08301BE5 		ldr	r3, [fp, #-8]
 150 00cc 000053E3 		cmp	r3, #0
 151 00d0 0100001A 		bne	.L9
  51:bert.c        **** {
  52:bert.c        **** return 0;
 153 00d4 0030A0E3 		mov	r3, #0
 154 00d8 050000EA 		b	.L10
 155              	.L9:
  53:bert.c        **** }
  54:bert.c        **** return (1+_size(EV_list->EV_next));
 157 00dc 08301BE5 		ldr	r3, [fp, #-8]
 158 00e0 043093E5 		ldr	r3, [r3, #4]
 159 00e4 0300A0E1 		mov	r0, r3
 160 00e8 FEFFFFEB 		bl	_size
 161 00ec 0030A0E1 		mov	r3, r0
 163 00f0 013083E2 		add	r3, r3, #1
 164              	.L10:
  55:bert.c        **** }
 166 00f4 0300A0E1 		mov	r0, r3
 167 00f8 04D04BE2 		sub	sp, fp, #4
 169              		@ sp needed
 170 00fc 0088BDE8 		pop	{fp, pc}
 172              	.LFE8:
 174              		.align	2
 175              		.global	_get
 176              		.syntax unified
 177              		.arm
 178              		.fpu vfp
 180              	_get:
 181              	.LFB9:
  56:bert.c        **** int _get(struct EV_node * EV_list,int EV_index)
  57:bert.c        **** {
 184              		@ args = 0, pretend = 0, frame = 8
 185              		@ frame_needed = 1, uses_anonymous_args = 0
 186 0100 00482DE9 		push	{fp, lr}
 190 0104 04B08DE2 		add	fp, sp, #4
 192 0108 08D04DE2 		sub	sp, sp, #8
 193 010c 08000BE5 		str	r0, [fp, #-8]
 194 0110 0C100BE5 		str	r1, [fp, #-12]
  58:bert.c        **** if ((EV_index==0))
 196 0114 0C301BE5 		ldr	r3, [fp, #-12]
 197 0118 000053E3 		cmp	r3, #0
 198 011c 0200001A 		bne	.L12
  59:bert.c        **** {
  60:bert.c        **** return EV_list->EV_data;
 200 0120 08301BE5 		ldr	r3, [fp, #-8]
 201 0124 003093E5 		ldr	r3, [r3]
 202 0128 070000EA 		b	.L13
 203              	.L12:
  61:bert.c        **** }
  62:bert.c        **** return _get(EV_list->EV_next, (EV_index-1));
 205 012c 08301BE5 		ldr	r3, [fp, #-8]
 206 0130 042093E5 		ldr	r2, [r3, #4]
 207 0134 0C301BE5 		ldr	r3, [fp, #-12]
 208 0138 013043E2 		sub	r3, r3, #1
 209 013c 0310A0E1 		mov	r1, r3
 210 0140 0200A0E1 		mov	r0, r2
 211 0144 FEFFFFEB 		bl	_get
 212 0148 0030A0E1 		mov	r3, r0
 213              	.L13:
  63:bert.c        **** }
 215 014c 0300A0E1 		mov	r0, r3
 216 0150 04D04BE2 		sub	sp, fp, #4
 218              		@ sp needed
 219 0154 0088BDE8 		pop	{fp, pc}
 221              	.LFE9:
 223              		.align	2
 224              		.global	_pop
 225              		.syntax unified
 226              		.arm
 227              		.fpu vfp
 229              	_pop:
 230              	.LFB10:
  64:bert.c        **** struct EV_node * _pop(struct EV_node * EV_list)
  65:bert.c        **** {
 233              		@ args = 0, pretend = 0, frame = 8
 234              		@ frame_needed = 1, uses_anonymous_args = 0
 235              		@ link register save eliminated.
 236 0158 04B02DE5 		str	fp, [sp, #-4]!
 239 015c 00B08DE2 		add	fp, sp, #0
 241 0160 0CD04DE2 		sub	sp, sp, #12
 242 0164 08000BE5 		str	r0, [fp, #-8]
  66:bert.c        **** EV_list = EV_list->EV_next;
 244 0168 08301BE5 		ldr	r3, [fp, #-8]
 245 016c 043093E5 		ldr	r3, [r3, #4]
 246 0170 08300BE5 		str	r3, [fp, #-8]
  67:bert.c        **** return EV_list;
 248 0174 08301BE5 		ldr	r3, [fp, #-8]
  68:bert.c        **** }
 250 0178 0300A0E1 		mov	r0, r3
 251 017c 00D08BE2 		add	sp, fp, #0
 253              		@ sp needed
 254 0180 04B09DE4 		ldr	fp, [sp], #4
 257 0184 1EFF2FE1 		bx	lr
 259              	.LFE10:
 261              		.section	.rodata
 262              		.align	2
 263              	.LC0:
 264 0000 25640A00 		.ascii	"%d\012\000"
 265              		.text
 266              		.align	2
 267              		.global	_printList
 268              		.syntax unified
 269              		.arm
 270              		.fpu vfp
 272              	_printList:
 273              	.LFB11:
  69:bert.c        **** void _printList(struct EV_node * EV_list)
  70:bert.c        **** {
 276              		@ args = 0, pretend = 0, frame = 8
 277              		@ frame_needed = 1, uses_anonymous_args = 0
 278 0188 00482DE9 		push	{fp, lr}
 282 018c 04B08DE2 		add	fp, sp, #4
 284 0190 08D04DE2 		sub	sp, sp, #8
 285 0194 08000BE5 		str	r0, [fp, #-8]
  71:bert.c        **** if ((EV_list!=NULL))
 287 0198 08301BE5 		ldr	r3, [fp, #-8]
 288 019c 000053E3 		cmp	r3, #0
 289 01a0 0800000A 		beq	.L18
  72:bert.c        **** {
  73:bert.c        **** printf("%d\n", EV_list->EV_data);
 291 01a4 08301BE5 		ldr	r3, [fp, #-8]
 292 01a8 003093E5 		ldr	r3, [r3]
 293 01ac 0310A0E1 		mov	r1, r3
 294 01b0 1C009FE5 		ldr	r0, .L19
 295 01b4 FEFFFFEB 		bl	printf
  74:bert.c        **** _printList(EV_list->EV_next);
 297 01b8 08301BE5 		ldr	r3, [fp, #-8]
 298 01bc 043093E5 		ldr	r3, [r3, #4]
 299 01c0 0300A0E1 		mov	r0, r3
 300 01c4 FEFFFFEB 		bl	_printList
 301              	.L18:
  75:bert.c        **** }
  76:bert.c        **** }
 303 01c8 0000A0E1 		nop
 304 01cc 04D04BE2 		sub	sp, fp, #4
 306              		@ sp needed
 307 01d0 0088BDE8 		pop	{fp, pc}
 308              	.L20:
 309              		.align	2
 310              	.L19:
 311 01d4 00000000 		.word	.LC0
 313              	.LFE11:
 315              		.align	2
 316              		.global	_treeprint
 317              		.syntax unified
 318              		.arm
 319              		.fpu vfp
 321              	_treeprint:
 322              	.LFB12:
  77:bert.c        **** void _treeprint(struct EV_tnode * EV_root)
  78:bert.c        **** {
 325              		@ args = 0, pretend = 0, frame = 8
 326              		@ frame_needed = 1, uses_anonymous_args = 0
 327 01d8 00482DE9 		push	{fp, lr}
 331 01dc 04B08DE2 		add	fp, sp, #4
 333 01e0 08D04DE2 		sub	sp, sp, #8
 334 01e4 08000BE5 		str	r0, [fp, #-8]
  79:bert.c        **** if ((EV_root!=NULL))
 336 01e8 08301BE5 		ldr	r3, [fp, #-8]
 337 01ec 000053E3 		cmp	r3, #0
 338 01f0 0C00000A 		beq	.L23
  80:bert.c        **** {
  81:bert.c        **** _treeprint(EV_root->EV_left);
 340 01f4 08301BE5 		ldr	r3, [fp, #-8]
 341 01f8 043093E5 		ldr	r3, [r3, #4]
 342 01fc 0300A0E1 		mov	r0, r3
 343 0200 FEFFFFEB 		bl	_treeprint
  82:bert.c        **** printf("%d\n", EV_root->EV_data);
 345 0204 08301BE5 		ldr	r3, [fp, #-8]
 346 0208 003093E5 		ldr	r3, [r3]
 347 020c 0310A0E1 		mov	r1, r3
 348 0210 1C009FE5 		ldr	r0, .L24
 349 0214 FEFFFFEB 		bl	printf
  83:bert.c        **** _treeprint(EV_root->EV_right);
 351 0218 08301BE5 		ldr	r3, [fp, #-8]
 352 021c 083093E5 		ldr	r3, [r3, #8]
 353 0220 0300A0E1 		mov	r0, r3
 354 0224 FEFFFFEB 		bl	_treeprint
 355              	.L23:
  84:bert.c        **** }
  85:bert.c        **** }
 357 0228 0000A0E1 		nop
 358 022c 04D04BE2 		sub	sp, fp, #4
 360              		@ sp needed
 361 0230 0088BDE8 		pop	{fp, pc}
 362              	.L25:
 363              		.align	2
 364              	.L24:
 365 0234 00000000 		.word	.LC0
 367              	.LFE12:
 369              		.align	2
 370              		.global	_freeList
 371              		.syntax unified
 372              		.arm
 373              		.fpu vfp
 375              	_freeList:
 376              	.LFB13:
  86:bert.c        **** void _freeList(struct EV_node * EV_list)
  87:bert.c        **** {
 379              		@ args = 0, pretend = 0, frame = 8
 380              		@ frame_needed = 1, uses_anonymous_args = 0
 381 0238 00482DE9 		push	{fp, lr}
 385 023c 04B08DE2 		add	fp, sp, #4
 387 0240 08D04DE2 		sub	sp, sp, #8
 388 0244 08000BE5 		str	r0, [fp, #-8]
  88:bert.c        **** if ((EV_list!=NULL))
 390 0248 08301BE5 		ldr	r3, [fp, #-8]
 391 024c 000053E3 		cmp	r3, #0
 392 0250 0500000A 		beq	.L28
  89:bert.c        **** {
  90:bert.c        **** _freeList(EV_list->EV_next);
 394 0254 08301BE5 		ldr	r3, [fp, #-8]
 395 0258 043093E5 		ldr	r3, [r3, #4]
 396 025c 0300A0E1 		mov	r0, r3
 397 0260 FEFFFFEB 		bl	_freeList
  91:bert.c        **** free(EV_list);
 399 0264 08001BE5 		ldr	r0, [fp, #-8]
 400 0268 FEFFFFEB 		bl	free
 401              	.L28:
  92:bert.c        **** }
  93:bert.c        **** }
 403 026c 0000A0E1 		nop
 404 0270 04D04BE2 		sub	sp, fp, #4
 406              		@ sp needed
 407 0274 0088BDE8 		pop	{fp, pc}
 409              	.LFE13:
 411              		.align	2
 412              		.global	_freeTree
 413              		.syntax unified
 414              		.arm
 415              		.fpu vfp
 417              	_freeTree:
 418              	.LFB14:
  94:bert.c        **** void _freeTree(struct EV_tnode * EV_root)
  95:bert.c        **** {
 421              		@ args = 0, pretend = 0, frame = 8
 422              		@ frame_needed = 1, uses_anonymous_args = 0
 423 0278 00482DE9 		push	{fp, lr}
 427 027c 04B08DE2 		add	fp, sp, #4
 429 0280 08D04DE2 		sub	sp, sp, #8
 430 0284 08000BE5 		str	r0, [fp, #-8]
  96:bert.c        **** if ((!(EV_root==NULL)))
 432 0288 08301BE5 		ldr	r3, [fp, #-8]
 433 028c 000053E3 		cmp	r3, #0
 434 0290 0900000A 		beq	.L31
  97:bert.c        **** {
  98:bert.c        **** _freeTree(EV_root->EV_left);
 436 0294 08301BE5 		ldr	r3, [fp, #-8]
 437 0298 043093E5 		ldr	r3, [r3, #4]
 438 029c 0300A0E1 		mov	r0, r3
 439 02a0 FEFFFFEB 		bl	_freeTree
  99:bert.c        **** _freeTree(EV_root->EV_right);
 441 02a4 08301BE5 		ldr	r3, [fp, #-8]
 442 02a8 083093E5 		ldr	r3, [r3, #8]
 443 02ac 0300A0E1 		mov	r0, r3
 444 02b0 FEFFFFEB 		bl	_freeTree
 100:bert.c        **** free(EV_root);
 446 02b4 08001BE5 		ldr	r0, [fp, #-8]
 447 02b8 FEFFFFEB 		bl	free
 448              	.L31:
 101:bert.c        **** }
 102:bert.c        **** }
 450 02bc 0000A0E1 		nop
 451 02c0 04D04BE2 		sub	sp, fp, #4
 453              		@ sp needed
 454 02c4 0088BDE8 		pop	{fp, pc}
 456              	.LFE14:
 458              		.align	2
 459              		.global	_postOrder
 460              		.syntax unified
 461              		.arm
 462              		.fpu vfp
 464              	_postOrder:
 465              	.LFB15:
 103:bert.c        **** struct EV_node * _postOrder(struct EV_tnode * EV_root)
 104:bert.c        **** {
 468              		@ args = 0, pretend = 0, frame = 16
 469              		@ frame_needed = 1, uses_anonymous_args = 0
 470 02c8 10482DE9 		push	{r4, fp, lr}
 475 02cc 08B08DE2 		add	fp, sp, #8
 477 02d0 14D04DE2 		sub	sp, sp, #20
 478 02d4 18000BE5 		str	r0, [fp, #-24]
 105:bert.c        **** struct EV_node * EV_temp;
 106:bert.c        **** if ((EV_root!=NULL))
 480 02d8 18301BE5 		ldr	r3, [fp, #-24]
 481 02dc 000053E3 		cmp	r3, #0
 482 02e0 1D00000A 		beq	.L33
 107:bert.c        **** {
 108:bert.c        **** EV_temp = (struct EV_node*)malloc(sizeof(struct EV_node));
 484 02e4 0800A0E3 		mov	r0, #8
 485 02e8 FEFFFFEB 		bl	malloc
 486 02ec 0030A0E1 		mov	r3, r0
 487 02f0 10300BE5 		str	r3, [fp, #-16]
 109:bert.c        **** EV_temp->EV_data = EV_root->EV_data;
 489 02f4 18301BE5 		ldr	r3, [fp, #-24]
 490 02f8 002093E5 		ldr	r2, [r3]
 492 02fc 10301BE5 		ldr	r3, [fp, #-16]
 493 0300 002083E5 		str	r2, [r3]
 110:bert.c        **** EV_temp->EV_next = NULL;
 495 0304 10301BE5 		ldr	r3, [fp, #-16]
 496 0308 0020A0E3 		mov	r2, #0
 497 030c 042083E5 		str	r2, [r3, #4]
 111:bert.c        **** return _concatLists(_concatLists(_postOrder(EV_root->EV_left), _postOrder(EV_root->EV_right)), EV_t
 499 0310 18301BE5 		ldr	r3, [fp, #-24]
 500 0314 043093E5 		ldr	r3, [r3, #4]
 501 0318 0300A0E1 		mov	r0, r3
 502 031c FEFFFFEB 		bl	_postOrder
 503 0320 0040A0E1 		mov	r4, r0
 504 0324 18301BE5 		ldr	r3, [fp, #-24]
 505 0328 083093E5 		ldr	r3, [r3, #8]
 506 032c 0300A0E1 		mov	r0, r3
 507 0330 FEFFFFEB 		bl	_postOrder
 508 0334 0030A0E1 		mov	r3, r0
 509 0338 0310A0E1 		mov	r1, r3
 510 033c 0400A0E1 		mov	r0, r4
 511 0340 FEFFFFEB 		bl	_concatLists
 512 0344 0030A0E1 		mov	r3, r0
 513 0348 10101BE5 		ldr	r1, [fp, #-16]
 514 034c 0300A0E1 		mov	r0, r3
 515 0350 FEFFFFEB 		bl	_concatLists
 516 0354 0030A0E1 		mov	r3, r0
 517 0358 000000EA 		b	.L34
 518              	.L33:
 112:bert.c        **** }
 113:bert.c        **** return NULL;
 520 035c 0030A0E3 		mov	r3, #0
 521              	.L34:
 114:bert.c        **** }
 523 0360 0300A0E1 		mov	r0, r3
 524 0364 08D04BE2 		sub	sp, fp, #8
 526              		@ sp needed
 527 0368 1088BDE8 		pop	{r4, fp, pc}
 529              	.LFE15:
 531              		.align	2
 532              		.global	_treeadd
 533              		.syntax unified
 534              		.arm
 535              		.fpu vfp
 537              	_treeadd:
 538              	.LFB16:
 115:bert.c        **** struct EV_tnode * _treeadd(struct EV_tnode * EV_root,int EV_toAdd)
 116:bert.c        **** {
 541              		@ args = 0, pretend = 0, frame = 16
 542              		@ frame_needed = 1, uses_anonymous_args = 0
 543 036c 00482DE9 		push	{fp, lr}
 547 0370 04B08DE2 		add	fp, sp, #4
 549 0374 10D04DE2 		sub	sp, sp, #16
 550 0378 10000BE5 		str	r0, [fp, #-16]
 551 037c 14100BE5 		str	r1, [fp, #-20]
 117:bert.c        **** struct EV_tnode * EV_temp;
 118:bert.c        **** if ((EV_root==NULL))
 553 0380 10301BE5 		ldr	r3, [fp, #-16]
 554 0384 000053E3 		cmp	r3, #0
 555 0388 0E00001A 		bne	.L36
 119:bert.c        **** {
 120:bert.c        **** EV_temp = (struct EV_tnode*)malloc(sizeof(struct EV_tnode));
 557 038c 0C00A0E3 		mov	r0, #12
 558 0390 FEFFFFEB 		bl	malloc
 559 0394 0030A0E1 		mov	r3, r0
 560 0398 08300BE5 		str	r3, [fp, #-8]
 121:bert.c        **** EV_temp->EV_data = EV_toAdd;
 562 039c 08301BE5 		ldr	r3, [fp, #-8]
 563 03a0 14201BE5 		ldr	r2, [fp, #-20]
 564 03a4 002083E5 		str	r2, [r3]
 122:bert.c        **** EV_temp->EV_left = NULL;
 566 03a8 08301BE5 		ldr	r3, [fp, #-8]
 567 03ac 0020A0E3 		mov	r2, #0
 568 03b0 042083E5 		str	r2, [r3, #4]
 123:bert.c        **** EV_temp->EV_right = NULL;
 570 03b4 08301BE5 		ldr	r3, [fp, #-8]
 571 03b8 0020A0E3 		mov	r2, #0
 572 03bc 082083E5 		str	r2, [r3, #8]
 124:bert.c        **** return EV_temp;
 574 03c0 08301BE5 		ldr	r3, [fp, #-8]
 575 03c4 160000EA 		b	.L37
 576              	.L36:
 125:bert.c        **** }
 126:bert.c        **** if ((EV_toAdd<EV_root->EV_data))
 578 03c8 10301BE5 		ldr	r3, [fp, #-16]
 579 03cc 003093E5 		ldr	r3, [r3]
 581 03d0 14201BE5 		ldr	r2, [fp, #-20]
 582 03d4 030052E1 		cmp	r2, r3
 583 03d8 080000AA 		bge	.L38
 127:bert.c        **** {
 128:bert.c        **** EV_root->EV_left = _treeadd(EV_root->EV_left, EV_toAdd);
 585 03dc 10301BE5 		ldr	r3, [fp, #-16]
 586 03e0 043093E5 		ldr	r3, [r3, #4]
 587 03e4 14101BE5 		ldr	r1, [fp, #-20]
 588 03e8 0300A0E1 		mov	r0, r3
 589 03ec FEFFFFEB 		bl	_treeadd
 590 03f0 0020A0E1 		mov	r2, r0
 592 03f4 10301BE5 		ldr	r3, [fp, #-16]
 593 03f8 042083E5 		str	r2, [r3, #4]
 594 03fc 070000EA 		b	.L39
 595              	.L38:
 129:bert.c        **** }
 130:bert.c        **** else
 131:bert.c        **** {
 132:bert.c        **** EV_root->EV_right = _treeadd(EV_root->EV_right, EV_toAdd);
 597 0400 10301BE5 		ldr	r3, [fp, #-16]
 598 0404 083093E5 		ldr	r3, [r3, #8]
 599 0408 14101BE5 		ldr	r1, [fp, #-20]
 600 040c 0300A0E1 		mov	r0, r3
 601 0410 FEFFFFEB 		bl	_treeadd
 602 0414 0020A0E1 		mov	r2, r0
 604 0418 10301BE5 		ldr	r3, [fp, #-16]
 605 041c 082083E5 		str	r2, [r3, #8]
 606              	.L39:
 133:bert.c        **** }
 134:bert.c        **** return EV_root;
 608 0420 10301BE5 		ldr	r3, [fp, #-16]
 609              	.L37:
 135:bert.c        **** }
 611 0424 0300A0E1 		mov	r0, r3
 612 0428 04D04BE2 		sub	sp, fp, #4
 614              		@ sp needed
 615 042c 0088BDE8 		pop	{fp, pc}
 617              	.LFE16:
 619              		.align	2
 620              		.global	_quickSort
 621              		.syntax unified
 622              		.arm
 623              		.fpu vfp
 625              	_quickSort:
 626              	.LFB17:
 136:bert.c        **** struct EV_node * _quickSort(struct EV_node * EV_list)
 137:bert.c        **** {
 629              		@ args = 0, pretend = 0, frame = 32
 630              		@ frame_needed = 1, uses_anonymous_args = 0
 631 0430 10482DE9 		push	{r4, fp, lr}
 636 0434 08B08DE2 		add	fp, sp, #8
 638 0438 24D04DE2 		sub	sp, sp, #36
 639 043c 28000BE5 		str	r0, [fp, #-40]
 138:bert.c        **** int EV_pivot;
 139:bert.c        **** int EV_i;
 140:bert.c        **** struct EV_node * EV_less;
 141:bert.c        **** struct EV_node * EV_greater;
 142:bert.c        **** struct EV_node * EV_temp;
 143:bert.c        **** EV_less = NULL;
 641 0440 0030A0E3 		mov	r3, #0
 642 0444 14300BE5 		str	r3, [fp, #-20]
 144:bert.c        **** EV_greater = NULL;
 644 0448 0030A0E3 		mov	r3, #0
 645 044c 18300BE5 		str	r3, [fp, #-24]
 145:bert.c        **** if ((_size(EV_list)<=1))
 647 0450 28001BE5 		ldr	r0, [fp, #-40]
 648 0454 FEFFFFEB 		bl	_size
 649 0458 0030A0E1 		mov	r3, r0
 651 045c 010053E3 		cmp	r3, #1
 652 0460 010000CA 		bgt	.L41
 146:bert.c        **** {
 147:bert.c        **** return EV_list;
 654 0464 28301BE5 		ldr	r3, [fp, #-40]
 655 0468 420000EA 		b	.L42
 656              	.L41:
 148:bert.c        **** }
 149:bert.c        **** EV_pivot = ((_get(EV_list, 0)+_get(EV_list, (_size(EV_list)-1)))/2);
 658 046c 0010A0E3 		mov	r1, #0
 659 0470 28001BE5 		ldr	r0, [fp, #-40]
 660 0474 FEFFFFEB 		bl	_get
 661 0478 0040A0E1 		mov	r4, r0
 663 047c 28001BE5 		ldr	r0, [fp, #-40]
 664 0480 FEFFFFEB 		bl	_size
 665 0484 0030A0E1 		mov	r3, r0
 667 0488 013043E2 		sub	r3, r3, #1
 668 048c 0310A0E1 		mov	r1, r3
 669 0490 28001BE5 		ldr	r0, [fp, #-40]
 670 0494 FEFFFFEB 		bl	_get
 671 0498 0030A0E1 		mov	r3, r0
 673 049c 033084E0 		add	r3, r4, r3
 675 04a0 A32FA0E1 		lsr	r2, r3, #31
 676 04a4 033082E0 		add	r3, r2, r3
 677 04a8 C330A0E1 		asr	r3, r3, #1
 678 04ac 20300BE5 		str	r3, [fp, #-32]
 150:bert.c        **** EV_temp = EV_list;
 680 04b0 28301BE5 		ldr	r3, [fp, #-40]
 681 04b4 1C300BE5 		str	r3, [fp, #-28]
 151:bert.c        **** EV_i = 0;
 683 04b8 0030A0E3 		mov	r3, #0
 684 04bc 10300BE5 		str	r3, [fp, #-16]
 152:bert.c        **** while ((EV_temp!=NULL))
 686 04c0 1D0000EA 		b	.L43
 687              	.L46:
 153:bert.c        **** {
 154:bert.c        **** if ((_get(EV_list, EV_i)>EV_pivot))
 689 04c4 10101BE5 		ldr	r1, [fp, #-16]
 690 04c8 28001BE5 		ldr	r0, [fp, #-40]
 691 04cc FEFFFFEB 		bl	_get
 692 04d0 0020A0E1 		mov	r2, r0
 694 04d4 20301BE5 		ldr	r3, [fp, #-32]
 695 04d8 020053E1 		cmp	r3, r2
 696 04dc 080000AA 		bge	.L44
 155:bert.c        **** {
 156:bert.c        **** EV_greater = _add(EV_greater, _get(EV_list, EV_i));
 698 04e0 10101BE5 		ldr	r1, [fp, #-16]
 699 04e4 28001BE5 		ldr	r0, [fp, #-40]
 700 04e8 FEFFFFEB 		bl	_get
 701 04ec 0030A0E1 		mov	r3, r0
 702 04f0 0310A0E1 		mov	r1, r3
 703 04f4 18001BE5 		ldr	r0, [fp, #-24]
 704 04f8 FEFFFFEB 		bl	_add
 705 04fc 18000BE5 		str	r0, [fp, #-24]
 706 0500 070000EA 		b	.L45
 707              	.L44:
 157:bert.c        **** }
 158:bert.c        **** else
 159:bert.c        **** {
 160:bert.c        **** EV_less = _add(EV_less, _get(EV_list, EV_i));
 709 0504 10101BE5 		ldr	r1, [fp, #-16]
 710 0508 28001BE5 		ldr	r0, [fp, #-40]
 711 050c FEFFFFEB 		bl	_get
 712 0510 0030A0E1 		mov	r3, r0
 713 0514 0310A0E1 		mov	r1, r3
 714 0518 14001BE5 		ldr	r0, [fp, #-20]
 715 051c FEFFFFEB 		bl	_add
 716 0520 14000BE5 		str	r0, [fp, #-20]
 717              	.L45:
 161:bert.c        **** }
 162:bert.c        **** EV_temp = EV_temp->EV_next;
 719 0524 1C301BE5 		ldr	r3, [fp, #-28]
 720 0528 043093E5 		ldr	r3, [r3, #4]
 721 052c 1C300BE5 		str	r3, [fp, #-28]
 163:bert.c        **** EV_i = (EV_i+1);
 723 0530 10301BE5 		ldr	r3, [fp, #-16]
 724 0534 013083E2 		add	r3, r3, #1
 725 0538 10300BE5 		str	r3, [fp, #-16]
 726              	.L43:
 152:bert.c        **** {
 728 053c 1C301BE5 		ldr	r3, [fp, #-28]
 729 0540 000053E3 		cmp	r3, #0
 730 0544 DEFFFF1A 		bne	.L46
 164:bert.c        **** }
 165:bert.c        **** _freeList(EV_list);
 732 0548 28001BE5 		ldr	r0, [fp, #-40]
 733 054c FEFFFFEB 		bl	_freeList
 166:bert.c        **** return _concatLists(_quickSort(EV_less), _quickSort(EV_greater));
 735 0550 14001BE5 		ldr	r0, [fp, #-20]
 736 0554 FEFFFFEB 		bl	_quickSort
 737 0558 0040A0E1 		mov	r4, r0
 738 055c 18001BE5 		ldr	r0, [fp, #-24]
 739 0560 FEFFFFEB 		bl	_quickSort
 740 0564 0030A0E1 		mov	r3, r0
 741 0568 0310A0E1 		mov	r1, r3
 742 056c 0400A0E1 		mov	r0, r4
 743 0570 FEFFFFEB 		bl	_concatLists
 744 0574 0030A0E1 		mov	r3, r0
 745              	.L42:
 167:bert.c        **** }
 747 0578 0300A0E1 		mov	r0, r3
 748 057c 08D04BE2 		sub	sp, fp, #8
 750              		@ sp needed
 751 0580 1088BDE8 		pop	{r4, fp, pc}
 753              	.LFE17:
 755              		.align	2
 756              		.global	_quickSortMain
 757              		.syntax unified
 758              		.arm
 759              		.fpu vfp
 761              	_quickSortMain:
 762              	.LFB18:
 168:bert.c        **** struct EV_node * _quickSortMain(struct EV_node * EV_list)
 169:bert.c        **** {
 765              		@ args = 0, pretend = 0, frame = 8
 766              		@ frame_needed = 1, uses_anonymous_args = 0
 767 0584 00482DE9 		push	{fp, lr}
 771 0588 04B08DE2 		add	fp, sp, #4
 773 058c 08D04DE2 		sub	sp, sp, #8
 774 0590 08000BE5 		str	r0, [fp, #-8]
 170:bert.c        **** _printList(EV_list);
 776 0594 08001BE5 		ldr	r0, [fp, #-8]
 777 0598 FEFFFFEB 		bl	_printList
 171:bert.c        **** printf("%d\n", (-999));
 779 059c 3C109FE5 		ldr	r1, .L49
 780 05a0 3C009FE5 		ldr	r0, .L49+4
 781 05a4 FEFFFFEB 		bl	printf
 172:bert.c        **** _printList(EV_list);
 783 05a8 08001BE5 		ldr	r0, [fp, #-8]
 784 05ac FEFFFFEB 		bl	_printList
 173:bert.c        **** printf("%d\n", (-999));
 786 05b0 28109FE5 		ldr	r1, .L49
 787 05b4 28009FE5 		ldr	r0, .L49+4
 788 05b8 FEFFFFEB 		bl	printf
 174:bert.c        **** _printList(EV_list);
 790 05bc 08001BE5 		ldr	r0, [fp, #-8]
 791 05c0 FEFFFFEB 		bl	_printList
 175:bert.c        **** printf("%d\n", (-999));
 793 05c4 14109FE5 		ldr	r1, .L49
 794 05c8 14009FE5 		ldr	r0, .L49+4
 795 05cc FEFFFFEB 		bl	printf
 176:bert.c        **** return NULL;
 797 05d0 0030A0E3 		mov	r3, #0
 177:bert.c        **** }
 799 05d4 0300A0E1 		mov	r0, r3
 800 05d8 04D04BE2 		sub	sp, fp, #4
 802              		@ sp needed
 803 05dc 0088BDE8 		pop	{fp, pc}
 804              	.L50:
 805              		.align	2
 806              	.L49:
 807 05e0 19FCFFFF 		.word	-999
 808 05e4 00000000 		.word	.LC0
 810              	.LFE18:
 812              		.align	2
 813              		.global	_treesearch
 814              		.syntax unified
 815              		.arm
 816              		.fpu vfp
 818              	_treesearch:
 819              	.LFB19:
 178:bert.c        **** int _treesearch(struct EV_tnode * EV_root,int EV_target)
 179:bert.c        **** {
 822              		@ args = 0, pretend = 0, frame = 8
 823              		@ frame_needed = 1, uses_anonymous_args = 0
 824 05e8 00482DE9 		push	{fp, lr}
 828 05ec 04B08DE2 		add	fp, sp, #4
 830 05f0 08D04DE2 		sub	sp, sp, #8
 831 05f4 08000BE5 		str	r0, [fp, #-8]
 832 05f8 0C100BE5 		str	r1, [fp, #-12]
 180:bert.c        **** printf("%d\n", (-1));
 834 05fc 0010E0E3 		mvn	r1, #0
 835 0600 90009FE5 		ldr	r0, .L57
 836 0604 FEFFFFEB 		bl	printf
 181:bert.c        **** if ((EV_root!=NULL))
 838 0608 08301BE5 		ldr	r3, [fp, #-8]
 839 060c 000053E3 		cmp	r3, #0
 840 0610 1C00000A 		beq	.L52
 182:bert.c        **** {
 183:bert.c        **** if ((EV_root->EV_data==EV_target))
 842 0614 08301BE5 		ldr	r3, [fp, #-8]
 843 0618 003093E5 		ldr	r3, [r3]
 845 061c 0C201BE5 		ldr	r2, [fp, #-12]
 846 0620 030052E1 		cmp	r2, r3
 847 0624 0100001A 		bne	.L53
 184:bert.c        **** {
 185:bert.c        **** return 1;
 849 0628 0130A0E3 		mov	r3, #1
 850 062c 160000EA 		b	.L54
 851              	.L53:
 186:bert.c        **** }
 187:bert.c        **** if ((_treesearch(EV_root->EV_left, EV_target)==1))
 853 0630 08301BE5 		ldr	r3, [fp, #-8]
 854 0634 043093E5 		ldr	r3, [r3, #4]
 855 0638 0C101BE5 		ldr	r1, [fp, #-12]
 856 063c 0300A0E1 		mov	r0, r3
 857 0640 FEFFFFEB 		bl	_treesearch
 858 0644 0030A0E1 		mov	r3, r0
 860 0648 010053E3 		cmp	r3, #1
 861 064c 0100001A 		bne	.L55
 188:bert.c        **** {
 189:bert.c        **** return 1;
 863 0650 0130A0E3 		mov	r3, #1
 864 0654 0C0000EA 		b	.L54
 865              	.L55:
 190:bert.c        **** }
 191:bert.c        **** if ((_treesearch(EV_root->EV_right, EV_target)==1))
 867 0658 08301BE5 		ldr	r3, [fp, #-8]
 868 065c 083093E5 		ldr	r3, [r3, #8]
 869 0660 0C101BE5 		ldr	r1, [fp, #-12]
 870 0664 0300A0E1 		mov	r0, r3
 871 0668 FEFFFFEB 		bl	_treesearch
 872 066c 0030A0E1 		mov	r3, r0
 874 0670 010053E3 		cmp	r3, #1
 875 0674 0100001A 		bne	.L56
 192:bert.c        **** {
 193:bert.c        **** return 1;
 877 0678 0130A0E3 		mov	r3, #1
 878 067c 020000EA 		b	.L54
 879              	.L56:
 194:bert.c        **** }
 195:bert.c        **** else
 196:bert.c        **** {
 197:bert.c        **** return 0;
 881 0680 0030A0E3 		mov	r3, #0
 882 0684 000000EA 		b	.L54
 883              	.L52:
 198:bert.c        **** }
 199:bert.c        **** }
 200:bert.c        **** return 0;
 885 0688 0030A0E3 		mov	r3, #0
 886              	.L54:
 201:bert.c        **** }
 888 068c 0300A0E1 		mov	r0, r3
 889 0690 04D04BE2 		sub	sp, fp, #4
 891              		@ sp needed
 892 0694 0088BDE8 		pop	{fp, pc}
 893              	.L58:
 894              		.align	2
 895              	.L57:
 896 0698 00000000 		.word	.LC0
 898              	.LFE19:
 900              		.align	2
 901              		.global	_inOrder
 902              		.syntax unified
 903              		.arm
 904              		.fpu vfp
 906              	_inOrder:
 907              	.LFB20:
 202:bert.c        **** struct EV_node * _inOrder(struct EV_tnode * EV_root)
 203:bert.c        **** {
 910              		@ args = 0, pretend = 0, frame = 16
 911              		@ frame_needed = 1, uses_anonymous_args = 0
 912 069c 10482DE9 		push	{r4, fp, lr}
 917 06a0 08B08DE2 		add	fp, sp, #8
 919 06a4 14D04DE2 		sub	sp, sp, #20
 920 06a8 18000BE5 		str	r0, [fp, #-24]
 204:bert.c        **** struct EV_node * EV_temp;
 205:bert.c        **** if ((EV_root!=NULL))
 922 06ac 18301BE5 		ldr	r3, [fp, #-24]
 923 06b0 000053E3 		cmp	r3, #0
 924 06b4 1D00000A 		beq	.L60
 206:bert.c        **** {
 207:bert.c        **** EV_temp = (struct EV_node*)malloc(sizeof(struct EV_node));
 926 06b8 0800A0E3 		mov	r0, #8
 927 06bc FEFFFFEB 		bl	malloc
 928 06c0 0030A0E1 		mov	r3, r0
 929 06c4 10300BE5 		str	r3, [fp, #-16]
 208:bert.c        **** EV_temp->EV_data = EV_root->EV_data;
 931 06c8 18301BE5 		ldr	r3, [fp, #-24]
 932 06cc 002093E5 		ldr	r2, [r3]
 934 06d0 10301BE5 		ldr	r3, [fp, #-16]
 935 06d4 002083E5 		str	r2, [r3]
 209:bert.c        **** EV_temp->EV_next = NULL;
 937 06d8 10301BE5 		ldr	r3, [fp, #-16]
 938 06dc 0020A0E3 		mov	r2, #0
 939 06e0 042083E5 		str	r2, [r3, #4]
 210:bert.c        **** return _concatLists(_inOrder(EV_root->EV_left), _concatLists(EV_temp, _inOrder(EV_root->EV_right)))
 941 06e4 18301BE5 		ldr	r3, [fp, #-24]
 942 06e8 043093E5 		ldr	r3, [r3, #4]
 943 06ec 0300A0E1 		mov	r0, r3
 944 06f0 FEFFFFEB 		bl	_inOrder
 945 06f4 0040A0E1 		mov	r4, r0
 946 06f8 18301BE5 		ldr	r3, [fp, #-24]
 947 06fc 083093E5 		ldr	r3, [r3, #8]
 948 0700 0300A0E1 		mov	r0, r3
 949 0704 FEFFFFEB 		bl	_inOrder
 950 0708 0030A0E1 		mov	r3, r0
 951 070c 0310A0E1 		mov	r1, r3
 952 0710 10001BE5 		ldr	r0, [fp, #-16]
 953 0714 FEFFFFEB 		bl	_concatLists
 954 0718 0030A0E1 		mov	r3, r0
 955 071c 0310A0E1 		mov	r1, r3
 956 0720 0400A0E1 		mov	r0, r4
 957 0724 FEFFFFEB 		bl	_concatLists
 958 0728 0030A0E1 		mov	r3, r0
 959 072c 000000EA 		b	.L61
 960              	.L60:
 211:bert.c        **** }
 212:bert.c        **** else
 213:bert.c        **** {
 214:bert.c        **** return NULL;
 962 0730 0030A0E3 		mov	r3, #0
 963              	.L61:
 215:bert.c        **** }
 216:bert.c        **** }
 965 0734 0300A0E1 		mov	r0, r3
 966 0738 08D04BE2 		sub	sp, fp, #8
 968              		@ sp needed
 969 073c 1088BDE8 		pop	{r4, fp, pc}
 971              	.LFE20:
 973              		.align	2
 974              		.global	_bintreesearch
 975              		.syntax unified
 976              		.arm
 977              		.fpu vfp
 979              	_bintreesearch:
 980              	.LFB21:
 217:bert.c        **** int _bintreesearch(struct EV_tnode * EV_root,int EV_target)
 218:bert.c        **** {
 983              		@ args = 0, pretend = 0, frame = 8
 984              		@ frame_needed = 1, uses_anonymous_args = 0
 985 0740 00482DE9 		push	{fp, lr}
 989 0744 04B08DE2 		add	fp, sp, #4
 991 0748 08D04DE2 		sub	sp, sp, #8
 992 074c 08000BE5 		str	r0, [fp, #-8]
 993 0750 0C100BE5 		str	r1, [fp, #-12]
 219:bert.c        **** printf("%d\n", (-1));
 995 0754 0010E0E3 		mvn	r1, #0
 996 0758 84009FE5 		ldr	r0, .L67
 997 075c FEFFFFEB 		bl	printf
 220:bert.c        **** if ((EV_root!=NULL))
 999 0760 08301BE5 		ldr	r3, [fp, #-8]
 1000 0764 000053E3 		cmp	r3, #0
 1001 0768 1900000A 		beq	.L63
 221:bert.c        **** {
 222:bert.c        **** if ((EV_root->EV_data==EV_target))
 1003 076c 08301BE5 		ldr	r3, [fp, #-8]
 1004 0770 003093E5 		ldr	r3, [r3]
 1006 0774 0C201BE5 		ldr	r2, [fp, #-12]
 1007 0778 030052E1 		cmp	r2, r3
 1008 077c 0100001A 		bne	.L64
 223:bert.c        **** {
 224:bert.c        **** return 1;
 1010 0780 0130A0E3 		mov	r3, #1
 1011 0784 130000EA 		b	.L65
 1012              	.L64:
 225:bert.c        **** }
 226:bert.c        **** if ((EV_target<EV_root->EV_data))
 1014 0788 08301BE5 		ldr	r3, [fp, #-8]
 1015 078c 003093E5 		ldr	r3, [r3]
 1017 0790 0C201BE5 		ldr	r2, [fp, #-12]
 1018 0794 030052E1 		cmp	r2, r3
 1019 0798 060000AA 		bge	.L66
 227:bert.c        **** {
 228:bert.c        **** return _bintreesearch(EV_root->EV_left, EV_target);
 1021 079c 08301BE5 		ldr	r3, [fp, #-8]
 1022 07a0 043093E5 		ldr	r3, [r3, #4]
 1023 07a4 0C101BE5 		ldr	r1, [fp, #-12]
 1024 07a8 0300A0E1 		mov	r0, r3
 1025 07ac FEFFFFEB 		bl	_bintreesearch
 1026 07b0 0030A0E1 		mov	r3, r0
 1027 07b4 070000EA 		b	.L65
 1028              	.L66:
 229:bert.c        **** }
 230:bert.c        **** else
 231:bert.c        **** {
 232:bert.c        **** return _bintreesearch(EV_root->EV_right, EV_target);
 1030 07b8 08301BE5 		ldr	r3, [fp, #-8]
 1031 07bc 083093E5 		ldr	r3, [r3, #8]
 1032 07c0 0C101BE5 		ldr	r1, [fp, #-12]
 1033 07c4 0300A0E1 		mov	r0, r3
 1034 07c8 FEFFFFEB 		bl	_bintreesearch
 1035 07cc 0030A0E1 		mov	r3, r0
 1036 07d0 000000EA 		b	.L65
 1037              	.L63:
 233:bert.c        **** }
 234:bert.c        **** }
 235:bert.c        **** return 0;
 1039 07d4 0030A0E3 		mov	r3, #0
 1040              	.L65:
 236:bert.c        **** }
 1042 07d8 0300A0E1 		mov	r0, r3
 1043 07dc 04D04BE2 		sub	sp, fp, #4
 1045              		@ sp needed
 1046 07e0 0088BDE8 		pop	{fp, pc}
 1047              	.L68:
 1048              		.align	2
 1049              	.L67:
 1050 07e4 00000000 		.word	.LC0
 1052              	.LFE21:
 1054              		.align	2
 1055              		.global	_buildTree
 1056              		.syntax unified
 1057              		.arm
 1058              		.fpu vfp
 1060              	_buildTree:
 1061              	.LFB22:
 237:bert.c        **** struct EV_tnode * _buildTree(struct EV_node * EV_list)
 238:bert.c        **** {
 1064              		@ args = 0, pretend = 0, frame = 16
 1065              		@ frame_needed = 1, uses_anonymous_args = 0
 1066 07e8 00482DE9 		push	{fp, lr}
 1070 07ec 04B08DE2 		add	fp, sp, #4
 1072 07f0 10D04DE2 		sub	sp, sp, #16
 1073 07f4 10000BE5 		str	r0, [fp, #-16]
 239:bert.c        **** int EV_i;
 240:bert.c        **** struct EV_tnode * EV_root;
 241:bert.c        **** EV_root = NULL;
 1075 07f8 0030A0E3 		mov	r3, #0
 1076 07fc 0C300BE5 		str	r3, [fp, #-12]
 242:bert.c        **** EV_i = 0;
 1078 0800 0030A0E3 		mov	r3, #0
 1079 0804 08300BE5 		str	r3, [fp, #-8]
 243:bert.c        **** while ((EV_i<_size(EV_list)))
 1081 0808 0A0000EA 		b	.L70
 1082              	.L71:
 244:bert.c        **** {
 245:bert.c        **** EV_root = _treeadd(EV_root, _get(EV_list, EV_i));
 1084 080c 08101BE5 		ldr	r1, [fp, #-8]
 1085 0810 10001BE5 		ldr	r0, [fp, #-16]
 1086 0814 FEFFFFEB 		bl	_get
 1087 0818 0030A0E1 		mov	r3, r0
 1088 081c 0310A0E1 		mov	r1, r3
 1089 0820 0C001BE5 		ldr	r0, [fp, #-12]
 1090 0824 FEFFFFEB 		bl	_treeadd
 1091 0828 0C000BE5 		str	r0, [fp, #-12]
 246:bert.c        **** EV_i = (EV_i+1);
 1093 082c 08301BE5 		ldr	r3, [fp, #-8]
 1094 0830 013083E2 		add	r3, r3, #1
 1095 0834 08300BE5 		str	r3, [fp, #-8]
 1096              	.L70:
 243:bert.c        **** while ((EV_i<_size(EV_list)))
 1098 0838 10001BE5 		ldr	r0, [fp, #-16]
 1099 083c FEFFFFEB 		bl	_size
 1100 0840 0020A0E1 		mov	r2, r0
 243:bert.c        **** while ((EV_i<_size(EV_list)))
 1102 0844 08301BE5 		ldr	r3, [fp, #-8]
 1103 0848 020053E1 		cmp	r3, r2
 1104 084c EEFFFFBA 		blt	.L71
 247:bert.c        **** }
 248:bert.c        **** return EV_root;
 1106 0850 0C301BE5 		ldr	r3, [fp, #-12]
 249:bert.c        **** }
 1108 0854 0300A0E1 		mov	r0, r3
 1109 0858 04D04BE2 		sub	sp, fp, #4
 1111              		@ sp needed
 1112 085c 0088BDE8 		pop	{fp, pc}
 1114              	.LFE22:
 1116              		.align	2
 1117              		.global	_treeMain
 1118              		.syntax unified
 1119              		.arm
 1120              		.fpu vfp
 1122              	_treeMain:
 1123              	.LFB23:
 250:bert.c        **** void _treeMain(struct EV_node * EV_list)
 251:bert.c        **** {
 1126              		@ args = 0, pretend = 0, frame = 24
 1127              		@ frame_needed = 1, uses_anonymous_args = 0
 1128 0860 00482DE9 		push	{fp, lr}
 1132 0864 04B08DE2 		add	fp, sp, #4
 1134 0868 18D04DE2 		sub	sp, sp, #24
 1135 086c 18000BE5 		str	r0, [fp, #-24]
 252:bert.c        **** struct EV_tnode * EV_root;
 253:bert.c        **** struct EV_node * EV_inList;
 254:bert.c        **** struct EV_node * EV_postList;
 255:bert.c        **** EV_root = _buildTree(EV_list);
 1137 0870 18001BE5 		ldr	r0, [fp, #-24]
 1138 0874 FEFFFFEB 		bl	_buildTree
 1139 0878 08000BE5 		str	r0, [fp, #-8]
 256:bert.c        **** _treeprint(EV_root);
 1141 087c 08001BE5 		ldr	r0, [fp, #-8]
 1142 0880 FEFFFFEB 		bl	_treeprint
 257:bert.c        **** printf("%d\n", (-999));
 1144 0884 98129FE5 		ldr	r1, .L74
 1145 0888 98029FE5 		ldr	r0, .L74+4
 1146 088c FEFFFFEB 		bl	printf
 258:bert.c        **** EV_inList = _inOrder(EV_root);
 1148 0890 08001BE5 		ldr	r0, [fp, #-8]
 1149 0894 FEFFFFEB 		bl	_inOrder
 1150 0898 0C000BE5 		str	r0, [fp, #-12]
 259:bert.c        **** _printList(EV_inList);
 1152 089c 0C001BE5 		ldr	r0, [fp, #-12]
 1153 08a0 FEFFFFEB 		bl	_printList
 260:bert.c        **** printf("%d\n", (-999));
 1155 08a4 78129FE5 		ldr	r1, .L74
 1156 08a8 78029FE5 		ldr	r0, .L74+4
 1157 08ac FEFFFFEB 		bl	printf
 261:bert.c        **** _freeList(EV_inList);
 1159 08b0 0C001BE5 		ldr	r0, [fp, #-12]
 1160 08b4 FEFFFFEB 		bl	_freeList
 262:bert.c        **** EV_postList = _postOrder(EV_root);
 1162 08b8 08001BE5 		ldr	r0, [fp, #-8]
 1163 08bc FEFFFFEB 		bl	_postOrder
 1164 08c0 10000BE5 		str	r0, [fp, #-16]
 263:bert.c        **** _printList(EV_postList);
 1166 08c4 10001BE5 		ldr	r0, [fp, #-16]
 1167 08c8 FEFFFFEB 		bl	_printList
 264:bert.c        **** printf("%d\n", (-999));
 1169 08cc 50129FE5 		ldr	r1, .L74
 1170 08d0 50029FE5 		ldr	r0, .L74+4
 1171 08d4 FEFFFFEB 		bl	printf
 265:bert.c        **** _freeList(EV_postList);
 1173 08d8 10001BE5 		ldr	r0, [fp, #-16]
 1174 08dc FEFFFFEB 		bl	_freeList
 266:bert.c        **** printf("%d\n", _treesearch(EV_root, 0));
 1176 08e0 0010A0E3 		mov	r1, #0
 1177 08e4 08001BE5 		ldr	r0, [fp, #-8]
 1178 08e8 FEFFFFEB 		bl	_treesearch
 1179 08ec 0030A0E1 		mov	r3, r0
 1180 08f0 0310A0E1 		mov	r1, r3
 1181 08f4 2C029FE5 		ldr	r0, .L74+4
 1182 08f8 FEFFFFEB 		bl	printf
 267:bert.c        **** printf("%d\n", (-999));
 1184 08fc 20129FE5 		ldr	r1, .L74
 1185 0900 20029FE5 		ldr	r0, .L74+4
 1186 0904 FEFFFFEB 		bl	printf
 268:bert.c        **** printf("%d\n", _treesearch(EV_root, 10));
 1188 0908 0A10A0E3 		mov	r1, #10
 1189 090c 08001BE5 		ldr	r0, [fp, #-8]
 1190 0910 FEFFFFEB 		bl	_treesearch
 1191 0914 0030A0E1 		mov	r3, r0
 1192 0918 0310A0E1 		mov	r1, r3
 1193 091c 04029FE5 		ldr	r0, .L74+4
 1194 0920 FEFFFFEB 		bl	printf
 269:bert.c        **** printf("%d\n", (-999));
 1196 0924 F8119FE5 		ldr	r1, .L74
 1197 0928 F8019FE5 		ldr	r0, .L74+4
 1198 092c FEFFFFEB 		bl	printf
 270:bert.c        **** printf("%d\n", _treesearch(EV_root, (-2)));
 1200 0930 0110E0E3 		mvn	r1, #1
 1201 0934 08001BE5 		ldr	r0, [fp, #-8]
 1202 0938 FEFFFFEB 		bl	_treesearch
 1203 093c 0030A0E1 		mov	r3, r0
 1204 0940 0310A0E1 		mov	r1, r3
 1205 0944 DC019FE5 		ldr	r0, .L74+4
 1206 0948 FEFFFFEB 		bl	printf
 271:bert.c        **** printf("%d\n", (-999));
 1208 094c D0119FE5 		ldr	r1, .L74
 1209 0950 D0019FE5 		ldr	r0, .L74+4
 1210 0954 FEFFFFEB 		bl	printf
 272:bert.c        **** printf("%d\n", _treesearch(EV_root, 2));
 1212 0958 0210A0E3 		mov	r1, #2
 1213 095c 08001BE5 		ldr	r0, [fp, #-8]
 1214 0960 FEFFFFEB 		bl	_treesearch
 1215 0964 0030A0E1 		mov	r3, r0
 1216 0968 0310A0E1 		mov	r1, r3
 1217 096c B4019FE5 		ldr	r0, .L74+4
 1218 0970 FEFFFFEB 		bl	printf
 273:bert.c        **** printf("%d\n", (-999));
 1220 0974 A8119FE5 		ldr	r1, .L74
 1221 0978 A8019FE5 		ldr	r0, .L74+4
 1222 097c FEFFFFEB 		bl	printf
 274:bert.c        **** printf("%d\n", _treesearch(EV_root, 3));
 1224 0980 0310A0E3 		mov	r1, #3
 1225 0984 08001BE5 		ldr	r0, [fp, #-8]
 1226 0988 FEFFFFEB 		bl	_treesearch
 1227 098c 0030A0E1 		mov	r3, r0
 1228 0990 0310A0E1 		mov	r1, r3
 1229 0994 8C019FE5 		ldr	r0, .L74+4
 1230 0998 FEFFFFEB 		bl	printf
 275:bert.c        **** printf("%d\n", (-999));
 1232 099c 80119FE5 		ldr	r1, .L74
 1233 09a0 80019FE5 		ldr	r0, .L74+4
 1234 09a4 FEFFFFEB 		bl	printf
 276:bert.c        **** printf("%d\n", _treesearch(EV_root, 9));
 1236 09a8 0910A0E3 		mov	r1, #9
 1237 09ac 08001BE5 		ldr	r0, [fp, #-8]
 1238 09b0 FEFFFFEB 		bl	_treesearch
 1239 09b4 0030A0E1 		mov	r3, r0
 1240 09b8 0310A0E1 		mov	r1, r3
 1241 09bc 64019FE5 		ldr	r0, .L74+4
 1242 09c0 FEFFFFEB 		bl	printf
 277:bert.c        **** printf("%d\n", (-999));
 1244 09c4 58119FE5 		ldr	r1, .L74
 1245 09c8 58019FE5 		ldr	r0, .L74+4
 1246 09cc FEFFFFEB 		bl	printf
 278:bert.c        **** printf("%d\n", _treesearch(EV_root, 1));
 1248 09d0 0110A0E3 		mov	r1, #1
 1249 09d4 08001BE5 		ldr	r0, [fp, #-8]
 1250 09d8 FEFFFFEB 		bl	_treesearch
 1251 09dc 0030A0E1 		mov	r3, r0
 1252 09e0 0310A0E1 		mov	r1, r3
 1253 09e4 3C019FE5 		ldr	r0, .L74+4
 1254 09e8 FEFFFFEB 		bl	printf
 279:bert.c        **** printf("%d\n", (-999));
 1256 09ec 30119FE5 		ldr	r1, .L74
 1257 09f0 30019FE5 		ldr	r0, .L74+4
 1258 09f4 FEFFFFEB 		bl	printf
 280:bert.c        **** printf("%d\n", _bintreesearch(EV_root, 0));
 1260 09f8 0010A0E3 		mov	r1, #0
 1261 09fc 08001BE5 		ldr	r0, [fp, #-8]
 1262 0a00 FEFFFFEB 		bl	_bintreesearch
 1263 0a04 0030A0E1 		mov	r3, r0
 1264 0a08 0310A0E1 		mov	r1, r3
 1265 0a0c 14019FE5 		ldr	r0, .L74+4
 1266 0a10 FEFFFFEB 		bl	printf
 281:bert.c        **** printf("%d\n", (-999));
 1268 0a14 08119FE5 		ldr	r1, .L74
 1269 0a18 08019FE5 		ldr	r0, .L74+4
 1270 0a1c FEFFFFEB 		bl	printf
 282:bert.c        **** printf("%d\n", _bintreesearch(EV_root, 10));
 1272 0a20 0A10A0E3 		mov	r1, #10
 1273 0a24 08001BE5 		ldr	r0, [fp, #-8]
 1274 0a28 FEFFFFEB 		bl	_bintreesearch
 1275 0a2c 0030A0E1 		mov	r3, r0
 1276 0a30 0310A0E1 		mov	r1, r3
 1277 0a34 EC009FE5 		ldr	r0, .L74+4
 1278 0a38 FEFFFFEB 		bl	printf
 283:bert.c        **** printf("%d\n", (-999));
 1280 0a3c E0109FE5 		ldr	r1, .L74
 1281 0a40 E0009FE5 		ldr	r0, .L74+4
 1282 0a44 FEFFFFEB 		bl	printf
 284:bert.c        **** printf("%d\n", _bintreesearch(EV_root, (-2)));
 1284 0a48 0110E0E3 		mvn	r1, #1
 1285 0a4c 08001BE5 		ldr	r0, [fp, #-8]
 1286 0a50 FEFFFFEB 		bl	_bintreesearch
 1287 0a54 0030A0E1 		mov	r3, r0
 1288 0a58 0310A0E1 		mov	r1, r3
 1289 0a5c C4009FE5 		ldr	r0, .L74+4
 1290 0a60 FEFFFFEB 		bl	printf
 285:bert.c        **** printf("%d\n", (-999));
 1292 0a64 B8109FE5 		ldr	r1, .L74
 1293 0a68 B8009FE5 		ldr	r0, .L74+4
 1294 0a6c FEFFFFEB 		bl	printf
 286:bert.c        **** printf("%d\n", _bintreesearch(EV_root, 2));
 1296 0a70 0210A0E3 		mov	r1, #2
 1297 0a74 08001BE5 		ldr	r0, [fp, #-8]
 1298 0a78 FEFFFFEB 		bl	_bintreesearch
 1299 0a7c 0030A0E1 		mov	r3, r0
 1300 0a80 0310A0E1 		mov	r1, r3
 1301 0a84 9C009FE5 		ldr	r0, .L74+4
 1302 0a88 FEFFFFEB 		bl	printf
 287:bert.c        **** printf("%d\n", (-999));
 1304 0a8c 90109FE5 		ldr	r1, .L74
 1305 0a90 90009FE5 		ldr	r0, .L74+4
 1306 0a94 FEFFFFEB 		bl	printf
 288:bert.c        **** printf("%d\n", _bintreesearch(EV_root, 3));
 1308 0a98 0310A0E3 		mov	r1, #3
 1309 0a9c 08001BE5 		ldr	r0, [fp, #-8]
 1310 0aa0 FEFFFFEB 		bl	_bintreesearch
 1311 0aa4 0030A0E1 		mov	r3, r0
 1312 0aa8 0310A0E1 		mov	r1, r3
 1313 0aac 74009FE5 		ldr	r0, .L74+4
 1314 0ab0 FEFFFFEB 		bl	printf
 289:bert.c        **** printf("%d\n", (-999));
 1316 0ab4 68109FE5 		ldr	r1, .L74
 1317 0ab8 68009FE5 		ldr	r0, .L74+4
 1318 0abc FEFFFFEB 		bl	printf
 290:bert.c        **** printf("%d\n", _bintreesearch(EV_root, 9));
 1320 0ac0 0910A0E3 		mov	r1, #9
 1321 0ac4 08001BE5 		ldr	r0, [fp, #-8]
 1322 0ac8 FEFFFFEB 		bl	_bintreesearch
 1323 0acc 0030A0E1 		mov	r3, r0
 1324 0ad0 0310A0E1 		mov	r1, r3
 1325 0ad4 4C009FE5 		ldr	r0, .L74+4
 1326 0ad8 FEFFFFEB 		bl	printf
 291:bert.c        **** printf("%d\n", (-999));
 1328 0adc 40109FE5 		ldr	r1, .L74
 1329 0ae0 40009FE5 		ldr	r0, .L74+4
 1330 0ae4 FEFFFFEB 		bl	printf
 292:bert.c        **** printf("%d\n", _bintreesearch(EV_root, 1));
 1332 0ae8 0110A0E3 		mov	r1, #1
 1333 0aec 08001BE5 		ldr	r0, [fp, #-8]
 1334 0af0 FEFFFFEB 		bl	_bintreesearch
 1335 0af4 0030A0E1 		mov	r3, r0
 1336 0af8 0310A0E1 		mov	r1, r3
 1337 0afc 24009FE5 		ldr	r0, .L74+4
 1338 0b00 FEFFFFEB 		bl	printf
 293:bert.c        **** printf("%d\n", (-999));
 1340 0b04 18109FE5 		ldr	r1, .L74
 1341 0b08 18009FE5 		ldr	r0, .L74+4
 1342 0b0c FEFFFFEB 		bl	printf
 294:bert.c        **** _freeTree(EV_root);
 1344 0b10 08001BE5 		ldr	r0, [fp, #-8]
 1345 0b14 FEFFFFEB 		bl	_freeTree
 295:bert.c        **** }
 1347 0b18 0000A0E1 		nop
 1348 0b1c 04D04BE2 		sub	sp, fp, #4
 1350              		@ sp needed
 1351 0b20 0088BDE8 		pop	{fp, pc}
 1352              	.L75:
 1353              		.align	2
 1354              	.L74:
 1355 0b24 19FCFFFF 		.word	-999
 1356 0b28 00000000 		.word	.LC0
 1358              	.LFE23:
 1360              		.align	2
 1361              		.global	_myCopy
 1362              		.syntax unified
 1363              		.arm
 1364              		.fpu vfp
 1366              	_myCopy:
 1367              	.LFB24:
 296:bert.c        **** struct EV_node * _myCopy(struct EV_node * EV_src)
 297:bert.c        **** {
 1370              		@ args = 0, pretend = 0, frame = 8
 1371              		@ frame_needed = 1, uses_anonymous_args = 0
 1372 0b2c 10482DE9 		push	{r4, fp, lr}
 1377 0b30 08B08DE2 		add	fp, sp, #8
 1379 0b34 0CD04DE2 		sub	sp, sp, #12
 1380 0b38 10000BE5 		str	r0, [fp, #-16]
 298:bert.c        **** if ((EV_src==NULL))
 1382 0b3c 10301BE5 		ldr	r3, [fp, #-16]
 1383 0b40 000053E3 		cmp	r3, #0
 1384 0b44 0100001A 		bne	.L77
 299:bert.c        **** {
 300:bert.c        **** return NULL;
 1386 0b48 0030A0E3 		mov	r3, #0
 1387 0b4c 0E0000EA 		b	.L78
 1388              	.L77:
 301:bert.c        **** }
 302:bert.c        **** return _concatLists(_add(NULL, EV_src->EV_data), _myCopy(EV_src->EV_next));
 1390 0b50 10301BE5 		ldr	r3, [fp, #-16]
 1391 0b54 003093E5 		ldr	r3, [r3]
 1392 0b58 0310A0E1 		mov	r1, r3
 1393 0b5c 0000A0E3 		mov	r0, #0
 1394 0b60 FEFFFFEB 		bl	_add
 1395 0b64 0040A0E1 		mov	r4, r0
 1396 0b68 10301BE5 		ldr	r3, [fp, #-16]
 1397 0b6c 043093E5 		ldr	r3, [r3, #4]
 1398 0b70 0300A0E1 		mov	r0, r3
 1399 0b74 FEFFFFEB 		bl	_myCopy
 1400 0b78 0030A0E1 		mov	r3, r0
 1401 0b7c 0310A0E1 		mov	r1, r3
 1402 0b80 0400A0E1 		mov	r0, r4
 1403 0b84 FEFFFFEB 		bl	_concatLists
 1404 0b88 0030A0E1 		mov	r3, r0
 1405              	.L78:
 303:bert.c        **** }
 1407 0b8c 0300A0E1 		mov	r0, r3
 1408 0b90 08D04BE2 		sub	sp, fp, #8
 1410              		@ sp needed
 1411 0b94 1088BDE8 		pop	{r4, fp, pc}
 1413              	.LFE24:
 1415              		.section	.rodata
 1416              		.align	2
 1417              	.LC1:
 1418 0004 256400   		.ascii	"%d\000"
 1419              		.text
 1420              		.align	2
 1421              		.global	_main
 1422              		.syntax unified
 1423              		.arm
 1424              		.fpu vfp
 1426              	_main:
 1427              	.LFB25:
 304:bert.c        **** int _main()
 305:bert.c        **** {
 1430              		@ args = 0, pretend = 0, frame = 24
 1431              		@ frame_needed = 1, uses_anonymous_args = 0
 1432 0b98 00482DE9 		push	{fp, lr}
 1436 0b9c 04B08DE2 		add	fp, sp, #4
 1438 0ba0 18D04DE2 		sub	sp, sp, #24
 306:bert.c        **** int EV_i;
 307:bert.c        **** int EV_element;
 308:bert.c        **** struct EV_node * EV_myList;
 309:bert.c        **** struct EV_node * EV_copyList1;
 310:bert.c        **** struct EV_node * EV_copyList2;
 311:bert.c        **** struct EV_node * EV_sortedList;
 312:bert.c        **** EV_myList = NULL;
 1440 0ba4 0030A0E3 		mov	r3, #0
 1441 0ba8 0C300BE5 		str	r3, [fp, #-12]
 313:bert.c        **** EV_copyList1 = NULL;
 1443 0bac 0030A0E3 		mov	r3, #0
 1444 0bb0 10300BE5 		str	r3, [fp, #-16]
 314:bert.c        **** EV_copyList2 = NULL;
 1446 0bb4 0030A0E3 		mov	r3, #0
 1447 0bb8 14300BE5 		str	r3, [fp, #-20]
 315:bert.c        **** EV_i = 0;
 1449 0bbc 0030A0E3 		mov	r3, #0
 1450 0bc0 08300BE5 		str	r3, [fp, #-8]
 316:bert.c        **** while ((EV_i<10))
 1452 0bc4 180000EA 		b	.L80
 1453              	.L81:
 317:bert.c        **** {
 318:bert.c        **** scanf("%d", &EV_element);
 1455 0bc8 1C304BE2 		sub	r3, fp, #28
 1456 0bcc 0310A0E1 		mov	r1, r3
 1457 0bd0 88009FE5 		ldr	r0, .L83
 1458 0bd4 FEFFFFEB 		bl	__isoc99_scanf
 319:bert.c        **** EV_myList = _add(EV_myList, EV_element);
 1460 0bd8 1C301BE5 		ldr	r3, [fp, #-28]
 1461 0bdc 0310A0E1 		mov	r1, r3
 1462 0be0 0C001BE5 		ldr	r0, [fp, #-12]
 1463 0be4 FEFFFFEB 		bl	_add
 1464 0be8 0C000BE5 		str	r0, [fp, #-12]
 320:bert.c        **** EV_copyList1 = _myCopy(EV_myList);
 1466 0bec 0C001BE5 		ldr	r0, [fp, #-12]
 1467 0bf0 FEFFFFEB 		bl	_myCopy
 1468 0bf4 10000BE5 		str	r0, [fp, #-16]
 321:bert.c        **** EV_copyList2 = _myCopy(EV_myList);
 1470 0bf8 0C001BE5 		ldr	r0, [fp, #-12]
 1471 0bfc FEFFFFEB 		bl	_myCopy
 1472 0c00 14000BE5 		str	r0, [fp, #-20]
 322:bert.c        **** EV_sortedList = _quickSortMain(EV_copyList1);
 1474 0c04 10001BE5 		ldr	r0, [fp, #-16]
 1475 0c08 FEFFFFEB 		bl	_quickSortMain
 1476 0c0c 18000BE5 		str	r0, [fp, #-24]
 323:bert.c        **** _freeList(EV_sortedList);
 1478 0c10 18001BE5 		ldr	r0, [fp, #-24]
 1479 0c14 FEFFFFEB 		bl	_freeList
 324:bert.c        **** _treeMain(EV_copyList2);
 1481 0c18 14001BE5 		ldr	r0, [fp, #-20]
 1482 0c1c FEFFFFEB 		bl	_treeMain
 325:bert.c        **** EV_i = (EV_i+1);
 1484 0c20 08301BE5 		ldr	r3, [fp, #-8]
 1485 0c24 013083E2 		add	r3, r3, #1
 1486 0c28 08300BE5 		str	r3, [fp, #-8]
 1487              	.L80:
 316:bert.c        **** {
 1489 0c2c 08301BE5 		ldr	r3, [fp, #-8]
 1490 0c30 090053E3 		cmp	r3, #9
 1491 0c34 E3FFFFDA 		ble	.L81
 326:bert.c        **** }
 327:bert.c        **** _freeList(EV_myList);
 1493 0c38 0C001BE5 		ldr	r0, [fp, #-12]
 1494 0c3c FEFFFFEB 		bl	_freeList
 328:bert.c        **** _freeList(EV_copyList1);
 1496 0c40 10001BE5 		ldr	r0, [fp, #-16]
 1497 0c44 FEFFFFEB 		bl	_freeList
 329:bert.c        **** _freeList(EV_copyList2);
 1499 0c48 14001BE5 		ldr	r0, [fp, #-20]
 1500 0c4c FEFFFFEB 		bl	_freeList
 330:bert.c        **** return 0;
 1502 0c50 0030A0E3 		mov	r3, #0
 331:bert.c        **** }
 1504 0c54 0300A0E1 		mov	r0, r3
 1505 0c58 04D04BE2 		sub	sp, fp, #4
 1507              		@ sp needed
 1508 0c5c 0088BDE8 		pop	{fp, pc}
 1509              	.L84:
 1510              		.align	2
 1511              	.L83:
 1512 0c60 04000000 		.word	.LC1
 1514              	.LFE25:
 1516              		.align	2
 1517              		.global	main
 1518              		.syntax unified
 1519              		.arm
 1520              		.fpu vfp
 1522              	main:
 1523              	.LFB26:
 332:bert.c        **** int main(void)
 333:bert.c        **** {
 1526              		@ args = 0, pretend = 0, frame = 0
 1527              		@ frame_needed = 1, uses_anonymous_args = 0
 1528 0c64 00482DE9 		push	{fp, lr}
 1532 0c68 04B08DE2 		add	fp, sp, #4
 334:bert.c        ****    return _main();
 1535 0c6c FEFFFFEB 		bl	_main
 1536 0c70 0030A0E1 		mov	r3, r0
 335:bert.c        **** }
 1538 0c74 0300A0E1 		mov	r0, r3
 1539 0c78 0088BDE8 		pop	{fp, pc}
 1541              	.LFE26:
 1543              	.Letext0:
