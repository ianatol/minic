   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.comm	EV_interval,4,4
  17              		.comm	EV_end,4,4
  18              		.align	2
  19              		.global	_multBy4xTimes
  20              		.arch armv6
  21              		.syntax unified
  22              		.arm
  23              		.fpu vfp
  25              	_multBy4xTimes:
  26              	.LFB6:
   1:GeneralFunctAndOptimize.c **** #include<stdio.h>
   2:GeneralFunctAndOptimize.c **** #include<stdlib.h>
   3:GeneralFunctAndOptimize.c **** struct EV_IntHolder
   4:GeneralFunctAndOptimize.c **** {
   5:GeneralFunctAndOptimize.c **** int EV_num;
   6:GeneralFunctAndOptimize.c **** };
   7:GeneralFunctAndOptimize.c **** int EV_interval;
   8:GeneralFunctAndOptimize.c **** int EV_end;
   9:GeneralFunctAndOptimize.c **** int _multBy4xTimes(struct EV_IntHolder * EV_num,int EV_timesLeft)
  10:GeneralFunctAndOptimize.c **** {
  30              		@ args = 0, pretend = 0, frame = 8
  31              		@ frame_needed = 1, uses_anonymous_args = 0
  32 0000 00482DE9 		push	{fp, lr}
  36 0004 04B08DE2 		add	fp, sp, #4
  38 0008 08D04DE2 		sub	sp, sp, #8
  39 000c 08000BE5 		str	r0, [fp, #-8]
  40 0010 0C100BE5 		str	r1, [fp, #-12]
  11:GeneralFunctAndOptimize.c **** if ((EV_timesLeft<=0))
  42 0014 0C301BE5 		ldr	r3, [fp, #-12]
  43 0018 000053E3 		cmp	r3, #0
  44 001c 020000CA 		bgt	.L2
  12:GeneralFunctAndOptimize.c **** {
  13:GeneralFunctAndOptimize.c **** return EV_num->EV_num;
  46 0020 08301BE5 		ldr	r3, [fp, #-8]
  47 0024 003093E5 		ldr	r3, [r3]
  48 0028 0B0000EA 		b	.L3
  49              	.L2:
  14:GeneralFunctAndOptimize.c **** }
  15:GeneralFunctAndOptimize.c **** EV_num->EV_num = (4*EV_num->EV_num);
  51 002c 08301BE5 		ldr	r3, [fp, #-8]
  52 0030 003093E5 		ldr	r3, [r3]
  54 0034 0321A0E1 		lsl	r2, r3, #2
  56 0038 08301BE5 		ldr	r3, [fp, #-8]
  57 003c 002083E5 		str	r2, [r3]
  16:GeneralFunctAndOptimize.c **** _multBy4xTimes(EV_num, (EV_timesLeft-1));
  59 0040 0C301BE5 		ldr	r3, [fp, #-12]
  60 0044 013043E2 		sub	r3, r3, #1
  61 0048 0310A0E1 		mov	r1, r3
  62 004c 08001BE5 		ldr	r0, [fp, #-8]
  63 0050 FEFFFFEB 		bl	_multBy4xTimes
  17:GeneralFunctAndOptimize.c **** return EV_num->EV_num;
  65 0054 08301BE5 		ldr	r3, [fp, #-8]
  66 0058 003093E5 		ldr	r3, [r3]
  67              	.L3:
  18:GeneralFunctAndOptimize.c **** }
  69 005c 0300A0E1 		mov	r0, r3
  70 0060 04D04BE2 		sub	sp, fp, #4
  72              		@ sp needed
  73 0064 0088BDE8 		pop	{fp, pc}
  75              	.LFE6:
  77              		.align	2
  78              		.global	_divideBy8
  79              		.syntax unified
  80              		.arm
  81              		.fpu vfp
  83              	_divideBy8:
  84              	.LFB7:
  19:GeneralFunctAndOptimize.c **** void _divideBy8(struct EV_IntHolder * EV_num)
  20:GeneralFunctAndOptimize.c **** {
  87              		@ args = 0, pretend = 0, frame = 8
  88              		@ frame_needed = 1, uses_anonymous_args = 0
  89              		@ link register save eliminated.
  90 0068 04B02DE5 		str	fp, [sp, #-4]!
  93 006c 00B08DE2 		add	fp, sp, #0
  95 0070 0CD04DE2 		sub	sp, sp, #12
  96 0074 08000BE5 		str	r0, [fp, #-8]
  21:GeneralFunctAndOptimize.c **** EV_num->EV_num = (EV_num->EV_num/2);
  98 0078 08301BE5 		ldr	r3, [fp, #-8]
  99 007c 003093E5 		ldr	r3, [r3]
 101 0080 A32FA0E1 		lsr	r2, r3, #31
 102 0084 033082E0 		add	r3, r2, r3
 103 0088 C330A0E1 		asr	r3, r3, #1
 104 008c 0320A0E1 		mov	r2, r3
 106 0090 08301BE5 		ldr	r3, [fp, #-8]
 107 0094 002083E5 		str	r2, [r3]
  22:GeneralFunctAndOptimize.c **** EV_num->EV_num = (EV_num->EV_num/2);
 109 0098 08301BE5 		ldr	r3, [fp, #-8]
 110 009c 003093E5 		ldr	r3, [r3]
 112 00a0 A32FA0E1 		lsr	r2, r3, #31
 113 00a4 033082E0 		add	r3, r2, r3
 114 00a8 C330A0E1 		asr	r3, r3, #1
 115 00ac 0320A0E1 		mov	r2, r3
 117 00b0 08301BE5 		ldr	r3, [fp, #-8]
 118 00b4 002083E5 		str	r2, [r3]
  23:GeneralFunctAndOptimize.c **** EV_num->EV_num = (EV_num->EV_num/2);
 120 00b8 08301BE5 		ldr	r3, [fp, #-8]
 121 00bc 003093E5 		ldr	r3, [r3]
 123 00c0 A32FA0E1 		lsr	r2, r3, #31
 124 00c4 033082E0 		add	r3, r2, r3
 125 00c8 C330A0E1 		asr	r3, r3, #1
 126 00cc 0320A0E1 		mov	r2, r3
 128 00d0 08301BE5 		ldr	r3, [fp, #-8]
 129 00d4 002083E5 		str	r2, [r3]
  24:GeneralFunctAndOptimize.c **** }
 131 00d8 0000A0E1 		nop
 132 00dc 00D08BE2 		add	sp, fp, #0
 134              		@ sp needed
 135 00e0 04B09DE4 		ldr	fp, [sp], #4
 138 00e4 1EFF2FE1 		bx	lr
 140              	.LFE7:
 142              		.section	.rodata
 143              		.align	2
 144              	.LC0:
 145 0000 256400   		.ascii	"%d\000"
 146 0003 00       		.align	2
 147              	.LC1:
 148 0004 25640A00 		.ascii	"%d\012\000"
 149              		.text
 150              		.align	2
 151              		.global	_main
 152              		.syntax unified
 153              		.arm
 154              		.fpu vfp
 156              	_main:
 157              	.LFB8:
  25:GeneralFunctAndOptimize.c **** int _main()
  26:GeneralFunctAndOptimize.c **** {
 160              		@ args = 0, pretend = 0, frame = 32
 161              		@ frame_needed = 1, uses_anonymous_args = 0
 162 00e8 00482DE9 		push	{fp, lr}
 166 00ec 04B08DE2 		add	fp, sp, #4
 168 00f0 20D04DE2 		sub	sp, sp, #32
  27:GeneralFunctAndOptimize.c **** int EV_start;
  28:GeneralFunctAndOptimize.c **** int EV_countOuter;
  29:GeneralFunctAndOptimize.c **** int EV_countInner;
  30:GeneralFunctAndOptimize.c **** int EV_calc;
  31:GeneralFunctAndOptimize.c **** int EV_tempAnswer;
  32:GeneralFunctAndOptimize.c **** int EV_tempInterval;
  33:GeneralFunctAndOptimize.c **** struct EV_IntHolder * EV_x;
  34:GeneralFunctAndOptimize.c **** int EV_uselessVar;
  35:GeneralFunctAndOptimize.c **** int EV_uselessVar2;
  36:GeneralFunctAndOptimize.c **** EV_x = (struct EV_IntHolder*)malloc(sizeof(struct EV_IntHolder));
 170 00f4 0400A0E3 		mov	r0, #4
 171 00f8 FEFFFFEB 		bl	malloc
 172 00fc 0030A0E1 		mov	r3, r0
 173 0100 18300BE5 		str	r3, [fp, #-24]
  37:GeneralFunctAndOptimize.c **** EV_end = 1000000;
 175 0104 4C319FE5 		ldr	r3, .L12
 176 0108 4C219FE5 		ldr	r2, .L12+4
 177 010c 002083E5 		str	r2, [r3]
  38:GeneralFunctAndOptimize.c **** scanf("%d", &EV_start);
 179 0110 24304BE2 		sub	r3, fp, #36
 180 0114 0310A0E1 		mov	r1, r3
 181 0118 40019FE5 		ldr	r0, .L12+8
 182 011c FEFFFFEB 		bl	__isoc99_scanf
  39:GeneralFunctAndOptimize.c **** scanf("%d", &EV_interval);
 184 0120 3C119FE5 		ldr	r1, .L12+12
 185 0124 34019FE5 		ldr	r0, .L12+8
 186 0128 FEFFFFEB 		bl	__isoc99_scanf
  40:GeneralFunctAndOptimize.c **** printf("%d\n", EV_start);
 188 012c 24301BE5 		ldr	r3, [fp, #-36]
 189 0130 0310A0E1 		mov	r1, r3
 190 0134 2C019FE5 		ldr	r0, .L12+16
 191 0138 FEFFFFEB 		bl	printf
  41:GeneralFunctAndOptimize.c **** printf("%d\n", EV_interval);
 193 013c 20319FE5 		ldr	r3, .L12+12
 194 0140 003093E5 		ldr	r3, [r3]
 195 0144 0310A0E1 		mov	r1, r3
 196 0148 18019FE5 		ldr	r0, .L12+16
 197 014c FEFFFFEB 		bl	printf
  42:GeneralFunctAndOptimize.c **** EV_countOuter = 0;
 199 0150 0030A0E3 		mov	r3, #0
 200 0154 08300BE5 		str	r3, [fp, #-8]
  43:GeneralFunctAndOptimize.c **** EV_countInner = 0;
 202 0158 0030A0E3 		mov	r3, #0
 203 015c 0C300BE5 		str	r3, [fp, #-12]
  44:GeneralFunctAndOptimize.c **** EV_calc = 0;
 205 0160 0030A0E3 		mov	r3, #0
 206 0164 10300BE5 		str	r3, [fp, #-16]
  45:GeneralFunctAndOptimize.c **** while ((EV_countOuter<50))
 208 0168 2D0000EA 		b	.L6
 209              	.L10:
  46:GeneralFunctAndOptimize.c **** {
  47:GeneralFunctAndOptimize.c **** EV_countInner = 0;
 211 016c 0030A0E3 		mov	r3, #0
 212 0170 0C300BE5 		str	r3, [fp, #-12]
  48:GeneralFunctAndOptimize.c **** while ((EV_countInner<=EV_end))
 214 0174 220000EA 		b	.L7
 215              	.L9:
  49:GeneralFunctAndOptimize.c **** {
  50:GeneralFunctAndOptimize.c **** EV_calc = ((((((((((1*2)*3)*4)*5)*6)*7)*8)*9)*10)*11);
 217 0178 EC309FE5 		ldr	r3, .L12+20
 218 017c 10300BE5 		str	r3, [fp, #-16]
  51:GeneralFunctAndOptimize.c **** EV_countInner = (EV_countInner+1);
 220 0180 0C301BE5 		ldr	r3, [fp, #-12]
 221 0184 013083E2 		add	r3, r3, #1
 222 0188 0C300BE5 		str	r3, [fp, #-12]
  52:GeneralFunctAndOptimize.c **** EV_x->EV_num = EV_countInner;
 224 018c 18301BE5 		ldr	r3, [fp, #-24]
 225 0190 0C201BE5 		ldr	r2, [fp, #-12]
 226 0194 002083E5 		str	r2, [r3]
  53:GeneralFunctAndOptimize.c **** EV_tempAnswer = EV_x->EV_num;
 228 0198 18301BE5 		ldr	r3, [fp, #-24]
 229 019c 003093E5 		ldr	r3, [r3]
 230 01a0 1C300BE5 		str	r3, [fp, #-28]
  54:GeneralFunctAndOptimize.c **** _multBy4xTimes(EV_x, 2);
 232 01a4 0210A0E3 		mov	r1, #2
 233 01a8 18001BE5 		ldr	r0, [fp, #-24]
 234 01ac FEFFFFEB 		bl	_multBy4xTimes
  55:GeneralFunctAndOptimize.c **** _divideBy8(EV_x);
 236 01b0 18001BE5 		ldr	r0, [fp, #-24]
 237 01b4 FEFFFFEB 		bl	_divideBy8
  56:GeneralFunctAndOptimize.c **** EV_tempInterval = (EV_interval-1);
 239 01b8 A4309FE5 		ldr	r3, .L12+12
 240 01bc 003093E5 		ldr	r3, [r3]
 242 01c0 013043E2 		sub	r3, r3, #1
 243 01c4 14300BE5 		str	r3, [fp, #-20]
  57:GeneralFunctAndOptimize.c **** EV_uselessVar = (EV_tempInterval<=0);
 245 01c8 14301BE5 		ldr	r3, [fp, #-20]
 246 01cc 000053E3 		cmp	r3, #0
 247 01d0 0130A0D3 		movle	r3, #1
 248 01d4 0030A0C3 		movgt	r3, #0
 249 01d8 7330EFE6 		uxtb	r3, r3
 251 01dc 20300BE5 		str	r3, [fp, #-32]
  58:GeneralFunctAndOptimize.c **** if ((EV_tempInterval<=0))
 253 01e0 14301BE5 		ldr	r3, [fp, #-20]
 254 01e4 000053E3 		cmp	r3, #0
 255 01e8 010000CA 		bgt	.L8
  59:GeneralFunctAndOptimize.c **** {
  60:GeneralFunctAndOptimize.c **** EV_tempInterval = 1;
 257 01ec 0130A0E3 		mov	r3, #1
 258 01f0 14300BE5 		str	r3, [fp, #-20]
 259              	.L8:
  61:GeneralFunctAndOptimize.c **** }
  62:GeneralFunctAndOptimize.c **** EV_countInner = (EV_countInner+EV_tempInterval);
 261 01f4 0C201BE5 		ldr	r2, [fp, #-12]
 262 01f8 14301BE5 		ldr	r3, [fp, #-20]
 263 01fc 033082E0 		add	r3, r2, r3
 264 0200 0C300BE5 		str	r3, [fp, #-12]
 265              	.L7:
  48:GeneralFunctAndOptimize.c **** {
 267 0204 4C309FE5 		ldr	r3, .L12
 268 0208 003093E5 		ldr	r3, [r3]
  48:GeneralFunctAndOptimize.c **** {
 270 020c 0C201BE5 		ldr	r2, [fp, #-12]
 271 0210 030052E1 		cmp	r2, r3
 272 0214 D7FFFFDA 		ble	.L9
  63:GeneralFunctAndOptimize.c **** }
  64:GeneralFunctAndOptimize.c **** EV_countOuter = (EV_countOuter+1);
 274 0218 08301BE5 		ldr	r3, [fp, #-8]
 275 021c 013083E2 		add	r3, r3, #1
 276 0220 08300BE5 		str	r3, [fp, #-8]
 277              	.L6:
  45:GeneralFunctAndOptimize.c **** {
 279 0224 08301BE5 		ldr	r3, [fp, #-8]
 280 0228 310053E3 		cmp	r3, #49
 281 022c CEFFFFDA 		ble	.L10
  65:GeneralFunctAndOptimize.c **** }
  66:GeneralFunctAndOptimize.c **** printf("%d\n", EV_countInner);
 283 0230 0C101BE5 		ldr	r1, [fp, #-12]
 284 0234 2C009FE5 		ldr	r0, .L12+16
 285 0238 FEFFFFEB 		bl	printf
  67:GeneralFunctAndOptimize.c **** printf("%d\n", EV_calc);
 287 023c 10101BE5 		ldr	r1, [fp, #-16]
 288 0240 20009FE5 		ldr	r0, .L12+16
 289 0244 FEFFFFEB 		bl	printf
  68:GeneralFunctAndOptimize.c **** return 0;
 291 0248 0030A0E3 		mov	r3, #0
  69:GeneralFunctAndOptimize.c **** }
 293 024c 0300A0E1 		mov	r0, r3
 294 0250 04D04BE2 		sub	sp, fp, #4
 296              		@ sp needed
 297 0254 0088BDE8 		pop	{fp, pc}
 298              	.L13:
 299              		.align	2
 300              	.L12:
 301 0258 00000000 		.word	EV_end
 302 025c 40420F00 		.word	1000000
 303 0260 00000000 		.word	.LC0
 304 0264 00000000 		.word	EV_interval
 305 0268 04000000 		.word	.LC1
 306 026c 00156102 		.word	39916800
 308              	.LFE8:
 310              		.align	2
 311              		.global	main
 312              		.syntax unified
 313              		.arm
 314              		.fpu vfp
 316              	main:
 317              	.LFB9:
  70:GeneralFunctAndOptimize.c **** int main(void)
  71:GeneralFunctAndOptimize.c **** {
 320              		@ args = 0, pretend = 0, frame = 0
 321              		@ frame_needed = 1, uses_anonymous_args = 0
 322 0270 00482DE9 		push	{fp, lr}
 326 0274 04B08DE2 		add	fp, sp, #4
  72:GeneralFunctAndOptimize.c ****    return _main();
 329 0278 FEFFFFEB 		bl	_main
 330 027c 0030A0E1 		mov	r3, r0
  73:GeneralFunctAndOptimize.c **** }
 332 0280 0300A0E1 		mov	r0, r3
 333 0284 0088BDE8 		pop	{fp, pc}
 335              	.LFE9:
 337              	.Letext0:
