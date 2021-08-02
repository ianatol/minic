   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.comm	EV_swapped,4,4
  17              		.align	2
  18              		.global	_compare
  19              		.arch armv6
  20              		.syntax unified
  21              		.arm
  22              		.fpu vfp
  24              	_compare:
  25              	.LFB6:
   1:killerBubbles.c **** #include<stdio.h>
   2:killerBubbles.c **** #include<stdlib.h>
   3:killerBubbles.c **** struct EV_Node
   4:killerBubbles.c **** {
   5:killerBubbles.c **** int EV_val;
   6:killerBubbles.c **** struct EV_Node * EV_prev;
   7:killerBubbles.c **** struct EV_Node * EV_next;
   8:killerBubbles.c **** };
   9:killerBubbles.c **** int EV_swapped;
  10:killerBubbles.c **** int _compare(struct EV_Node * EV_a,struct EV_Node * EV_b)
  11:killerBubbles.c **** {
  29              		@ args = 0, pretend = 0, frame = 8
  30              		@ frame_needed = 1, uses_anonymous_args = 0
  31              		@ link register save eliminated.
  32 0000 04B02DE5 		str	fp, [sp, #-4]!
  35 0004 00B08DE2 		add	fp, sp, #0
  37 0008 0CD04DE2 		sub	sp, sp, #12
  38 000c 08000BE5 		str	r0, [fp, #-8]
  39 0010 0C100BE5 		str	r1, [fp, #-12]
  12:killerBubbles.c **** return (EV_a->EV_val-EV_b->EV_val);
  41 0014 08301BE5 		ldr	r3, [fp, #-8]
  42 0018 002093E5 		ldr	r2, [r3]
  44 001c 0C301BE5 		ldr	r3, [fp, #-12]
  45 0020 003093E5 		ldr	r3, [r3]
  47 0024 033042E0 		sub	r3, r2, r3
  13:killerBubbles.c **** }
  49 0028 0300A0E1 		mov	r0, r3
  50 002c 00D08BE2 		add	sp, fp, #0
  52              		@ sp needed
  53 0030 04B09DE4 		ldr	fp, [sp], #4
  56 0034 1EFF2FE1 		bx	lr
  58              	.LFE6:
  60              		.align	2
  61              		.global	_deathSort
  62              		.syntax unified
  63              		.arm
  64              		.fpu vfp
  66              	_deathSort:
  67              	.LFB7:
  14:killerBubbles.c **** void _deathSort(struct EV_Node * EV_head)
  15:killerBubbles.c **** {
  70              		@ args = 0, pretend = 0, frame = 24
  71              		@ frame_needed = 1, uses_anonymous_args = 0
  72 0038 00482DE9 		push	{fp, lr}
  76 003c 04B08DE2 		add	fp, sp, #4
  78 0040 18D04DE2 		sub	sp, sp, #24
  79 0044 18000BE5 		str	r0, [fp, #-24]
  16:killerBubbles.c **** int EV_swapped;
  17:killerBubbles.c **** int EV_swap;
  18:killerBubbles.c **** struct EV_Node * EV_currNode;
  19:killerBubbles.c **** EV_swapped = 1;
  81 0048 0130A0E3 		mov	r3, #1
  82 004c 08300BE5 		str	r3, [fp, #-8]
  20:killerBubbles.c **** while ((EV_swapped==1))
  84 0050 220000EA 		b	.L4
  85              	.L8:
  21:killerBubbles.c **** {
  22:killerBubbles.c **** EV_swapped = 0;
  87 0054 0030A0E3 		mov	r3, #0
  88 0058 08300BE5 		str	r3, [fp, #-8]
  23:killerBubbles.c **** EV_currNode = EV_head;
  90 005c 18301BE5 		ldr	r3, [fp, #-24]
  91 0060 0C300BE5 		str	r3, [fp, #-12]
  24:killerBubbles.c **** while ((EV_currNode->EV_next!=EV_head))
  93 0064 180000EA 		b	.L5
  94              	.L7:
  25:killerBubbles.c **** {
  26:killerBubbles.c **** if ((_compare(EV_currNode, EV_currNode->EV_next)>0))
  96 0068 0C301BE5 		ldr	r3, [fp, #-12]
  97 006c 083093E5 		ldr	r3, [r3, #8]
  98 0070 0310A0E1 		mov	r1, r3
  99 0074 0C001BE5 		ldr	r0, [fp, #-12]
 100 0078 FEFFFFEB 		bl	_compare
 101 007c 0030A0E1 		mov	r3, r0
 103 0080 000053E3 		cmp	r3, #0
 104 0084 0D0000DA 		ble	.L6
  27:killerBubbles.c **** {
  28:killerBubbles.c **** EV_swap = EV_currNode->EV_val;
 106 0088 0C301BE5 		ldr	r3, [fp, #-12]
 107 008c 003093E5 		ldr	r3, [r3]
 108 0090 10300BE5 		str	r3, [fp, #-16]
  29:killerBubbles.c **** EV_currNode->EV_val = EV_currNode->EV_next->EV_val;
 110 0094 0C301BE5 		ldr	r3, [fp, #-12]
 111 0098 083093E5 		ldr	r3, [r3, #8]
 113 009c 002093E5 		ldr	r2, [r3]
 115 00a0 0C301BE5 		ldr	r3, [fp, #-12]
 116 00a4 002083E5 		str	r2, [r3]
  30:killerBubbles.c **** EV_currNode->EV_next->EV_val = EV_swap;
 118 00a8 0C301BE5 		ldr	r3, [fp, #-12]
 119 00ac 083093E5 		ldr	r3, [r3, #8]
 121 00b0 10201BE5 		ldr	r2, [fp, #-16]
 122 00b4 002083E5 		str	r2, [r3]
  31:killerBubbles.c **** EV_swapped = 1;
 124 00b8 0130A0E3 		mov	r3, #1
 125 00bc 08300BE5 		str	r3, [fp, #-8]
 126              	.L6:
  32:killerBubbles.c **** }
  33:killerBubbles.c **** EV_currNode = EV_currNode->EV_next;
 128 00c0 0C301BE5 		ldr	r3, [fp, #-12]
 129 00c4 083093E5 		ldr	r3, [r3, #8]
 130 00c8 0C300BE5 		str	r3, [fp, #-12]
 131              	.L5:
  24:killerBubbles.c **** {
 133 00cc 0C301BE5 		ldr	r3, [fp, #-12]
 134 00d0 083093E5 		ldr	r3, [r3, #8]
  24:killerBubbles.c **** {
 136 00d4 18201BE5 		ldr	r2, [fp, #-24]
 137 00d8 030052E1 		cmp	r2, r3
 138 00dc E1FFFF1A 		bne	.L7
 139              	.L4:
  20:killerBubbles.c **** {
 141 00e0 08301BE5 		ldr	r3, [fp, #-8]
 142 00e4 010053E3 		cmp	r3, #1
 143 00e8 D9FFFF0A 		beq	.L8
  34:killerBubbles.c **** }
  35:killerBubbles.c **** }
  36:killerBubbles.c **** }
 145 00ec 0000A0E1 		nop
 146 00f0 04D04BE2 		sub	sp, fp, #4
 148              		@ sp needed
 149 00f4 0088BDE8 		pop	{fp, pc}
 151              	.LFE7:
 153              		.section	.rodata
 154              		.align	2
 155              	.LC0:
 156 0000 25640A00 		.ascii	"%d\012\000"
 157              		.text
 158              		.align	2
 159              		.global	_printEVILList
 160              		.syntax unified
 161              		.arm
 162              		.fpu vfp
 164              	_printEVILList:
 165              	.LFB8:
  37:killerBubbles.c **** void _printEVILList(struct EV_Node * EV_head)
  38:killerBubbles.c **** {
 168              		@ args = 0, pretend = 0, frame = 16
 169              		@ frame_needed = 1, uses_anonymous_args = 0
 170 00f8 00482DE9 		push	{fp, lr}
 174 00fc 04B08DE2 		add	fp, sp, #4
 176 0100 10D04DE2 		sub	sp, sp, #16
 177 0104 10000BE5 		str	r0, [fp, #-16]
  39:killerBubbles.c **** struct EV_Node * EV_currNode;
  40:killerBubbles.c **** struct EV_Node * EV_toFree;
  41:killerBubbles.c **** EV_currNode = EV_head->EV_next;
 179 0108 10301BE5 		ldr	r3, [fp, #-16]
 180 010c 083093E5 		ldr	r3, [r3, #8]
 181 0110 08300BE5 		str	r3, [fp, #-8]
  42:killerBubbles.c **** printf("%d\n", EV_head->EV_val);
 183 0114 10301BE5 		ldr	r3, [fp, #-16]
 184 0118 003093E5 		ldr	r3, [r3]
 185 011c 0310A0E1 		mov	r1, r3
 186 0120 58009FE5 		ldr	r0, .L12
 187 0124 FEFFFFEB 		bl	printf
  43:killerBubbles.c **** free(EV_head);
 189 0128 10001BE5 		ldr	r0, [fp, #-16]
 190 012c FEFFFFEB 		bl	free
  44:killerBubbles.c **** while ((EV_currNode!=EV_head))
 192 0130 0B0000EA 		b	.L10
 193              	.L11:
  45:killerBubbles.c **** {
  46:killerBubbles.c **** EV_toFree = EV_currNode;
 195 0134 08301BE5 		ldr	r3, [fp, #-8]
 196 0138 0C300BE5 		str	r3, [fp, #-12]
  47:killerBubbles.c **** printf("%d\n", EV_currNode->EV_val);
 198 013c 08301BE5 		ldr	r3, [fp, #-8]
 199 0140 003093E5 		ldr	r3, [r3]
 200 0144 0310A0E1 		mov	r1, r3
 201 0148 30009FE5 		ldr	r0, .L12
 202 014c FEFFFFEB 		bl	printf
  48:killerBubbles.c **** EV_currNode = EV_currNode->EV_next;
 204 0150 08301BE5 		ldr	r3, [fp, #-8]
 205 0154 083093E5 		ldr	r3, [r3, #8]
 206 0158 08300BE5 		str	r3, [fp, #-8]
  49:killerBubbles.c **** free(EV_toFree);
 208 015c 0C001BE5 		ldr	r0, [fp, #-12]
 209 0160 FEFFFFEB 		bl	free
 210              	.L10:
  44:killerBubbles.c **** {
 212 0164 08201BE5 		ldr	r2, [fp, #-8]
 213 0168 10301BE5 		ldr	r3, [fp, #-16]
 214 016c 030052E1 		cmp	r2, r3
 215 0170 EFFFFF1A 		bne	.L11
  50:killerBubbles.c **** }
  51:killerBubbles.c **** }
 217 0174 0000A0E1 		nop
 218 0178 04D04BE2 		sub	sp, fp, #4
 220              		@ sp needed
 221 017c 0088BDE8 		pop	{fp, pc}
 222              	.L13:
 223              		.align	2
 224              	.L12:
 225 0180 00000000 		.word	.LC0
 227              	.LFE8:
 229              		.section	.rodata
 230              		.align	2
 231              	.LC1:
 232 0004 256400   		.ascii	"%d\000"
 233              		.text
 234              		.align	2
 235              		.global	_main
 236              		.syntax unified
 237              		.arm
 238              		.fpu vfp
 240              	_main:
 241              	.LFB9:
  52:killerBubbles.c **** int _main()
  53:killerBubbles.c **** {
 244              		@ args = 0, pretend = 0, frame = 24
 245              		@ frame_needed = 1, uses_anonymous_args = 0
 246 0184 00482DE9 		push	{fp, lr}
 250 0188 04B08DE2 		add	fp, sp, #4
 252 018c 18D04DE2 		sub	sp, sp, #24
  54:killerBubbles.c **** int EV_numNodes;
  55:killerBubbles.c **** int EV_counter;
  56:killerBubbles.c **** struct EV_Node * EV_currNode;
  57:killerBubbles.c **** struct EV_Node * EV_head;
  58:killerBubbles.c **** struct EV_Node * EV_previous;
  59:killerBubbles.c **** EV_swapped = 666;
 254 0190 28319FE5 		ldr	r3, .L20
 255 0194 28219FE5 		ldr	r2, .L20+4
 256 0198 002083E5 		str	r2, [r3]
  60:killerBubbles.c **** scanf("%d", &EV_numNodes);
 258 019c 18304BE2 		sub	r3, fp, #24
 259 01a0 0310A0E1 		mov	r1, r3
 260 01a4 1C019FE5 		ldr	r0, .L20+8
 261 01a8 FEFFFFEB 		bl	__isoc99_scanf
  61:killerBubbles.c **** if ((EV_numNodes<=0))
 263 01ac 18301BE5 		ldr	r3, [fp, #-24]
 265 01b0 000053E3 		cmp	r3, #0
 266 01b4 040000CA 		bgt	.L15
  62:killerBubbles.c **** {
  63:killerBubbles.c **** printf("%d\n", (-1));
 268 01b8 0010E0E3 		mvn	r1, #0
 269 01bc 08019FE5 		ldr	r0, .L20+12
 270 01c0 FEFFFFEB 		bl	printf
  64:killerBubbles.c **** return (-1);
 272 01c4 0030E0E3 		mvn	r3, #0
 273 01c8 390000EA 		b	.L19
 274              	.L15:
  65:killerBubbles.c **** }
  66:killerBubbles.c **** EV_numNodes = (EV_numNodes*1000);
 276 01cc 18201BE5 		ldr	r2, [fp, #-24]
 277 01d0 0230A0E1 		mov	r3, r2
 278 01d4 8332A0E1 		lsl	r3, r3, #5
 279 01d8 023043E0 		sub	r3, r3, r2
 280 01dc 0331A0E1 		lsl	r3, r3, #2
 281 01e0 023083E0 		add	r3, r3, r2
 282 01e4 8331A0E1 		lsl	r3, r3, #3
 284 01e8 18300BE5 		str	r3, [fp, #-24]
  67:killerBubbles.c **** EV_counter = EV_numNodes;
 286 01ec 18301BE5 		ldr	r3, [fp, #-24]
 287 01f0 08300BE5 		str	r3, [fp, #-8]
  68:killerBubbles.c **** EV_head = (struct EV_Node*)malloc(sizeof(struct EV_Node));
 289 01f4 0C00A0E3 		mov	r0, #12
 290 01f8 FEFFFFEB 		bl	malloc
 291 01fc 0030A0E1 		mov	r3, r0
 292 0200 10300BE5 		str	r3, [fp, #-16]
  69:killerBubbles.c **** EV_head->EV_val = EV_counter;
 294 0204 10301BE5 		ldr	r3, [fp, #-16]
 295 0208 08201BE5 		ldr	r2, [fp, #-8]
 296 020c 002083E5 		str	r2, [r3]
  70:killerBubbles.c **** EV_head->EV_prev = EV_head;
 298 0210 10301BE5 		ldr	r3, [fp, #-16]
 299 0214 10201BE5 		ldr	r2, [fp, #-16]
 300 0218 042083E5 		str	r2, [r3, #4]
  71:killerBubbles.c **** EV_head->EV_next = EV_head;
 302 021c 10301BE5 		ldr	r3, [fp, #-16]
 303 0220 10201BE5 		ldr	r2, [fp, #-16]
 304 0224 082083E5 		str	r2, [r3, #8]
  72:killerBubbles.c **** EV_counter = (EV_counter-1);
 306 0228 08301BE5 		ldr	r3, [fp, #-8]
 307 022c 013043E2 		sub	r3, r3, #1
 308 0230 08300BE5 		str	r3, [fp, #-8]
  73:killerBubbles.c **** EV_previous = EV_head;
 310 0234 10301BE5 		ldr	r3, [fp, #-16]
 311 0238 0C300BE5 		str	r3, [fp, #-12]
  74:killerBubbles.c **** while ((EV_counter>0))
 313 023c 140000EA 		b	.L17
 314              	.L18:
  75:killerBubbles.c **** {
  76:killerBubbles.c **** EV_currNode = (struct EV_Node*)malloc(sizeof(struct EV_Node));
 316 0240 0C00A0E3 		mov	r0, #12
 317 0244 FEFFFFEB 		bl	malloc
 318 0248 0030A0E1 		mov	r3, r0
 319 024c 14300BE5 		str	r3, [fp, #-20]
  77:killerBubbles.c **** EV_currNode->EV_val = EV_counter;
 321 0250 14301BE5 		ldr	r3, [fp, #-20]
 322 0254 08201BE5 		ldr	r2, [fp, #-8]
 323 0258 002083E5 		str	r2, [r3]
  78:killerBubbles.c **** EV_currNode->EV_prev = EV_previous;
 325 025c 14301BE5 		ldr	r3, [fp, #-20]
 326 0260 0C201BE5 		ldr	r2, [fp, #-12]
 327 0264 042083E5 		str	r2, [r3, #4]
  79:killerBubbles.c **** EV_currNode->EV_next = EV_head;
 329 0268 14301BE5 		ldr	r3, [fp, #-20]
 330 026c 10201BE5 		ldr	r2, [fp, #-16]
 331 0270 082083E5 		str	r2, [r3, #8]
  80:killerBubbles.c **** EV_previous->EV_next = EV_currNode;
 333 0274 0C301BE5 		ldr	r3, [fp, #-12]
 334 0278 14201BE5 		ldr	r2, [fp, #-20]
 335 027c 082083E5 		str	r2, [r3, #8]
  81:killerBubbles.c **** EV_previous = EV_currNode;
 337 0280 14301BE5 		ldr	r3, [fp, #-20]
 338 0284 0C300BE5 		str	r3, [fp, #-12]
  82:killerBubbles.c **** EV_counter = (EV_counter-1);
 340 0288 08301BE5 		ldr	r3, [fp, #-8]
 341 028c 013043E2 		sub	r3, r3, #1
 342 0290 08300BE5 		str	r3, [fp, #-8]
 343              	.L17:
  74:killerBubbles.c **** {
 345 0294 08301BE5 		ldr	r3, [fp, #-8]
 346 0298 000053E3 		cmp	r3, #0
 347 029c E7FFFFCA 		bgt	.L18
  83:killerBubbles.c **** }
  84:killerBubbles.c **** _deathSort(EV_head);
 349 02a0 10001BE5 		ldr	r0, [fp, #-16]
 350 02a4 FEFFFFEB 		bl	_deathSort
  85:killerBubbles.c **** _printEVILList(EV_head);
 352 02a8 10001BE5 		ldr	r0, [fp, #-16]
 353 02ac FEFFFFEB 		bl	_printEVILList
  86:killerBubbles.c **** return 0;
 355 02b0 0030A0E3 		mov	r3, #0
 356              	.L19:
  87:killerBubbles.c **** }
 358 02b4 0300A0E1 		mov	r0, r3
 359 02b8 04D04BE2 		sub	sp, fp, #4
 361              		@ sp needed
 362 02bc 0088BDE8 		pop	{fp, pc}
 363              	.L21:
 364              		.align	2
 365              	.L20:
 366 02c0 00000000 		.word	EV_swapped
 367 02c4 9A020000 		.word	666
 368 02c8 04000000 		.word	.LC1
 369 02cc 00000000 		.word	.LC0
 371              	.LFE9:
 373              		.align	2
 374              		.global	main
 375              		.syntax unified
 376              		.arm
 377              		.fpu vfp
 379              	main:
 380              	.LFB10:
  88:killerBubbles.c **** int main(void)
  89:killerBubbles.c **** {
 383              		@ args = 0, pretend = 0, frame = 0
 384              		@ frame_needed = 1, uses_anonymous_args = 0
 385 02d0 00482DE9 		push	{fp, lr}
 389 02d4 04B08DE2 		add	fp, sp, #4
  90:killerBubbles.c ****    return _main();
 392 02d8 FEFFFFEB 		bl	_main
 393 02dc 0030A0E1 		mov	r3, r0
  91:killerBubbles.c **** }
 395 02e0 0300A0E1 		mov	r0, r3
 396 02e4 0088BDE8 		pop	{fp, pc}
 398              	.LFE10:
 400              	.Letext0:
