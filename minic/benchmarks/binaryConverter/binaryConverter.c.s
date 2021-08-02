   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.align	2
  17              		.global	_wait
  18              		.arch armv6
  19              		.syntax unified
  20              		.arm
  21              		.fpu vfp
  23              	_wait:
  24              	.LFB6:
   1:binaryConverter.c **** #include<stdio.h>
   2:binaryConverter.c **** #include<stdlib.h>
   3:binaryConverter.c **** int _wait(int EV_waitTime)
   4:binaryConverter.c **** {
  28              		@ args = 0, pretend = 0, frame = 8
  29              		@ frame_needed = 1, uses_anonymous_args = 0
  30              		@ link register save eliminated.
  31 0000 04B02DE5 		str	fp, [sp, #-4]!
  34 0004 00B08DE2 		add	fp, sp, #0
  36 0008 0CD04DE2 		sub	sp, sp, #12
  37 000c 08000BE5 		str	r0, [fp, #-8]
   5:binaryConverter.c **** while ((EV_waitTime>0))
  39 0010 020000EA 		b	.L2
  40              	.L3:
   6:binaryConverter.c **** {
   7:binaryConverter.c **** EV_waitTime = (EV_waitTime-1);
  42 0014 08301BE5 		ldr	r3, [fp, #-8]
  43 0018 013043E2 		sub	r3, r3, #1
  44 001c 08300BE5 		str	r3, [fp, #-8]
  45              	.L2:
   5:binaryConverter.c **** while ((EV_waitTime>0))
  47 0020 08301BE5 		ldr	r3, [fp, #-8]
  48 0024 000053E3 		cmp	r3, #0
  49 0028 F9FFFFCA 		bgt	.L3
   8:binaryConverter.c **** }
   9:binaryConverter.c **** return 0;
  51 002c 0030A0E3 		mov	r3, #0
  10:binaryConverter.c **** }
  53 0030 0300A0E1 		mov	r0, r3
  54 0034 00D08BE2 		add	sp, fp, #0
  56              		@ sp needed
  57 0038 04B09DE4 		ldr	fp, [sp], #4
  60 003c 1EFF2FE1 		bx	lr
  62              	.LFE6:
  64              		.align	2
  65              		.global	_power
  66              		.syntax unified
  67              		.arm
  68              		.fpu vfp
  70              	_power:
  71              	.LFB7:
  11:binaryConverter.c **** int _power(int EV_base,int EV_exponent)
  12:binaryConverter.c **** {
  74              		@ args = 0, pretend = 0, frame = 16
  75              		@ frame_needed = 1, uses_anonymous_args = 0
  76              		@ link register save eliminated.
  77 0040 04B02DE5 		str	fp, [sp, #-4]!
  80 0044 00B08DE2 		add	fp, sp, #0
  82 0048 14D04DE2 		sub	sp, sp, #20
  83 004c 10000BE5 		str	r0, [fp, #-16]
  84 0050 14100BE5 		str	r1, [fp, #-20]
  13:binaryConverter.c **** int EV_product;
  14:binaryConverter.c **** EV_product = 1;
  86 0054 0130A0E3 		mov	r3, #1
  87 0058 08300BE5 		str	r3, [fp, #-8]
  15:binaryConverter.c **** while ((EV_exponent>0))
  89 005c 060000EA 		b	.L6
  90              	.L7:
  16:binaryConverter.c **** {
  17:binaryConverter.c **** EV_product = (EV_product*EV_base);
  92 0060 08301BE5 		ldr	r3, [fp, #-8]
  93 0064 10201BE5 		ldr	r2, [fp, #-16]
  94 0068 920303E0 		mul	r3, r2, r3
  95 006c 08300BE5 		str	r3, [fp, #-8]
  18:binaryConverter.c **** EV_exponent = (EV_exponent-1);
  97 0070 14301BE5 		ldr	r3, [fp, #-20]
  98 0074 013043E2 		sub	r3, r3, #1
  99 0078 14300BE5 		str	r3, [fp, #-20]
 100              	.L6:
  15:binaryConverter.c **** while ((EV_exponent>0))
 102 007c 14301BE5 		ldr	r3, [fp, #-20]
 103 0080 000053E3 		cmp	r3, #0
 104 0084 F5FFFFCA 		bgt	.L7
  19:binaryConverter.c **** }
  20:binaryConverter.c **** return EV_product;
 106 0088 08301BE5 		ldr	r3, [fp, #-8]
  21:binaryConverter.c **** }
 108 008c 0300A0E1 		mov	r0, r3
 109 0090 00D08BE2 		add	sp, fp, #0
 111              		@ sp needed
 112 0094 04B09DE4 		ldr	fp, [sp], #4
 115 0098 1EFF2FE1 		bx	lr
 117              	.LFE7:
 119              		.align	2
 120              		.global	_recursiveDecimalSum
 121              		.syntax unified
 122              		.arm
 123              		.fpu vfp
 125              	_recursiveDecimalSum:
 126              	.LFB8:
  22:binaryConverter.c **** int _recursiveDecimalSum(int EV_binaryNum,int EV_decimalSum,int EV_recursiveDepth)
  23:binaryConverter.c **** {
 129              		@ args = 0, pretend = 0, frame = 24
 130              		@ frame_needed = 1, uses_anonymous_args = 0
 131 009c 00482DE9 		push	{fp, lr}
 135 00a0 04B08DE2 		add	fp, sp, #4
 137 00a4 18D04DE2 		sub	sp, sp, #24
 138 00a8 10000BE5 		str	r0, [fp, #-16]
 139 00ac 14100BE5 		str	r1, [fp, #-20]
 140 00b0 18200BE5 		str	r2, [fp, #-24]
  24:binaryConverter.c **** int EV_tempNum;
  25:binaryConverter.c **** int EV_base;
  26:binaryConverter.c **** int EV_remainder;
  27:binaryConverter.c **** if ((EV_binaryNum>0))
 142 00b4 10301BE5 		ldr	r3, [fp, #-16]
 143 00b8 000053E3 		cmp	r3, #0
 144 00bc 290000DA 		ble	.L10
  28:binaryConverter.c **** {
  29:binaryConverter.c **** EV_base = 2;
 146 00c0 0230A0E3 		mov	r3, #2
 147 00c4 08300BE5 		str	r3, [fp, #-8]
  30:binaryConverter.c **** EV_tempNum = (EV_binaryNum/10);
 149 00c8 10301BE5 		ldr	r3, [fp, #-16]
 150 00cc A4209FE5 		ldr	r2, .L13
 151 00d0 9213C2E0 		smull	r1, r2, r2, r3
 152 00d4 4221A0E1 		asr	r2, r2, #2
 153 00d8 C33FA0E1 		asr	r3, r3, #31
 154 00dc 033042E0 		sub	r3, r2, r3
 155 00e0 0C300BE5 		str	r3, [fp, #-12]
  31:binaryConverter.c **** EV_tempNum = (EV_tempNum*10);
 157 00e4 0C201BE5 		ldr	r2, [fp, #-12]
 158 00e8 0230A0E1 		mov	r3, r2
 159 00ec 0331A0E1 		lsl	r3, r3, #2
 160 00f0 023083E0 		add	r3, r3, r2
 161 00f4 8330A0E1 		lsl	r3, r3, #1
 162 00f8 0C300BE5 		str	r3, [fp, #-12]
  32:binaryConverter.c **** EV_tempNum = (EV_binaryNum-EV_tempNum);
 164 00fc 10201BE5 		ldr	r2, [fp, #-16]
 165 0100 0C301BE5 		ldr	r3, [fp, #-12]
 166 0104 033042E0 		sub	r3, r2, r3
 167 0108 0C300BE5 		str	r3, [fp, #-12]
  33:binaryConverter.c **** if ((EV_tempNum==1))
 169 010c 0C301BE5 		ldr	r3, [fp, #-12]
 170 0110 010053E3 		cmp	r3, #1
 171 0114 0600001A 		bne	.L11
  34:binaryConverter.c **** {
  35:binaryConverter.c **** EV_decimalSum = (EV_decimalSum+_power(EV_base, EV_recursiveDepth));
 173 0118 18101BE5 		ldr	r1, [fp, #-24]
 174 011c 08001BE5 		ldr	r0, [fp, #-8]
 175 0120 FEFFFFEB 		bl	_power
 176 0124 0020A0E1 		mov	r2, r0
 178 0128 14301BE5 		ldr	r3, [fp, #-20]
 179 012c 023083E0 		add	r3, r3, r2
 180 0130 14300BE5 		str	r3, [fp, #-20]
 181              	.L11:
  36:binaryConverter.c **** }
  37:binaryConverter.c **** return _recursiveDecimalSum((EV_binaryNum/10), EV_decimalSum, (EV_recursiveDepth+1));
 183 0134 10301BE5 		ldr	r3, [fp, #-16]
 184 0138 38209FE5 		ldr	r2, .L13
 185 013c 9213C2E0 		smull	r1, r2, r2, r3
 186 0140 4221A0E1 		asr	r2, r2, #2
 187 0144 C33FA0E1 		asr	r3, r3, #31
 188 0148 030042E0 		sub	r0, r2, r3
 189 014c 18301BE5 		ldr	r3, [fp, #-24]
 190 0150 013083E2 		add	r3, r3, #1
 191 0154 0320A0E1 		mov	r2, r3
 192 0158 14101BE5 		ldr	r1, [fp, #-20]
 193 015c FEFFFFEB 		bl	_recursiveDecimalSum
 194 0160 0030A0E1 		mov	r3, r0
 195 0164 000000EA 		b	.L12
 196              	.L10:
  38:binaryConverter.c **** }
  39:binaryConverter.c **** return EV_decimalSum;
 198 0168 14301BE5 		ldr	r3, [fp, #-20]
 199              	.L12:
  40:binaryConverter.c **** }
 201 016c 0300A0E1 		mov	r0, r3
 202 0170 04D04BE2 		sub	sp, fp, #4
 204              		@ sp needed
 205 0174 0088BDE8 		pop	{fp, pc}
 206              	.L14:
 207              		.align	2
 208              	.L13:
 209 0178 67666666 		.word	1717986919
 211              	.LFE8:
 213              		.align	2
 214              		.global	_convertToDecimal
 215              		.syntax unified
 216              		.arm
 217              		.fpu vfp
 219              	_convertToDecimal:
 220              	.LFB9:
  41:binaryConverter.c **** int _convertToDecimal(int EV_binaryNum)
  42:binaryConverter.c **** {
 223              		@ args = 0, pretend = 0, frame = 16
 224              		@ frame_needed = 1, uses_anonymous_args = 0
 225 017c 00482DE9 		push	{fp, lr}
 229 0180 04B08DE2 		add	fp, sp, #4
 231 0184 10D04DE2 		sub	sp, sp, #16
 232 0188 10000BE5 		str	r0, [fp, #-16]
  43:binaryConverter.c **** int EV_recursiveDepth;
  44:binaryConverter.c **** int EV_decimalSum;
  45:binaryConverter.c **** EV_recursiveDepth = 0;
 234 018c 0030A0E3 		mov	r3, #0
 235 0190 08300BE5 		str	r3, [fp, #-8]
  46:binaryConverter.c **** EV_decimalSum = 0;
 237 0194 0030A0E3 		mov	r3, #0
 238 0198 0C300BE5 		str	r3, [fp, #-12]
  47:binaryConverter.c **** return _recursiveDecimalSum(EV_binaryNum, EV_decimalSum, EV_recursiveDepth);
 240 019c 08201BE5 		ldr	r2, [fp, #-8]
 241 01a0 0C101BE5 		ldr	r1, [fp, #-12]
 242 01a4 10001BE5 		ldr	r0, [fp, #-16]
 243 01a8 FEFFFFEB 		bl	_recursiveDecimalSum
 244 01ac 0030A0E1 		mov	r3, r0
  48:binaryConverter.c **** }
 246 01b0 0300A0E1 		mov	r0, r3
 247 01b4 04D04BE2 		sub	sp, fp, #4
 249              		@ sp needed
 250 01b8 0088BDE8 		pop	{fp, pc}
 252              	.LFE9:
 254              		.section	.rodata
 255              		.align	2
 256              	.LC0:
 257 0000 256400   		.ascii	"%d\000"
 258 0003 00       		.align	2
 259              	.LC1:
 260 0004 25640A00 		.ascii	"%d\012\000"
 261              		.text
 262              		.align	2
 263              		.global	_main
 264              		.syntax unified
 265              		.arm
 266              		.fpu vfp
 268              	_main:
 269              	.LFB10:
  49:binaryConverter.c **** int _main()
  50:binaryConverter.c **** {
 272              		@ args = 0, pretend = 0, frame = 8
 273              		@ frame_needed = 1, uses_anonymous_args = 0
 274 01bc 00482DE9 		push	{fp, lr}
 278 01c0 04B08DE2 		add	fp, sp, #4
 280 01c4 08D04DE2 		sub	sp, sp, #8
  51:binaryConverter.c **** int EV_number;
  52:binaryConverter.c **** int EV_waitTime;
  53:binaryConverter.c **** scanf("%d", &EV_number);
 282 01c8 0C304BE2 		sub	r3, fp, #12
 283 01cc 0310A0E1 		mov	r1, r3
 284 01d0 68009FE5 		ldr	r0, .L21
 285 01d4 FEFFFFEB 		bl	__isoc99_scanf
  54:binaryConverter.c **** EV_number = _convertToDecimal(EV_number);
 287 01d8 0C301BE5 		ldr	r3, [fp, #-12]
 288 01dc 0300A0E1 		mov	r0, r3
 289 01e0 FEFFFFEB 		bl	_convertToDecimal
 290 01e4 0030A0E1 		mov	r3, r0
 292 01e8 0C300BE5 		str	r3, [fp, #-12]
  55:binaryConverter.c **** EV_waitTime = (EV_number*EV_number);
 294 01ec 0C301BE5 		ldr	r3, [fp, #-12]
 295 01f0 0C201BE5 		ldr	r2, [fp, #-12]
 297 01f4 920303E0 		mul	r3, r2, r3
 298 01f8 08300BE5 		str	r3, [fp, #-8]
  56:binaryConverter.c **** while ((EV_waitTime>0))
 300 01fc 040000EA 		b	.L18
 301              	.L19:
  57:binaryConverter.c **** {
  58:binaryConverter.c **** _wait(EV_waitTime);
 303 0200 08001BE5 		ldr	r0, [fp, #-8]
 304 0204 FEFFFFEB 		bl	_wait
  59:binaryConverter.c **** EV_waitTime = (EV_waitTime-1);
 306 0208 08301BE5 		ldr	r3, [fp, #-8]
 307 020c 013043E2 		sub	r3, r3, #1
 308 0210 08300BE5 		str	r3, [fp, #-8]
 309              	.L18:
  56:binaryConverter.c **** while ((EV_waitTime>0))
 311 0214 08301BE5 		ldr	r3, [fp, #-8]
 312 0218 000053E3 		cmp	r3, #0
 313 021c F7FFFFCA 		bgt	.L19
  60:binaryConverter.c **** }
  61:binaryConverter.c **** printf("%d\n", EV_number);
 315 0220 0C301BE5 		ldr	r3, [fp, #-12]
 316 0224 0310A0E1 		mov	r1, r3
 317 0228 14009FE5 		ldr	r0, .L21+4
 318 022c FEFFFFEB 		bl	printf
  62:binaryConverter.c **** return 0;
 320 0230 0030A0E3 		mov	r3, #0
  63:binaryConverter.c **** }
 322 0234 0300A0E1 		mov	r0, r3
 323 0238 04D04BE2 		sub	sp, fp, #4
 325              		@ sp needed
 326 023c 0088BDE8 		pop	{fp, pc}
 327              	.L22:
 328              		.align	2
 329              	.L21:
 330 0240 00000000 		.word	.LC0
 331 0244 04000000 		.word	.LC1
 333              	.LFE10:
 335              		.align	2
 336              		.global	main
 337              		.syntax unified
 338              		.arm
 339              		.fpu vfp
 341              	main:
 342              	.LFB11:
  64:binaryConverter.c **** int main(void)
  65:binaryConverter.c **** {
 345              		@ args = 0, pretend = 0, frame = 0
 346              		@ frame_needed = 1, uses_anonymous_args = 0
 347 0248 00482DE9 		push	{fp, lr}
 351 024c 04B08DE2 		add	fp, sp, #4
  66:binaryConverter.c ****    return _main();
 354 0250 FEFFFFEB 		bl	_main
 355 0254 0030A0E1 		mov	r3, r0
  67:binaryConverter.c **** }
 357 0258 0300A0E1 		mov	r0, r3
 358 025c 0088BDE8 		pop	{fp, pc}
 360              	.LFE11:
 362              	.Letext0:
