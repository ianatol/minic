   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.align	2
  17              		.global	_isqrt
  18              		.arch armv6
  19              		.syntax unified
  20              		.arm
  21              		.fpu vfp
  23              	_isqrt:
  24              	.LFB6:
   1:primes.c      **** #include<stdio.h>
   2:primes.c      **** #include<stdlib.h>
   3:primes.c      **** int _isqrt(int EV_a)
   4:primes.c      **** {
  28              		@ args = 0, pretend = 0, frame = 16
  29              		@ frame_needed = 1, uses_anonymous_args = 0
  30              		@ link register save eliminated.
  31 0000 04B02DE5 		str	fp, [sp, #-4]!
  34 0004 00B08DE2 		add	fp, sp, #0
  36 0008 14D04DE2 		sub	sp, sp, #20
  37 000c 10000BE5 		str	r0, [fp, #-16]
   5:primes.c      **** int EV_square;
   6:primes.c      **** int EV_delta;
   7:primes.c      **** EV_square = 1;
  39 0010 0130A0E3 		mov	r3, #1
  40 0014 08300BE5 		str	r3, [fp, #-8]
   8:primes.c      **** EV_delta = 3;
  42 0018 0330A0E3 		mov	r3, #3
  43 001c 0C300BE5 		str	r3, [fp, #-12]
   9:primes.c      **** while ((EV_square<=EV_a))
  45 0020 060000EA 		b	.L2
  46              	.L3:
  10:primes.c      **** {
  11:primes.c      **** EV_square = (EV_square+EV_delta);
  48 0024 08201BE5 		ldr	r2, [fp, #-8]
  49 0028 0C301BE5 		ldr	r3, [fp, #-12]
  50 002c 033082E0 		add	r3, r2, r3
  51 0030 08300BE5 		str	r3, [fp, #-8]
  12:primes.c      **** EV_delta = (EV_delta+2);
  53 0034 0C301BE5 		ldr	r3, [fp, #-12]
  54 0038 023083E2 		add	r3, r3, #2
  55 003c 0C300BE5 		str	r3, [fp, #-12]
  56              	.L2:
   9:primes.c      **** while ((EV_square<=EV_a))
  58 0040 08201BE5 		ldr	r2, [fp, #-8]
  59 0044 10301BE5 		ldr	r3, [fp, #-16]
  60 0048 030052E1 		cmp	r2, r3
  61 004c F4FFFFDA 		ble	.L3
  13:primes.c      **** }
  14:primes.c      **** return ((EV_delta/2)-1);
  63 0050 0C301BE5 		ldr	r3, [fp, #-12]
  64 0054 A32FA0E1 		lsr	r2, r3, #31
  65 0058 033082E0 		add	r3, r2, r3
  66 005c C330A0E1 		asr	r3, r3, #1
  68 0060 013043E2 		sub	r3, r3, #1
  15:primes.c      **** }
  70 0064 0300A0E1 		mov	r0, r3
  71 0068 00D08BE2 		add	sp, fp, #0
  73              		@ sp needed
  74 006c 04B09DE4 		ldr	fp, [sp], #4
  77 0070 1EFF2FE1 		bx	lr
  79              	.LFE6:
  82              		.align	2
  83              		.global	_prime
  84              		.syntax unified
  85              		.arm
  86              		.fpu vfp
  88              	_prime:
  89              	.LFB7:
  16:primes.c      **** int _prime(int EV_a)
  17:primes.c      **** {
  92              		@ args = 0, pretend = 0, frame = 24
  93              		@ frame_needed = 1, uses_anonymous_args = 0
  94 0074 00482DE9 		push	{fp, lr}
  98 0078 04B08DE2 		add	fp, sp, #4
 100 007c 18D04DE2 		sub	sp, sp, #24
 101 0080 18000BE5 		str	r0, [fp, #-24]
  18:primes.c      **** int EV_max;
  19:primes.c      **** int EV_divisor;
  20:primes.c      **** int EV_remainder;
  21:primes.c      **** if ((EV_a<2))
 103 0084 18301BE5 		ldr	r3, [fp, #-24]
 104 0088 010053E3 		cmp	r3, #1
 105 008c 010000CA 		bgt	.L6
  22:primes.c      **** {
  23:primes.c      **** return 0;
 107 0090 0030A0E3 		mov	r3, #0
 108 0094 180000EA 		b	.L7
 109              	.L6:
  24:primes.c      **** }
  25:primes.c      **** else
  26:primes.c      **** {
  27:primes.c      **** EV_max = _isqrt(EV_a);
 111 0098 18001BE5 		ldr	r0, [fp, #-24]
 112 009c FEFFFFEB 		bl	_isqrt
 113 00a0 0C000BE5 		str	r0, [fp, #-12]
  28:primes.c      **** EV_divisor = 2;
 115 00a4 0230A0E3 		mov	r3, #2
 116 00a8 08300BE5 		str	r3, [fp, #-8]
  29:primes.c      **** while ((EV_divisor<=EV_max))
 118 00ac 0D0000EA 		b	.L8
 119              	.L10:
  30:primes.c      **** {
  31:primes.c      **** EV_remainder = (EV_a-((EV_a/EV_divisor)*EV_divisor));
 121 00b0 18301BE5 		ldr	r3, [fp, #-24]
 122 00b4 08101BE5 		ldr	r1, [fp, #-8]
 123 00b8 0300A0E1 		mov	r0, r3
 125              	.LVL0:
 126 00c0 0130A0E1 		mov	r3, r1
 127 00c4 10300BE5 		str	r3, [fp, #-16]
  32:primes.c      **** if ((EV_remainder==0))
 129 00c8 10301BE5 		ldr	r3, [fp, #-16]
 130 00cc 000053E3 		cmp	r3, #0
 131 00d0 0100001A 		bne	.L9
  33:primes.c      **** {
  34:primes.c      **** return 0;
 133 00d4 0030A0E3 		mov	r3, #0
 134 00d8 070000EA 		b	.L7
 135              	.L9:
  35:primes.c      **** }
  36:primes.c      **** EV_divisor = (EV_divisor+1);
 137 00dc 08301BE5 		ldr	r3, [fp, #-8]
 138 00e0 013083E2 		add	r3, r3, #1
 139 00e4 08300BE5 		str	r3, [fp, #-8]
 140              	.L8:
  29:primes.c      **** {
 142 00e8 08201BE5 		ldr	r2, [fp, #-8]
 143 00ec 0C301BE5 		ldr	r3, [fp, #-12]
 144 00f0 030052E1 		cmp	r2, r3
 145 00f4 EDFFFFDA 		ble	.L10
  37:primes.c      **** }
  38:primes.c      **** return 1;
 147 00f8 0130A0E3 		mov	r3, #1
 148              	.L7:
  39:primes.c      **** }
  40:primes.c      **** }
 150 00fc 0300A0E1 		mov	r0, r3
 151 0100 04D04BE2 		sub	sp, fp, #4
 153              		@ sp needed
 154 0104 0088BDE8 		pop	{fp, pc}
 156              	.LFE7:
 158              		.section	.rodata
 159              		.align	2
 160              	.LC0:
 161 0000 256400   		.ascii	"%d\000"
 162 0003 00       		.align	2
 163              	.LC1:
 164 0004 25640A00 		.ascii	"%d\012\000"
 165              		.text
 166              		.align	2
 167              		.global	_main
 168              		.syntax unified
 169              		.arm
 170              		.fpu vfp
 172              	_main:
 173              	.LFB8:
  41:primes.c      **** int _main()
  42:primes.c      **** {
 176              		@ args = 0, pretend = 0, frame = 8
 177              		@ frame_needed = 1, uses_anonymous_args = 0
 178 0108 00482DE9 		push	{fp, lr}
 182 010c 04B08DE2 		add	fp, sp, #4
 184 0110 08D04DE2 		sub	sp, sp, #8
  43:primes.c      **** int EV_limit;
  44:primes.c      **** int EV_a;
  45:primes.c      **** scanf("%d", &EV_limit);
 186 0114 0C304BE2 		sub	r3, fp, #12
 187 0118 0310A0E1 		mov	r1, r3
 188 011c 58009FE5 		ldr	r0, .L16
 189 0120 FEFFFFEB 		bl	__isoc99_scanf
  46:primes.c      **** EV_a = 0;
 191 0124 0030A0E3 		mov	r3, #0
 192 0128 08300BE5 		str	r3, [fp, #-8]
  47:primes.c      **** while ((EV_a<=EV_limit))
 194 012c 0A0000EA 		b	.L12
 195              	.L14:
  48:primes.c      **** {
  49:primes.c      **** if (_prime(EV_a))
 197 0130 08001BE5 		ldr	r0, [fp, #-8]
 198 0134 FEFFFFEB 		bl	_prime
 199 0138 0030A0E1 		mov	r3, r0
 201 013c 000053E3 		cmp	r3, #0
 202 0140 0200000A 		beq	.L13
  50:primes.c      **** {
  51:primes.c      **** printf("%d\n", EV_a);
 204 0144 08101BE5 		ldr	r1, [fp, #-8]
 205 0148 30009FE5 		ldr	r0, .L16+4
 206 014c FEFFFFEB 		bl	printf
 207              	.L13:
  52:primes.c      **** }
  53:primes.c      **** EV_a = (EV_a+1);
 209 0150 08301BE5 		ldr	r3, [fp, #-8]
 210 0154 013083E2 		add	r3, r3, #1
 211 0158 08300BE5 		str	r3, [fp, #-8]
 212              	.L12:
  47:primes.c      **** {
 214 015c 0C301BE5 		ldr	r3, [fp, #-12]
  47:primes.c      **** {
 216 0160 08201BE5 		ldr	r2, [fp, #-8]
 217 0164 030052E1 		cmp	r2, r3
 218 0168 F0FFFFDA 		ble	.L14
  54:primes.c      **** }
  55:primes.c      **** return 0;
 220 016c 0030A0E3 		mov	r3, #0
  56:primes.c      **** }
 222 0170 0300A0E1 		mov	r0, r3
 223 0174 04D04BE2 		sub	sp, fp, #4
 225              		@ sp needed
 226 0178 0088BDE8 		pop	{fp, pc}
 227              	.L17:
 228              		.align	2
 229              	.L16:
 230 017c 00000000 		.word	.LC0
 231 0180 04000000 		.word	.LC1
 233              	.LFE8:
 235              		.align	2
 236              		.global	main
 237              		.syntax unified
 238              		.arm
 239              		.fpu vfp
 241              	main:
 242              	.LFB9:
  57:primes.c      **** int main(void)
  58:primes.c      **** {
 245              		@ args = 0, pretend = 0, frame = 0
 246              		@ frame_needed = 1, uses_anonymous_args = 0
 247 0184 00482DE9 		push	{fp, lr}
 251 0188 04B08DE2 		add	fp, sp, #4
  59:primes.c      ****    return _main();
 254 018c FEFFFFEB 		bl	_main
 255 0190 0030A0E1 		mov	r3, r0
  60:primes.c      **** }
 257 0194 0300A0E1 		mov	r0, r3
 258 0198 0088BDE8 		pop	{fp, pc}
 260              	.LFE9:
 262              	.Letext0:
