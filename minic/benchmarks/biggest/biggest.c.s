   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.section	.rodata
  17              		.align	2
  18              	.LC0:
  19 0000 256400   		.ascii	"%d\000"
  20              		.text
  21              		.align	2
  22              		.global	_getIntList
  23              		.arch armv6
  24              		.syntax unified
  25              		.arm
  26              		.fpu vfp
  28              	_getIntList:
  29              	.LFB6:
   1:biggest.c     **** #include<stdio.h>
   2:biggest.c     **** #include<stdlib.h>
   3:biggest.c     **** struct EV_IntList
   4:biggest.c     **** {
   5:biggest.c     **** int EV_head;
   6:biggest.c     **** struct EV_IntList * EV_tail;
   7:biggest.c     **** };
   8:biggest.c     **** struct EV_IntList * _getIntList()
   9:biggest.c     **** {
  33              		@ args = 0, pretend = 0, frame = 8
  34              		@ frame_needed = 1, uses_anonymous_args = 0
  35 0000 00482DE9 		push	{fp, lr}
  39 0004 04B08DE2 		add	fp, sp, #4
  41 0008 08D04DE2 		sub	sp, sp, #8
  10:biggest.c     **** struct EV_IntList * EV_list;
  11:biggest.c     **** int EV_next;
  12:biggest.c     **** EV_list = (struct EV_IntList*)malloc(sizeof(struct EV_IntList));
  43 000c 0800A0E3 		mov	r0, #8
  44 0010 FEFFFFEB 		bl	malloc
  45 0014 0030A0E1 		mov	r3, r0
  46 0018 08300BE5 		str	r3, [fp, #-8]
  13:biggest.c     **** scanf("%d", &EV_next);
  48 001c 0C304BE2 		sub	r3, fp, #12
  49 0020 0310A0E1 		mov	r1, r3
  50 0024 58009FE5 		ldr	r0, .L5
  51 0028 FEFFFFEB 		bl	__isoc99_scanf
  14:biggest.c     **** if ((EV_next==(-1)))
  53 002c 0C301BE5 		ldr	r3, [fp, #-12]
  55 0030 010073E3 		cmn	r3, #1
  56 0034 0700001A 		bne	.L2
  15:biggest.c     **** {
  16:biggest.c     **** EV_list->EV_head = EV_next;
  58 0038 0C201BE5 		ldr	r2, [fp, #-12]
  59 003c 08301BE5 		ldr	r3, [fp, #-8]
  60 0040 002083E5 		str	r2, [r3]
  17:biggest.c     **** EV_list->EV_tail = NULL;
  62 0044 08301BE5 		ldr	r3, [fp, #-8]
  63 0048 0020A0E3 		mov	r2, #0
  64 004c 042083E5 		str	r2, [r3, #4]
  18:biggest.c     **** return EV_list;
  66 0050 08301BE5 		ldr	r3, [fp, #-8]
  67 0054 070000EA 		b	.L4
  68              	.L2:
  19:biggest.c     **** }
  20:biggest.c     **** else
  21:biggest.c     **** {
  22:biggest.c     **** EV_list->EV_head = EV_next;
  70 0058 0C201BE5 		ldr	r2, [fp, #-12]
  71 005c 08301BE5 		ldr	r3, [fp, #-8]
  72 0060 002083E5 		str	r2, [r3]
  23:biggest.c     **** EV_list->EV_tail = _getIntList();
  74 0064 FEFFFFEB 		bl	_getIntList
  75 0068 0020A0E1 		mov	r2, r0
  77 006c 08301BE5 		ldr	r3, [fp, #-8]
  78 0070 042083E5 		str	r2, [r3, #4]
  24:biggest.c     **** return EV_list;
  80 0074 08301BE5 		ldr	r3, [fp, #-8]
  81              	.L4:
  25:biggest.c     **** }
  26:biggest.c     **** }
  83 0078 0300A0E1 		mov	r0, r3
  84 007c 04D04BE2 		sub	sp, fp, #4
  86              		@ sp needed
  87 0080 0088BDE8 		pop	{fp, pc}
  88              	.L6:
  89              		.align	2
  90              	.L5:
  91 0084 00000000 		.word	.LC0
  93              	.LFE6:
  95              		.align	2
  96              		.global	_biggest
  97              		.syntax unified
  98              		.arm
  99              		.fpu vfp
 101              	_biggest:
 102              	.LFB7:
  27:biggest.c     **** int _biggest(int EV_num1,int EV_num2)
  28:biggest.c     **** {
 105              		@ args = 0, pretend = 0, frame = 8
 106              		@ frame_needed = 1, uses_anonymous_args = 0
 107              		@ link register save eliminated.
 108 0088 04B02DE5 		str	fp, [sp, #-4]!
 111 008c 00B08DE2 		add	fp, sp, #0
 113 0090 0CD04DE2 		sub	sp, sp, #12
 114 0094 08000BE5 		str	r0, [fp, #-8]
 115 0098 0C100BE5 		str	r1, [fp, #-12]
  29:biggest.c     **** if ((EV_num1>EV_num2))
 117 009c 08201BE5 		ldr	r2, [fp, #-8]
 118 00a0 0C301BE5 		ldr	r3, [fp, #-12]
 119 00a4 030052E1 		cmp	r2, r3
 120 00a8 010000DA 		ble	.L8
  30:biggest.c     **** {
  31:biggest.c     **** return EV_num1;
 122 00ac 08301BE5 		ldr	r3, [fp, #-8]
 123 00b0 000000EA 		b	.L9
 124              	.L8:
  32:biggest.c     **** }
  33:biggest.c     **** else
  34:biggest.c     **** {
  35:biggest.c     **** return EV_num2;
 126 00b4 0C301BE5 		ldr	r3, [fp, #-12]
 127              	.L9:
  36:biggest.c     **** }
  37:biggest.c     **** }
 129 00b8 0300A0E1 		mov	r0, r3
 130 00bc 00D08BE2 		add	sp, fp, #0
 132              		@ sp needed
 133 00c0 04B09DE4 		ldr	fp, [sp], #4
 136 00c4 1EFF2FE1 		bx	lr
 138              	.LFE7:
 140              		.align	2
 141              		.global	_biggestInList
 142              		.syntax unified
 143              		.arm
 144              		.fpu vfp
 146              	_biggestInList:
 147              	.LFB8:
  38:biggest.c     **** int _biggestInList(struct EV_IntList * EV_list)
  39:biggest.c     **** {
 150              		@ args = 0, pretend = 0, frame = 16
 151              		@ frame_needed = 1, uses_anonymous_args = 0
 152 00c8 00482DE9 		push	{fp, lr}
 156 00cc 04B08DE2 		add	fp, sp, #4
 158 00d0 10D04DE2 		sub	sp, sp, #16
 159 00d4 10000BE5 		str	r0, [fp, #-16]
  40:biggest.c     **** int EV_big;
  41:biggest.c     **** EV_big = EV_list->EV_head;
 161 00d8 10301BE5 		ldr	r3, [fp, #-16]
 162 00dc 003093E5 		ldr	r3, [r3]
 163 00e0 08300BE5 		str	r3, [fp, #-8]
  42:biggest.c     **** while ((EV_list->EV_tail!=NULL))
 165 00e4 080000EA 		b	.L11
 166              	.L12:
  43:biggest.c     **** {
  44:biggest.c     **** EV_big = _biggest(EV_big, EV_list->EV_head);
 168 00e8 10301BE5 		ldr	r3, [fp, #-16]
 169 00ec 003093E5 		ldr	r3, [r3]
 170 00f0 0310A0E1 		mov	r1, r3
 171 00f4 08001BE5 		ldr	r0, [fp, #-8]
 172 00f8 FEFFFFEB 		bl	_biggest
 173 00fc 08000BE5 		str	r0, [fp, #-8]
  45:biggest.c     **** EV_list = EV_list->EV_tail;
 175 0100 10301BE5 		ldr	r3, [fp, #-16]
 176 0104 043093E5 		ldr	r3, [r3, #4]
 177 0108 10300BE5 		str	r3, [fp, #-16]
 178              	.L11:
  42:biggest.c     **** while ((EV_list->EV_tail!=NULL))
 180 010c 10301BE5 		ldr	r3, [fp, #-16]
 181 0110 043093E5 		ldr	r3, [r3, #4]
  42:biggest.c     **** while ((EV_list->EV_tail!=NULL))
 183 0114 000053E3 		cmp	r3, #0
 184 0118 F2FFFF1A 		bne	.L12
  46:biggest.c     **** }
  47:biggest.c     **** return EV_big;
 186 011c 08301BE5 		ldr	r3, [fp, #-8]
  48:biggest.c     **** }
 188 0120 0300A0E1 		mov	r0, r3
 189 0124 04D04BE2 		sub	sp, fp, #4
 191              		@ sp needed
 192 0128 0088BDE8 		pop	{fp, pc}
 194              	.LFE8:
 196              		.section	.rodata
 197 0003 00       		.align	2
 198              	.LC1:
 199 0004 25640A00 		.ascii	"%d\012\000"
 200              		.text
 201              		.align	2
 202              		.global	_main
 203              		.syntax unified
 204              		.arm
 205              		.fpu vfp
 207              	_main:
 208              	.LFB9:
  49:biggest.c     **** int _main()
  50:biggest.c     **** {
 211              		@ args = 0, pretend = 0, frame = 8
 212              		@ frame_needed = 1, uses_anonymous_args = 0
 213 012c 00482DE9 		push	{fp, lr}
 217 0130 04B08DE2 		add	fp, sp, #4
 219 0134 08D04DE2 		sub	sp, sp, #8
  51:biggest.c     **** struct EV_IntList * EV_list;
  52:biggest.c     **** EV_list = _getIntList();
 221 0138 FEFFFFEB 		bl	_getIntList
 222 013c 08000BE5 		str	r0, [fp, #-8]
  53:biggest.c     **** printf("%d\n", _biggestInList(EV_list));
 224 0140 08001BE5 		ldr	r0, [fp, #-8]
 225 0144 FEFFFFEB 		bl	_biggestInList
 226 0148 0030A0E1 		mov	r3, r0
 227 014c 0310A0E1 		mov	r1, r3
 228 0150 10009FE5 		ldr	r0, .L16
 229 0154 FEFFFFEB 		bl	printf
  54:biggest.c     **** return 0;
 231 0158 0030A0E3 		mov	r3, #0
  55:biggest.c     **** }
 233 015c 0300A0E1 		mov	r0, r3
 234 0160 04D04BE2 		sub	sp, fp, #4
 236              		@ sp needed
 237 0164 0088BDE8 		pop	{fp, pc}
 238              	.L17:
 239              		.align	2
 240              	.L16:
 241 0168 04000000 		.word	.LC1
 243              	.LFE9:
 245              		.align	2
 246              		.global	main
 247              		.syntax unified
 248              		.arm
 249              		.fpu vfp
 251              	main:
 252              	.LFB10:
  56:biggest.c     **** int main(void)
  57:biggest.c     **** {
 255              		@ args = 0, pretend = 0, frame = 0
 256              		@ frame_needed = 1, uses_anonymous_args = 0
 257 016c 00482DE9 		push	{fp, lr}
 261 0170 04B08DE2 		add	fp, sp, #4
  58:biggest.c     ****    return _main();
 264 0174 FEFFFFEB 		bl	_main
 265 0178 0030A0E1 		mov	r3, r0
  59:biggest.c     **** }
 267 017c 0300A0E1 		mov	r0, r3
 268 0180 0088BDE8 		pop	{fp, pc}
 270              	.LFE10:
 272              	.Letext0:
