   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.align	2
  17              		.global	_sum
  18              		.arch armv6
  19              		.syntax unified
  20              		.arm
  21              		.fpu vfp
  23              	_sum:
  24              	.LFB6:
   1:fact_sum.c    **** #include<stdio.h>
   2:fact_sum.c    **** #include<stdlib.h>
   3:fact_sum.c    **** int _sum(int EV_a,int EV_b)
   4:fact_sum.c    **** {
  28              		@ args = 0, pretend = 0, frame = 8
  29              		@ frame_needed = 1, uses_anonymous_args = 0
  30              		@ link register save eliminated.
  31 0000 04B02DE5 		str	fp, [sp, #-4]!
  34 0004 00B08DE2 		add	fp, sp, #0
  36 0008 0CD04DE2 		sub	sp, sp, #12
  37 000c 08000BE5 		str	r0, [fp, #-8]
  38 0010 0C100BE5 		str	r1, [fp, #-12]
   5:fact_sum.c    **** return (EV_a+EV_b);
  40 0014 08201BE5 		ldr	r2, [fp, #-8]
  41 0018 0C301BE5 		ldr	r3, [fp, #-12]
  42 001c 033082E0 		add	r3, r2, r3
   6:fact_sum.c    **** }
  44 0020 0300A0E1 		mov	r0, r3
  45 0024 00D08BE2 		add	sp, fp, #0
  47              		@ sp needed
  48 0028 04B09DE4 		ldr	fp, [sp], #4
  51 002c 1EFF2FE1 		bx	lr
  53              	.LFE6:
  55              		.align	2
  56              		.global	_fact
  57              		.syntax unified
  58              		.arm
  59              		.fpu vfp
  61              	_fact:
  62              	.LFB7:
   7:fact_sum.c    **** int _fact(int EV_n)
   8:fact_sum.c    **** {
  65              		@ args = 0, pretend = 0, frame = 16
  66              		@ frame_needed = 1, uses_anonymous_args = 0
  67 0030 00482DE9 		push	{fp, lr}
  71 0034 04B08DE2 		add	fp, sp, #4
  73 0038 10D04DE2 		sub	sp, sp, #16
  74 003c 10000BE5 		str	r0, [fp, #-16]
   9:fact_sum.c    **** int EV_t;
  10:fact_sum.c    **** if (((EV_n==1)||(EV_n==0)))
  76 0040 10301BE5 		ldr	r3, [fp, #-16]
  77 0044 010053E3 		cmp	r3, #1
  78 0048 0200000A 		beq	.L4
  80 004c 10301BE5 		ldr	r3, [fp, #-16]
  81 0050 000053E3 		cmp	r3, #0
  82 0054 0100001A 		bne	.L5
  83              	.L4:
  11:fact_sum.c    **** {
  12:fact_sum.c    **** return 1;
  85 0058 0130A0E3 		mov	r3, #1
  86 005c 110000EA 		b	.L6
  87              	.L5:
  13:fact_sum.c    **** }
  14:fact_sum.c    **** if ((EV_n<=1))
  89 0060 10301BE5 		ldr	r3, [fp, #-16]
  90 0064 010053E3 		cmp	r3, #1
  91 0068 050000CA 		bgt	.L7
  15:fact_sum.c    **** {
  16:fact_sum.c    **** return _fact(((-1)*EV_n));
  93 006c 10301BE5 		ldr	r3, [fp, #-16]
  94 0070 003063E2 		rsb	r3, r3, #0
  95 0074 0300A0E1 		mov	r0, r3
  96 0078 FEFFFFEB 		bl	_fact
  97 007c 0030A0E1 		mov	r3, r0
  98 0080 080000EA 		b	.L6
  99              	.L7:
  17:fact_sum.c    **** }
  18:fact_sum.c    **** EV_t = (EV_n*_fact((EV_n-1)));
 101 0084 10301BE5 		ldr	r3, [fp, #-16]
 102 0088 013043E2 		sub	r3, r3, #1
 103 008c 0300A0E1 		mov	r0, r3
 104 0090 FEFFFFEB 		bl	_fact
 105 0094 0020A0E1 		mov	r2, r0
 107 0098 10301BE5 		ldr	r3, [fp, #-16]
 108 009c 920303E0 		mul	r3, r2, r3
 109 00a0 08300BE5 		str	r3, [fp, #-8]
  19:fact_sum.c    **** return EV_t;
 111 00a4 08301BE5 		ldr	r3, [fp, #-8]
 112              	.L6:
  20:fact_sum.c    **** }
 114 00a8 0300A0E1 		mov	r0, r3
 115 00ac 04D04BE2 		sub	sp, fp, #4
 117              		@ sp needed
 118 00b0 0088BDE8 		pop	{fp, pc}
 120              	.LFE7:
 122              		.section	.rodata
 123              		.align	2
 124              	.LC0:
 125 0000 256400   		.ascii	"%d\000"
 126 0003 00       		.align	2
 127              	.LC1:
 128 0004 25640A00 		.ascii	"%d\012\000"
 129              		.text
 130              		.align	2
 131              		.global	_main
 132              		.syntax unified
 133              		.arm
 134              		.fpu vfp
 136              	_main:
 137              	.LFB8:
  21:fact_sum.c    **** int _main()
  22:fact_sum.c    **** {
 140              		@ args = 0, pretend = 0, frame = 16
 141              		@ frame_needed = 1, uses_anonymous_args = 0
 142 00b4 00482DE9 		push	{fp, lr}
 146 00b8 04B08DE2 		add	fp, sp, #4
 148 00bc 10D04DE2 		sub	sp, sp, #16
  23:fact_sum.c    **** int EV_num1;
  24:fact_sum.c    **** int EV_num2;
  25:fact_sum.c    **** int EV_flag;
  26:fact_sum.c    **** EV_flag = 0;
 150 00c0 0030A0E3 		mov	r3, #0
 151 00c4 10300BE5 		str	r3, [fp, #-16]
  27:fact_sum.c    **** while ((EV_flag!=(-1)))
 153 00c8 1E0000EA 		b	.L9
 154              	.L10:
  28:fact_sum.c    **** {
  29:fact_sum.c    **** scanf("%d", &EV_num1);
 156 00cc 08304BE2 		sub	r3, fp, #8
 157 00d0 0310A0E1 		mov	r1, r3
 158 00d4 88009FE5 		ldr	r0, .L12
 159 00d8 FEFFFFEB 		bl	__isoc99_scanf
  30:fact_sum.c    **** scanf("%d", &EV_num2);
 161 00dc 0C304BE2 		sub	r3, fp, #12
 162 00e0 0310A0E1 		mov	r1, r3
 163 00e4 78009FE5 		ldr	r0, .L12
 164 00e8 FEFFFFEB 		bl	__isoc99_scanf
  31:fact_sum.c    **** EV_num1 = _fact(EV_num1);
 166 00ec 08301BE5 		ldr	r3, [fp, #-8]
 167 00f0 0300A0E1 		mov	r0, r3
 168 00f4 FEFFFFEB 		bl	_fact
 169 00f8 0030A0E1 		mov	r3, r0
 171 00fc 08300BE5 		str	r3, [fp, #-8]
  32:fact_sum.c    **** EV_num2 = _fact(EV_num2);
 173 0100 0C301BE5 		ldr	r3, [fp, #-12]
 174 0104 0300A0E1 		mov	r0, r3
 175 0108 FEFFFFEB 		bl	_fact
 176 010c 0030A0E1 		mov	r3, r0
 178 0110 0C300BE5 		str	r3, [fp, #-12]
  33:fact_sum.c    **** printf("%d\n", _sum(EV_num1, EV_num2));
 180 0114 08301BE5 		ldr	r3, [fp, #-8]
 181 0118 0C201BE5 		ldr	r2, [fp, #-12]
 182 011c 0210A0E1 		mov	r1, r2
 183 0120 0300A0E1 		mov	r0, r3
 184 0124 FEFFFFEB 		bl	_sum
 185 0128 0030A0E1 		mov	r3, r0
 186 012c 0310A0E1 		mov	r1, r3
 187 0130 30009FE5 		ldr	r0, .L12+4
 188 0134 FEFFFFEB 		bl	printf
  34:fact_sum.c    **** scanf("%d", &EV_flag);
 190 0138 10304BE2 		sub	r3, fp, #16
 191 013c 0310A0E1 		mov	r1, r3
 192 0140 1C009FE5 		ldr	r0, .L12
 193 0144 FEFFFFEB 		bl	__isoc99_scanf
 194              	.L9:
  27:fact_sum.c    **** {
 196 0148 10301BE5 		ldr	r3, [fp, #-16]
  27:fact_sum.c    **** {
 198 014c 010073E3 		cmn	r3, #1
 199 0150 DDFFFF1A 		bne	.L10
  35:fact_sum.c    **** }
  36:fact_sum.c    **** return 0;
 201 0154 0030A0E3 		mov	r3, #0
  37:fact_sum.c    **** }
 203 0158 0300A0E1 		mov	r0, r3
 204 015c 04D04BE2 		sub	sp, fp, #4
 206              		@ sp needed
 207 0160 0088BDE8 		pop	{fp, pc}
 208              	.L13:
 209              		.align	2
 210              	.L12:
 211 0164 00000000 		.word	.LC0
 212 0168 04000000 		.word	.LC1
 214              	.LFE8:
 216              		.align	2
 217              		.global	main
 218              		.syntax unified
 219              		.arm
 220              		.fpu vfp
 222              	main:
 223              	.LFB9:
  38:fact_sum.c    **** int main(void)
  39:fact_sum.c    **** {
 226              		@ args = 0, pretend = 0, frame = 0
 227              		@ frame_needed = 1, uses_anonymous_args = 0
 228 016c 00482DE9 		push	{fp, lr}
 232 0170 04B08DE2 		add	fp, sp, #4
  40:fact_sum.c    ****    return _main();
 235 0174 FEFFFFEB 		bl	_main
 236 0178 0030A0E1 		mov	r3, r0
  41:fact_sum.c    **** }
 238 017c 0300A0E1 		mov	r0, r3
 239 0180 0088BDE8 		pop	{fp, pc}
 241              	.LFE9:
 243              	.Letext0:
