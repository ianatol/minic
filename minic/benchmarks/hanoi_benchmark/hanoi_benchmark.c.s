   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.comm	EV_peg1,4,4
  17              		.comm	EV_peg2,4,4
  18              		.comm	EV_peg3,4,4
  19              		.comm	EV_numMoves,4,4
  20              		.align	2
  21              		.global	_move
  22              		.arch armv6
  23              		.syntax unified
  24              		.arm
  25              		.fpu vfp
  27              	_move:
  28              	.LFB6:
   1:hanoi_benchmark.c **** #include<stdio.h>
   2:hanoi_benchmark.c **** #include<stdlib.h>
   3:hanoi_benchmark.c **** struct EV_plate
   4:hanoi_benchmark.c **** {
   5:hanoi_benchmark.c **** int EV_size;
   6:hanoi_benchmark.c **** struct EV_plate * EV_plateUnder;
   7:hanoi_benchmark.c **** };
   8:hanoi_benchmark.c **** struct EV_plate * EV_peg1;
   9:hanoi_benchmark.c **** struct EV_plate * EV_peg2;
  10:hanoi_benchmark.c **** struct EV_plate * EV_peg3;
  11:hanoi_benchmark.c **** int EV_numMoves;
  12:hanoi_benchmark.c **** void _move(int EV_from,int EV_to)
  13:hanoi_benchmark.c **** {
  32              		@ args = 0, pretend = 0, frame = 16
  33              		@ frame_needed = 1, uses_anonymous_args = 0
  34              		@ link register save eliminated.
  35 0000 04B02DE5 		str	fp, [sp, #-4]!
  38 0004 00B08DE2 		add	fp, sp, #0
  40 0008 14D04DE2 		sub	sp, sp, #20
  41 000c 10000BE5 		str	r0, [fp, #-16]
  42 0010 14100BE5 		str	r1, [fp, #-20]
  14:hanoi_benchmark.c **** struct EV_plate * EV_plateToMove;
  15:hanoi_benchmark.c **** if ((EV_from==1))
  44 0014 10301BE5 		ldr	r3, [fp, #-16]
  45 0018 010053E3 		cmp	r3, #1
  46 001c 0800001A 		bne	.L2
  16:hanoi_benchmark.c **** {
  17:hanoi_benchmark.c **** EV_plateToMove = EV_peg1;
  48 0020 04319FE5 		ldr	r3, .L8
  49 0024 003093E5 		ldr	r3, [r3]
  50 0028 08300BE5 		str	r3, [fp, #-8]
  18:hanoi_benchmark.c **** EV_peg1 = EV_peg1->EV_plateUnder;
  52 002c F8309FE5 		ldr	r3, .L8
  53 0030 003093E5 		ldr	r3, [r3]
  54 0034 043093E5 		ldr	r3, [r3, #4]
  56 0038 EC209FE5 		ldr	r2, .L8
  57 003c 003082E5 		str	r3, [r2]
  58 0040 130000EA 		b	.L3
  59              	.L2:
  19:hanoi_benchmark.c **** }
  20:hanoi_benchmark.c **** else
  21:hanoi_benchmark.c **** {
  22:hanoi_benchmark.c **** if ((EV_from==2))
  61 0044 10301BE5 		ldr	r3, [fp, #-16]
  62 0048 020053E3 		cmp	r3, #2
  63 004c 0800001A 		bne	.L4
  23:hanoi_benchmark.c **** {
  24:hanoi_benchmark.c **** EV_plateToMove = EV_peg2;
  65 0050 D8309FE5 		ldr	r3, .L8+4
  66 0054 003093E5 		ldr	r3, [r3]
  67 0058 08300BE5 		str	r3, [fp, #-8]
  25:hanoi_benchmark.c **** EV_peg2 = EV_peg2->EV_plateUnder;
  69 005c CC309FE5 		ldr	r3, .L8+4
  70 0060 003093E5 		ldr	r3, [r3]
  71 0064 043093E5 		ldr	r3, [r3, #4]
  73 0068 C0209FE5 		ldr	r2, .L8+4
  74 006c 003082E5 		str	r3, [r2]
  75 0070 070000EA 		b	.L3
  76              	.L4:
  26:hanoi_benchmark.c **** }
  27:hanoi_benchmark.c **** else
  28:hanoi_benchmark.c **** {
  29:hanoi_benchmark.c **** EV_plateToMove = EV_peg3;
  78 0074 B8309FE5 		ldr	r3, .L8+8
  79 0078 003093E5 		ldr	r3, [r3]
  80 007c 08300BE5 		str	r3, [fp, #-8]
  30:hanoi_benchmark.c **** EV_peg3 = EV_peg3->EV_plateUnder;
  82 0080 AC309FE5 		ldr	r3, .L8+8
  83 0084 003093E5 		ldr	r3, [r3]
  84 0088 043093E5 		ldr	r3, [r3, #4]
  86 008c A0209FE5 		ldr	r2, .L8+8
  87 0090 003082E5 		str	r3, [r2]
  88              	.L3:
  31:hanoi_benchmark.c **** }
  32:hanoi_benchmark.c **** }
  33:hanoi_benchmark.c **** if ((EV_to==1))
  90 0094 14301BE5 		ldr	r3, [fp, #-20]
  91 0098 010053E3 		cmp	r3, #1
  92 009c 0700001A 		bne	.L5
  34:hanoi_benchmark.c **** {
  35:hanoi_benchmark.c **** EV_plateToMove->EV_plateUnder = EV_peg1;
  94 00a0 84309FE5 		ldr	r3, .L8
  95 00a4 002093E5 		ldr	r2, [r3]
  96 00a8 08301BE5 		ldr	r3, [fp, #-8]
  97 00ac 042083E5 		str	r2, [r3, #4]
  36:hanoi_benchmark.c **** EV_peg1 = EV_plateToMove;
  99 00b0 74209FE5 		ldr	r2, .L8
 100 00b4 08301BE5 		ldr	r3, [fp, #-8]
 101 00b8 003082E5 		str	r3, [r2]
 102 00bc 110000EA 		b	.L6
 103              	.L5:
  37:hanoi_benchmark.c **** }
  38:hanoi_benchmark.c **** else
  39:hanoi_benchmark.c **** {
  40:hanoi_benchmark.c **** if ((EV_to==2))
 105 00c0 14301BE5 		ldr	r3, [fp, #-20]
 106 00c4 020053E3 		cmp	r3, #2
 107 00c8 0700001A 		bne	.L7
  41:hanoi_benchmark.c **** {
  42:hanoi_benchmark.c **** EV_plateToMove->EV_plateUnder = EV_peg2;
 109 00cc 5C309FE5 		ldr	r3, .L8+4
 110 00d0 002093E5 		ldr	r2, [r3]
 111 00d4 08301BE5 		ldr	r3, [fp, #-8]
 112 00d8 042083E5 		str	r2, [r3, #4]
  43:hanoi_benchmark.c **** EV_peg2 = EV_plateToMove;
 114 00dc 4C209FE5 		ldr	r2, .L8+4
 115 00e0 08301BE5 		ldr	r3, [fp, #-8]
 116 00e4 003082E5 		str	r3, [r2]
 117 00e8 060000EA 		b	.L6
 118              	.L7:
  44:hanoi_benchmark.c **** }
  45:hanoi_benchmark.c **** else
  46:hanoi_benchmark.c **** {
  47:hanoi_benchmark.c **** EV_plateToMove->EV_plateUnder = EV_peg3;
 120 00ec 40309FE5 		ldr	r3, .L8+8
 121 00f0 002093E5 		ldr	r2, [r3]
 122 00f4 08301BE5 		ldr	r3, [fp, #-8]
 123 00f8 042083E5 		str	r2, [r3, #4]
  48:hanoi_benchmark.c **** EV_peg3 = EV_plateToMove;
 125 00fc 30209FE5 		ldr	r2, .L8+8
 126 0100 08301BE5 		ldr	r3, [fp, #-8]
 127 0104 003082E5 		str	r3, [r2]
 128              	.L6:
  49:hanoi_benchmark.c **** }
  50:hanoi_benchmark.c **** }
  51:hanoi_benchmark.c **** EV_numMoves = (EV_numMoves+1);
 130 0108 28309FE5 		ldr	r3, .L8+12
 131 010c 003093E5 		ldr	r3, [r3]
 132 0110 013083E2 		add	r3, r3, #1
 134 0114 1C209FE5 		ldr	r2, .L8+12
 135 0118 003082E5 		str	r3, [r2]
  52:hanoi_benchmark.c **** }
 137 011c 0000A0E1 		nop
 138 0120 00D08BE2 		add	sp, fp, #0
 140              		@ sp needed
 141 0124 04B09DE4 		ldr	fp, [sp], #4
 144 0128 1EFF2FE1 		bx	lr
 145              	.L9:
 146              		.align	2
 147              	.L8:
 148 012c 00000000 		.word	EV_peg1
 149 0130 00000000 		.word	EV_peg2
 150 0134 00000000 		.word	EV_peg3
 151 0138 00000000 		.word	EV_numMoves
 153              	.LFE6:
 155              		.align	2
 156              		.global	_hanoi
 157              		.syntax unified
 158              		.arm
 159              		.fpu vfp
 161              	_hanoi:
 162              	.LFB7:
  53:hanoi_benchmark.c **** void _hanoi(int EV_n,int EV_from,int EV_to,int EV_other)
  54:hanoi_benchmark.c **** {
 165              		@ args = 0, pretend = 0, frame = 16
 166              		@ frame_needed = 1, uses_anonymous_args = 0
 167 013c 00482DE9 		push	{fp, lr}
 171 0140 04B08DE2 		add	fp, sp, #4
 173 0144 10D04DE2 		sub	sp, sp, #16
 174 0148 08000BE5 		str	r0, [fp, #-8]
 175 014c 0C100BE5 		str	r1, [fp, #-12]
 176 0150 10200BE5 		str	r2, [fp, #-16]
 177 0154 14300BE5 		str	r3, [fp, #-20]
  55:hanoi_benchmark.c **** if ((EV_n==1))
 179 0158 08301BE5 		ldr	r3, [fp, #-8]
 180 015c 010053E3 		cmp	r3, #1
 181 0160 0300001A 		bne	.L11
  56:hanoi_benchmark.c **** {
  57:hanoi_benchmark.c **** _move(EV_from, EV_to);
 183 0164 10101BE5 		ldr	r1, [fp, #-16]
 184 0168 0C001BE5 		ldr	r0, [fp, #-12]
 185 016c FEFFFFEB 		bl	_move
  58:hanoi_benchmark.c **** }
  59:hanoi_benchmark.c **** else
  60:hanoi_benchmark.c **** {
  61:hanoi_benchmark.c **** _hanoi((EV_n-1), EV_from, EV_other, EV_to);
  62:hanoi_benchmark.c **** _move(EV_from, EV_to);
  63:hanoi_benchmark.c **** _hanoi((EV_n-1), EV_other, EV_to, EV_from);
  64:hanoi_benchmark.c **** }
  65:hanoi_benchmark.c **** }
 187 0170 0E0000EA 		b	.L13
 188              	.L11:
  61:hanoi_benchmark.c **** _move(EV_from, EV_to);
 190 0174 08301BE5 		ldr	r3, [fp, #-8]
 191 0178 010043E2 		sub	r0, r3, #1
 192 017c 10301BE5 		ldr	r3, [fp, #-16]
 193 0180 14201BE5 		ldr	r2, [fp, #-20]
 194 0184 0C101BE5 		ldr	r1, [fp, #-12]
 195 0188 FEFFFFEB 		bl	_hanoi
  62:hanoi_benchmark.c **** _hanoi((EV_n-1), EV_other, EV_to, EV_from);
 197 018c 10101BE5 		ldr	r1, [fp, #-16]
 198 0190 0C001BE5 		ldr	r0, [fp, #-12]
 199 0194 FEFFFFEB 		bl	_move
  63:hanoi_benchmark.c **** }
 201 0198 08301BE5 		ldr	r3, [fp, #-8]
 202 019c 010043E2 		sub	r0, r3, #1
 203 01a0 0C301BE5 		ldr	r3, [fp, #-12]
 204 01a4 10201BE5 		ldr	r2, [fp, #-16]
 205 01a8 14101BE5 		ldr	r1, [fp, #-20]
 206 01ac FEFFFFEB 		bl	_hanoi
 207              	.L13:
 209 01b0 0000A0E1 		nop
 210 01b4 04D04BE2 		sub	sp, fp, #4
 212              		@ sp needed
 213 01b8 0088BDE8 		pop	{fp, pc}
 215              	.LFE7:
 217              		.section	.rodata
 218              		.align	2
 219              	.LC0:
 220 0000 25640A00 		.ascii	"%d\012\000"
 221              		.text
 222              		.align	2
 223              		.global	_printPeg
 224              		.syntax unified
 225              		.arm
 226              		.fpu vfp
 228              	_printPeg:
 229              	.LFB8:
  66:hanoi_benchmark.c **** void _printPeg(struct EV_plate * EV_peg)
  67:hanoi_benchmark.c **** {
 232              		@ args = 0, pretend = 0, frame = 16
 233              		@ frame_needed = 1, uses_anonymous_args = 0
 234 01bc 00482DE9 		push	{fp, lr}
 238 01c0 04B08DE2 		add	fp, sp, #4
 240 01c4 10D04DE2 		sub	sp, sp, #16
 241 01c8 10000BE5 		str	r0, [fp, #-16]
  68:hanoi_benchmark.c **** struct EV_plate * EV_aPlate;
  69:hanoi_benchmark.c **** EV_aPlate = EV_peg;
 243 01cc 10301BE5 		ldr	r3, [fp, #-16]
 244 01d0 08300BE5 		str	r3, [fp, #-8]
  70:hanoi_benchmark.c **** while ((EV_aPlate!=NULL))
 246 01d4 070000EA 		b	.L15
 247              	.L16:
  71:hanoi_benchmark.c **** {
  72:hanoi_benchmark.c **** printf("%d\n", EV_aPlate->EV_size);
 249 01d8 08301BE5 		ldr	r3, [fp, #-8]
 250 01dc 003093E5 		ldr	r3, [r3]
 251 01e0 0310A0E1 		mov	r1, r3
 252 01e4 24009FE5 		ldr	r0, .L17
 253 01e8 FEFFFFEB 		bl	printf
  73:hanoi_benchmark.c **** EV_aPlate = EV_aPlate->EV_plateUnder;
 255 01ec 08301BE5 		ldr	r3, [fp, #-8]
 256 01f0 043093E5 		ldr	r3, [r3, #4]
 257 01f4 08300BE5 		str	r3, [fp, #-8]
 258              	.L15:
  70:hanoi_benchmark.c **** while ((EV_aPlate!=NULL))
 260 01f8 08301BE5 		ldr	r3, [fp, #-8]
 261 01fc 000053E3 		cmp	r3, #0
 262 0200 F4FFFF1A 		bne	.L16
  74:hanoi_benchmark.c **** }
  75:hanoi_benchmark.c **** }
 264 0204 0000A0E1 		nop
 265 0208 04D04BE2 		sub	sp, fp, #4
 267              		@ sp needed
 268 020c 0088BDE8 		pop	{fp, pc}
 269              	.L18:
 270              		.align	2
 271              	.L17:
 272 0210 00000000 		.word	.LC0
 274              	.LFE8:
 276              		.section	.rodata
 277              		.align	2
 278              	.LC1:
 279 0004 256400   		.ascii	"%d\000"
 280              		.text
 281              		.align	2
 282              		.global	_main
 283              		.syntax unified
 284              		.arm
 285              		.fpu vfp
 287              	_main:
 288              	.LFB9:
  76:hanoi_benchmark.c **** int _main()
  77:hanoi_benchmark.c **** {
 291              		@ args = 0, pretend = 0, frame = 16
 292              		@ frame_needed = 1, uses_anonymous_args = 0
 293 0214 00482DE9 		push	{fp, lr}
 297 0218 04B08DE2 		add	fp, sp, #4
 299 021c 10D04DE2 		sub	sp, sp, #16
  78:hanoi_benchmark.c **** int EV_count;
  79:hanoi_benchmark.c **** int EV_numPlates;
  80:hanoi_benchmark.c **** struct EV_plate * EV_aPlate;
  81:hanoi_benchmark.c **** EV_peg1 = NULL;
 301 0220 BC319FE5 		ldr	r3, .L26
 302 0224 0020A0E3 		mov	r2, #0
 303 0228 002083E5 		str	r2, [r3]
  82:hanoi_benchmark.c **** EV_peg2 = NULL;
 305 022c B4319FE5 		ldr	r3, .L26+4
 306 0230 0020A0E3 		mov	r2, #0
 307 0234 002083E5 		str	r2, [r3]
  83:hanoi_benchmark.c **** EV_peg3 = NULL;
 309 0238 AC319FE5 		ldr	r3, .L26+8
 310 023c 0020A0E3 		mov	r2, #0
 311 0240 002083E5 		str	r2, [r3]
  84:hanoi_benchmark.c **** EV_numMoves = 0;
 313 0244 A4319FE5 		ldr	r3, .L26+12
 314 0248 0020A0E3 		mov	r2, #0
 315 024c 002083E5 		str	r2, [r3]
  85:hanoi_benchmark.c **** scanf("%d", &EV_numPlates);
 317 0250 10304BE2 		sub	r3, fp, #16
 318 0254 0310A0E1 		mov	r1, r3
 319 0258 94019FE5 		ldr	r0, .L26+16
 320 025c FEFFFFEB 		bl	__isoc99_scanf
  86:hanoi_benchmark.c **** if ((EV_numPlates>=1))
 322 0260 10301BE5 		ldr	r3, [fp, #-16]
 324 0264 000053E3 		cmp	r3, #0
 325 0268 590000DA 		ble	.L20
  87:hanoi_benchmark.c **** {
  88:hanoi_benchmark.c **** EV_count = EV_numPlates;
 327 026c 10301BE5 		ldr	r3, [fp, #-16]
 328 0270 08300BE5 		str	r3, [fp, #-8]
  89:hanoi_benchmark.c **** while ((EV_count!=0))
 330 0274 100000EA 		b	.L21
 331              	.L22:
  90:hanoi_benchmark.c **** {
  91:hanoi_benchmark.c **** EV_aPlate = (struct EV_plate*)malloc(sizeof(struct EV_plate));
 333 0278 0800A0E3 		mov	r0, #8
 334 027c FEFFFFEB 		bl	malloc
 335 0280 0030A0E1 		mov	r3, r0
 336 0284 0C300BE5 		str	r3, [fp, #-12]
  92:hanoi_benchmark.c **** EV_aPlate->EV_size = EV_count;
 338 0288 0C301BE5 		ldr	r3, [fp, #-12]
 339 028c 08201BE5 		ldr	r2, [fp, #-8]
 340 0290 002083E5 		str	r2, [r3]
  93:hanoi_benchmark.c **** EV_aPlate->EV_plateUnder = EV_peg1;
 342 0294 48319FE5 		ldr	r3, .L26
 343 0298 002093E5 		ldr	r2, [r3]
 344 029c 0C301BE5 		ldr	r3, [fp, #-12]
 345 02a0 042083E5 		str	r2, [r3, #4]
  94:hanoi_benchmark.c **** EV_peg1 = EV_aPlate;
 347 02a4 38219FE5 		ldr	r2, .L26
 348 02a8 0C301BE5 		ldr	r3, [fp, #-12]
 349 02ac 003082E5 		str	r3, [r2]
  95:hanoi_benchmark.c **** EV_count = (EV_count-1);
 351 02b0 08301BE5 		ldr	r3, [fp, #-8]
 352 02b4 013043E2 		sub	r3, r3, #1
 353 02b8 08300BE5 		str	r3, [fp, #-8]
 354              	.L21:
  89:hanoi_benchmark.c **** {
 356 02bc 08301BE5 		ldr	r3, [fp, #-8]
 357 02c0 000053E3 		cmp	r3, #0
 358 02c4 EBFFFF1A 		bne	.L22
  96:hanoi_benchmark.c **** }
  97:hanoi_benchmark.c **** printf("%d\n", 1);
 360 02c8 0110A0E3 		mov	r1, #1
 361 02cc 24019FE5 		ldr	r0, .L26+20
 362 02d0 FEFFFFEB 		bl	printf
  98:hanoi_benchmark.c **** _printPeg(EV_peg1);
 364 02d4 08319FE5 		ldr	r3, .L26
 365 02d8 003093E5 		ldr	r3, [r3]
 366 02dc 0300A0E1 		mov	r0, r3
 367 02e0 FEFFFFEB 		bl	_printPeg
  99:hanoi_benchmark.c **** printf("%d\n", 2);
 369 02e4 0210A0E3 		mov	r1, #2
 370 02e8 08019FE5 		ldr	r0, .L26+20
 371 02ec FEFFFFEB 		bl	printf
 100:hanoi_benchmark.c **** _printPeg(EV_peg2);
 373 02f0 F0309FE5 		ldr	r3, .L26+4
 374 02f4 003093E5 		ldr	r3, [r3]
 375 02f8 0300A0E1 		mov	r0, r3
 376 02fc FEFFFFEB 		bl	_printPeg
 101:hanoi_benchmark.c **** printf("%d\n", 3);
 378 0300 0310A0E3 		mov	r1, #3
 379 0304 EC009FE5 		ldr	r0, .L26+20
 380 0308 FEFFFFEB 		bl	printf
 102:hanoi_benchmark.c **** _printPeg(EV_peg3);
 382 030c D8309FE5 		ldr	r3, .L26+8
 383 0310 003093E5 		ldr	r3, [r3]
 384 0314 0300A0E1 		mov	r0, r3
 385 0318 FEFFFFEB 		bl	_printPeg
 103:hanoi_benchmark.c **** _hanoi(EV_numPlates, 1, 3, 2);
 387 031c 10001BE5 		ldr	r0, [fp, #-16]
 388 0320 0230A0E3 		mov	r3, #2
 389 0324 0320A0E3 		mov	r2, #3
 390 0328 0110A0E3 		mov	r1, #1
 391 032c FEFFFFEB 		bl	_hanoi
 104:hanoi_benchmark.c **** printf("%d\n", 1);
 393 0330 0110A0E3 		mov	r1, #1
 394 0334 BC009FE5 		ldr	r0, .L26+20
 395 0338 FEFFFFEB 		bl	printf
 105:hanoi_benchmark.c **** _printPeg(EV_peg1);
 397 033c A0309FE5 		ldr	r3, .L26
 398 0340 003093E5 		ldr	r3, [r3]
 399 0344 0300A0E1 		mov	r0, r3
 400 0348 FEFFFFEB 		bl	_printPeg
 106:hanoi_benchmark.c **** printf("%d\n", 2);
 402 034c 0210A0E3 		mov	r1, #2
 403 0350 A0009FE5 		ldr	r0, .L26+20
 404 0354 FEFFFFEB 		bl	printf
 107:hanoi_benchmark.c **** _printPeg(EV_peg2);
 406 0358 88309FE5 		ldr	r3, .L26+4
 407 035c 003093E5 		ldr	r3, [r3]
 408 0360 0300A0E1 		mov	r0, r3
 409 0364 FEFFFFEB 		bl	_printPeg
 108:hanoi_benchmark.c **** printf("%d\n", 3);
 411 0368 0310A0E3 		mov	r1, #3
 412 036c 84009FE5 		ldr	r0, .L26+20
 413 0370 FEFFFFEB 		bl	printf
 109:hanoi_benchmark.c **** _printPeg(EV_peg3);
 415 0374 70309FE5 		ldr	r3, .L26+8
 416 0378 003093E5 		ldr	r3, [r3]
 417 037c 0300A0E1 		mov	r0, r3
 418 0380 FEFFFFEB 		bl	_printPeg
 110:hanoi_benchmark.c **** printf("%d\n", EV_numMoves);
 420 0384 64309FE5 		ldr	r3, .L26+12
 421 0388 003093E5 		ldr	r3, [r3]
 422 038c 0310A0E1 		mov	r1, r3
 423 0390 60009FE5 		ldr	r0, .L26+20
 424 0394 FEFFFFEB 		bl	printf
 111:hanoi_benchmark.c **** while ((EV_peg3!=NULL))
 426 0398 090000EA 		b	.L23
 427              	.L24:
 112:hanoi_benchmark.c **** {
 113:hanoi_benchmark.c **** EV_aPlate = EV_peg3;
 429 039c 48309FE5 		ldr	r3, .L26+8
 430 03a0 003093E5 		ldr	r3, [r3]
 431 03a4 0C300BE5 		str	r3, [fp, #-12]
 114:hanoi_benchmark.c **** EV_peg3 = EV_peg3->EV_plateUnder;
 433 03a8 3C309FE5 		ldr	r3, .L26+8
 434 03ac 003093E5 		ldr	r3, [r3]
 435 03b0 043093E5 		ldr	r3, [r3, #4]
 437 03b4 30209FE5 		ldr	r2, .L26+8
 438 03b8 003082E5 		str	r3, [r2]
 115:hanoi_benchmark.c **** free(EV_aPlate);
 440 03bc 0C001BE5 		ldr	r0, [fp, #-12]
 441 03c0 FEFFFFEB 		bl	free
 442              	.L23:
 111:hanoi_benchmark.c **** {
 444 03c4 20309FE5 		ldr	r3, .L26+8
 445 03c8 003093E5 		ldr	r3, [r3]
 111:hanoi_benchmark.c **** {
 447 03cc 000053E3 		cmp	r3, #0
 448 03d0 F1FFFF1A 		bne	.L24
 449              	.L20:
 116:hanoi_benchmark.c **** }
 117:hanoi_benchmark.c **** }
 118:hanoi_benchmark.c **** return 0;
 451 03d4 0030A0E3 		mov	r3, #0
 119:hanoi_benchmark.c **** }
 453 03d8 0300A0E1 		mov	r0, r3
 454 03dc 04D04BE2 		sub	sp, fp, #4
 456              		@ sp needed
 457 03e0 0088BDE8 		pop	{fp, pc}
 458              	.L27:
 459              		.align	2
 460              	.L26:
 461 03e4 00000000 		.word	EV_peg1
 462 03e8 00000000 		.word	EV_peg2
 463 03ec 00000000 		.word	EV_peg3
 464 03f0 00000000 		.word	EV_numMoves
 465 03f4 04000000 		.word	.LC1
 466 03f8 00000000 		.word	.LC0
 468              	.LFE9:
 470              		.align	2
 471              		.global	main
 472              		.syntax unified
 473              		.arm
 474              		.fpu vfp
 476              	main:
 477              	.LFB10:
 120:hanoi_benchmark.c **** int main(void)
 121:hanoi_benchmark.c **** {
 480              		@ args = 0, pretend = 0, frame = 0
 481              		@ frame_needed = 1, uses_anonymous_args = 0
 482 03fc 00482DE9 		push	{fp, lr}
 486 0400 04B08DE2 		add	fp, sp, #4
 122:hanoi_benchmark.c ****    return _main();
 489 0404 FEFFFFEB 		bl	_main
 490 0408 0030A0E1 		mov	r3, r0
 123:hanoi_benchmark.c **** }
 492 040c 0300A0E1 		mov	r0, r3
 493 0410 0088BDE8 		pop	{fp, pc}
 495              	.LFE10:
 497              	.Letext0:
