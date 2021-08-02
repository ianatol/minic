   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  17              		.align	2
  18              		.global	_mod
  19              		.arch armv6
  20              		.syntax unified
  21              		.arm
  22              		.fpu vfp
  24              	_mod:
  25              	.LFB6:
   1:hailstone.c   **** #include<stdio.h>
   2:hailstone.c   **** #include<stdlib.h>
   3:hailstone.c   **** int _mod(int EV_a,int EV_b)
   4:hailstone.c   **** {
  29              		@ args = 0, pretend = 0, frame = 8
  30              		@ frame_needed = 1, uses_anonymous_args = 0
  31 0000 00482DE9 		push	{fp, lr}
  35 0004 04B08DE2 		add	fp, sp, #4
  37 0008 08D04DE2 		sub	sp, sp, #8
  38 000c 08000BE5 		str	r0, [fp, #-8]
  39 0010 0C100BE5 		str	r1, [fp, #-12]
   5:hailstone.c   **** return (EV_a-((EV_a/EV_b)*EV_b));
  41 0014 08301BE5 		ldr	r3, [fp, #-8]
  42 0018 0C101BE5 		ldr	r1, [fp, #-12]
  43 001c 0300A0E1 		mov	r0, r3
  45              	.LVL0:
  46 0024 0130A0E1 		mov	r3, r1
   6:hailstone.c   **** }
  48 0028 0300A0E1 		mov	r0, r3
  49 002c 04D04BE2 		sub	sp, fp, #4
  51              		@ sp needed
  52 0030 0088BDE8 		pop	{fp, pc}
  54              	.LFE6:
  56              		.section	.rodata
  57              		.align	2
  58              	.LC0:
  59 0000 25642000 		.ascii	"%d \000"
  60              		.align	2
  61              	.LC1:
  62 0004 25640A00 		.ascii	"%d\012\000"
  63              		.text
  64              		.align	2
  65              		.global	_hailstone
  66              		.syntax unified
  67              		.arm
  68              		.fpu vfp
  70              	_hailstone:
  71              	.LFB7:
   7:hailstone.c   **** void _hailstone(int EV_n)
   8:hailstone.c   **** {
  74              		@ args = 0, pretend = 0, frame = 8
  75              		@ frame_needed = 1, uses_anonymous_args = 0
  76 0034 00482DE9 		push	{fp, lr}
  80 0038 04B08DE2 		add	fp, sp, #4
  82 003c 08D04DE2 		sub	sp, sp, #8
  83 0040 08000BE5 		str	r0, [fp, #-8]
  84              	.L8:
   9:hailstone.c   **** while (1)
  10:hailstone.c   **** {
  11:hailstone.c   **** printf("%d ", EV_n);
  86 0044 08101BE5 		ldr	r1, [fp, #-8]
  87 0048 6C009FE5 		ldr	r0, .L10
  88 004c FEFFFFEB 		bl	printf
  12:hailstone.c   **** if ((_mod(EV_n, 2)==1))
  90 0050 0210A0E3 		mov	r1, #2
  91 0054 08001BE5 		ldr	r0, [fp, #-8]
  92 0058 FEFFFFEB 		bl	_mod
  93 005c 0030A0E1 		mov	r3, r0
  95 0060 010053E3 		cmp	r3, #1
  96 0064 0600001A 		bne	.L4
  13:hailstone.c   **** {
  14:hailstone.c   **** EV_n = ((3*EV_n)+1);
  98 0068 08201BE5 		ldr	r2, [fp, #-8]
  99 006c 0230A0E1 		mov	r3, r2
 100 0070 8330A0E1 		lsl	r3, r3, #1
 101 0074 023083E0 		add	r3, r3, r2
 103 0078 013083E2 		add	r3, r3, #1
 104 007c 08300BE5 		str	r3, [fp, #-8]
 105 0080 040000EA 		b	.L5
 106              	.L4:
  15:hailstone.c   **** }
  16:hailstone.c   **** else
  17:hailstone.c   **** {
  18:hailstone.c   **** EV_n = (EV_n/2);
 108 0084 08301BE5 		ldr	r3, [fp, #-8]
 109 0088 A32FA0E1 		lsr	r2, r3, #31
 110 008c 033082E0 		add	r3, r2, r3
 111 0090 C330A0E1 		asr	r3, r3, #1
 112 0094 08300BE5 		str	r3, [fp, #-8]
 113              	.L5:
  19:hailstone.c   **** }
  20:hailstone.c   **** if ((EV_n<=1))
 115 0098 08301BE5 		ldr	r3, [fp, #-8]
 116 009c 010053E3 		cmp	r3, #1
 117 00a0 E7FFFFCA 		bgt	.L8
  21:hailstone.c   **** {
  22:hailstone.c   **** printf("%d\n", EV_n);
 119 00a4 08101BE5 		ldr	r1, [fp, #-8]
 120 00a8 10009FE5 		ldr	r0, .L10+4
 121 00ac FEFFFFEB 		bl	printf
  23:hailstone.c   **** return ;
 123 00b0 0000A0E1 		nop
  24:hailstone.c   **** }
  25:hailstone.c   **** }
  26:hailstone.c   **** }
 125 00b4 04D04BE2 		sub	sp, fp, #4
 127              		@ sp needed
 128 00b8 0088BDE8 		pop	{fp, pc}
 129              	.L11:
 130              		.align	2
 131              	.L10:
 132 00bc 00000000 		.word	.LC0
 133 00c0 04000000 		.word	.LC1
 135              	.LFE7:
 137              		.section	.rodata
 138              		.align	2
 139              	.LC2:
 140 0008 256400   		.ascii	"%d\000"
 141              		.text
 142              		.align	2
 143              		.global	_main
 144              		.syntax unified
 145              		.arm
 146              		.fpu vfp
 148              	_main:
 149              	.LFB8:
  27:hailstone.c   **** int _main()
  28:hailstone.c   **** {
 152              		@ args = 0, pretend = 0, frame = 8
 153              		@ frame_needed = 1, uses_anonymous_args = 0
 154 00c4 00482DE9 		push	{fp, lr}
 158 00c8 04B08DE2 		add	fp, sp, #4
 160 00cc 08D04DE2 		sub	sp, sp, #8
  29:hailstone.c   **** int EV_num;
  30:hailstone.c   **** scanf("%d", &EV_num);
 162 00d0 08304BE2 		sub	r3, fp, #8
 163 00d4 0310A0E1 		mov	r1, r3
 164 00d8 1C009FE5 		ldr	r0, .L14
 165 00dc FEFFFFEB 		bl	__isoc99_scanf
  31:hailstone.c   **** _hailstone(EV_num);
 167 00e0 08301BE5 		ldr	r3, [fp, #-8]
 168 00e4 0300A0E1 		mov	r0, r3
 169 00e8 FEFFFFEB 		bl	_hailstone
  32:hailstone.c   **** return 0;
 171 00ec 0030A0E3 		mov	r3, #0
  33:hailstone.c   **** }
 173 00f0 0300A0E1 		mov	r0, r3
 174 00f4 04D04BE2 		sub	sp, fp, #4
 176              		@ sp needed
 177 00f8 0088BDE8 		pop	{fp, pc}
 178              	.L15:
 179              		.align	2
 180              	.L14:
 181 00fc 08000000 		.word	.LC2
 183              	.LFE8:
 185              		.align	2
 186              		.global	main
 187              		.syntax unified
 188              		.arm
 189              		.fpu vfp
 191              	main:
 192              	.LFB9:
  34:hailstone.c   **** int main(void)
  35:hailstone.c   **** {
 195              		@ args = 0, pretend = 0, frame = 0
 196              		@ frame_needed = 1, uses_anonymous_args = 0
 197 0100 00482DE9 		push	{fp, lr}
 201 0104 04B08DE2 		add	fp, sp, #4
  36:hailstone.c   ****    return _main();
 204 0108 FEFFFFEB 		bl	_main
 205 010c 0030A0E1 		mov	r3, r0
  37:hailstone.c   **** }
 207 0110 0300A0E1 		mov	r0, r3
 208 0114 0088BDE8 		pop	{fp, pc}
 210              	.LFE9:
 212              	.Letext0:
