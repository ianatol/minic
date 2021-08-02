   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.comm	EV_gi1,4,4
  17              		.comm	EV_gb1,4,4
  18              		.comm	EV_gs1,4,4
  19              		.comm	EV_counter,4,4
  20              		.section	.rodata
  21              		.align	2
  22              	.LC0:
  23 0000 25642000 		.ascii	"%d \000"
  24              		.align	2
  25              	.LC1:
  26 0004 25640A00 		.ascii	"%d\012\000"
  27              		.text
  28              		.align	2
  29              		.global	_printgroup
  30              		.arch armv6
  31              		.syntax unified
  32              		.arm
  33              		.fpu vfp
  35              	_printgroup:
  36              	.LFB6:
   1:brett.c       **** #include<stdio.h>
   2:brett.c       **** #include<stdlib.h>
   3:brett.c       **** struct EV_thing
   4:brett.c       **** {
   5:brett.c       **** int EV_i;
   6:brett.c       **** int EV_b;
   7:brett.c       **** struct EV_thing * EV_s;
   8:brett.c       **** };
   9:brett.c       **** int EV_gi1;
  10:brett.c       **** int EV_gb1;
  11:brett.c       **** struct EV_thing * EV_gs1;
  12:brett.c       **** int EV_counter;
  13:brett.c       **** void _printgroup(int EV_groupnum)
  14:brett.c       **** {
  40              		@ args = 0, pretend = 0, frame = 8
  41              		@ frame_needed = 1, uses_anonymous_args = 0
  42 0000 00482DE9 		push	{fp, lr}
  46 0004 04B08DE2 		add	fp, sp, #4
  48 0008 08D04DE2 		sub	sp, sp, #8
  49 000c 08000BE5 		str	r0, [fp, #-8]
  15:brett.c       **** printf("%d ", 1);
  51 0010 0110A0E3 		mov	r1, #1
  52 0014 54009FE5 		ldr	r0, .L3
  53 0018 FEFFFFEB 		bl	printf
  16:brett.c       **** printf("%d ", 0);
  55 001c 0010A0E3 		mov	r1, #0
  56 0020 48009FE5 		ldr	r0, .L3
  57 0024 FEFFFFEB 		bl	printf
  17:brett.c       **** printf("%d ", 1);
  59 0028 0110A0E3 		mov	r1, #1
  60 002c 3C009FE5 		ldr	r0, .L3
  61 0030 FEFFFFEB 		bl	printf
  18:brett.c       **** printf("%d ", 0);
  63 0034 0010A0E3 		mov	r1, #0
  64 0038 30009FE5 		ldr	r0, .L3
  65 003c FEFFFFEB 		bl	printf
  19:brett.c       **** printf("%d ", 1);
  67 0040 0110A0E3 		mov	r1, #1
  68 0044 24009FE5 		ldr	r0, .L3
  69 0048 FEFFFFEB 		bl	printf
  20:brett.c       **** printf("%d ", 0);
  71 004c 0010A0E3 		mov	r1, #0
  72 0050 18009FE5 		ldr	r0, .L3
  73 0054 FEFFFFEB 		bl	printf
  21:brett.c       **** printf("%d\n", EV_groupnum);
  75 0058 08101BE5 		ldr	r1, [fp, #-8]
  76 005c 10009FE5 		ldr	r0, .L3+4
  77 0060 FEFFFFEB 		bl	printf
  22:brett.c       **** return ;
  79 0064 0000A0E1 		nop
  23:brett.c       **** }
  81 0068 04D04BE2 		sub	sp, fp, #4
  83              		@ sp needed
  84 006c 0088BDE8 		pop	{fp, pc}
  85              	.L4:
  86              		.align	2
  87              	.L3:
  88 0070 00000000 		.word	.LC0
  89 0074 04000000 		.word	.LC1
  91              	.LFE6:
  93              		.align	2
  94              		.global	_setcounter
  95              		.syntax unified
  96              		.arm
  97              		.fpu vfp
  99              	_setcounter:
 100              	.LFB7:
  24:brett.c       **** int _setcounter(int EV_val)
  25:brett.c       **** {
 103              		@ args = 0, pretend = 0, frame = 8
 104              		@ frame_needed = 1, uses_anonymous_args = 0
 105              		@ link register save eliminated.
 106 0078 04B02DE5 		str	fp, [sp, #-4]!
 109 007c 00B08DE2 		add	fp, sp, #0
 111 0080 0CD04DE2 		sub	sp, sp, #12
 112 0084 08000BE5 		str	r0, [fp, #-8]
  26:brett.c       **** EV_counter = EV_val;
 114 0088 18209FE5 		ldr	r2, .L7
 115 008c 08301BE5 		ldr	r3, [fp, #-8]
 116 0090 003082E5 		str	r3, [r2]
  27:brett.c       **** return 1;
 118 0094 0130A0E3 		mov	r3, #1
  28:brett.c       **** }
 120 0098 0300A0E1 		mov	r0, r3
 121 009c 00D08BE2 		add	sp, fp, #0
 123              		@ sp needed
 124 00a0 04B09DE4 		ldr	fp, [sp], #4
 127 00a4 1EFF2FE1 		bx	lr
 128              	.L8:
 129              		.align	2
 130              	.L7:
 131 00a8 00000000 		.word	EV_counter
 133              	.LFE7:
 135              		.align	2
 136              		.global	_takealltypes
 137              		.syntax unified
 138              		.arm
 139              		.fpu vfp
 141              	_takealltypes:
 142              	.LFB8:
  29:brett.c       **** void _takealltypes(int EV_i,int EV_b,struct EV_thing * EV_s)
  30:brett.c       **** {
 145              		@ args = 0, pretend = 0, frame = 16
 146              		@ frame_needed = 1, uses_anonymous_args = 0
 147 00ac 00482DE9 		push	{fp, lr}
 151 00b0 04B08DE2 		add	fp, sp, #4
 153 00b4 10D04DE2 		sub	sp, sp, #16
 154 00b8 08000BE5 		str	r0, [fp, #-8]
 155 00bc 0C100BE5 		str	r1, [fp, #-12]
 156 00c0 10200BE5 		str	r2, [fp, #-16]
  31:brett.c       **** if ((EV_i==3))
 158 00c4 08301BE5 		ldr	r3, [fp, #-8]
 159 00c8 030053E3 		cmp	r3, #3
 160 00cc 0300001A 		bne	.L10
  32:brett.c       **** {
  33:brett.c       **** printf("%d\n", 1);
 162 00d0 0110A0E3 		mov	r1, #1
 163 00d4 70009FE5 		ldr	r0, .L17
 164 00d8 FEFFFFEB 		bl	printf
 165 00dc 020000EA 		b	.L11
 166              	.L10:
  34:brett.c       **** }
  35:brett.c       **** else
  36:brett.c       **** {
  37:brett.c       **** printf("%d\n", 0);
 168 00e0 0010A0E3 		mov	r1, #0
 169 00e4 60009FE5 		ldr	r0, .L17
 170 00e8 FEFFFFEB 		bl	printf
 171              	.L11:
  38:brett.c       **** }
  39:brett.c       **** if (EV_b)
 173 00ec 0C301BE5 		ldr	r3, [fp, #-12]
 174 00f0 000053E3 		cmp	r3, #0
 175 00f4 0300000A 		beq	.L12
  40:brett.c       **** {
  41:brett.c       **** printf("%d\n", 1);
 177 00f8 0110A0E3 		mov	r1, #1
 178 00fc 48009FE5 		ldr	r0, .L17
 179 0100 FEFFFFEB 		bl	printf
 180 0104 020000EA 		b	.L13
 181              	.L12:
  42:brett.c       **** }
  43:brett.c       **** else
  44:brett.c       **** {
  45:brett.c       **** printf("%d\n", 0);
 183 0108 0010A0E3 		mov	r1, #0
 184 010c 38009FE5 		ldr	r0, .L17
 185 0110 FEFFFFEB 		bl	printf
 186              	.L13:
  46:brett.c       **** }
  47:brett.c       **** if (EV_s->EV_b)
 188 0114 10301BE5 		ldr	r3, [fp, #-16]
 189 0118 043093E5 		ldr	r3, [r3, #4]
 191 011c 000053E3 		cmp	r3, #0
 192 0120 0300000A 		beq	.L14
  48:brett.c       **** {
  49:brett.c       **** printf("%d\n", 1);
 194 0124 0110A0E3 		mov	r1, #1
 195 0128 1C009FE5 		ldr	r0, .L17
 196 012c FEFFFFEB 		bl	printf
  50:brett.c       **** }
  51:brett.c       **** else
  52:brett.c       **** {
  53:brett.c       **** printf("%d\n", 0);
  54:brett.c       **** }
  55:brett.c       **** }
 198 0130 020000EA 		b	.L16
 199              	.L14:
  53:brett.c       **** }
 201 0134 0010A0E3 		mov	r1, #0
 202 0138 0C009FE5 		ldr	r0, .L17
 203 013c FEFFFFEB 		bl	printf
 204              	.L16:
 206 0140 0000A0E1 		nop
 207 0144 04D04BE2 		sub	sp, fp, #4
 209              		@ sp needed
 210 0148 0088BDE8 		pop	{fp, pc}
 211              	.L18:
 212              		.align	2
 213              	.L17:
 214 014c 04000000 		.word	.LC1
 216              	.LFE8:
 218              		.align	2
 219              		.global	_tonofargs
 220              		.syntax unified
 221              		.arm
 222              		.fpu vfp
 224              	_tonofargs:
 225              	.LFB9:
  56:brett.c       **** void _tonofargs(int EV_a1,int EV_a2,int EV_a3,int EV_a4,int EV_a5,int EV_a6,int EV_a7,int EV_a8)
  57:brett.c       **** {
 228              		@ args = 16, pretend = 0, frame = 16
 229              		@ frame_needed = 1, uses_anonymous_args = 0
 230 0150 00482DE9 		push	{fp, lr}
 234 0154 04B08DE2 		add	fp, sp, #4
 236 0158 10D04DE2 		sub	sp, sp, #16
 237 015c 08000BE5 		str	r0, [fp, #-8]
 238 0160 0C100BE5 		str	r1, [fp, #-12]
 239 0164 10200BE5 		str	r2, [fp, #-16]
 240 0168 14300BE5 		str	r3, [fp, #-20]
  58:brett.c       **** if ((EV_a5==5))
 242 016c 04309BE5 		ldr	r3, [fp, #4]
 243 0170 050053E3 		cmp	r3, #5
 244 0174 0300001A 		bne	.L20
  59:brett.c       **** {
  60:brett.c       **** printf("%d\n", 1);
 246 0178 0110A0E3 		mov	r1, #1
 247 017c C4009FE5 		ldr	r0, .L29
 248 0180 FEFFFFEB 		bl	printf
 249 0184 050000EA 		b	.L21
 250              	.L20:
  61:brett.c       **** }
  62:brett.c       **** else
  63:brett.c       **** {
  64:brett.c       **** printf("%d ", 0);
 252 0188 0010A0E3 		mov	r1, #0
 253 018c B8009FE5 		ldr	r0, .L29+4
 254 0190 FEFFFFEB 		bl	printf
  65:brett.c       **** printf("%d\n", EV_a5);
 256 0194 04109BE5 		ldr	r1, [fp, #4]
 257 0198 A8009FE5 		ldr	r0, .L29
 258 019c FEFFFFEB 		bl	printf
 259              	.L21:
  66:brett.c       **** }
  67:brett.c       **** if ((EV_a6==6))
 261 01a0 08309BE5 		ldr	r3, [fp, #8]
 262 01a4 060053E3 		cmp	r3, #6
 263 01a8 0300001A 		bne	.L22
  68:brett.c       **** {
  69:brett.c       **** printf("%d\n", 1);
 265 01ac 0110A0E3 		mov	r1, #1
 266 01b0 90009FE5 		ldr	r0, .L29
 267 01b4 FEFFFFEB 		bl	printf
 268 01b8 050000EA 		b	.L23
 269              	.L22:
  70:brett.c       **** }
  71:brett.c       **** else
  72:brett.c       **** {
  73:brett.c       **** printf("%d ", 0);
 271 01bc 0010A0E3 		mov	r1, #0
 272 01c0 84009FE5 		ldr	r0, .L29+4
 273 01c4 FEFFFFEB 		bl	printf
  74:brett.c       **** printf("%d\n", EV_a6);
 275 01c8 08109BE5 		ldr	r1, [fp, #8]
 276 01cc 74009FE5 		ldr	r0, .L29
 277 01d0 FEFFFFEB 		bl	printf
 278              	.L23:
  75:brett.c       **** }
  76:brett.c       **** if ((EV_a7==7))
 280 01d4 0C309BE5 		ldr	r3, [fp, #12]
 281 01d8 070053E3 		cmp	r3, #7
 282 01dc 0300001A 		bne	.L24
  77:brett.c       **** {
  78:brett.c       **** printf("%d\n", 1);
 284 01e0 0110A0E3 		mov	r1, #1
 285 01e4 5C009FE5 		ldr	r0, .L29
 286 01e8 FEFFFFEB 		bl	printf
 287 01ec 050000EA 		b	.L25
 288              	.L24:
  79:brett.c       **** }
  80:brett.c       **** else
  81:brett.c       **** {
  82:brett.c       **** printf("%d ", 0);
 290 01f0 0010A0E3 		mov	r1, #0
 291 01f4 50009FE5 		ldr	r0, .L29+4
 292 01f8 FEFFFFEB 		bl	printf
  83:brett.c       **** printf("%d\n", EV_a7);
 294 01fc 0C109BE5 		ldr	r1, [fp, #12]
 295 0200 40009FE5 		ldr	r0, .L29
 296 0204 FEFFFFEB 		bl	printf
 297              	.L25:
  84:brett.c       **** }
  85:brett.c       **** if ((EV_a8==8))
 299 0208 10309BE5 		ldr	r3, [fp, #16]
 300 020c 080053E3 		cmp	r3, #8
 301 0210 0300001A 		bne	.L26
  86:brett.c       **** {
  87:brett.c       **** printf("%d\n", 1);
 303 0214 0110A0E3 		mov	r1, #1
 304 0218 28009FE5 		ldr	r0, .L29
 305 021c FEFFFFEB 		bl	printf
  88:brett.c       **** }
  89:brett.c       **** else
  90:brett.c       **** {
  91:brett.c       **** printf("%d ", 0);
  92:brett.c       **** printf("%d\n", EV_a8);
  93:brett.c       **** }
  94:brett.c       **** }
 307 0220 050000EA 		b	.L28
 308              	.L26:
  91:brett.c       **** printf("%d\n", EV_a8);
 310 0224 0010A0E3 		mov	r1, #0
 311 0228 1C009FE5 		ldr	r0, .L29+4
 312 022c FEFFFFEB 		bl	printf
  92:brett.c       **** }
 314 0230 10109BE5 		ldr	r1, [fp, #16]
 315 0234 0C009FE5 		ldr	r0, .L29
 316 0238 FEFFFFEB 		bl	printf
 317              	.L28:
 319 023c 0000A0E1 		nop
 320 0240 04D04BE2 		sub	sp, fp, #4
 322              		@ sp needed
 323 0244 0088BDE8 		pop	{fp, pc}
 324              	.L30:
 325              		.align	2
 326              	.L29:
 327 0248 04000000 		.word	.LC1
 328 024c 00000000 		.word	.LC0
 330              	.LFE9:
 332              		.align	2
 333              		.global	_returnint
 334              		.syntax unified
 335              		.arm
 336              		.fpu vfp
 338              	_returnint:
 339              	.LFB10:
  95:brett.c       **** int _returnint(int EV_ret)
  96:brett.c       **** {
 342              		@ args = 0, pretend = 0, frame = 8
 343              		@ frame_needed = 1, uses_anonymous_args = 0
 344              		@ link register save eliminated.
 345 0250 04B02DE5 		str	fp, [sp, #-4]!
 348 0254 00B08DE2 		add	fp, sp, #0
 350 0258 0CD04DE2 		sub	sp, sp, #12
 351 025c 08000BE5 		str	r0, [fp, #-8]
  97:brett.c       **** return EV_ret;
 353 0260 08301BE5 		ldr	r3, [fp, #-8]
  98:brett.c       **** }
 355 0264 0300A0E1 		mov	r0, r3
 356 0268 00D08BE2 		add	sp, fp, #0
 358              		@ sp needed
 359 026c 04B09DE4 		ldr	fp, [sp], #4
 362 0270 1EFF2FE1 		bx	lr
 364              	.LFE10:
 366              		.align	2
 367              		.global	_returnbool
 368              		.syntax unified
 369              		.arm
 370              		.fpu vfp
 372              	_returnbool:
 373              	.LFB11:
  99:brett.c       **** int _returnbool(int EV_ret)
 100:brett.c       **** {
 376              		@ args = 0, pretend = 0, frame = 8
 377              		@ frame_needed = 1, uses_anonymous_args = 0
 378              		@ link register save eliminated.
 379 0274 04B02DE5 		str	fp, [sp, #-4]!
 382 0278 00B08DE2 		add	fp, sp, #0
 384 027c 0CD04DE2 		sub	sp, sp, #12
 385 0280 08000BE5 		str	r0, [fp, #-8]
 101:brett.c       **** return EV_ret;
 387 0284 08301BE5 		ldr	r3, [fp, #-8]
 102:brett.c       **** }
 389 0288 0300A0E1 		mov	r0, r3
 390 028c 00D08BE2 		add	sp, fp, #0
 392              		@ sp needed
 393 0290 04B09DE4 		ldr	fp, [sp], #4
 396 0294 1EFF2FE1 		bx	lr
 398              	.LFE11:
 400              		.align	2
 401              		.global	_returnstruct
 402              		.syntax unified
 403              		.arm
 404              		.fpu vfp
 406              	_returnstruct:
 407              	.LFB12:
 103:brett.c       **** struct EV_thing * _returnstruct(struct EV_thing * EV_ret)
 104:brett.c       **** {
 410              		@ args = 0, pretend = 0, frame = 8
 411              		@ frame_needed = 1, uses_anonymous_args = 0
 412              		@ link register save eliminated.
 413 0298 04B02DE5 		str	fp, [sp, #-4]!
 416 029c 00B08DE2 		add	fp, sp, #0
 418 02a0 0CD04DE2 		sub	sp, sp, #12
 419 02a4 08000BE5 		str	r0, [fp, #-8]
 105:brett.c       **** return EV_ret;
 421 02a8 08301BE5 		ldr	r3, [fp, #-8]
 106:brett.c       **** }
 423 02ac 0300A0E1 		mov	r0, r3
 424 02b0 00D08BE2 		add	sp, fp, #0
 426              		@ sp needed
 427 02b4 04B09DE4 		ldr	fp, [sp], #4
 430 02b8 1EFF2FE1 		bx	lr
 432              	.LFE12:
 434              		.align	2
 435              		.global	_main
 436              		.syntax unified
 437              		.arm
 438              		.fpu vfp
 440              	_main:
 441              	.LFB13:
 107:brett.c       **** int _main()
 108:brett.c       **** {
 444              		@ args = 0, pretend = 0, frame = 32
 445              		@ frame_needed = 1, uses_anonymous_args = 0
 446 02bc 10482DE9 		push	{r4, fp, lr}
 451 02c0 08B08DE2 		add	fp, sp, #8
 453 02c4 34D04DE2 		sub	sp, sp, #52
 109:brett.c       **** int EV_b1;
 110:brett.c       **** int EV_b2;
 111:brett.c       **** int EV_i1;
 112:brett.c       **** int EV_i2;
 113:brett.c       **** int EV_i3;
 114:brett.c       **** struct EV_thing * EV_s1;
 115:brett.c       **** struct EV_thing * EV_s2;
 116:brett.c       **** EV_counter = 0;
 455 02c8 F8399FE5 		ldr	r3, .L107
 456 02cc 0020A0E3 		mov	r2, #0
 457 02d0 002083E5 		str	r2, [r3]
 117:brett.c       **** _printgroup(1);
 459 02d4 0100A0E3 		mov	r0, #1
 460 02d8 FEFFFFEB 		bl	_printgroup
 118:brett.c       **** EV_b1 = 0;
 462 02dc 0030A0E3 		mov	r3, #0
 463 02e0 14300BE5 		str	r3, [fp, #-20]
 119:brett.c       **** EV_b2 = 0;
 465 02e4 0030A0E3 		mov	r3, #0
 466 02e8 18300BE5 		str	r3, [fp, #-24]
 120:brett.c       **** if ((EV_b1&&EV_b2))
 468 02ec 14301BE5 		ldr	r3, [fp, #-20]
 469 02f0 000053E3 		cmp	r3, #0
 470 02f4 0600000A 		beq	.L38
 472 02f8 18301BE5 		ldr	r3, [fp, #-24]
 473 02fc 000053E3 		cmp	r3, #0
 474 0300 0300000A 		beq	.L38
 121:brett.c       **** {
 122:brett.c       **** printf("%d\n", 0);
 476 0304 0010A0E3 		mov	r1, #0
 477 0308 BC099FE5 		ldr	r0, .L107+4
 478 030c FEFFFFEB 		bl	printf
 479 0310 020000EA 		b	.L39
 480              	.L38:
 123:brett.c       **** }
 124:brett.c       **** else
 125:brett.c       **** {
 126:brett.c       **** printf("%d\n", 1);
 482 0314 0110A0E3 		mov	r1, #1
 483 0318 AC099FE5 		ldr	r0, .L107+4
 484 031c FEFFFFEB 		bl	printf
 485              	.L39:
 127:brett.c       **** }
 128:brett.c       **** EV_b1 = 1;
 487 0320 0130A0E3 		mov	r3, #1
 488 0324 14300BE5 		str	r3, [fp, #-20]
 129:brett.c       **** EV_b2 = 0;
 490 0328 0030A0E3 		mov	r3, #0
 491 032c 18300BE5 		str	r3, [fp, #-24]
 130:brett.c       **** if ((EV_b1&&EV_b2))
 493 0330 14301BE5 		ldr	r3, [fp, #-20]
 494 0334 000053E3 		cmp	r3, #0
 495 0338 0600000A 		beq	.L40
 497 033c 18301BE5 		ldr	r3, [fp, #-24]
 498 0340 000053E3 		cmp	r3, #0
 499 0344 0300000A 		beq	.L40
 131:brett.c       **** {
 132:brett.c       **** printf("%d\n", 0);
 501 0348 0010A0E3 		mov	r1, #0
 502 034c 78099FE5 		ldr	r0, .L107+4
 503 0350 FEFFFFEB 		bl	printf
 504 0354 020000EA 		b	.L41
 505              	.L40:
 133:brett.c       **** }
 134:brett.c       **** else
 135:brett.c       **** {
 136:brett.c       **** printf("%d\n", 1);
 507 0358 0110A0E3 		mov	r1, #1
 508 035c 68099FE5 		ldr	r0, .L107+4
 509 0360 FEFFFFEB 		bl	printf
 510              	.L41:
 137:brett.c       **** }
 138:brett.c       **** EV_b1 = 0;
 512 0364 0030A0E3 		mov	r3, #0
 513 0368 14300BE5 		str	r3, [fp, #-20]
 139:brett.c       **** EV_b2 = 1;
 515 036c 0130A0E3 		mov	r3, #1
 516 0370 18300BE5 		str	r3, [fp, #-24]
 140:brett.c       **** if ((EV_b1&&EV_b2))
 518 0374 14301BE5 		ldr	r3, [fp, #-20]
 519 0378 000053E3 		cmp	r3, #0
 520 037c 0600000A 		beq	.L42
 522 0380 18301BE5 		ldr	r3, [fp, #-24]
 523 0384 000053E3 		cmp	r3, #0
 524 0388 0300000A 		beq	.L42
 141:brett.c       **** {
 142:brett.c       **** printf("%d\n", 0);
 526 038c 0010A0E3 		mov	r1, #0
 527 0390 34099FE5 		ldr	r0, .L107+4
 528 0394 FEFFFFEB 		bl	printf
 529 0398 020000EA 		b	.L43
 530              	.L42:
 143:brett.c       **** }
 144:brett.c       **** else
 145:brett.c       **** {
 146:brett.c       **** printf("%d\n", 1);
 532 039c 0110A0E3 		mov	r1, #1
 533 03a0 24099FE5 		ldr	r0, .L107+4
 534 03a4 FEFFFFEB 		bl	printf
 535              	.L43:
 147:brett.c       **** }
 148:brett.c       **** EV_b1 = 1;
 537 03a8 0130A0E3 		mov	r3, #1
 538 03ac 14300BE5 		str	r3, [fp, #-20]
 149:brett.c       **** EV_b2 = 1;
 540 03b0 0130A0E3 		mov	r3, #1
 541 03b4 18300BE5 		str	r3, [fp, #-24]
 150:brett.c       **** if ((EV_b1&&EV_b2))
 543 03b8 14301BE5 		ldr	r3, [fp, #-20]
 544 03bc 000053E3 		cmp	r3, #0
 545 03c0 0600000A 		beq	.L44
 547 03c4 18301BE5 		ldr	r3, [fp, #-24]
 548 03c8 000053E3 		cmp	r3, #0
 549 03cc 0300000A 		beq	.L44
 151:brett.c       **** {
 152:brett.c       **** printf("%d\n", 1);
 551 03d0 0110A0E3 		mov	r1, #1
 552 03d4 F0089FE5 		ldr	r0, .L107+4
 553 03d8 FEFFFFEB 		bl	printf
 554 03dc 020000EA 		b	.L45
 555              	.L44:
 153:brett.c       **** }
 154:brett.c       **** else
 155:brett.c       **** {
 156:brett.c       **** printf("%d\n", 0);
 557 03e0 0010A0E3 		mov	r1, #0
 558 03e4 E0089FE5 		ldr	r0, .L107+4
 559 03e8 FEFFFFEB 		bl	printf
 560              	.L45:
 157:brett.c       **** }
 158:brett.c       **** EV_counter = 0;
 562 03ec D4389FE5 		ldr	r3, .L107
 563 03f0 0020A0E3 		mov	r2, #0
 564 03f4 002083E5 		str	r2, [r3]
 159:brett.c       **** _printgroup(2);
 566 03f8 0200A0E3 		mov	r0, #2
 567 03fc FEFFFFEB 		bl	_printgroup
 160:brett.c       **** EV_b1 = 1;
 569 0400 0130A0E3 		mov	r3, #1
 570 0404 14300BE5 		str	r3, [fp, #-20]
 161:brett.c       **** EV_b2 = 1;
 572 0408 0130A0E3 		mov	r3, #1
 573 040c 18300BE5 		str	r3, [fp, #-24]
 162:brett.c       **** if ((EV_b1||EV_b2))
 575 0410 14301BE5 		ldr	r3, [fp, #-20]
 576 0414 000053E3 		cmp	r3, #0
 577 0418 0200001A 		bne	.L46
 579 041c 18301BE5 		ldr	r3, [fp, #-24]
 580 0420 000053E3 		cmp	r3, #0
 581 0424 0300000A 		beq	.L47
 582              	.L46:
 163:brett.c       **** {
 164:brett.c       **** printf("%d\n", 1);
 584 0428 0110A0E3 		mov	r1, #1
 585 042c 98089FE5 		ldr	r0, .L107+4
 586 0430 FEFFFFEB 		bl	printf
 587 0434 020000EA 		b	.L48
 588              	.L47:
 165:brett.c       **** }
 166:brett.c       **** else
 167:brett.c       **** {
 168:brett.c       **** printf("%d\n", 0);
 590 0438 0010A0E3 		mov	r1, #0
 591 043c 88089FE5 		ldr	r0, .L107+4
 592 0440 FEFFFFEB 		bl	printf
 593              	.L48:
 169:brett.c       **** }
 170:brett.c       **** EV_b1 = 1;
 595 0444 0130A0E3 		mov	r3, #1
 596 0448 14300BE5 		str	r3, [fp, #-20]
 171:brett.c       **** EV_b2 = 0;
 598 044c 0030A0E3 		mov	r3, #0
 599 0450 18300BE5 		str	r3, [fp, #-24]
 172:brett.c       **** if ((EV_b1||EV_b2))
 601 0454 14301BE5 		ldr	r3, [fp, #-20]
 602 0458 000053E3 		cmp	r3, #0
 603 045c 0200001A 		bne	.L49
 605 0460 18301BE5 		ldr	r3, [fp, #-24]
 606 0464 000053E3 		cmp	r3, #0
 607 0468 0300000A 		beq	.L50
 608              	.L49:
 173:brett.c       **** {
 174:brett.c       **** printf("%d\n", 1);
 610 046c 0110A0E3 		mov	r1, #1
 611 0470 54089FE5 		ldr	r0, .L107+4
 612 0474 FEFFFFEB 		bl	printf
 613 0478 020000EA 		b	.L51
 614              	.L50:
 175:brett.c       **** }
 176:brett.c       **** else
 177:brett.c       **** {
 178:brett.c       **** printf("%d\n", 0);
 616 047c 0010A0E3 		mov	r1, #0
 617 0480 44089FE5 		ldr	r0, .L107+4
 618 0484 FEFFFFEB 		bl	printf
 619              	.L51:
 179:brett.c       **** }
 180:brett.c       **** EV_b1 = 0;
 621 0488 0030A0E3 		mov	r3, #0
 622 048c 14300BE5 		str	r3, [fp, #-20]
 181:brett.c       **** EV_b2 = 1;
 624 0490 0130A0E3 		mov	r3, #1
 625 0494 18300BE5 		str	r3, [fp, #-24]
 182:brett.c       **** if ((EV_b1||EV_b2))
 627 0498 14301BE5 		ldr	r3, [fp, #-20]
 628 049c 000053E3 		cmp	r3, #0
 629 04a0 0200001A 		bne	.L52
 631 04a4 18301BE5 		ldr	r3, [fp, #-24]
 632 04a8 000053E3 		cmp	r3, #0
 633 04ac 0300000A 		beq	.L53
 634              	.L52:
 183:brett.c       **** {
 184:brett.c       **** printf("%d\n", 1);
 636 04b0 0110A0E3 		mov	r1, #1
 637 04b4 10089FE5 		ldr	r0, .L107+4
 638 04b8 FEFFFFEB 		bl	printf
 639 04bc 020000EA 		b	.L54
 640              	.L53:
 185:brett.c       **** }
 186:brett.c       **** else
 187:brett.c       **** {
 188:brett.c       **** printf("%d\n", 0);
 642 04c0 0010A0E3 		mov	r1, #0
 643 04c4 00089FE5 		ldr	r0, .L107+4
 644 04c8 FEFFFFEB 		bl	printf
 645              	.L54:
 189:brett.c       **** }
 190:brett.c       **** EV_b1 = 0;
 647 04cc 0030A0E3 		mov	r3, #0
 648 04d0 14300BE5 		str	r3, [fp, #-20]
 191:brett.c       **** EV_b2 = 0;
 650 04d4 0030A0E3 		mov	r3, #0
 651 04d8 18300BE5 		str	r3, [fp, #-24]
 192:brett.c       **** if ((EV_b1||EV_b2))
 653 04dc 14301BE5 		ldr	r3, [fp, #-20]
 654 04e0 000053E3 		cmp	r3, #0
 655 04e4 0200001A 		bne	.L55
 657 04e8 18301BE5 		ldr	r3, [fp, #-24]
 658 04ec 000053E3 		cmp	r3, #0
 659 04f0 0300000A 		beq	.L56
 660              	.L55:
 193:brett.c       **** {
 194:brett.c       **** printf("%d\n", 0);
 662 04f4 0010A0E3 		mov	r1, #0
 663 04f8 CC079FE5 		ldr	r0, .L107+4
 664 04fc FEFFFFEB 		bl	printf
 665 0500 020000EA 		b	.L57
 666              	.L56:
 195:brett.c       **** }
 196:brett.c       **** else
 197:brett.c       **** {
 198:brett.c       **** printf("%d\n", 1);
 668 0504 0110A0E3 		mov	r1, #1
 669 0508 BC079FE5 		ldr	r0, .L107+4
 670 050c FEFFFFEB 		bl	printf
 671              	.L57:
 199:brett.c       **** }
 200:brett.c       **** _printgroup(3);
 673 0510 0300A0E3 		mov	r0, #3
 674 0514 FEFFFFEB 		bl	_printgroup
 201:brett.c       **** if ((42>1))
 202:brett.c       **** {
 203:brett.c       **** printf("%d\n", 1);
 676 0518 0110A0E3 		mov	r1, #1
 677 051c A8079FE5 		ldr	r0, .L107+4
 678 0520 FEFFFFEB 		bl	printf
 204:brett.c       **** }
 205:brett.c       **** else
 206:brett.c       **** {
 207:brett.c       **** printf("%d\n", 0);
 208:brett.c       **** }
 209:brett.c       **** if ((42>=1))
 210:brett.c       **** {
 211:brett.c       **** printf("%d\n", 1);
 680 0524 0110A0E3 		mov	r1, #1
 681 0528 9C079FE5 		ldr	r0, .L107+4
 682 052c FEFFFFEB 		bl	printf
 212:brett.c       **** }
 213:brett.c       **** else
 214:brett.c       **** {
 215:brett.c       **** printf("%d\n", 0);
 216:brett.c       **** }
 217:brett.c       **** if ((42<1))
 218:brett.c       **** {
 219:brett.c       **** printf("%d\n", 0);
 220:brett.c       **** }
 221:brett.c       **** else
 222:brett.c       **** {
 223:brett.c       **** printf("%d\n", 1);
 684 0530 0110A0E3 		mov	r1, #1
 685 0534 90079FE5 		ldr	r0, .L107+4
 686 0538 FEFFFFEB 		bl	printf
 224:brett.c       **** }
 225:brett.c       **** if ((42<=1))
 226:brett.c       **** {
 227:brett.c       **** printf("%d\n", 0);
 228:brett.c       **** }
 229:brett.c       **** else
 230:brett.c       **** {
 231:brett.c       **** printf("%d\n", 1);
 688 053c 0110A0E3 		mov	r1, #1
 689 0540 84079FE5 		ldr	r0, .L107+4
 690 0544 FEFFFFEB 		bl	printf
 232:brett.c       **** }
 233:brett.c       **** if ((42==1))
 234:brett.c       **** {
 235:brett.c       **** printf("%d\n", 0);
 236:brett.c       **** }
 237:brett.c       **** else
 238:brett.c       **** {
 239:brett.c       **** printf("%d\n", 1);
 692 0548 0110A0E3 		mov	r1, #1
 693 054c 78079FE5 		ldr	r0, .L107+4
 694 0550 FEFFFFEB 		bl	printf
 240:brett.c       **** }
 241:brett.c       **** if ((42!=1))
 242:brett.c       **** {
 243:brett.c       **** printf("%d\n", 1);
 696 0554 0110A0E3 		mov	r1, #1
 697 0558 6C079FE5 		ldr	r0, .L107+4
 698 055c FEFFFFEB 		bl	printf
 244:brett.c       **** }
 245:brett.c       **** else
 246:brett.c       **** {
 247:brett.c       **** printf("%d\n", 0);
 248:brett.c       **** }
 249:brett.c       **** if (1)
 250:brett.c       **** {
 251:brett.c       **** printf("%d\n", 1);
 700 0560 0110A0E3 		mov	r1, #1
 701 0564 60079FE5 		ldr	r0, .L107+4
 702 0568 FEFFFFEB 		bl	printf
 252:brett.c       **** }
 253:brett.c       **** else
 254:brett.c       **** {
 255:brett.c       **** printf("%d\n", 0);
 256:brett.c       **** }
 257:brett.c       **** if ((!1))
 258:brett.c       **** {
 259:brett.c       **** printf("%d\n", 0);
 260:brett.c       **** }
 261:brett.c       **** else
 262:brett.c       **** {
 263:brett.c       **** printf("%d\n", 1);
 704 056c 0110A0E3 		mov	r1, #1
 705 0570 54079FE5 		ldr	r0, .L107+4
 706 0574 FEFFFFEB 		bl	printf
 264:brett.c       **** }
 265:brett.c       **** if (0)
 266:brett.c       **** {
 267:brett.c       **** printf("%d\n", 0);
 268:brett.c       **** }
 269:brett.c       **** else
 270:brett.c       **** {
 271:brett.c       **** printf("%d\n", 1);
 708 0578 0110A0E3 		mov	r1, #1
 709 057c 48079FE5 		ldr	r0, .L107+4
 710 0580 FEFFFFEB 		bl	printf
 272:brett.c       **** }
 273:brett.c       **** if ((!0))
 274:brett.c       **** {
 275:brett.c       **** printf("%d\n", 1);
 712 0584 0110A0E3 		mov	r1, #1
 713 0588 3C079FE5 		ldr	r0, .L107+4
 714 058c FEFFFFEB 		bl	printf
 276:brett.c       **** }
 277:brett.c       **** else
 278:brett.c       **** {
 279:brett.c       **** printf("%d\n", 0);
 280:brett.c       **** }
 281:brett.c       **** if ((!0))
 282:brett.c       **** {
 283:brett.c       **** printf("%d\n", 1);
 716 0590 0110A0E3 		mov	r1, #1
 717 0594 30079FE5 		ldr	r0, .L107+4
 718 0598 FEFFFFEB 		bl	printf
 284:brett.c       **** }
 285:brett.c       **** else
 286:brett.c       **** {
 287:brett.c       **** printf("%d\n", 0);
 288:brett.c       **** }
 289:brett.c       **** _printgroup(4);
 720 059c 0400A0E3 		mov	r0, #4
 721 05a0 FEFFFFEB 		bl	_printgroup
 290:brett.c       **** if (((2+3)==5))
 291:brett.c       **** {
 292:brett.c       **** printf("%d\n", 1);
 723 05a4 0110A0E3 		mov	r1, #1
 724 05a8 1C079FE5 		ldr	r0, .L107+4
 725 05ac FEFFFFEB 		bl	printf
 293:brett.c       **** }
 294:brett.c       **** else
 295:brett.c       **** {
 296:brett.c       **** printf("%d ", 0);
 297:brett.c       **** printf("%d\n", (2+3));
 298:brett.c       **** }
 299:brett.c       **** if (((2*3)==6))
 300:brett.c       **** {
 301:brett.c       **** printf("%d\n", 1);
 727 05b0 0110A0E3 		mov	r1, #1
 728 05b4 10079FE5 		ldr	r0, .L107+4
 729 05b8 FEFFFFEB 		bl	printf
 302:brett.c       **** }
 303:brett.c       **** else
 304:brett.c       **** {
 305:brett.c       **** printf("%d ", 0);
 306:brett.c       **** printf("%d\n", (2*3));
 307:brett.c       **** }
 308:brett.c       **** if (((3-2)==1))
 309:brett.c       **** {
 310:brett.c       **** printf("%d\n", 1);
 731 05bc 0110A0E3 		mov	r1, #1
 732 05c0 04079FE5 		ldr	r0, .L107+4
 733 05c4 FEFFFFEB 		bl	printf
 311:brett.c       **** }
 312:brett.c       **** else
 313:brett.c       **** {
 314:brett.c       **** printf("%d ", 0);
 315:brett.c       **** printf("%d\n", (3-2));
 316:brett.c       **** }
 317:brett.c       **** if (((6/3)==2))
 318:brett.c       **** {
 319:brett.c       **** printf("%d\n", 1);
 735 05c8 0110A0E3 		mov	r1, #1
 736 05cc F8069FE5 		ldr	r0, .L107+4
 737 05d0 FEFFFFEB 		bl	printf
 320:brett.c       **** }
 321:brett.c       **** else
 322:brett.c       **** {
 323:brett.c       **** printf("%d ", 0);
 324:brett.c       **** printf("%d\n", (6/3));
 325:brett.c       **** }
 326:brett.c       **** if (((-6)<0))
 327:brett.c       **** {
 328:brett.c       **** printf("%d\n", 1);
 739 05d4 0110A0E3 		mov	r1, #1
 740 05d8 EC069FE5 		ldr	r0, .L107+4
 741 05dc FEFFFFEB 		bl	printf
 329:brett.c       **** }
 330:brett.c       **** else
 331:brett.c       **** {
 332:brett.c       **** printf("%d\n", 0);
 333:brett.c       **** }
 334:brett.c       **** _printgroup(5);
 743 05e0 0500A0E3 		mov	r0, #5
 744 05e4 FEFFFFEB 		bl	_printgroup
 335:brett.c       **** EV_i1 = 42;
 746 05e8 2A30A0E3 		mov	r3, #42
 747 05ec 10300BE5 		str	r3, [fp, #-16]
 336:brett.c       **** if ((EV_i1==42))
 749 05f0 10301BE5 		ldr	r3, [fp, #-16]
 750 05f4 2A0053E3 		cmp	r3, #42
 751 05f8 0300001A 		bne	.L58
 337:brett.c       **** {
 338:brett.c       **** printf("%d\n", 1);
 753 05fc 0110A0E3 		mov	r1, #1
 754 0600 C4069FE5 		ldr	r0, .L107+4
 755 0604 FEFFFFEB 		bl	printf
 756 0608 020000EA 		b	.L59
 757              	.L58:
 339:brett.c       **** }
 340:brett.c       **** else
 341:brett.c       **** {
 342:brett.c       **** printf("%d\n", 0);
 759 060c 0010A0E3 		mov	r1, #0
 760 0610 B4069FE5 		ldr	r0, .L107+4
 761 0614 FEFFFFEB 		bl	printf
 762              	.L59:
 343:brett.c       **** }
 344:brett.c       **** EV_i1 = 3;
 764 0618 0330A0E3 		mov	r3, #3
 765 061c 10300BE5 		str	r3, [fp, #-16]
 345:brett.c       **** EV_i2 = 2;
 767 0620 0230A0E3 		mov	r3, #2
 768 0624 1C300BE5 		str	r3, [fp, #-28]
 346:brett.c       **** EV_i3 = (EV_i1+EV_i2);
 770 0628 10201BE5 		ldr	r2, [fp, #-16]
 771 062c 1C301BE5 		ldr	r3, [fp, #-28]
 772 0630 033082E0 		add	r3, r2, r3
 773 0634 20300BE5 		str	r3, [fp, #-32]
 347:brett.c       **** if ((EV_i3==5))
 775 0638 20301BE5 		ldr	r3, [fp, #-32]
 776 063c 050053E3 		cmp	r3, #5
 777 0640 0300001A 		bne	.L60
 348:brett.c       **** {
 349:brett.c       **** printf("%d\n", 1);
 779 0644 0110A0E3 		mov	r1, #1
 780 0648 7C069FE5 		ldr	r0, .L107+4
 781 064c FEFFFFEB 		bl	printf
 782 0650 020000EA 		b	.L61
 783              	.L60:
 350:brett.c       **** }
 351:brett.c       **** else
 352:brett.c       **** {
 353:brett.c       **** printf("%d\n", 0);
 785 0654 0010A0E3 		mov	r1, #0
 786 0658 6C069FE5 		ldr	r0, .L107+4
 787 065c FEFFFFEB 		bl	printf
 788              	.L61:
 354:brett.c       **** }
 355:brett.c       **** EV_b1 = 1;
 790 0660 0130A0E3 		mov	r3, #1
 791 0664 14300BE5 		str	r3, [fp, #-20]
 356:brett.c       **** if (EV_b1)
 793 0668 14301BE5 		ldr	r3, [fp, #-20]
 794 066c 000053E3 		cmp	r3, #0
 795 0670 0300000A 		beq	.L62
 357:brett.c       **** {
 358:brett.c       **** printf("%d\n", 1);
 797 0674 0110A0E3 		mov	r1, #1
 798 0678 4C069FE5 		ldr	r0, .L107+4
 799 067c FEFFFFEB 		bl	printf
 800 0680 020000EA 		b	.L63
 801              	.L62:
 359:brett.c       **** }
 360:brett.c       **** else
 361:brett.c       **** {
 362:brett.c       **** printf("%d\n", 0);
 803 0684 0010A0E3 		mov	r1, #0
 804 0688 3C069FE5 		ldr	r0, .L107+4
 805 068c FEFFFFEB 		bl	printf
 806              	.L63:
 363:brett.c       **** }
 364:brett.c       **** if ((!EV_b1))
 808 0690 14301BE5 		ldr	r3, [fp, #-20]
 809 0694 000053E3 		cmp	r3, #0
 810 0698 0300001A 		bne	.L64
 365:brett.c       **** {
 366:brett.c       **** printf("%d\n", 0);
 812 069c 0010A0E3 		mov	r1, #0
 813 06a0 24069FE5 		ldr	r0, .L107+4
 814 06a4 FEFFFFEB 		bl	printf
 815 06a8 020000EA 		b	.L65
 816              	.L64:
 367:brett.c       **** }
 368:brett.c       **** else
 369:brett.c       **** {
 370:brett.c       **** printf("%d\n", 1);
 818 06ac 0110A0E3 		mov	r1, #1
 819 06b0 14069FE5 		ldr	r0, .L107+4
 820 06b4 FEFFFFEB 		bl	printf
 821              	.L65:
 371:brett.c       **** }
 372:brett.c       **** EV_b1 = 0;
 823 06b8 0030A0E3 		mov	r3, #0
 824 06bc 14300BE5 		str	r3, [fp, #-20]
 373:brett.c       **** if (EV_b1)
 826 06c0 14301BE5 		ldr	r3, [fp, #-20]
 827 06c4 000053E3 		cmp	r3, #0
 828 06c8 0300000A 		beq	.L66
 374:brett.c       **** {
 375:brett.c       **** printf("%d\n", 0);
 830 06cc 0010A0E3 		mov	r1, #0
 831 06d0 F4059FE5 		ldr	r0, .L107+4
 832 06d4 FEFFFFEB 		bl	printf
 833 06d8 020000EA 		b	.L67
 834              	.L66:
 376:brett.c       **** }
 377:brett.c       **** else
 378:brett.c       **** {
 379:brett.c       **** printf("%d\n", 1);
 836 06dc 0110A0E3 		mov	r1, #1
 837 06e0 E4059FE5 		ldr	r0, .L107+4
 838 06e4 FEFFFFEB 		bl	printf
 839              	.L67:
 380:brett.c       **** }
 381:brett.c       **** if ((!EV_b1))
 841 06e8 14301BE5 		ldr	r3, [fp, #-20]
 842 06ec 000053E3 		cmp	r3, #0
 843 06f0 0300001A 		bne	.L68
 382:brett.c       **** {
 383:brett.c       **** printf("%d\n", 1);
 845 06f4 0110A0E3 		mov	r1, #1
 846 06f8 CC059FE5 		ldr	r0, .L107+4
 847 06fc FEFFFFEB 		bl	printf
 848 0700 020000EA 		b	.L69
 849              	.L68:
 384:brett.c       **** }
 385:brett.c       **** else
 386:brett.c       **** {
 387:brett.c       **** printf("%d\n", 0);
 851 0704 0010A0E3 		mov	r1, #0
 852 0708 BC059FE5 		ldr	r0, .L107+4
 853 070c FEFFFFEB 		bl	printf
 854              	.L69:
 388:brett.c       **** }
 389:brett.c       **** if (EV_b1)
 856 0710 14301BE5 		ldr	r3, [fp, #-20]
 857 0714 000053E3 		cmp	r3, #0
 858 0718 0300000A 		beq	.L70
 390:brett.c       **** {
 391:brett.c       **** printf("%d\n", 0);
 860 071c 0010A0E3 		mov	r1, #0
 861 0720 A4059FE5 		ldr	r0, .L107+4
 862 0724 FEFFFFEB 		bl	printf
 863 0728 020000EA 		b	.L71
 864              	.L70:
 392:brett.c       **** }
 393:brett.c       **** else
 394:brett.c       **** {
 395:brett.c       **** printf("%d\n", 1);
 866 072c 0110A0E3 		mov	r1, #1
 867 0730 94059FE5 		ldr	r0, .L107+4
 868 0734 FEFFFFEB 		bl	printf
 869              	.L71:
 396:brett.c       **** }
 397:brett.c       **** _printgroup(6);
 871 0738 0600A0E3 		mov	r0, #6
 872 073c FEFFFFEB 		bl	_printgroup
 398:brett.c       **** EV_i1 = 0;
 874 0740 0030A0E3 		mov	r3, #0
 875 0744 10300BE5 		str	r3, [fp, #-16]
 399:brett.c       **** while ((EV_i1<5))
 877 0748 080000EA 		b	.L72
 878              	.L74:
 400:brett.c       **** {
 401:brett.c       **** if ((EV_i1>=5))
 880 074c 10301BE5 		ldr	r3, [fp, #-16]
 881 0750 040053E3 		cmp	r3, #4
 882 0754 020000DA 		ble	.L73
 402:brett.c       **** {
 403:brett.c       **** printf("%d\n", 0);
 884 0758 0010A0E3 		mov	r1, #0
 885 075c 68059FE5 		ldr	r0, .L107+4
 886 0760 FEFFFFEB 		bl	printf
 887              	.L73:
 404:brett.c       **** }
 405:brett.c       **** EV_i1 = (EV_i1+5);
 889 0764 10301BE5 		ldr	r3, [fp, #-16]
 890 0768 053083E2 		add	r3, r3, #5
 891 076c 10300BE5 		str	r3, [fp, #-16]
 892              	.L72:
 399:brett.c       **** {
 894 0770 10301BE5 		ldr	r3, [fp, #-16]
 895 0774 040053E3 		cmp	r3, #4
 896 0778 F3FFFFDA 		ble	.L74
 406:brett.c       **** }
 407:brett.c       **** if ((EV_i1==5))
 898 077c 10301BE5 		ldr	r3, [fp, #-16]
 899 0780 050053E3 		cmp	r3, #5
 900 0784 0300001A 		bne	.L75
 408:brett.c       **** {
 409:brett.c       **** printf("%d\n", 1);
 902 0788 0110A0E3 		mov	r1, #1
 903 078c 38059FE5 		ldr	r0, .L107+4
 904 0790 FEFFFFEB 		bl	printf
 905 0794 050000EA 		b	.L76
 906              	.L75:
 410:brett.c       **** }
 411:brett.c       **** else
 412:brett.c       **** {
 413:brett.c       **** printf("%d ", 0);
 908 0798 0010A0E3 		mov	r1, #0
 909 079c 2C059FE5 		ldr	r0, .L107+8
 910 07a0 FEFFFFEB 		bl	printf
 414:brett.c       **** printf("%d\n", EV_i1);
 912 07a4 10101BE5 		ldr	r1, [fp, #-16]
 913 07a8 1C059FE5 		ldr	r0, .L107+4
 914 07ac FEFFFFEB 		bl	printf
 915              	.L76:
 415:brett.c       **** }
 416:brett.c       **** _printgroup(7);
 917 07b0 0700A0E3 		mov	r0, #7
 918 07b4 FEFFFFEB 		bl	_printgroup
 417:brett.c       **** EV_s1 = (struct EV_thing*)malloc(sizeof(struct EV_thing));
 920 07b8 0C00A0E3 		mov	r0, #12
 921 07bc FEFFFFEB 		bl	malloc
 922 07c0 0030A0E1 		mov	r3, r0
 923 07c4 24300BE5 		str	r3, [fp, #-36]
 418:brett.c       **** EV_s1->EV_i = 42;
 925 07c8 24301BE5 		ldr	r3, [fp, #-36]
 926 07cc 2A20A0E3 		mov	r2, #42
 927 07d0 002083E5 		str	r2, [r3]
 419:brett.c       **** EV_s1->EV_b = 1;
 929 07d4 24301BE5 		ldr	r3, [fp, #-36]
 930 07d8 0120A0E3 		mov	r2, #1
 931 07dc 042083E5 		str	r2, [r3, #4]
 420:brett.c       **** if ((EV_s1->EV_i==42))
 933 07e0 24301BE5 		ldr	r3, [fp, #-36]
 934 07e4 003093E5 		ldr	r3, [r3]
 936 07e8 2A0053E3 		cmp	r3, #42
 937 07ec 0300001A 		bne	.L77
 421:brett.c       **** {
 422:brett.c       **** printf("%d\n", 1);
 939 07f0 0110A0E3 		mov	r1, #1
 940 07f4 D0049FE5 		ldr	r0, .L107+4
 941 07f8 FEFFFFEB 		bl	printf
 942 07fc 070000EA 		b	.L78
 943              	.L77:
 423:brett.c       **** }
 424:brett.c       **** else
 425:brett.c       **** {
 426:brett.c       **** printf("%d ", 0);
 945 0800 0010A0E3 		mov	r1, #0
 946 0804 C4049FE5 		ldr	r0, .L107+8
 947 0808 FEFFFFEB 		bl	printf
 427:brett.c       **** printf("%d\n", EV_s1->EV_i);
 949 080c 24301BE5 		ldr	r3, [fp, #-36]
 950 0810 003093E5 		ldr	r3, [r3]
 951 0814 0310A0E1 		mov	r1, r3
 952 0818 AC049FE5 		ldr	r0, .L107+4
 953 081c FEFFFFEB 		bl	printf
 954              	.L78:
 428:brett.c       **** }
 429:brett.c       **** if (EV_s1->EV_b)
 956 0820 24301BE5 		ldr	r3, [fp, #-36]
 957 0824 043093E5 		ldr	r3, [r3, #4]
 959 0828 000053E3 		cmp	r3, #0
 960 082c 0300000A 		beq	.L79
 430:brett.c       **** {
 431:brett.c       **** printf("%d\n", 1);
 962 0830 0110A0E3 		mov	r1, #1
 963 0834 90049FE5 		ldr	r0, .L107+4
 964 0838 FEFFFFEB 		bl	printf
 965 083c 020000EA 		b	.L80
 966              	.L79:
 432:brett.c       **** }
 433:brett.c       **** else
 434:brett.c       **** {
 435:brett.c       **** printf("%d\n", 0);
 968 0840 0010A0E3 		mov	r1, #0
 969 0844 80049FE5 		ldr	r0, .L107+4
 970 0848 FEFFFFEB 		bl	printf
 971              	.L80:
 436:brett.c       **** }
 437:brett.c       **** EV_s1->EV_s = (struct EV_thing*)malloc(sizeof(struct EV_thing));
 973 084c 0C00A0E3 		mov	r0, #12
 974 0850 FEFFFFEB 		bl	malloc
 975 0854 0030A0E1 		mov	r3, r0
 976 0858 0320A0E1 		mov	r2, r3
 978 085c 24301BE5 		ldr	r3, [fp, #-36]
 979 0860 082083E5 		str	r2, [r3, #8]
 438:brett.c       **** EV_s1->EV_s->EV_i = 13;
 981 0864 24301BE5 		ldr	r3, [fp, #-36]
 982 0868 083093E5 		ldr	r3, [r3, #8]
 984 086c 0D20A0E3 		mov	r2, #13
 985 0870 002083E5 		str	r2, [r3]
 439:brett.c       **** EV_s1->EV_s->EV_b = 0;
 987 0874 24301BE5 		ldr	r3, [fp, #-36]
 988 0878 083093E5 		ldr	r3, [r3, #8]
 990 087c 0020A0E3 		mov	r2, #0
 991 0880 042083E5 		str	r2, [r3, #4]
 440:brett.c       **** if ((EV_s1->EV_s->EV_i==13))
 993 0884 24301BE5 		ldr	r3, [fp, #-36]
 994 0888 083093E5 		ldr	r3, [r3, #8]
 996 088c 003093E5 		ldr	r3, [r3]
 998 0890 0D0053E3 		cmp	r3, #13
 999 0894 0300001A 		bne	.L81
 441:brett.c       **** {
 442:brett.c       **** printf("%d\n", 1);
 1001 0898 0110A0E3 		mov	r1, #1
 1002 089c 28049FE5 		ldr	r0, .L107+4
 1003 08a0 FEFFFFEB 		bl	printf
 1004 08a4 080000EA 		b	.L82
 1005              	.L81:
 443:brett.c       **** }
 444:brett.c       **** else
 445:brett.c       **** {
 446:brett.c       **** printf("%d ", 0);
 1007 08a8 0010A0E3 		mov	r1, #0
 1008 08ac 1C049FE5 		ldr	r0, .L107+8
 1009 08b0 FEFFFFEB 		bl	printf
 447:brett.c       **** printf("%d\n", EV_s1->EV_s->EV_i);
 1011 08b4 24301BE5 		ldr	r3, [fp, #-36]
 1012 08b8 083093E5 		ldr	r3, [r3, #8]
 1014 08bc 003093E5 		ldr	r3, [r3]
 1015 08c0 0310A0E1 		mov	r1, r3
 1016 08c4 00049FE5 		ldr	r0, .L107+4
 1017 08c8 FEFFFFEB 		bl	printf
 1018              	.L82:
 448:brett.c       **** }
 449:brett.c       **** if ((!EV_s1->EV_s->EV_b))
 1020 08cc 24301BE5 		ldr	r3, [fp, #-36]
 1021 08d0 083093E5 		ldr	r3, [r3, #8]
 1023 08d4 043093E5 		ldr	r3, [r3, #4]
 1025 08d8 000053E3 		cmp	r3, #0
 1026 08dc 0300001A 		bne	.L83
 450:brett.c       **** {
 451:brett.c       **** printf("%d\n", 1);
 1028 08e0 0110A0E3 		mov	r1, #1
 1029 08e4 E0039FE5 		ldr	r0, .L107+4
 1030 08e8 FEFFFFEB 		bl	printf
 1031 08ec 020000EA 		b	.L106
 1032              	.L83:
 452:brett.c       **** }
 453:brett.c       **** else
 454:brett.c       **** {
 455:brett.c       **** printf("%d\n", 0);
 1034 08f0 0010A0E3 		mov	r1, #0
 1035 08f4 D0039FE5 		ldr	r0, .L107+4
 1036 08f8 FEFFFFEB 		bl	printf
 1037              	.L106:
 456:brett.c       **** }
 457:brett.c       **** if ((EV_s1==EV_s1))
 458:brett.c       **** {
 459:brett.c       **** printf("%d\n", 1);
 1039 08fc 0110A0E3 		mov	r1, #1
 1040 0900 C4039FE5 		ldr	r0, .L107+4
 1041 0904 FEFFFFEB 		bl	printf
 460:brett.c       **** }
 461:brett.c       **** else
 462:brett.c       **** {
 463:brett.c       **** printf("%d\n", 0);
 464:brett.c       **** }
 465:brett.c       **** if ((EV_s1!=EV_s1->EV_s))
 1043 0908 24301BE5 		ldr	r3, [fp, #-36]
 1044 090c 083093E5 		ldr	r3, [r3, #8]
 1046 0910 24201BE5 		ldr	r2, [fp, #-36]
 1047 0914 030052E1 		cmp	r2, r3
 1048 0918 0300000A 		beq	.L85
 466:brett.c       **** {
 467:brett.c       **** printf("%d\n", 1);
 1050 091c 0110A0E3 		mov	r1, #1
 1051 0920 A4039FE5 		ldr	r0, .L107+4
 1052 0924 FEFFFFEB 		bl	printf
 1053 0928 020000EA 		b	.L86
 1054              	.L85:
 468:brett.c       **** }
 469:brett.c       **** else
 470:brett.c       **** {
 471:brett.c       **** printf("%d\n", 0);
 1056 092c 0010A0E3 		mov	r1, #0
 1057 0930 94039FE5 		ldr	r0, .L107+4
 1058 0934 FEFFFFEB 		bl	printf
 1059              	.L86:
 472:brett.c       **** }
 473:brett.c       **** free(EV_s1->EV_s);
 1061 0938 24301BE5 		ldr	r3, [fp, #-36]
 1062 093c 083093E5 		ldr	r3, [r3, #8]
 1064 0940 0300A0E1 		mov	r0, r3
 1065 0944 FEFFFFEB 		bl	free
 474:brett.c       **** free(EV_s1);
 1067 0948 24001BE5 		ldr	r0, [fp, #-36]
 1068 094c FEFFFFEB 		bl	free
 475:brett.c       **** _printgroup(8);
 1070 0950 0800A0E3 		mov	r0, #8
 1071 0954 FEFFFFEB 		bl	_printgroup
 476:brett.c       **** EV_gi1 = 7;
 1073 0958 74339FE5 		ldr	r3, .L107+12
 1074 095c 0720A0E3 		mov	r2, #7
 1075 0960 002083E5 		str	r2, [r3]
 477:brett.c       **** if ((EV_gi1==7))
 1077 0964 68339FE5 		ldr	r3, .L107+12
 1078 0968 003093E5 		ldr	r3, [r3]
 1080 096c 070053E3 		cmp	r3, #7
 1081 0970 0300001A 		bne	.L87
 478:brett.c       **** {
 479:brett.c       **** printf("%d\n", 1);
 1083 0974 0110A0E3 		mov	r1, #1
 1084 0978 4C039FE5 		ldr	r0, .L107+4
 1085 097c FEFFFFEB 		bl	printf
 1086 0980 070000EA 		b	.L88
 1087              	.L87:
 480:brett.c       **** }
 481:brett.c       **** else
 482:brett.c       **** {
 483:brett.c       **** printf("%d ", 0);
 1089 0984 0010A0E3 		mov	r1, #0
 1090 0988 40039FE5 		ldr	r0, .L107+8
 1091 098c FEFFFFEB 		bl	printf
 484:brett.c       **** printf("%d\n", EV_gi1);
 1093 0990 3C339FE5 		ldr	r3, .L107+12
 1094 0994 003093E5 		ldr	r3, [r3]
 1095 0998 0310A0E1 		mov	r1, r3
 1096 099c 28039FE5 		ldr	r0, .L107+4
 1097 09a0 FEFFFFEB 		bl	printf
 1098              	.L88:
 485:brett.c       **** }
 486:brett.c       **** EV_gb1 = 1;
 1100 09a4 2C339FE5 		ldr	r3, .L107+16
 1101 09a8 0120A0E3 		mov	r2, #1
 1102 09ac 002083E5 		str	r2, [r3]
 487:brett.c       **** if (EV_gb1)
 1104 09b0 20339FE5 		ldr	r3, .L107+16
 1105 09b4 003093E5 		ldr	r3, [r3]
 1107 09b8 000053E3 		cmp	r3, #0
 1108 09bc 0300000A 		beq	.L89
 488:brett.c       **** {
 489:brett.c       **** printf("%d\n", 1);
 1110 09c0 0110A0E3 		mov	r1, #1
 1111 09c4 00039FE5 		ldr	r0, .L107+4
 1112 09c8 FEFFFFEB 		bl	printf
 1113 09cc 020000EA 		b	.L90
 1114              	.L89:
 490:brett.c       **** }
 491:brett.c       **** else
 492:brett.c       **** {
 493:brett.c       **** printf("%d\n", 0);
 1116 09d0 0010A0E3 		mov	r1, #0
 1117 09d4 F0029FE5 		ldr	r0, .L107+4
 1118 09d8 FEFFFFEB 		bl	printf
 1119              	.L90:
 494:brett.c       **** }
 495:brett.c       **** EV_gs1 = (struct EV_thing*)malloc(sizeof(struct EV_thing));
 1121 09dc 0C00A0E3 		mov	r0, #12
 1122 09e0 FEFFFFEB 		bl	malloc
 1123 09e4 0030A0E1 		mov	r3, r0
 1124 09e8 0320A0E1 		mov	r2, r3
 1126 09ec E8329FE5 		ldr	r3, .L107+20
 1127 09f0 002083E5 		str	r2, [r3]
 496:brett.c       **** EV_gs1->EV_i = 34;
 1129 09f4 E0329FE5 		ldr	r3, .L107+20
 1130 09f8 003093E5 		ldr	r3, [r3]
 1132 09fc 2220A0E3 		mov	r2, #34
 1133 0a00 002083E5 		str	r2, [r3]
 497:brett.c       **** EV_gs1->EV_b = 0;
 1135 0a04 D0329FE5 		ldr	r3, .L107+20
 1136 0a08 003093E5 		ldr	r3, [r3]
 1138 0a0c 0020A0E3 		mov	r2, #0
 1139 0a10 042083E5 		str	r2, [r3, #4]
 498:brett.c       **** if ((EV_gs1->EV_i==34))
 1141 0a14 C0329FE5 		ldr	r3, .L107+20
 1142 0a18 003093E5 		ldr	r3, [r3]
 1143 0a1c 003093E5 		ldr	r3, [r3]
 1145 0a20 220053E3 		cmp	r3, #34
 1146 0a24 0300001A 		bne	.L91
 499:brett.c       **** {
 500:brett.c       **** printf("%d\n", 1);
 1148 0a28 0110A0E3 		mov	r1, #1
 1149 0a2c 98029FE5 		ldr	r0, .L107+4
 1150 0a30 FEFFFFEB 		bl	printf
 1151 0a34 080000EA 		b	.L92
 1152              	.L91:
 501:brett.c       **** }
 502:brett.c       **** else
 503:brett.c       **** {
 504:brett.c       **** printf("%d ", 0);
 1154 0a38 0010A0E3 		mov	r1, #0
 1155 0a3c 8C029FE5 		ldr	r0, .L107+8
 1156 0a40 FEFFFFEB 		bl	printf
 505:brett.c       **** printf("%d\n", EV_gs1->EV_i);
 1158 0a44 90329FE5 		ldr	r3, .L107+20
 1159 0a48 003093E5 		ldr	r3, [r3]
 1161 0a4c 003093E5 		ldr	r3, [r3]
 1162 0a50 0310A0E1 		mov	r1, r3
 1163 0a54 70029FE5 		ldr	r0, .L107+4
 1164 0a58 FEFFFFEB 		bl	printf
 1165              	.L92:
 506:brett.c       **** }
 507:brett.c       **** if ((!EV_gs1->EV_b))
 1167 0a5c 78329FE5 		ldr	r3, .L107+20
 1168 0a60 003093E5 		ldr	r3, [r3]
 1169 0a64 043093E5 		ldr	r3, [r3, #4]
 1171 0a68 000053E3 		cmp	r3, #0
 1172 0a6c 0300001A 		bne	.L93
 508:brett.c       **** {
 509:brett.c       **** printf("%d\n", 1);
 1174 0a70 0110A0E3 		mov	r1, #1
 1175 0a74 50029FE5 		ldr	r0, .L107+4
 1176 0a78 FEFFFFEB 		bl	printf
 1177 0a7c 020000EA 		b	.L94
 1178              	.L93:
 510:brett.c       **** }
 511:brett.c       **** else
 512:brett.c       **** {
 513:brett.c       **** printf("%d\n", 0);
 1180 0a80 0010A0E3 		mov	r1, #0
 1181 0a84 40029FE5 		ldr	r0, .L107+4
 1182 0a88 FEFFFFEB 		bl	printf
 1183              	.L94:
 514:brett.c       **** }
 515:brett.c       **** EV_gs1->EV_s = (struct EV_thing*)malloc(sizeof(struct EV_thing));
 1185 0a8c 48329FE5 		ldr	r3, .L107+20
 1186 0a90 004093E5 		ldr	r4, [r3]
 1188 0a94 0C00A0E3 		mov	r0, #12
 1189 0a98 FEFFFFEB 		bl	malloc
 1190 0a9c 0030A0E1 		mov	r3, r0
 1192 0aa0 083084E5 		str	r3, [r4, #8]
 516:brett.c       **** EV_gs1->EV_s->EV_i = 16;
 1194 0aa4 30329FE5 		ldr	r3, .L107+20
 1195 0aa8 003093E5 		ldr	r3, [r3]
 1196 0aac 083093E5 		ldr	r3, [r3, #8]
 1198 0ab0 1020A0E3 		mov	r2, #16
 1199 0ab4 002083E5 		str	r2, [r3]
 517:brett.c       **** EV_gs1->EV_s->EV_b = 1;
 1201 0ab8 1C329FE5 		ldr	r3, .L107+20
 1202 0abc 003093E5 		ldr	r3, [r3]
 1203 0ac0 083093E5 		ldr	r3, [r3, #8]
 1205 0ac4 0120A0E3 		mov	r2, #1
 1206 0ac8 042083E5 		str	r2, [r3, #4]
 518:brett.c       **** if ((EV_gs1->EV_s->EV_i==16))
 1208 0acc 08329FE5 		ldr	r3, .L107+20
 1209 0ad0 003093E5 		ldr	r3, [r3]
 1210 0ad4 083093E5 		ldr	r3, [r3, #8]
 1212 0ad8 003093E5 		ldr	r3, [r3]
 1214 0adc 100053E3 		cmp	r3, #16
 1215 0ae0 0300001A 		bne	.L95
 519:brett.c       **** {
 520:brett.c       **** printf("%d\n", 1);
 1217 0ae4 0110A0E3 		mov	r1, #1
 1218 0ae8 DC019FE5 		ldr	r0, .L107+4
 1219 0aec FEFFFFEB 		bl	printf
 1220 0af0 090000EA 		b	.L96
 1221              	.L95:
 521:brett.c       **** }
 522:brett.c       **** else
 523:brett.c       **** {
 524:brett.c       **** printf("%d ", 0);
 1223 0af4 0010A0E3 		mov	r1, #0
 1224 0af8 D0019FE5 		ldr	r0, .L107+8
 1225 0afc FEFFFFEB 		bl	printf
 525:brett.c       **** printf("%d\n", EV_gs1->EV_s->EV_i);
 1227 0b00 D4319FE5 		ldr	r3, .L107+20
 1228 0b04 003093E5 		ldr	r3, [r3]
 1229 0b08 083093E5 		ldr	r3, [r3, #8]
 1231 0b0c 003093E5 		ldr	r3, [r3]
 1232 0b10 0310A0E1 		mov	r1, r3
 1233 0b14 B0019FE5 		ldr	r0, .L107+4
 1234 0b18 FEFFFFEB 		bl	printf
 1235              	.L96:
 526:brett.c       **** }
 527:brett.c       **** if (EV_gs1->EV_s->EV_b)
 1237 0b1c B8319FE5 		ldr	r3, .L107+20
 1238 0b20 003093E5 		ldr	r3, [r3]
 1239 0b24 083093E5 		ldr	r3, [r3, #8]
 1241 0b28 043093E5 		ldr	r3, [r3, #4]
 1243 0b2c 000053E3 		cmp	r3, #0
 1244 0b30 0300000A 		beq	.L97
 528:brett.c       **** {
 529:brett.c       **** printf("%d\n", 1);
 1246 0b34 0110A0E3 		mov	r1, #1
 1247 0b38 8C019FE5 		ldr	r0, .L107+4
 1248 0b3c FEFFFFEB 		bl	printf
 1249 0b40 020000EA 		b	.L98
 1250              	.L97:
 530:brett.c       **** }
 531:brett.c       **** else
 532:brett.c       **** {
 533:brett.c       **** printf("%d\n", 0);
 1252 0b44 0010A0E3 		mov	r1, #0
 1253 0b48 7C019FE5 		ldr	r0, .L107+4
 1254 0b4c FEFFFFEB 		bl	printf
 1255              	.L98:
 534:brett.c       **** }
 535:brett.c       **** free(EV_gs1->EV_s);
 1257 0b50 84319FE5 		ldr	r3, .L107+20
 1258 0b54 003093E5 		ldr	r3, [r3]
 1259 0b58 083093E5 		ldr	r3, [r3, #8]
 1261 0b5c 0300A0E1 		mov	r0, r3
 1262 0b60 FEFFFFEB 		bl	free
 536:brett.c       **** free(EV_gs1);
 1264 0b64 70319FE5 		ldr	r3, .L107+20
 1265 0b68 003093E5 		ldr	r3, [r3]
 1266 0b6c 0300A0E1 		mov	r0, r3
 1267 0b70 FEFFFFEB 		bl	free
 537:brett.c       **** _printgroup(9);
 1269 0b74 0900A0E3 		mov	r0, #9
 1270 0b78 FEFFFFEB 		bl	_printgroup
 538:brett.c       **** EV_s1 = (struct EV_thing*)malloc(sizeof(struct EV_thing));
 1272 0b7c 0C00A0E3 		mov	r0, #12
 1273 0b80 FEFFFFEB 		bl	malloc
 1274 0b84 0030A0E1 		mov	r3, r0
 1275 0b88 24300BE5 		str	r3, [fp, #-36]
 539:brett.c       **** EV_s1->EV_b = 1;
 1277 0b8c 24301BE5 		ldr	r3, [fp, #-36]
 1278 0b90 0120A0E3 		mov	r2, #1
 1279 0b94 042083E5 		str	r2, [r3, #4]
 540:brett.c       **** _takealltypes(3, 1, EV_s1);
 1281 0b98 24201BE5 		ldr	r2, [fp, #-36]
 1282 0b9c 0110A0E3 		mov	r1, #1
 1283 0ba0 0300A0E3 		mov	r0, #3
 1284 0ba4 FEFFFFEB 		bl	_takealltypes
 541:brett.c       **** printf("%d\n", 2);
 1286 0ba8 0210A0E3 		mov	r1, #2
 1287 0bac 18019FE5 		ldr	r0, .L107+4
 1288 0bb0 FEFFFFEB 		bl	printf
 542:brett.c       **** _tonofargs(1, 2, 3, 4, 5, 6, 7, 8);
 1290 0bb4 0830A0E3 		mov	r3, #8
 1291 0bb8 0C308DE5 		str	r3, [sp, #12]
 1292 0bbc 0730A0E3 		mov	r3, #7
 1293 0bc0 08308DE5 		str	r3, [sp, #8]
 1294 0bc4 0630A0E3 		mov	r3, #6
 1295 0bc8 04308DE5 		str	r3, [sp, #4]
 1296 0bcc 0530A0E3 		mov	r3, #5
 1297 0bd0 00308DE5 		str	r3, [sp]
 1298 0bd4 0430A0E3 		mov	r3, #4
 1299 0bd8 0320A0E3 		mov	r2, #3
 1300 0bdc 0210A0E3 		mov	r1, #2
 1301 0be0 0100A0E3 		mov	r0, #1
 1302 0be4 FEFFFFEB 		bl	_tonofargs
 543:brett.c       **** printf("%d\n", 3);
 1304 0be8 0310A0E3 		mov	r1, #3
 1305 0bec D8009FE5 		ldr	r0, .L107+4
 1306 0bf0 FEFFFFEB 		bl	printf
 544:brett.c       **** EV_i1 = _returnint(3);
 1308 0bf4 0300A0E3 		mov	r0, #3
 1309 0bf8 FEFFFFEB 		bl	_returnint
 1310 0bfc 10000BE5 		str	r0, [fp, #-16]
 545:brett.c       **** if ((EV_i1==3))
 1312 0c00 10301BE5 		ldr	r3, [fp, #-16]
 1313 0c04 030053E3 		cmp	r3, #3
 1314 0c08 0300001A 		bne	.L99
 546:brett.c       **** {
 547:brett.c       **** printf("%d\n", 1);
 1316 0c0c 0110A0E3 		mov	r1, #1
 1317 0c10 B4009FE5 		ldr	r0, .L107+4
 1318 0c14 FEFFFFEB 		bl	printf
 1319 0c18 050000EA 		b	.L100
 1320              	.L99:
 548:brett.c       **** }
 549:brett.c       **** else
 550:brett.c       **** {
 551:brett.c       **** printf("%d ", 0);
 1322 0c1c 0010A0E3 		mov	r1, #0
 1323 0c20 A8009FE5 		ldr	r0, .L107+8
 1324 0c24 FEFFFFEB 		bl	printf
 552:brett.c       **** printf("%d\n", EV_i1);
 1326 0c28 10101BE5 		ldr	r1, [fp, #-16]
 1327 0c2c 98009FE5 		ldr	r0, .L107+4
 1328 0c30 FEFFFFEB 		bl	printf
 1329              	.L100:
 553:brett.c       **** }
 554:brett.c       **** EV_b1 = _returnbool(1);
 1331 0c34 0100A0E3 		mov	r0, #1
 1332 0c38 FEFFFFEB 		bl	_returnbool
 1333 0c3c 14000BE5 		str	r0, [fp, #-20]
 555:brett.c       **** if (EV_b1)
 1335 0c40 14301BE5 		ldr	r3, [fp, #-20]
 1336 0c44 000053E3 		cmp	r3, #0
 1337 0c48 0300000A 		beq	.L101
 556:brett.c       **** {
 557:brett.c       **** printf("%d\n", 1);
 1339 0c4c 0110A0E3 		mov	r1, #1
 1340 0c50 74009FE5 		ldr	r0, .L107+4
 1341 0c54 FEFFFFEB 		bl	printf
 1342 0c58 020000EA 		b	.L102
 1343              	.L101:
 558:brett.c       **** }
 559:brett.c       **** else
 560:brett.c       **** {
 561:brett.c       **** printf("%d\n", 0);
 1345 0c5c 0010A0E3 		mov	r1, #0
 1346 0c60 64009FE5 		ldr	r0, .L107+4
 1347 0c64 FEFFFFEB 		bl	printf
 1348              	.L102:
 562:brett.c       **** }
 563:brett.c       **** EV_s1 = (struct EV_thing*)malloc(sizeof(struct EV_thing));
 1350 0c68 0C00A0E3 		mov	r0, #12
 1351 0c6c FEFFFFEB 		bl	malloc
 1352 0c70 0030A0E1 		mov	r3, r0
 1353 0c74 24300BE5 		str	r3, [fp, #-36]
 564:brett.c       **** EV_s2 = _returnstruct(EV_s1);
 1355 0c78 24001BE5 		ldr	r0, [fp, #-36]
 1356 0c7c FEFFFFEB 		bl	_returnstruct
 1357 0c80 28000BE5 		str	r0, [fp, #-40]
 565:brett.c       **** if ((EV_s1==EV_s2))
 1359 0c84 24201BE5 		ldr	r2, [fp, #-36]
 1360 0c88 28301BE5 		ldr	r3, [fp, #-40]
 1361 0c8c 030052E1 		cmp	r2, r3
 1362 0c90 0300001A 		bne	.L103
 566:brett.c       **** {
 567:brett.c       **** printf("%d\n", 1);
 1364 0c94 0110A0E3 		mov	r1, #1
 1365 0c98 2C009FE5 		ldr	r0, .L107+4
 1366 0c9c FEFFFFEB 		bl	printf
 1367 0ca0 020000EA 		b	.L104
 1368              	.L103:
 568:brett.c       **** }
 569:brett.c       **** else
 570:brett.c       **** {
 571:brett.c       **** printf("%d\n", 0);
 1370 0ca4 0010A0E3 		mov	r1, #0
 1371 0ca8 1C009FE5 		ldr	r0, .L107+4
 1372 0cac FEFFFFEB 		bl	printf
 1373              	.L104:
 572:brett.c       **** }
 573:brett.c       **** _printgroup(10);
 1375 0cb0 0A00A0E3 		mov	r0, #10
 1376 0cb4 FEFFFFEB 		bl	_printgroup
 574:brett.c       **** return 0;
 1378 0cb8 0030A0E3 		mov	r3, #0
 575:brett.c       **** }
 1380 0cbc 0300A0E1 		mov	r0, r3
 1381 0cc0 08D04BE2 		sub	sp, fp, #8
 1383              		@ sp needed
 1384 0cc4 1088BDE8 		pop	{r4, fp, pc}
 1385              	.L108:
 1386              		.align	2
 1387              	.L107:
 1388 0cc8 00000000 		.word	EV_counter
 1389 0ccc 04000000 		.word	.LC1
 1390 0cd0 00000000 		.word	.LC0
 1391 0cd4 00000000 		.word	EV_gi1
 1392 0cd8 00000000 		.word	EV_gb1
 1393 0cdc 00000000 		.word	EV_gs1
 1395              	.LFE13:
 1397              		.align	2
 1398              		.global	main
 1399              		.syntax unified
 1400              		.arm
 1401              		.fpu vfp
 1403              	main:
 1404              	.LFB14:
 576:brett.c       **** int main(void)
 577:brett.c       **** {
 1407              		@ args = 0, pretend = 0, frame = 0
 1408              		@ frame_needed = 1, uses_anonymous_args = 0
 1409 0ce0 00482DE9 		push	{fp, lr}
 1413 0ce4 04B08DE2 		add	fp, sp, #4
 578:brett.c       ****    return _main();
 1416 0ce8 FEFFFFEB 		bl	_main
 1417 0cec 0030A0E1 		mov	r3, r0
 579:brett.c       **** }
 1419 0cf0 0300A0E1 		mov	r0, r3
 1420 0cf4 0088BDE8 		pop	{fp, pc}
 1422              	.LFE14:
 1424              	.Letext0:
