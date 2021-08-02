   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.comm	EV_GLOBAL,4,4
  17              		.comm	EV_count,4,4
  18              		.align	2
  19              		.global	_fun2
  20              		.arch armv6
  21              		.syntax unified
  22              		.arm
  23              		.fpu vfp
  25              	_fun2:
  26              	.LFB6:
   1:programBreaker.c **** #include<stdio.h>
   2:programBreaker.c **** #include<stdlib.h>
   3:programBreaker.c **** int EV_GLOBAL;
   4:programBreaker.c **** int EV_count;
   5:programBreaker.c **** int _fun2(int EV_x,int EV_y)
   6:programBreaker.c **** {
  30              		@ args = 0, pretend = 0, frame = 8
  31              		@ frame_needed = 1, uses_anonymous_args = 0
  32 0000 00482DE9 		push	{fp, lr}
  36 0004 04B08DE2 		add	fp, sp, #4
  38 0008 08D04DE2 		sub	sp, sp, #8
  39 000c 08000BE5 		str	r0, [fp, #-8]
  40 0010 0C100BE5 		str	r1, [fp, #-12]
   7:programBreaker.c **** if ((EV_x==0))
  42 0014 08301BE5 		ldr	r3, [fp, #-8]
  43 0018 000053E3 		cmp	r3, #0
  44 001c 0100001A 		bne	.L2
   8:programBreaker.c **** {
   9:programBreaker.c **** return EV_y;
  46 0020 0C301BE5 		ldr	r3, [fp, #-12]
  47 0024 050000EA 		b	.L3
  48              	.L2:
  10:programBreaker.c **** }
  11:programBreaker.c **** else
  12:programBreaker.c **** {
  13:programBreaker.c **** return _fun2((EV_x-1), EV_y);
  50 0028 08301BE5 		ldr	r3, [fp, #-8]
  51 002c 013043E2 		sub	r3, r3, #1
  52 0030 0C101BE5 		ldr	r1, [fp, #-12]
  53 0034 0300A0E1 		mov	r0, r3
  54 0038 FEFFFFEB 		bl	_fun2
  55 003c 0030A0E1 		mov	r3, r0
  56              	.L3:
  14:programBreaker.c **** }
  15:programBreaker.c **** }
  58 0040 0300A0E1 		mov	r0, r3
  59 0044 04D04BE2 		sub	sp, fp, #4
  61              		@ sp needed
  62 0048 0088BDE8 		pop	{fp, pc}
  64              	.LFE6:
  67              		.align	2
  68              		.global	_fun1
  69              		.syntax unified
  70              		.arm
  71              		.fpu vfp
  73              	_fun1:
  74              	.LFB7:
  16:programBreaker.c **** int _fun1(int EV_x,int EV_y,int EV_z)
  17:programBreaker.c **** {
  77              		@ args = 0, pretend = 0, frame = 24
  78              		@ frame_needed = 1, uses_anonymous_args = 0
  79 004c 10482DE9 		push	{r4, fp, lr}
  84 0050 08B08DE2 		add	fp, sp, #8
  86 0054 1CD04DE2 		sub	sp, sp, #28
  87 0058 18000BE5 		str	r0, [fp, #-24]
  88 005c 1C100BE5 		str	r1, [fp, #-28]
  89 0060 20200BE5 		str	r2, [fp, #-32]
  18:programBreaker.c **** int EV_retVal;
  19:programBreaker.c **** EV_retVal = ((((5+6)-(EV_x*2))+(4/EV_y))+EV_z);
  91 0064 18301BE5 		ldr	r3, [fp, #-24]
  92 0068 8330A0E1 		lsl	r3, r3, #1
  94 006c 0B4063E2 		rsb	r4, r3, #11
  96 0070 1C101BE5 		ldr	r1, [fp, #-28]
  97 0074 0400A0E3 		mov	r0, #4
  99              	.LVL0:
 100 007c 0030A0E1 		mov	r3, r0
 102 0080 033084E0 		add	r3, r4, r3
 104 0084 20201BE5 		ldr	r2, [fp, #-32]
 105 0088 033082E0 		add	r3, r2, r3
 106 008c 10300BE5 		str	r3, [fp, #-16]
  20:programBreaker.c **** if ((EV_retVal>EV_y))
 108 0090 10201BE5 		ldr	r2, [fp, #-16]
 109 0094 1C301BE5 		ldr	r3, [fp, #-28]
 110 0098 030052E1 		cmp	r2, r3
 111 009c 040000DA 		ble	.L5
  21:programBreaker.c **** {
  22:programBreaker.c **** return _fun2(EV_retVal, EV_x);
 113 00a0 18101BE5 		ldr	r1, [fp, #-24]
 114 00a4 10001BE5 		ldr	r0, [fp, #-16]
 115 00a8 FEFFFFEB 		bl	_fun2
 116 00ac 0030A0E1 		mov	r3, r0
 117 00b0 090000EA 		b	.L6
 118              	.L5:
  23:programBreaker.c **** }
  24:programBreaker.c **** else
  25:programBreaker.c **** {
  26:programBreaker.c **** if (((5<6)&&(EV_retVal<=EV_y)))
 120 00b4 10201BE5 		ldr	r2, [fp, #-16]
 121 00b8 1C301BE5 		ldr	r3, [fp, #-28]
 122 00bc 030052E1 		cmp	r2, r3
 123 00c0 040000CA 		bgt	.L7
  27:programBreaker.c **** {
  28:programBreaker.c **** return _fun2(EV_retVal, EV_y);
 125 00c4 1C101BE5 		ldr	r1, [fp, #-28]
 126 00c8 10001BE5 		ldr	r0, [fp, #-16]
 127 00cc FEFFFFEB 		bl	_fun2
 128 00d0 0030A0E1 		mov	r3, r0
 129 00d4 000000EA 		b	.L6
 130              	.L7:
  29:programBreaker.c **** }
  30:programBreaker.c **** }
  31:programBreaker.c **** return EV_retVal;
 132 00d8 10301BE5 		ldr	r3, [fp, #-16]
 133              	.L6:
  32:programBreaker.c **** }
 135 00dc 0300A0E1 		mov	r0, r3
 136 00e0 08D04BE2 		sub	sp, fp, #8
 138              		@ sp needed
 139 00e4 1088BDE8 		pop	{r4, fp, pc}
 141              	.LFE7:
 143              		.section	.rodata
 144              		.align	2
 145              	.LC0:
 146 0000 256400   		.ascii	"%d\000"
 147 0003 00       		.align	2
 148              	.LC1:
 149 0004 25640A00 		.ascii	"%d\012\000"
 150              		.text
 151              		.align	2
 152              		.global	_main
 153              		.syntax unified
 154              		.arm
 155              		.fpu vfp
 157              	_main:
 158              	.LFB8:
  33:programBreaker.c **** int _main()
  34:programBreaker.c **** {
 161              		@ args = 0, pretend = 0, frame = 8
 162              		@ frame_needed = 1, uses_anonymous_args = 0
 163 00e8 00482DE9 		push	{fp, lr}
 167 00ec 04B08DE2 		add	fp, sp, #4
 169 00f0 08D04DE2 		sub	sp, sp, #8
  35:programBreaker.c **** int EV_i;
  36:programBreaker.c **** EV_i = 0;
 171 00f4 0030A0E3 		mov	r3, #0
 172 00f8 08300BE5 		str	r3, [fp, #-8]
  37:programBreaker.c **** scanf("%d", &EV_i);
 174 00fc 08304BE2 		sub	r3, fp, #8
 175 0100 0310A0E1 		mov	r1, r3
 176 0104 54009FE5 		ldr	r0, .L12
 177 0108 FEFFFFEB 		bl	__isoc99_scanf
  38:programBreaker.c **** while ((EV_i<10000))
 179 010c 0B0000EA 		b	.L9
 180              	.L10:
  39:programBreaker.c **** {
  40:programBreaker.c **** printf("%d\n", _fun1(3, EV_i, 5));
 182 0110 08301BE5 		ldr	r3, [fp, #-8]
 183 0114 0520A0E3 		mov	r2, #5
 184 0118 0310A0E1 		mov	r1, r3
 185 011c 0300A0E3 		mov	r0, #3
 186 0120 FEFFFFEB 		bl	_fun1
 187 0124 0030A0E1 		mov	r3, r0
 188 0128 0310A0E1 		mov	r1, r3
 189 012c 30009FE5 		ldr	r0, .L12+4
 190 0130 FEFFFFEB 		bl	printf
  41:programBreaker.c **** EV_i = (EV_i+1);
 192 0134 08301BE5 		ldr	r3, [fp, #-8]
 193 0138 013083E2 		add	r3, r3, #1
 195 013c 08300BE5 		str	r3, [fp, #-8]
 196              	.L9:
  38:programBreaker.c **** while ((EV_i<10000))
 198 0140 08301BE5 		ldr	r3, [fp, #-8]
  38:programBreaker.c **** while ((EV_i<10000))
 200 0144 1C209FE5 		ldr	r2, .L12+8
 201 0148 020053E1 		cmp	r3, r2
 202 014c EFFFFFDA 		ble	.L10
  42:programBreaker.c **** }
  43:programBreaker.c **** return 0;
 204 0150 0030A0E3 		mov	r3, #0
  44:programBreaker.c **** }
 206 0154 0300A0E1 		mov	r0, r3
 207 0158 04D04BE2 		sub	sp, fp, #4
 209              		@ sp needed
 210 015c 0088BDE8 		pop	{fp, pc}
 211              	.L13:
 212              		.align	2
 213              	.L12:
 214 0160 00000000 		.word	.LC0
 215 0164 04000000 		.word	.LC1
 216 0168 0F270000 		.word	9999
 218              	.LFE8:
 220              		.align	2
 221              		.global	main
 222              		.syntax unified
 223              		.arm
 224              		.fpu vfp
 226              	main:
 227              	.LFB9:
  45:programBreaker.c **** int main(void)
  46:programBreaker.c **** {
 230              		@ args = 0, pretend = 0, frame = 0
 231              		@ frame_needed = 1, uses_anonymous_args = 0
 232 016c 00482DE9 		push	{fp, lr}
 236 0170 04B08DE2 		add	fp, sp, #4
  47:programBreaker.c ****    return _main();
 239 0174 FEFFFFEB 		bl	_main
 240 0178 0030A0E1 		mov	r3, r0
  48:programBreaker.c **** }
 242 017c 0300A0E1 		mov	r0, r3
 243 0180 0088BDE8 		pop	{fp, pc}
 245              	.LFE9:
 247              	.Letext0:
