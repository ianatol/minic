   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.align	2
  17              		.global	_computeFib
  18              		.arch armv6
  19              		.syntax unified
  20              		.arm
  21              		.fpu vfp
  23              	_computeFib:
  24              	.LFB6:
   1:Fibonacci.c   **** #include<stdio.h>
   2:Fibonacci.c   **** #include<stdlib.h>
   3:Fibonacci.c   **** int _computeFib(int EV_input)
   4:Fibonacci.c   **** {
  28              		@ args = 0, pretend = 0, frame = 8
  29              		@ frame_needed = 1, uses_anonymous_args = 0
  30 0000 10482DE9 		push	{r4, fp, lr}
  35 0004 08B08DE2 		add	fp, sp, #8
  37 0008 0CD04DE2 		sub	sp, sp, #12
  38 000c 10000BE5 		str	r0, [fp, #-16]
   5:Fibonacci.c   **** if ((EV_input==0))
  40 0010 10301BE5 		ldr	r3, [fp, #-16]
  41 0014 000053E3 		cmp	r3, #0
  42 0018 0100001A 		bne	.L2
   6:Fibonacci.c   **** {
   7:Fibonacci.c   **** return 0;
  44 001c 0030A0E3 		mov	r3, #0
  45 0020 0F0000EA 		b	.L3
  46              	.L2:
   8:Fibonacci.c   **** }
   9:Fibonacci.c   **** else
  10:Fibonacci.c   **** {
  11:Fibonacci.c   **** if ((EV_input<=2))
  48 0024 10301BE5 		ldr	r3, [fp, #-16]
  49 0028 020053E3 		cmp	r3, #2
  50 002c 010000CA 		bgt	.L4
  12:Fibonacci.c   **** {
  13:Fibonacci.c   **** return 1;
  52 0030 0130A0E3 		mov	r3, #1
  53 0034 0A0000EA 		b	.L3
  54              	.L4:
  14:Fibonacci.c   **** }
  15:Fibonacci.c   **** else
  16:Fibonacci.c   **** {
  17:Fibonacci.c   **** return (_computeFib((EV_input-1))+_computeFib((EV_input-2)));
  56 0038 10301BE5 		ldr	r3, [fp, #-16]
  57 003c 013043E2 		sub	r3, r3, #1
  58 0040 0300A0E1 		mov	r0, r3
  59 0044 FEFFFFEB 		bl	_computeFib
  60 0048 0040A0E1 		mov	r4, r0
  62 004c 10301BE5 		ldr	r3, [fp, #-16]
  63 0050 023043E2 		sub	r3, r3, #2
  64 0054 0300A0E1 		mov	r0, r3
  65 0058 FEFFFFEB 		bl	_computeFib
  66 005c 0030A0E1 		mov	r3, r0
  68 0060 033084E0 		add	r3, r4, r3
  69              	.L3:
  18:Fibonacci.c   **** }
  19:Fibonacci.c   **** }
  20:Fibonacci.c   **** }
  71 0064 0300A0E1 		mov	r0, r3
  72 0068 08D04BE2 		sub	sp, fp, #8
  74              		@ sp needed
  75 006c 1088BDE8 		pop	{r4, fp, pc}
  77              	.LFE6:
  79              		.section	.rodata
  80              		.align	2
  81              	.LC0:
  82 0000 256400   		.ascii	"%d\000"
  83 0003 00       		.align	2
  84              	.LC1:
  85 0004 25640A00 		.ascii	"%d\012\000"
  86              		.text
  87              		.align	2
  88              		.global	_main
  89              		.syntax unified
  90              		.arm
  91              		.fpu vfp
  93              	_main:
  94              	.LFB7:
  21:Fibonacci.c   **** int _main()
  22:Fibonacci.c   **** {
  97              		@ args = 0, pretend = 0, frame = 8
  98              		@ frame_needed = 1, uses_anonymous_args = 0
  99 0070 00482DE9 		push	{fp, lr}
 103 0074 04B08DE2 		add	fp, sp, #4
 105 0078 08D04DE2 		sub	sp, sp, #8
  23:Fibonacci.c   **** int EV_input;
  24:Fibonacci.c   **** scanf("%d", &EV_input);
 107 007c 08304BE2 		sub	r3, fp, #8
 108 0080 0310A0E1 		mov	r1, r3
 109 0084 2C009FE5 		ldr	r0, .L7
 110 0088 FEFFFFEB 		bl	__isoc99_scanf
  25:Fibonacci.c   **** printf("%d\n", _computeFib(EV_input));
 112 008c 08301BE5 		ldr	r3, [fp, #-8]
 113 0090 0300A0E1 		mov	r0, r3
 114 0094 FEFFFFEB 		bl	_computeFib
 115 0098 0030A0E1 		mov	r3, r0
 116 009c 0310A0E1 		mov	r1, r3
 117 00a0 14009FE5 		ldr	r0, .L7+4
 118 00a4 FEFFFFEB 		bl	printf
  26:Fibonacci.c   **** return 0;
 120 00a8 0030A0E3 		mov	r3, #0
  27:Fibonacci.c   **** }
 122 00ac 0300A0E1 		mov	r0, r3
 123 00b0 04D04BE2 		sub	sp, fp, #4
 125              		@ sp needed
 126 00b4 0088BDE8 		pop	{fp, pc}
 127              	.L8:
 128              		.align	2
 129              	.L7:
 130 00b8 00000000 		.word	.LC0
 131 00bc 04000000 		.word	.LC1
 133              	.LFE7:
 135              		.align	2
 136              		.global	main
 137              		.syntax unified
 138              		.arm
 139              		.fpu vfp
 141              	main:
 142              	.LFB8:
  28:Fibonacci.c   **** int main(void)
  29:Fibonacci.c   **** {
 145              		@ args = 0, pretend = 0, frame = 0
 146              		@ frame_needed = 1, uses_anonymous_args = 0
 147 00c0 00482DE9 		push	{fp, lr}
 151 00c4 04B08DE2 		add	fp, sp, #4
  30:Fibonacci.c   ****    return _main();
 154 00c8 FEFFFFEB 		bl	_main
 155 00cc 0030A0E1 		mov	r3, r0
  31:Fibonacci.c   **** }
 157 00d0 0300A0E1 		mov	r0, r3
 158 00d4 0088BDE8 		pop	{fp, pc}
 160              	.LFE8:
 162              	.Letext0:
