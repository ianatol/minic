   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  17              		.align	2
  18              		.global	_getRands
  19              		.arch armv6
  20              		.syntax unified
  21              		.arm
  22              		.fpu vfp
  24              	_getRands:
  25              	.LFB6:
   1:stats.c       **** #include<stdio.h>
   2:stats.c       **** #include<stdlib.h>
   3:stats.c       **** struct EV_linkedNums
   4:stats.c       **** {
   5:stats.c       **** int EV_num;
   6:stats.c       **** struct EV_linkedNums * EV_next;
   7:stats.c       **** };
   8:stats.c       **** struct EV_linkedNums * _getRands(int EV_seed,int EV_num)
   9:stats.c       **** {
  29              		@ args = 0, pretend = 0, frame = 24
  30              		@ frame_needed = 1, uses_anonymous_args = 0
  31 0000 00482DE9 		push	{fp, lr}
  35 0004 04B08DE2 		add	fp, sp, #4
  37 0008 18D04DE2 		sub	sp, sp, #24
  38 000c 18000BE5 		str	r0, [fp, #-24]
  39 0010 1C100BE5 		str	r1, [fp, #-28]
  10:stats.c       **** int EV_cur;
  11:stats.c       **** int EV_prev;
  12:stats.c       **** struct EV_linkedNums * EV_curNode;
  13:stats.c       **** struct EV_linkedNums * EV_prevNode;
  14:stats.c       **** EV_curNode = NULL;
  41 0014 0030A0E3 		mov	r3, #0
  42 0018 0C300BE5 		str	r3, [fp, #-12]
  15:stats.c       **** EV_cur = (EV_seed*EV_seed);
  44 001c 18301BE5 		ldr	r3, [fp, #-24]
  45 0020 18201BE5 		ldr	r2, [fp, #-24]
  46 0024 920303E0 		mul	r3, r2, r3
  47 0028 14300BE5 		str	r3, [fp, #-20]
  16:stats.c       **** EV_prevNode = (struct EV_linkedNums*)malloc(sizeof(struct EV_linkedNums));
  49 002c 0800A0E3 		mov	r0, #8
  50 0030 FEFFFFEB 		bl	malloc
  51 0034 0030A0E1 		mov	r3, r0
  52 0038 10300BE5 		str	r3, [fp, #-16]
  17:stats.c       **** EV_prevNode->EV_num = EV_cur;
  54 003c 10301BE5 		ldr	r3, [fp, #-16]
  55 0040 14201BE5 		ldr	r2, [fp, #-20]
  56 0044 002083E5 		str	r2, [r3]
  18:stats.c       **** EV_prevNode->EV_next = NULL;
  58 0048 10301BE5 		ldr	r3, [fp, #-16]
  59 004c 0020A0E3 		mov	r2, #0
  60 0050 042083E5 		str	r2, [r3, #4]
  19:stats.c       **** EV_num = (EV_num-1);
  62 0054 1C301BE5 		ldr	r3, [fp, #-28]
  63 0058 013043E2 		sub	r3, r3, #1
  64 005c 1C300BE5 		str	r3, [fp, #-28]
  20:stats.c       **** EV_prev = EV_cur;
  66 0060 14301BE5 		ldr	r3, [fp, #-20]
  67 0064 08300BE5 		str	r3, [fp, #-8]
  21:stats.c       **** while ((EV_num>0))
  69 0068 1F0000EA 		b	.L2
  70              	.L3:
  22:stats.c       **** {
  23:stats.c       **** EV_cur = ((((EV_prev*EV_prev)/EV_seed)*(EV_seed/2))+1);
  72 006c 08301BE5 		ldr	r3, [fp, #-8]
  73 0070 08201BE5 		ldr	r2, [fp, #-8]
  74 0074 920303E0 		mul	r3, r2, r3
  76 0078 18101BE5 		ldr	r1, [fp, #-24]
  77 007c 0300A0E1 		mov	r0, r3
  79              	.LVL0:
  80 0084 0030A0E1 		mov	r3, r0
  81 0088 0310A0E1 		mov	r1, r3
  83 008c 18301BE5 		ldr	r3, [fp, #-24]
  84 0090 A32FA0E1 		lsr	r2, r3, #31
  85 0094 033082E0 		add	r3, r2, r3
  86 0098 C330A0E1 		asr	r3, r3, #1
  88 009c 930103E0 		mul	r3, r3, r1
  90 00a0 013083E2 		add	r3, r3, #1
  91 00a4 14300BE5 		str	r3, [fp, #-20]
  24:stats.c       **** EV_curNode = (struct EV_linkedNums*)malloc(sizeof(struct EV_linkedNums));
  93 00a8 0800A0E3 		mov	r0, #8
  94 00ac FEFFFFEB 		bl	malloc
  95 00b0 0030A0E1 		mov	r3, r0
  96 00b4 0C300BE5 		str	r3, [fp, #-12]
  25:stats.c       **** EV_curNode->EV_num = EV_cur;
  98 00b8 0C301BE5 		ldr	r3, [fp, #-12]
  99 00bc 14201BE5 		ldr	r2, [fp, #-20]
 100 00c0 002083E5 		str	r2, [r3]
  26:stats.c       **** EV_curNode->EV_next = EV_prevNode;
 102 00c4 0C301BE5 		ldr	r3, [fp, #-12]
 103 00c8 10201BE5 		ldr	r2, [fp, #-16]
 104 00cc 042083E5 		str	r2, [r3, #4]
  27:stats.c       **** EV_prevNode = EV_curNode;
 106 00d0 0C301BE5 		ldr	r3, [fp, #-12]
 107 00d4 10300BE5 		str	r3, [fp, #-16]
  28:stats.c       **** EV_num = (EV_num-1);
 109 00d8 1C301BE5 		ldr	r3, [fp, #-28]
 110 00dc 013043E2 		sub	r3, r3, #1
 111 00e0 1C300BE5 		str	r3, [fp, #-28]
  29:stats.c       **** EV_prev = EV_cur;
 113 00e4 14301BE5 		ldr	r3, [fp, #-20]
 114 00e8 08300BE5 		str	r3, [fp, #-8]
 115              	.L2:
  21:stats.c       **** {
 117 00ec 1C301BE5 		ldr	r3, [fp, #-28]
 118 00f0 000053E3 		cmp	r3, #0
 119 00f4 DCFFFFCA 		bgt	.L3
  30:stats.c       **** }
  31:stats.c       **** return EV_curNode;
 121 00f8 0C301BE5 		ldr	r3, [fp, #-12]
  32:stats.c       **** }
 123 00fc 0300A0E1 		mov	r0, r3
 124 0100 04D04BE2 		sub	sp, fp, #4
 126              		@ sp needed
 127 0104 0088BDE8 		pop	{fp, pc}
 129              	.LFE6:
 131              		.align	2
 132              		.global	_calcMean
 133              		.syntax unified
 134              		.arm
 135              		.fpu vfp
 137              	_calcMean:
 138              	.LFB7:
  33:stats.c       **** int _calcMean(struct EV_linkedNums * EV_nums)
  34:stats.c       **** {
 141              		@ args = 0, pretend = 0, frame = 24
 142              		@ frame_needed = 1, uses_anonymous_args = 0
 143 0108 00482DE9 		push	{fp, lr}
 147 010c 04B08DE2 		add	fp, sp, #4
 149 0110 18D04DE2 		sub	sp, sp, #24
 150 0114 18000BE5 		str	r0, [fp, #-24]
  35:stats.c       **** int EV_sum;
  36:stats.c       **** int EV_num;
  37:stats.c       **** int EV_mean;
  38:stats.c       **** EV_sum = 0;
 152 0118 0030A0E3 		mov	r3, #0
 153 011c 08300BE5 		str	r3, [fp, #-8]
  39:stats.c       **** EV_num = 0;
 155 0120 0030A0E3 		mov	r3, #0
 156 0124 0C300BE5 		str	r3, [fp, #-12]
  40:stats.c       **** EV_mean = 0;
 158 0128 0030A0E3 		mov	r3, #0
 159 012c 10300BE5 		str	r3, [fp, #-16]
  41:stats.c       **** while ((EV_nums!=NULL))
 161 0130 0A0000EA 		b	.L6
 162              	.L7:
  42:stats.c       **** {
  43:stats.c       **** EV_num = (EV_num+1);
 164 0134 0C301BE5 		ldr	r3, [fp, #-12]
 165 0138 013083E2 		add	r3, r3, #1
 166 013c 0C300BE5 		str	r3, [fp, #-12]
  44:stats.c       **** EV_sum = (EV_sum+EV_nums->EV_num);
 168 0140 18301BE5 		ldr	r3, [fp, #-24]
 169 0144 003093E5 		ldr	r3, [r3]
 171 0148 08201BE5 		ldr	r2, [fp, #-8]
 172 014c 033082E0 		add	r3, r2, r3
 173 0150 08300BE5 		str	r3, [fp, #-8]
  45:stats.c       **** EV_nums = EV_nums->EV_next;
 175 0154 18301BE5 		ldr	r3, [fp, #-24]
 176 0158 043093E5 		ldr	r3, [r3, #4]
 177 015c 18300BE5 		str	r3, [fp, #-24]
 178              	.L6:
  41:stats.c       **** {
 180 0160 18301BE5 		ldr	r3, [fp, #-24]
 181 0164 000053E3 		cmp	r3, #0
 182 0168 F1FFFF1A 		bne	.L7
  46:stats.c       **** }
  47:stats.c       **** if ((EV_num!=0))
 184 016c 0C301BE5 		ldr	r3, [fp, #-12]
 185 0170 000053E3 		cmp	r3, #0
 186 0174 0400000A 		beq	.L8
  48:stats.c       **** {
  49:stats.c       **** EV_mean = (EV_sum/EV_num);
 188 0178 0C101BE5 		ldr	r1, [fp, #-12]
 189 017c 08001BE5 		ldr	r0, [fp, #-8]
 191              	.LVL1:
 192 0184 0030A0E1 		mov	r3, r0
 193 0188 10300BE5 		str	r3, [fp, #-16]
 194              	.L8:
  50:stats.c       **** }
  51:stats.c       **** return EV_mean;
 196 018c 10301BE5 		ldr	r3, [fp, #-16]
  52:stats.c       **** }
 198 0190 0300A0E1 		mov	r0, r3
 199 0194 04D04BE2 		sub	sp, fp, #4
 201              		@ sp needed
 202 0198 0088BDE8 		pop	{fp, pc}
 204              	.LFE7:
 206              		.align	2
 207              		.global	_approxSqrt
 208              		.syntax unified
 209              		.arm
 210              		.fpu vfp
 212              	_approxSqrt:
 213              	.LFB8:
  53:stats.c       **** int _approxSqrt(int EV_num)
  54:stats.c       **** {
 216              		@ args = 0, pretend = 0, frame = 24
 217              		@ frame_needed = 1, uses_anonymous_args = 0
 218              		@ link register save eliminated.
 219 019c 04B02DE5 		str	fp, [sp, #-4]!
 222 01a0 00B08DE2 		add	fp, sp, #0
 224 01a4 1CD04DE2 		sub	sp, sp, #28
 225 01a8 18000BE5 		str	r0, [fp, #-24]
  55:stats.c       **** int EV_guess;
  56:stats.c       **** int EV_result;
  57:stats.c       **** int EV_prev;
  58:stats.c       **** EV_guess = 1;
 227 01ac 0130A0E3 		mov	r3, #1
 228 01b0 08300BE5 		str	r3, [fp, #-8]
  59:stats.c       **** EV_prev = EV_guess;
 230 01b4 08301BE5 		ldr	r3, [fp, #-8]
 231 01b8 10300BE5 		str	r3, [fp, #-16]
  60:stats.c       **** EV_result = 0;
 233 01bc 0030A0E3 		mov	r3, #0
 234 01c0 0C300BE5 		str	r3, [fp, #-12]
  61:stats.c       **** while ((EV_result<EV_num))
 236 01c4 080000EA 		b	.L11
 237              	.L12:
  62:stats.c       **** {
  63:stats.c       **** EV_result = (EV_guess*EV_guess);
 239 01c8 08301BE5 		ldr	r3, [fp, #-8]
 240 01cc 08201BE5 		ldr	r2, [fp, #-8]
 241 01d0 920303E0 		mul	r3, r2, r3
 242 01d4 0C300BE5 		str	r3, [fp, #-12]
  64:stats.c       **** EV_prev = EV_guess;
 244 01d8 08301BE5 		ldr	r3, [fp, #-8]
 245 01dc 10300BE5 		str	r3, [fp, #-16]
  65:stats.c       **** EV_guess = (EV_guess+1);
 247 01e0 08301BE5 		ldr	r3, [fp, #-8]
 248 01e4 013083E2 		add	r3, r3, #1
 249 01e8 08300BE5 		str	r3, [fp, #-8]
 250              	.L11:
  61:stats.c       **** {
 252 01ec 0C201BE5 		ldr	r2, [fp, #-12]
 253 01f0 18301BE5 		ldr	r3, [fp, #-24]
 254 01f4 030052E1 		cmp	r2, r3
 255 01f8 F2FFFFBA 		blt	.L12
  66:stats.c       **** }
  67:stats.c       **** return EV_prev;
 257 01fc 10301BE5 		ldr	r3, [fp, #-16]
  68:stats.c       **** }
 259 0200 0300A0E1 		mov	r0, r3
 260 0204 00D08BE2 		add	sp, fp, #0
 262              		@ sp needed
 263 0208 04B09DE4 		ldr	fp, [sp], #4
 266 020c 1EFF2FE1 		bx	lr
 268              	.LFE8:
 270              		.section	.rodata
 271              		.align	2
 272              	.LC0:
 273 0000 25640A00 		.ascii	"%d\012\000"
 274              		.text
 275              		.align	2
 276              		.global	_approxSqrtAll
 277              		.syntax unified
 278              		.arm
 279              		.fpu vfp
 281              	_approxSqrtAll:
 282              	.LFB9:
  69:stats.c       **** void _approxSqrtAll(struct EV_linkedNums * EV_nums)
  70:stats.c       **** {
 285              		@ args = 0, pretend = 0, frame = 8
 286              		@ frame_needed = 1, uses_anonymous_args = 0
 287 0210 00482DE9 		push	{fp, lr}
 291 0214 04B08DE2 		add	fp, sp, #4
 293 0218 08D04DE2 		sub	sp, sp, #8
 294 021c 08000BE5 		str	r0, [fp, #-8]
  71:stats.c       **** while ((EV_nums!=NULL))
 296 0220 0A0000EA 		b	.L15
 297              	.L16:
  72:stats.c       **** {
  73:stats.c       **** printf("%d\n", _approxSqrt(EV_nums->EV_num));
 299 0224 08301BE5 		ldr	r3, [fp, #-8]
 300 0228 003093E5 		ldr	r3, [r3]
 301 022c 0300A0E1 		mov	r0, r3
 302 0230 FEFFFFEB 		bl	_approxSqrt
 303 0234 0030A0E1 		mov	r3, r0
 304 0238 0310A0E1 		mov	r1, r3
 305 023c 24009FE5 		ldr	r0, .L17
 306 0240 FEFFFFEB 		bl	printf
  74:stats.c       **** EV_nums = EV_nums->EV_next;
 308 0244 08301BE5 		ldr	r3, [fp, #-8]
 309 0248 043093E5 		ldr	r3, [r3, #4]
 310 024c 08300BE5 		str	r3, [fp, #-8]
 311              	.L15:
  71:stats.c       **** while ((EV_nums!=NULL))
 313 0250 08301BE5 		ldr	r3, [fp, #-8]
 314 0254 000053E3 		cmp	r3, #0
 315 0258 F1FFFF1A 		bne	.L16
  75:stats.c       **** }
  76:stats.c       **** }
 317 025c 0000A0E1 		nop
 318 0260 04D04BE2 		sub	sp, fp, #4
 320              		@ sp needed
 321 0264 0088BDE8 		pop	{fp, pc}
 322              	.L18:
 323              		.align	2
 324              	.L17:
 325 0268 00000000 		.word	.LC0
 327              	.LFE9:
 329              		.align	2
 330              		.global	_range
 331              		.syntax unified
 332              		.arm
 333              		.fpu vfp
 335              	_range:
 336              	.LFB10:
  77:stats.c       **** void _range(struct EV_linkedNums * EV_nums)
  78:stats.c       **** {
 339              		@ args = 0, pretend = 0, frame = 24
 340              		@ frame_needed = 1, uses_anonymous_args = 0
 341 026c 00482DE9 		push	{fp, lr}
 345 0270 04B08DE2 		add	fp, sp, #4
 347 0274 18D04DE2 		sub	sp, sp, #24
 348 0278 18000BE5 		str	r0, [fp, #-24]
  79:stats.c       **** int EV_min;
  80:stats.c       **** int EV_max;
  81:stats.c       **** int EV_first;
  82:stats.c       **** EV_min = 0;
 350 027c 0030A0E3 		mov	r3, #0
 351 0280 08300BE5 		str	r3, [fp, #-8]
  83:stats.c       **** EV_max = 0;
 353 0284 0030A0E3 		mov	r3, #0
 354 0288 0C300BE5 		str	r3, [fp, #-12]
  84:stats.c       **** EV_first = 1;
 356 028c 0130A0E3 		mov	r3, #1
 357 0290 10300BE5 		str	r3, [fp, #-16]
  85:stats.c       **** while ((EV_nums!=NULL))
 359 0294 1F0000EA 		b	.L20
 360              	.L24:
  86:stats.c       **** {
  87:stats.c       **** if (EV_first)
 362 0298 10301BE5 		ldr	r3, [fp, #-16]
 363 029c 000053E3 		cmp	r3, #0
 364 02a0 0800000A 		beq	.L21
  88:stats.c       **** {
  89:stats.c       **** EV_min = EV_nums->EV_num;
 366 02a4 18301BE5 		ldr	r3, [fp, #-24]
 367 02a8 003093E5 		ldr	r3, [r3]
 368 02ac 08300BE5 		str	r3, [fp, #-8]
  90:stats.c       **** EV_max = EV_nums->EV_num;
 370 02b0 18301BE5 		ldr	r3, [fp, #-24]
 371 02b4 003093E5 		ldr	r3, [r3]
 372 02b8 0C300BE5 		str	r3, [fp, #-12]
  91:stats.c       **** EV_first = 0;
 374 02bc 0030A0E3 		mov	r3, #0
 375 02c0 10300BE5 		str	r3, [fp, #-16]
 376 02c4 100000EA 		b	.L22
 377              	.L21:
  92:stats.c       **** }
  93:stats.c       **** else
  94:stats.c       **** {
  95:stats.c       **** if ((EV_nums->EV_num<EV_min))
 379 02c8 18301BE5 		ldr	r3, [fp, #-24]
 380 02cc 003093E5 		ldr	r3, [r3]
 382 02d0 08201BE5 		ldr	r2, [fp, #-8]
 383 02d4 030052E1 		cmp	r2, r3
 384 02d8 030000DA 		ble	.L23
  96:stats.c       **** {
  97:stats.c       **** EV_min = EV_nums->EV_num;
 386 02dc 18301BE5 		ldr	r3, [fp, #-24]
 387 02e0 003093E5 		ldr	r3, [r3]
 388 02e4 08300BE5 		str	r3, [fp, #-8]
 389 02e8 070000EA 		b	.L22
 390              	.L23:
  98:stats.c       **** }
  99:stats.c       **** else
 100:stats.c       **** {
 101:stats.c       **** if ((EV_nums->EV_num>EV_max))
 392 02ec 18301BE5 		ldr	r3, [fp, #-24]
 393 02f0 003093E5 		ldr	r3, [r3]
 395 02f4 0C201BE5 		ldr	r2, [fp, #-12]
 396 02f8 030052E1 		cmp	r2, r3
 397 02fc 020000AA 		bge	.L22
 102:stats.c       **** {
 103:stats.c       **** EV_max = EV_nums->EV_num;
 399 0300 18301BE5 		ldr	r3, [fp, #-24]
 400 0304 003093E5 		ldr	r3, [r3]
 401 0308 0C300BE5 		str	r3, [fp, #-12]
 402              	.L22:
 104:stats.c       **** }
 105:stats.c       **** }
 106:stats.c       **** }
 107:stats.c       **** EV_nums = EV_nums->EV_next;
 404 030c 18301BE5 		ldr	r3, [fp, #-24]
 405 0310 043093E5 		ldr	r3, [r3, #4]
 406 0314 18300BE5 		str	r3, [fp, #-24]
 407              	.L20:
  85:stats.c       **** {
 409 0318 18301BE5 		ldr	r3, [fp, #-24]
 410 031c 000053E3 		cmp	r3, #0
 411 0320 DCFFFF1A 		bne	.L24
 108:stats.c       **** }
 109:stats.c       **** printf("%d\n", EV_min);
 413 0324 08101BE5 		ldr	r1, [fp, #-8]
 414 0328 18009FE5 		ldr	r0, .L25
 415 032c FEFFFFEB 		bl	printf
 110:stats.c       **** printf("%d\n", EV_max);
 417 0330 0C101BE5 		ldr	r1, [fp, #-12]
 418 0334 0C009FE5 		ldr	r0, .L25
 419 0338 FEFFFFEB 		bl	printf
 111:stats.c       **** }
 421 033c 0000A0E1 		nop
 422 0340 04D04BE2 		sub	sp, fp, #4
 424              		@ sp needed
 425 0344 0088BDE8 		pop	{fp, pc}
 426              	.L26:
 427              		.align	2
 428              	.L25:
 429 0348 00000000 		.word	.LC0
 431              	.LFE10:
 433              		.section	.rodata
 434              		.align	2
 435              	.LC1:
 436 0004 256400   		.ascii	"%d\000"
 437              		.text
 438              		.align	2
 439              		.global	_main
 440              		.syntax unified
 441              		.arm
 442              		.fpu vfp
 444              	_main:
 445              	.LFB11:
 112:stats.c       **** int _main()
 113:stats.c       **** {
 448              		@ args = 0, pretend = 0, frame = 16
 449              		@ frame_needed = 1, uses_anonymous_args = 0
 450 034c 00482DE9 		push	{fp, lr}
 454 0350 04B08DE2 		add	fp, sp, #4
 456 0354 10D04DE2 		sub	sp, sp, #16
 114:stats.c       **** int EV_seed;
 115:stats.c       **** int EV_num;
 116:stats.c       **** int EV_mean;
 117:stats.c       **** struct EV_linkedNums * EV_nums;
 118:stats.c       **** scanf("%d", &EV_seed);
 458 0358 10304BE2 		sub	r3, fp, #16
 459 035c 0310A0E1 		mov	r1, r3
 460 0360 60009FE5 		ldr	r0, .L29
 461 0364 FEFFFFEB 		bl	__isoc99_scanf
 119:stats.c       **** scanf("%d", &EV_num);
 463 0368 14304BE2 		sub	r3, fp, #20
 464 036c 0310A0E1 		mov	r1, r3
 465 0370 50009FE5 		ldr	r0, .L29
 466 0374 FEFFFFEB 		bl	__isoc99_scanf
 120:stats.c       **** EV_nums = _getRands(EV_seed, EV_num);
 468 0378 10301BE5 		ldr	r3, [fp, #-16]
 469 037c 14201BE5 		ldr	r2, [fp, #-20]
 470 0380 0210A0E1 		mov	r1, r2
 471 0384 0300A0E1 		mov	r0, r3
 472 0388 FEFFFFEB 		bl	_getRands
 473 038c 08000BE5 		str	r0, [fp, #-8]
 121:stats.c       **** EV_mean = _calcMean(EV_nums);
 475 0390 08001BE5 		ldr	r0, [fp, #-8]
 476 0394 FEFFFFEB 		bl	_calcMean
 477 0398 0C000BE5 		str	r0, [fp, #-12]
 122:stats.c       **** printf("%d\n", EV_mean);
 479 039c 0C101BE5 		ldr	r1, [fp, #-12]
 480 03a0 24009FE5 		ldr	r0, .L29+4
 481 03a4 FEFFFFEB 		bl	printf
 123:stats.c       **** _range(EV_nums);
 483 03a8 08001BE5 		ldr	r0, [fp, #-8]
 484 03ac FEFFFFEB 		bl	_range
 124:stats.c       **** _approxSqrtAll(EV_nums);
 486 03b0 08001BE5 		ldr	r0, [fp, #-8]
 487 03b4 FEFFFFEB 		bl	_approxSqrtAll
 125:stats.c       **** return 0;
 489 03b8 0030A0E3 		mov	r3, #0
 126:stats.c       **** }
 491 03bc 0300A0E1 		mov	r0, r3
 492 03c0 04D04BE2 		sub	sp, fp, #4
 494              		@ sp needed
 495 03c4 0088BDE8 		pop	{fp, pc}
 496              	.L30:
 497              		.align	2
 498              	.L29:
 499 03c8 04000000 		.word	.LC1
 500 03cc 00000000 		.word	.LC0
 502              	.LFE11:
 504              		.align	2
 505              		.global	main
 506              		.syntax unified
 507              		.arm
 508              		.fpu vfp
 510              	main:
 511              	.LFB12:
 127:stats.c       **** int main(void)
 128:stats.c       **** {
 514              		@ args = 0, pretend = 0, frame = 0
 515              		@ frame_needed = 1, uses_anonymous_args = 0
 516 03d0 00482DE9 		push	{fp, lr}
 520 03d4 04B08DE2 		add	fp, sp, #4
 129:stats.c       ****    return _main();
 523 03d8 FEFFFFEB 		bl	_main
 524 03dc 0030A0E1 		mov	r3, r0
 130:stats.c       **** }
 526 03e0 0300A0E1 		mov	r0, r3
 527 03e4 0088BDE8 		pop	{fp, pc}
 529              	.LFE12:
 531              	.Letext0:
