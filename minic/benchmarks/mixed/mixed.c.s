   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.comm	EV_globalfoo,4,4
  17              		.align	2
  18              		.global	_tailrecursive
  19              		.arch armv6
  20              		.syntax unified
  21              		.arm
  22              		.fpu vfp
  24              	_tailrecursive:
  25              	.LFB6:
   1:mixed.c       **** #include<stdio.h>
   2:mixed.c       **** #include<stdlib.h>
   3:mixed.c       **** struct EV_simple
   4:mixed.c       **** {
   5:mixed.c       **** int EV_one;
   6:mixed.c       **** };
   7:mixed.c       **** struct EV_foo
   8:mixed.c       **** {
   9:mixed.c       **** int EV_bar;
  10:mixed.c       **** int EV_cool;
  11:mixed.c       **** struct EV_simple * EV_simp;
  12:mixed.c       **** };
  13:mixed.c       **** struct EV_foo * EV_globalfoo;
  14:mixed.c       **** void _tailrecursive(int EV_num)
  15:mixed.c       **** {
  29              		@ args = 0, pretend = 0, frame = 8
  30              		@ frame_needed = 1, uses_anonymous_args = 0
  31 0000 00482DE9 		push	{fp, lr}
  35 0004 04B08DE2 		add	fp, sp, #4
  37 0008 08D04DE2 		sub	sp, sp, #8
  38 000c 08000BE5 		str	r0, [fp, #-8]
  16:mixed.c       **** if ((EV_num<=0))
  40 0010 08301BE5 		ldr	r3, [fp, #-8]
  41 0014 000053E3 		cmp	r3, #0
  42 0018 040000DA 		ble	.L4
  17:mixed.c       **** {
  18:mixed.c       **** return ;
  19:mixed.c       **** }
  20:mixed.c       **** _tailrecursive((EV_num-1));
  44 001c 08301BE5 		ldr	r3, [fp, #-8]
  45 0020 013043E2 		sub	r3, r3, #1
  46 0024 0300A0E1 		mov	r0, r3
  47 0028 FEFFFFEB 		bl	_tailrecursive
  48 002c 000000EA 		b	.L1
  49              	.L4:
  18:mixed.c       **** }
  51 0030 0000A0E1 		nop
  52              	.L1:
  21:mixed.c       **** }
  54 0034 04D04BE2 		sub	sp, fp, #4
  56              		@ sp needed
  57 0038 0088BDE8 		pop	{fp, pc}
  59              	.LFE6:
  61              		.align	2
  62              		.global	_add
  63              		.syntax unified
  64              		.arm
  65              		.fpu vfp
  67              	_add:
  68              	.LFB7:
  22:mixed.c       **** int _add(int EV_x,int EV_y)
  23:mixed.c       **** {
  71              		@ args = 0, pretend = 0, frame = 8
  72              		@ frame_needed = 1, uses_anonymous_args = 0
  73              		@ link register save eliminated.
  74 003c 04B02DE5 		str	fp, [sp, #-4]!
  77 0040 00B08DE2 		add	fp, sp, #0
  79 0044 0CD04DE2 		sub	sp, sp, #12
  80 0048 08000BE5 		str	r0, [fp, #-8]
  81 004c 0C100BE5 		str	r1, [fp, #-12]
  24:mixed.c       **** return (EV_x+EV_y);
  83 0050 08201BE5 		ldr	r2, [fp, #-8]
  84 0054 0C301BE5 		ldr	r3, [fp, #-12]
  85 0058 033082E0 		add	r3, r2, r3
  25:mixed.c       **** }
  87 005c 0300A0E1 		mov	r0, r3
  88 0060 00D08BE2 		add	sp, fp, #0
  90              		@ sp needed
  91 0064 04B09DE4 		ldr	fp, [sp], #4
  94 0068 1EFF2FE1 		bx	lr
  96              	.LFE7:
  99              		.align	2
 100              		.global	_domath
 101              		.syntax unified
 102              		.arm
 103              		.fpu vfp
 105              	_domath:
 106              	.LFB8:
  26:mixed.c       **** void _domath(int EV_num)
  27:mixed.c       **** {
 109              		@ args = 0, pretend = 0, frame = 24
 110              		@ frame_needed = 1, uses_anonymous_args = 0
 111 006c 00482DE9 		push	{fp, lr}
 115 0070 04B08DE2 		add	fp, sp, #4
 117 0074 18D04DE2 		sub	sp, sp, #24
 118 0078 18000BE5 		str	r0, [fp, #-24]
  28:mixed.c       **** struct EV_foo * EV_math1;
  29:mixed.c       **** struct EV_foo * EV_math2;
  30:mixed.c       **** int EV_tmp;
  31:mixed.c       **** EV_math1 = (struct EV_foo*)malloc(sizeof(struct EV_foo));
 120 007c 0C00A0E3 		mov	r0, #12
 121 0080 FEFFFFEB 		bl	malloc
 122 0084 0030A0E1 		mov	r3, r0
 123 0088 08300BE5 		str	r3, [fp, #-8]
  32:mixed.c       **** EV_math1->EV_simp = (struct EV_simple*)malloc(sizeof(struct EV_simple));
 125 008c 0400A0E3 		mov	r0, #4
 126 0090 FEFFFFEB 		bl	malloc
 127 0094 0030A0E1 		mov	r3, r0
 128 0098 0320A0E1 		mov	r2, r3
 130 009c 08301BE5 		ldr	r3, [fp, #-8]
 131 00a0 082083E5 		str	r2, [r3, #8]
  33:mixed.c       **** EV_math2 = (struct EV_foo*)malloc(sizeof(struct EV_foo));
 133 00a4 0C00A0E3 		mov	r0, #12
 134 00a8 FEFFFFEB 		bl	malloc
 135 00ac 0030A0E1 		mov	r3, r0
 136 00b0 0C300BE5 		str	r3, [fp, #-12]
  34:mixed.c       **** EV_math2->EV_simp = (struct EV_simple*)malloc(sizeof(struct EV_simple));
 138 00b4 0400A0E3 		mov	r0, #4
 139 00b8 FEFFFFEB 		bl	malloc
 140 00bc 0030A0E1 		mov	r3, r0
 141 00c0 0320A0E1 		mov	r2, r3
 143 00c4 0C301BE5 		ldr	r3, [fp, #-12]
 144 00c8 082083E5 		str	r2, [r3, #8]
  35:mixed.c       **** EV_math1->EV_bar = EV_num;
 146 00cc 08301BE5 		ldr	r3, [fp, #-8]
 147 00d0 18201BE5 		ldr	r2, [fp, #-24]
 148 00d4 002083E5 		str	r2, [r3]
  36:mixed.c       **** EV_math2->EV_bar = 3;
 150 00d8 0C301BE5 		ldr	r3, [fp, #-12]
 151 00dc 0320A0E3 		mov	r2, #3
 152 00e0 002083E5 		str	r2, [r3]
  37:mixed.c       **** EV_math1->EV_simp->EV_one = EV_math1->EV_bar;
 154 00e4 08301BE5 		ldr	r3, [fp, #-8]
 155 00e8 083093E5 		ldr	r3, [r3, #8]
 157 00ec 08201BE5 		ldr	r2, [fp, #-8]
 158 00f0 002092E5 		ldr	r2, [r2]
 160 00f4 002083E5 		str	r2, [r3]
  38:mixed.c       **** EV_math2->EV_simp->EV_one = EV_math2->EV_bar;
 162 00f8 0C301BE5 		ldr	r3, [fp, #-12]
 163 00fc 083093E5 		ldr	r3, [r3, #8]
 165 0100 0C201BE5 		ldr	r2, [fp, #-12]
 166 0104 002092E5 		ldr	r2, [r2]
 168 0108 002083E5 		str	r2, [r3]
  39:mixed.c       **** while ((EV_num>0))
 170 010c 230000EA 		b	.L8
 171              	.L9:
  40:mixed.c       **** {
  41:mixed.c       **** EV_tmp = (EV_math1->EV_bar*EV_math2->EV_bar);
 173 0110 08301BE5 		ldr	r3, [fp, #-8]
 174 0114 003093E5 		ldr	r3, [r3]
 176 0118 0C201BE5 		ldr	r2, [fp, #-12]
 177 011c 002092E5 		ldr	r2, [r2]
 179 0120 920303E0 		mul	r3, r2, r3
 180 0124 10300BE5 		str	r3, [fp, #-16]
  42:mixed.c       **** EV_tmp = ((EV_tmp*EV_math1->EV_simp->EV_one)/EV_math2->EV_bar);
 182 0128 08301BE5 		ldr	r3, [fp, #-8]
 183 012c 083093E5 		ldr	r3, [r3, #8]
 185 0130 003093E5 		ldr	r3, [r3]
 187 0134 10201BE5 		ldr	r2, [fp, #-16]
 188 0138 920302E0 		mul	r2, r2, r3
 190 013c 0C301BE5 		ldr	r3, [fp, #-12]
 191 0140 003093E5 		ldr	r3, [r3]
 193 0144 0310A0E1 		mov	r1, r3
 194 0148 0200A0E1 		mov	r0, r2
 196              	.LVL0:
 197 0150 0030A0E1 		mov	r3, r0
 198 0154 10300BE5 		str	r3, [fp, #-16]
  43:mixed.c       **** EV_tmp = _add(EV_math2->EV_simp->EV_one, EV_math1->EV_bar);
 200 0158 0C301BE5 		ldr	r3, [fp, #-12]
 201 015c 083093E5 		ldr	r3, [r3, #8]
 203 0160 002093E5 		ldr	r2, [r3]
 204 0164 08301BE5 		ldr	r3, [fp, #-8]
 205 0168 003093E5 		ldr	r3, [r3]
 206 016c 0310A0E1 		mov	r1, r3
 207 0170 0200A0E1 		mov	r0, r2
 208 0174 FEFFFFEB 		bl	_add
 209 0178 10000BE5 		str	r0, [fp, #-16]
  44:mixed.c       **** EV_tmp = (EV_math2->EV_bar-EV_math1->EV_bar);
 211 017c 0C301BE5 		ldr	r3, [fp, #-12]
 212 0180 002093E5 		ldr	r2, [r3]
 214 0184 08301BE5 		ldr	r3, [fp, #-8]
 215 0188 003093E5 		ldr	r3, [r3]
 217 018c 033042E0 		sub	r3, r2, r3
 218 0190 10300BE5 		str	r3, [fp, #-16]
  45:mixed.c       **** EV_num = (EV_num-1);
 220 0194 18301BE5 		ldr	r3, [fp, #-24]
 221 0198 013043E2 		sub	r3, r3, #1
 222 019c 18300BE5 		str	r3, [fp, #-24]
 223              	.L8:
  39:mixed.c       **** {
 225 01a0 18301BE5 		ldr	r3, [fp, #-24]
 226 01a4 000053E3 		cmp	r3, #0
 227 01a8 D8FFFFCA 		bgt	.L9
  46:mixed.c       **** }
  47:mixed.c       **** free(EV_math1);
 229 01ac 08001BE5 		ldr	r0, [fp, #-8]
 230 01b0 FEFFFFEB 		bl	free
  48:mixed.c       **** free(EV_math2);
 232 01b4 0C001BE5 		ldr	r0, [fp, #-12]
 233 01b8 FEFFFFEB 		bl	free
  49:mixed.c       **** }
 235 01bc 0000A0E1 		nop
 236 01c0 04D04BE2 		sub	sp, fp, #4
 238              		@ sp needed
 239 01c4 0088BDE8 		pop	{fp, pc}
 241              	.LFE8:
 243              		.align	2
 244              		.global	_objinstantiation
 245              		.syntax unified
 246              		.arm
 247              		.fpu vfp
 249              	_objinstantiation:
 250              	.LFB9:
  50:mixed.c       **** void _objinstantiation(int EV_num)
  51:mixed.c       **** {
 253              		@ args = 0, pretend = 0, frame = 16
 254              		@ frame_needed = 1, uses_anonymous_args = 0
 255 01c8 00482DE9 		push	{fp, lr}
 259 01cc 04B08DE2 		add	fp, sp, #4
 261 01d0 10D04DE2 		sub	sp, sp, #16
 262 01d4 10000BE5 		str	r0, [fp, #-16]
  52:mixed.c       **** struct EV_foo * EV_tmp;
  53:mixed.c       **** while ((EV_num>0))
 264 01d8 080000EA 		b	.L11
 265              	.L12:
  54:mixed.c       **** {
  55:mixed.c       **** EV_tmp = (struct EV_foo*)malloc(sizeof(struct EV_foo));
 267 01dc 0C00A0E3 		mov	r0, #12
 268 01e0 FEFFFFEB 		bl	malloc
 269 01e4 0030A0E1 		mov	r3, r0
 270 01e8 08300BE5 		str	r3, [fp, #-8]
  56:mixed.c       **** free(EV_tmp);
 272 01ec 08001BE5 		ldr	r0, [fp, #-8]
 273 01f0 FEFFFFEB 		bl	free
  57:mixed.c       **** EV_num = (EV_num-1);
 275 01f4 10301BE5 		ldr	r3, [fp, #-16]
 276 01f8 013043E2 		sub	r3, r3, #1
 277 01fc 10300BE5 		str	r3, [fp, #-16]
 278              	.L11:
  53:mixed.c       **** {
 280 0200 10301BE5 		ldr	r3, [fp, #-16]
 281 0204 000053E3 		cmp	r3, #0
 282 0208 F3FFFFCA 		bgt	.L12
  58:mixed.c       **** }
  59:mixed.c       **** }
 284 020c 0000A0E1 		nop
 285 0210 04D04BE2 		sub	sp, fp, #4
 287              		@ sp needed
 288 0214 0088BDE8 		pop	{fp, pc}
 290              	.LFE9:
 292              		.align	2
 293              		.global	_ackermann
 294              		.syntax unified
 295              		.arm
 296              		.fpu vfp
 298              	_ackermann:
 299              	.LFB10:
  60:mixed.c       **** int _ackermann(int EV_m,int EV_n)
  61:mixed.c       **** {
 302              		@ args = 0, pretend = 0, frame = 8
 303              		@ frame_needed = 1, uses_anonymous_args = 0
 304 0218 10482DE9 		push	{r4, fp, lr}
 309 021c 08B08DE2 		add	fp, sp, #8
 311 0220 0CD04DE2 		sub	sp, sp, #12
 312 0224 10000BE5 		str	r0, [fp, #-16]
 313 0228 14100BE5 		str	r1, [fp, #-20]
  62:mixed.c       **** if ((EV_m==0))
 315 022c 10301BE5 		ldr	r3, [fp, #-16]
 316 0230 000053E3 		cmp	r3, #0
 317 0234 0200001A 		bne	.L14
  63:mixed.c       **** {
  64:mixed.c       **** return (EV_n+1);
 319 0238 14301BE5 		ldr	r3, [fp, #-20]
 320 023c 013083E2 		add	r3, r3, #1
 321 0240 150000EA 		b	.L15
 322              	.L14:
  65:mixed.c       **** }
  66:mixed.c       **** if ((EV_n==0))
 324 0244 14301BE5 		ldr	r3, [fp, #-20]
 325 0248 000053E3 		cmp	r3, #0
 326 024c 0600001A 		bne	.L16
  67:mixed.c       **** {
  68:mixed.c       **** return _ackermann((EV_m-1), 1);
 328 0250 10301BE5 		ldr	r3, [fp, #-16]
 329 0254 013043E2 		sub	r3, r3, #1
 330 0258 0110A0E3 		mov	r1, #1
 331 025c 0300A0E1 		mov	r0, r3
 332 0260 FEFFFFEB 		bl	_ackermann
 333 0264 0030A0E1 		mov	r3, r0
 334 0268 0B0000EA 		b	.L15
 335              	.L16:
  69:mixed.c       **** }
  70:mixed.c       **** else
  71:mixed.c       **** {
  72:mixed.c       **** return _ackermann((EV_m-1), _ackermann(EV_m, (EV_n-1)));
 337 026c 10301BE5 		ldr	r3, [fp, #-16]
 338 0270 014043E2 		sub	r4, r3, #1
 339 0274 14301BE5 		ldr	r3, [fp, #-20]
 340 0278 013043E2 		sub	r3, r3, #1
 341 027c 0310A0E1 		mov	r1, r3
 342 0280 10001BE5 		ldr	r0, [fp, #-16]
 343 0284 FEFFFFEB 		bl	_ackermann
 344 0288 0030A0E1 		mov	r3, r0
 345 028c 0310A0E1 		mov	r1, r3
 346 0290 0400A0E1 		mov	r0, r4
 347 0294 FEFFFFEB 		bl	_ackermann
 348 0298 0030A0E1 		mov	r3, r0
 349              	.L15:
  73:mixed.c       **** }
  74:mixed.c       **** }
 351 029c 0300A0E1 		mov	r0, r3
 352 02a0 08D04BE2 		sub	sp, fp, #8
 354              		@ sp needed
 355 02a4 1088BDE8 		pop	{r4, fp, pc}
 357              	.LFE10:
 359              		.section	.rodata
 360              		.align	2
 361              	.LC0:
 362 0000 256400   		.ascii	"%d\000"
 363 0003 00       		.align	2
 364              	.LC1:
 365 0004 25640A00 		.ascii	"%d\012\000"
 366              		.text
 367              		.align	2
 368              		.global	_main
 369              		.syntax unified
 370              		.arm
 371              		.fpu vfp
 373              	_main:
 374              	.LFB11:
  75:mixed.c       **** int _main()
  76:mixed.c       **** {
 377              		@ args = 0, pretend = 0, frame = 24
 378              		@ frame_needed = 1, uses_anonymous_args = 0
 379 02a8 00482DE9 		push	{fp, lr}
 383 02ac 04B08DE2 		add	fp, sp, #4
 385 02b0 18D04DE2 		sub	sp, sp, #24
  77:mixed.c       **** int EV_a;
  78:mixed.c       **** int EV_b;
  79:mixed.c       **** int EV_c;
  80:mixed.c       **** int EV_d;
  81:mixed.c       **** int EV_e;
  82:mixed.c       **** scanf("%d", &EV_a);
 387 02b4 08304BE2 		sub	r3, fp, #8
 388 02b8 0310A0E1 		mov	r1, r3
 389 02bc C8009FE5 		ldr	r0, .L19
 390 02c0 FEFFFFEB 		bl	__isoc99_scanf
  83:mixed.c       **** scanf("%d", &EV_b);
 392 02c4 0C304BE2 		sub	r3, fp, #12
 393 02c8 0310A0E1 		mov	r1, r3
 394 02cc B8009FE5 		ldr	r0, .L19
 395 02d0 FEFFFFEB 		bl	__isoc99_scanf
  84:mixed.c       **** scanf("%d", &EV_c);
 397 02d4 10304BE2 		sub	r3, fp, #16
 398 02d8 0310A0E1 		mov	r1, r3
 399 02dc A8009FE5 		ldr	r0, .L19
 400 02e0 FEFFFFEB 		bl	__isoc99_scanf
  85:mixed.c       **** scanf("%d", &EV_d);
 402 02e4 14304BE2 		sub	r3, fp, #20
 403 02e8 0310A0E1 		mov	r1, r3
 404 02ec 98009FE5 		ldr	r0, .L19
 405 02f0 FEFFFFEB 		bl	__isoc99_scanf
  86:mixed.c       **** scanf("%d", &EV_e);
 407 02f4 18304BE2 		sub	r3, fp, #24
 408 02f8 0310A0E1 		mov	r1, r3
 409 02fc 88009FE5 		ldr	r0, .L19
 410 0300 FEFFFFEB 		bl	__isoc99_scanf
  87:mixed.c       **** _tailrecursive(EV_a);
 412 0304 08301BE5 		ldr	r3, [fp, #-8]
 413 0308 0300A0E1 		mov	r0, r3
 414 030c FEFFFFEB 		bl	_tailrecursive
  88:mixed.c       **** printf("%d\n", EV_a);
 416 0310 08301BE5 		ldr	r3, [fp, #-8]
 417 0314 0310A0E1 		mov	r1, r3
 418 0318 70009FE5 		ldr	r0, .L19+4
 419 031c FEFFFFEB 		bl	printf
  89:mixed.c       **** _domath(EV_b);
 421 0320 0C301BE5 		ldr	r3, [fp, #-12]
 422 0324 0300A0E1 		mov	r0, r3
 423 0328 FEFFFFEB 		bl	_domath
  90:mixed.c       **** printf("%d\n", EV_b);
 425 032c 0C301BE5 		ldr	r3, [fp, #-12]
 426 0330 0310A0E1 		mov	r1, r3
 427 0334 54009FE5 		ldr	r0, .L19+4
 428 0338 FEFFFFEB 		bl	printf
  91:mixed.c       **** _objinstantiation(EV_c);
 430 033c 10301BE5 		ldr	r3, [fp, #-16]
 431 0340 0300A0E1 		mov	r0, r3
 432 0344 FEFFFFEB 		bl	_objinstantiation
  92:mixed.c       **** printf("%d\n", EV_c);
 434 0348 10301BE5 		ldr	r3, [fp, #-16]
 435 034c 0310A0E1 		mov	r1, r3
 436 0350 38009FE5 		ldr	r0, .L19+4
 437 0354 FEFFFFEB 		bl	printf
  93:mixed.c       **** printf("%d\n", _ackermann(EV_d, EV_e));
 439 0358 14301BE5 		ldr	r3, [fp, #-20]
 440 035c 18201BE5 		ldr	r2, [fp, #-24]
 441 0360 0210A0E1 		mov	r1, r2
 442 0364 0300A0E1 		mov	r0, r3
 443 0368 FEFFFFEB 		bl	_ackermann
 444 036c 0030A0E1 		mov	r3, r0
 445 0370 0310A0E1 		mov	r1, r3
 446 0374 14009FE5 		ldr	r0, .L19+4
 447 0378 FEFFFFEB 		bl	printf
  94:mixed.c       **** return 0;
 449 037c 0030A0E3 		mov	r3, #0
  95:mixed.c       **** }
 451 0380 0300A0E1 		mov	r0, r3
 452 0384 04D04BE2 		sub	sp, fp, #4
 454              		@ sp needed
 455 0388 0088BDE8 		pop	{fp, pc}
 456              	.L20:
 457              		.align	2
 458              	.L19:
 459 038c 00000000 		.word	.LC0
 460 0390 04000000 		.word	.LC1
 462              	.LFE11:
 464              		.align	2
 465              		.global	main
 466              		.syntax unified
 467              		.arm
 468              		.fpu vfp
 470              	main:
 471              	.LFB12:
  96:mixed.c       **** int main(void)
  97:mixed.c       **** {
 474              		@ args = 0, pretend = 0, frame = 0
 475              		@ frame_needed = 1, uses_anonymous_args = 0
 476 0394 00482DE9 		push	{fp, lr}
 480 0398 04B08DE2 		add	fp, sp, #4
  98:mixed.c       ****    return _main();
 483 039c FEFFFFEB 		bl	_main
 484 03a0 0030A0E1 		mov	r3, r0
  99:mixed.c       **** }
 486 03a4 0300A0E1 		mov	r0, r3
 487 03a8 0088BDE8 		pop	{fp, pc}
 489              	.LFE12:
 491              	.Letext0:
