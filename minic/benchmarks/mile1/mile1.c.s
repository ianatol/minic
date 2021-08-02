   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.align	2
  17              		.global	_calcPower
  18              		.arch armv6
  19              		.syntax unified
  20              		.arm
  21              		.fpu vfp
  23              	_calcPower:
  24              	.LFB6:
   1:mile1.c       **** #include<stdio.h>
   2:mile1.c       **** #include<stdlib.h>
   3:mile1.c       **** struct EV_Power
   4:mile1.c       **** {
   5:mile1.c       **** int EV_base;
   6:mile1.c       **** int EV_exp;
   7:mile1.c       **** };
   8:mile1.c       **** int _calcPower(int EV_base,int EV_exp)
   9:mile1.c       **** {
  28              		@ args = 0, pretend = 0, frame = 16
  29              		@ frame_needed = 1, uses_anonymous_args = 0
  30              		@ link register save eliminated.
  31 0000 04B02DE5 		str	fp, [sp, #-4]!
  34 0004 00B08DE2 		add	fp, sp, #0
  36 0008 14D04DE2 		sub	sp, sp, #20
  37 000c 10000BE5 		str	r0, [fp, #-16]
  38 0010 14100BE5 		str	r1, [fp, #-20]
  10:mile1.c       **** int EV_result;
  11:mile1.c       **** EV_result = 1;
  40 0014 0130A0E3 		mov	r3, #1
  41 0018 08300BE5 		str	r3, [fp, #-8]
  12:mile1.c       **** while ((EV_exp>0))
  43 001c 060000EA 		b	.L2
  44              	.L3:
  13:mile1.c       **** {
  14:mile1.c       **** EV_result = (EV_result*EV_base);
  46 0020 08301BE5 		ldr	r3, [fp, #-8]
  47 0024 10201BE5 		ldr	r2, [fp, #-16]
  48 0028 920303E0 		mul	r3, r2, r3
  49 002c 08300BE5 		str	r3, [fp, #-8]
  15:mile1.c       **** EV_exp = (EV_exp-1);
  51 0030 14301BE5 		ldr	r3, [fp, #-20]
  52 0034 013043E2 		sub	r3, r3, #1
  53 0038 14300BE5 		str	r3, [fp, #-20]
  54              	.L2:
  12:mile1.c       **** while ((EV_exp>0))
  56 003c 14301BE5 		ldr	r3, [fp, #-20]
  57 0040 000053E3 		cmp	r3, #0
  58 0044 F5FFFFCA 		bgt	.L3
  16:mile1.c       **** }
  17:mile1.c       **** return EV_result;
  60 0048 08301BE5 		ldr	r3, [fp, #-8]
  18:mile1.c       **** }
  62 004c 0300A0E1 		mov	r0, r3
  63 0050 00D08BE2 		add	sp, fp, #0
  65              		@ sp needed
  66 0054 04B09DE4 		ldr	fp, [sp], #4
  69 0058 1EFF2FE1 		bx	lr
  71              	.LFE6:
  73              		.section	.rodata
  74              		.align	2
  75              	.LC0:
  76 0000 256400   		.ascii	"%d\000"
  77 0003 00       		.align	2
  78              	.LC1:
  79 0004 25640A00 		.ascii	"%d\012\000"
  80              		.text
  81              		.align	2
  82              		.global	_main
  83              		.syntax unified
  84              		.arm
  85              		.fpu vfp
  87              	_main:
  88              	.LFB7:
  19:mile1.c       **** int _main()
  20:mile1.c       **** {
  91              		@ args = 0, pretend = 0, frame = 16
  92              		@ frame_needed = 1, uses_anonymous_args = 0
  93 005c 00482DE9 		push	{fp, lr}
  97 0060 04B08DE2 		add	fp, sp, #4
  99 0064 10D04DE2 		sub	sp, sp, #16
  21:mile1.c       **** struct EV_Power * EV_power;
  22:mile1.c       **** int EV_input;
  23:mile1.c       **** int EV_result;
  24:mile1.c       **** int EV_exp;
  25:mile1.c       **** int EV_i;
  26:mile1.c       **** EV_power = (struct EV_Power*)malloc(sizeof(struct EV_Power));
 101 0068 0800A0E3 		mov	r0, #8
 102 006c FEFFFFEB 		bl	malloc
 103 0070 0030A0E1 		mov	r3, r0
 104 0074 10300BE5 		str	r3, [fp, #-16]
  27:mile1.c       **** EV_result = 0;
 106 0078 0030A0E3 		mov	r3, #0
 107 007c 08300BE5 		str	r3, [fp, #-8]
  28:mile1.c       **** scanf("%d", &EV_input);
 109 0080 14304BE2 		sub	r3, fp, #20
 110 0084 0310A0E1 		mov	r1, r3
 111 0088 A0009FE5 		ldr	r0, .L11
 112 008c FEFFFFEB 		bl	__isoc99_scanf
  29:mile1.c       **** EV_power->EV_base = EV_input;
 114 0090 14201BE5 		ldr	r2, [fp, #-20]
 115 0094 10301BE5 		ldr	r3, [fp, #-16]
 116 0098 002083E5 		str	r2, [r3]
  30:mile1.c       **** scanf("%d", &EV_input);
 118 009c 14304BE2 		sub	r3, fp, #20
 119 00a0 0310A0E1 		mov	r1, r3
 120 00a4 84009FE5 		ldr	r0, .L11
 121 00a8 FEFFFFEB 		bl	__isoc99_scanf
  31:mile1.c       **** if ((EV_input<0))
 123 00ac 14301BE5 		ldr	r3, [fp, #-20]
 125 00b0 000053E3 		cmp	r3, #0
 126 00b4 010000AA 		bge	.L6
  32:mile1.c       **** {
  33:mile1.c       **** return (-1);
 128 00b8 0030E0E3 		mvn	r3, #0
 129 00bc 180000EA 		b	.L10
 130              	.L6:
  34:mile1.c       **** }
  35:mile1.c       **** EV_power->EV_exp = EV_input;
 132 00c0 14201BE5 		ldr	r2, [fp, #-20]
 133 00c4 10301BE5 		ldr	r3, [fp, #-16]
 134 00c8 042083E5 		str	r2, [r3, #4]
  36:mile1.c       **** EV_i = 0;
 136 00cc 0030A0E3 		mov	r3, #0
 137 00d0 0C300BE5 		str	r3, [fp, #-12]
  37:mile1.c       **** while ((EV_i<1000000))
 139 00d4 0A0000EA 		b	.L8
 140              	.L9:
  38:mile1.c       **** {
  39:mile1.c       **** EV_i = (EV_i+1);
 142 00d8 0C301BE5 		ldr	r3, [fp, #-12]
 143 00dc 013083E2 		add	r3, r3, #1
 144 00e0 0C300BE5 		str	r3, [fp, #-12]
  40:mile1.c       **** EV_result = _calcPower(EV_power->EV_base, EV_power->EV_exp);
 146 00e4 10301BE5 		ldr	r3, [fp, #-16]
 147 00e8 002093E5 		ldr	r2, [r3]
 148 00ec 10301BE5 		ldr	r3, [fp, #-16]
 149 00f0 043093E5 		ldr	r3, [r3, #4]
 150 00f4 0310A0E1 		mov	r1, r3
 151 00f8 0200A0E1 		mov	r0, r2
 152 00fc FEFFFFEB 		bl	_calcPower
 153 0100 08000BE5 		str	r0, [fp, #-8]
 154              	.L8:
  37:mile1.c       **** while ((EV_i<1000000))
 156 0104 0C301BE5 		ldr	r3, [fp, #-12]
 157 0108 24209FE5 		ldr	r2, .L11+4
 158 010c 020053E1 		cmp	r3, r2
 159 0110 F0FFFFDA 		ble	.L9
  41:mile1.c       **** }
  42:mile1.c       **** printf("%d\n", EV_result);
 161 0114 08101BE5 		ldr	r1, [fp, #-8]
 162 0118 18009FE5 		ldr	r0, .L11+8
 163 011c FEFFFFEB 		bl	printf
  43:mile1.c       **** return 1;
 165 0120 0130A0E3 		mov	r3, #1
 166              	.L10:
  44:mile1.c       **** }
 168 0124 0300A0E1 		mov	r0, r3
 169 0128 04D04BE2 		sub	sp, fp, #4
 171              		@ sp needed
 172 012c 0088BDE8 		pop	{fp, pc}
 173              	.L12:
 174              		.align	2
 175              	.L11:
 176 0130 00000000 		.word	.LC0
 177 0134 3F420F00 		.word	999999
 178 0138 04000000 		.word	.LC1
 180              	.LFE7:
 182              		.align	2
 183              		.global	main
 184              		.syntax unified
 185              		.arm
 186              		.fpu vfp
 188              	main:
 189              	.LFB8:
  45:mile1.c       **** int main(void)
  46:mile1.c       **** {
 192              		@ args = 0, pretend = 0, frame = 0
 193              		@ frame_needed = 1, uses_anonymous_args = 0
 194 013c 00482DE9 		push	{fp, lr}
 198 0140 04B08DE2 		add	fp, sp, #4
  47:mile1.c       ****    return _main();
 201 0144 FEFFFFEB 		bl	_main
 202 0148 0030A0E1 		mov	r3, r0
  48:mile1.c       **** }
 204 014c 0300A0E1 		mov	r0, r3
 205 0150 0088BDE8 		pop	{fp, pc}
 207              	.LFE8:
 209              	.Letext0:
