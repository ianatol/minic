   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.section	.rodata
  17              		.align	2
  18              	.LC0:
  19 0000 25642000 		.ascii	"%d \000"
  20              		.text
  21              		.align	2
  22              		.global	_function
  23              		.arch armv6
  24              		.syntax unified
  25              		.arm
  26              		.fpu vfp
  28              	_function:
  29              	.LFB6:
   1:wasteOfCycles.c **** #include<stdio.h>
   2:wasteOfCycles.c **** #include<stdlib.h>
   3:wasteOfCycles.c **** int _function(int EV_n)
   4:wasteOfCycles.c **** {
  33              		@ args = 0, pretend = 0, frame = 16
  34              		@ frame_needed = 1, uses_anonymous_args = 0
  35 0000 00482DE9 		push	{fp, lr}
  39 0004 04B08DE2 		add	fp, sp, #4
  41 0008 10D04DE2 		sub	sp, sp, #16
  42 000c 10000BE5 		str	r0, [fp, #-16]
   5:wasteOfCycles.c **** int EV_i;
   6:wasteOfCycles.c **** int EV_j;
   7:wasteOfCycles.c **** if ((EV_n<=0))
  44 0010 10301BE5 		ldr	r3, [fp, #-16]
  45 0014 000053E3 		cmp	r3, #0
  46 0018 010000CA 		bgt	.L2
   8:wasteOfCycles.c **** {
   9:wasteOfCycles.c **** return 0;
  48 001c 0030A0E3 		mov	r3, #0
  49 0020 170000EA 		b	.L3
  50              	.L2:
  10:wasteOfCycles.c **** }
  11:wasteOfCycles.c **** EV_i = 0;
  52 0024 0030A0E3 		mov	r3, #0
  53 0028 08300BE5 		str	r3, [fp, #-8]
  12:wasteOfCycles.c **** while ((EV_i<(EV_n*EV_n)))
  55 002c 090000EA 		b	.L4
  56              	.L5:
  13:wasteOfCycles.c **** {
  14:wasteOfCycles.c **** EV_j = (EV_i+EV_n);
  58 0030 08201BE5 		ldr	r2, [fp, #-8]
  59 0034 10301BE5 		ldr	r3, [fp, #-16]
  60 0038 033082E0 		add	r3, r2, r3
  61 003c 0C300BE5 		str	r3, [fp, #-12]
  15:wasteOfCycles.c **** printf("%d ", EV_j);
  63 0040 0C101BE5 		ldr	r1, [fp, #-12]
  64 0044 44009FE5 		ldr	r0, .L6
  65 0048 FEFFFFEB 		bl	printf
  16:wasteOfCycles.c **** EV_i = (EV_i+1);
  67 004c 08301BE5 		ldr	r3, [fp, #-8]
  68 0050 013083E2 		add	r3, r3, #1
  69 0054 08300BE5 		str	r3, [fp, #-8]
  70              	.L4:
  12:wasteOfCycles.c **** {
  72 0058 10301BE5 		ldr	r3, [fp, #-16]
  73 005c 10201BE5 		ldr	r2, [fp, #-16]
  74 0060 920303E0 		mul	r3, r2, r3
  12:wasteOfCycles.c **** {
  76 0064 08201BE5 		ldr	r2, [fp, #-8]
  77 0068 030052E1 		cmp	r2, r3
  78 006c EFFFFFBA 		blt	.L5
  17:wasteOfCycles.c **** }
  18:wasteOfCycles.c **** return _function((EV_n-1));
  80 0070 10301BE5 		ldr	r3, [fp, #-16]
  81 0074 013043E2 		sub	r3, r3, #1
  82 0078 0300A0E1 		mov	r0, r3
  83 007c FEFFFFEB 		bl	_function
  84 0080 0030A0E1 		mov	r3, r0
  85              	.L3:
  19:wasteOfCycles.c **** }
  87 0084 0300A0E1 		mov	r0, r3
  88 0088 04D04BE2 		sub	sp, fp, #4
  90              		@ sp needed
  91 008c 0088BDE8 		pop	{fp, pc}
  92              	.L7:
  93              		.align	2
  94              	.L6:
  95 0090 00000000 		.word	.LC0
  97              	.LFE6:
  99              		.section	.rodata
 100              		.align	2
 101              	.LC1:
 102 0004 256400   		.ascii	"%d\000"
 103 0007 00       		.align	2
 104              	.LC2:
 105 0008 25640A00 		.ascii	"%d\012\000"
 106              		.text
 107              		.align	2
 108              		.global	_main
 109              		.syntax unified
 110              		.arm
 111              		.fpu vfp
 113              	_main:
 114              	.LFB7:
  20:wasteOfCycles.c **** int _main()
  21:wasteOfCycles.c **** {
 117              		@ args = 0, pretend = 0, frame = 8
 118              		@ frame_needed = 1, uses_anonymous_args = 0
 119 0094 00482DE9 		push	{fp, lr}
 123 0098 04B08DE2 		add	fp, sp, #4
 125 009c 08D04DE2 		sub	sp, sp, #8
  22:wasteOfCycles.c **** int EV_num;
  23:wasteOfCycles.c **** scanf("%d", &EV_num);
 127 00a0 08304BE2 		sub	r3, fp, #8
 128 00a4 0310A0E1 		mov	r1, r3
 129 00a8 28009FE5 		ldr	r0, .L10
 130 00ac FEFFFFEB 		bl	__isoc99_scanf
  24:wasteOfCycles.c **** _function(EV_num);
 132 00b0 08301BE5 		ldr	r3, [fp, #-8]
 133 00b4 0300A0E1 		mov	r0, r3
 134 00b8 FEFFFFEB 		bl	_function
  25:wasteOfCycles.c **** printf("%d\n", 0);
 136 00bc 0010A0E3 		mov	r1, #0
 137 00c0 14009FE5 		ldr	r0, .L10+4
 138 00c4 FEFFFFEB 		bl	printf
  26:wasteOfCycles.c **** return 0;
 140 00c8 0030A0E3 		mov	r3, #0
  27:wasteOfCycles.c **** }
 142 00cc 0300A0E1 		mov	r0, r3
 143 00d0 04D04BE2 		sub	sp, fp, #4
 145              		@ sp needed
 146 00d4 0088BDE8 		pop	{fp, pc}
 147              	.L11:
 148              		.align	2
 149              	.L10:
 150 00d8 04000000 		.word	.LC1
 151 00dc 08000000 		.word	.LC2
 153              	.LFE7:
 155              		.align	2
 156              		.global	main
 157              		.syntax unified
 158              		.arm
 159              		.fpu vfp
 161              	main:
 162              	.LFB8:
  28:wasteOfCycles.c **** int main(void)
  29:wasteOfCycles.c **** {
 165              		@ args = 0, pretend = 0, frame = 0
 166              		@ frame_needed = 1, uses_anonymous_args = 0
 167 00e0 00482DE9 		push	{fp, lr}
 171 00e4 04B08DE2 		add	fp, sp, #4
  30:wasteOfCycles.c ****    return _main();
 174 00e8 FEFFFFEB 		bl	_main
 175 00ec 0030A0E1 		mov	r3, r0
  31:wasteOfCycles.c **** }
 177 00f0 0300A0E1 		mov	r0, r3
 178 00f4 0088BDE8 		pop	{fp, pc}
 180              	.LFE8:
 182              	.Letext0:
