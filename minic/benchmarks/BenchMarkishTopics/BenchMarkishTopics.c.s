   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.comm	EV_intList,4,4
  17              		.align	2
  18              		.global	_length
  19              		.arch armv6
  20              		.syntax unified
  21              		.arm
  22              		.fpu vfp
  24              	_length:
  25              	.LFB6:
   1:BenchMarkishTopics.c **** #include<stdio.h>
   2:BenchMarkishTopics.c **** #include<stdlib.h>
   3:BenchMarkishTopics.c **** struct EV_intList
   4:BenchMarkishTopics.c **** {
   5:BenchMarkishTopics.c **** int EV_data;
   6:BenchMarkishTopics.c **** struct EV_intList * EV_rest;
   7:BenchMarkishTopics.c **** };
   8:BenchMarkishTopics.c **** int EV_intList;
   9:BenchMarkishTopics.c **** int _length(struct EV_intList * EV_list)
  10:BenchMarkishTopics.c **** {
  29              		@ args = 0, pretend = 0, frame = 8
  30              		@ frame_needed = 1, uses_anonymous_args = 0
  31 0000 00482DE9 		push	{fp, lr}
  35 0004 04B08DE2 		add	fp, sp, #4
  37 0008 08D04DE2 		sub	sp, sp, #8
  38 000c 08000BE5 		str	r0, [fp, #-8]
  11:BenchMarkishTopics.c **** if ((EV_list==NULL))
  40 0010 08301BE5 		ldr	r3, [fp, #-8]
  41 0014 000053E3 		cmp	r3, #0
  42 0018 0100001A 		bne	.L2
  12:BenchMarkishTopics.c **** {
  13:BenchMarkishTopics.c **** return 0;
  44 001c 0030A0E3 		mov	r3, #0
  45 0020 050000EA 		b	.L3
  46              	.L2:
  14:BenchMarkishTopics.c **** }
  15:BenchMarkishTopics.c **** return (1+_length(EV_list->EV_rest));
  48 0024 08301BE5 		ldr	r3, [fp, #-8]
  49 0028 043093E5 		ldr	r3, [r3, #4]
  50 002c 0300A0E1 		mov	r0, r3
  51 0030 FEFFFFEB 		bl	_length
  52 0034 0030A0E1 		mov	r3, r0
  54 0038 013083E2 		add	r3, r3, #1
  55              	.L3:
  16:BenchMarkishTopics.c **** }
  57 003c 0300A0E1 		mov	r0, r3
  58 0040 04D04BE2 		sub	sp, fp, #4
  60              		@ sp needed
  61 0044 0088BDE8 		pop	{fp, pc}
  63              	.LFE6:
  65              		.align	2
  66              		.global	_addToFront
  67              		.syntax unified
  68              		.arm
  69              		.fpu vfp
  71              	_addToFront:
  72              	.LFB7:
  17:BenchMarkishTopics.c **** struct EV_intList * _addToFront(struct EV_intList * EV_list,int EV_element)
  18:BenchMarkishTopics.c **** {
  75              		@ args = 0, pretend = 0, frame = 16
  76              		@ frame_needed = 1, uses_anonymous_args = 0
  77 0048 00482DE9 		push	{fp, lr}
  81 004c 04B08DE2 		add	fp, sp, #4
  83 0050 10D04DE2 		sub	sp, sp, #16
  84 0054 10000BE5 		str	r0, [fp, #-16]
  85 0058 14100BE5 		str	r1, [fp, #-20]
  19:BenchMarkishTopics.c **** struct EV_intList * EV_front;
  20:BenchMarkishTopics.c **** if ((EV_list==NULL))
  87 005c 10301BE5 		ldr	r3, [fp, #-16]
  88 0060 000053E3 		cmp	r3, #0
  89 0064 0B00001A 		bne	.L5
  21:BenchMarkishTopics.c **** {
  22:BenchMarkishTopics.c **** EV_list = (struct EV_intList*)malloc(sizeof(struct EV_intList));
  91 0068 0800A0E3 		mov	r0, #8
  92 006c FEFFFFEB 		bl	malloc
  93 0070 0030A0E1 		mov	r3, r0
  94 0074 10300BE5 		str	r3, [fp, #-16]
  23:BenchMarkishTopics.c **** EV_list->EV_data = EV_element;
  96 0078 10301BE5 		ldr	r3, [fp, #-16]
  97 007c 14201BE5 		ldr	r2, [fp, #-20]
  98 0080 002083E5 		str	r2, [r3]
  24:BenchMarkishTopics.c **** EV_list->EV_rest = NULL;
 100 0084 10301BE5 		ldr	r3, [fp, #-16]
 101 0088 0020A0E3 		mov	r2, #0
 102 008c 042083E5 		str	r2, [r3, #4]
  25:BenchMarkishTopics.c **** return EV_list;
 104 0090 10301BE5 		ldr	r3, [fp, #-16]
 105 0094 0A0000EA 		b	.L6
 106              	.L5:
  26:BenchMarkishTopics.c **** }
  27:BenchMarkishTopics.c **** EV_front = (struct EV_intList*)malloc(sizeof(struct EV_intList));
 108 0098 0800A0E3 		mov	r0, #8
 109 009c FEFFFFEB 		bl	malloc
 110 00a0 0030A0E1 		mov	r3, r0
 111 00a4 08300BE5 		str	r3, [fp, #-8]
  28:BenchMarkishTopics.c **** EV_front->EV_data = EV_element;
 113 00a8 08301BE5 		ldr	r3, [fp, #-8]
 114 00ac 14201BE5 		ldr	r2, [fp, #-20]
 115 00b0 002083E5 		str	r2, [r3]
  29:BenchMarkishTopics.c **** EV_front->EV_rest = EV_list;
 117 00b4 08301BE5 		ldr	r3, [fp, #-8]
 118 00b8 10201BE5 		ldr	r2, [fp, #-16]
 119 00bc 042083E5 		str	r2, [r3, #4]
  30:BenchMarkishTopics.c **** return EV_front;
 121 00c0 08301BE5 		ldr	r3, [fp, #-8]
 122              	.L6:
  31:BenchMarkishTopics.c **** }
 124 00c4 0300A0E1 		mov	r0, r3
 125 00c8 04D04BE2 		sub	sp, fp, #4
 127              		@ sp needed
 128 00cc 0088BDE8 		pop	{fp, pc}
 130              	.LFE7:
 132              		.align	2
 133              		.global	_deleteFirst
 134              		.syntax unified
 135              		.arm
 136              		.fpu vfp
 138              	_deleteFirst:
 139              	.LFB8:
  32:BenchMarkishTopics.c **** struct EV_intList * _deleteFirst(struct EV_intList * EV_list)
  33:BenchMarkishTopics.c **** {
 142              		@ args = 0, pretend = 0, frame = 16
 143              		@ frame_needed = 1, uses_anonymous_args = 0
 144 00d0 00482DE9 		push	{fp, lr}
 148 00d4 04B08DE2 		add	fp, sp, #4
 150 00d8 10D04DE2 		sub	sp, sp, #16
 151 00dc 10000BE5 		str	r0, [fp, #-16]
  34:BenchMarkishTopics.c **** struct EV_intList * EV_first;
  35:BenchMarkishTopics.c **** if ((EV_list==NULL))
 153 00e0 10301BE5 		ldr	r3, [fp, #-16]
 154 00e4 000053E3 		cmp	r3, #0
 155 00e8 0100001A 		bne	.L8
  36:BenchMarkishTopics.c **** {
  37:BenchMarkishTopics.c **** return NULL;
 157 00ec 0030A0E3 		mov	r3, #0
 158 00f0 070000EA 		b	.L9
 159              	.L8:
  38:BenchMarkishTopics.c **** }
  39:BenchMarkishTopics.c **** EV_first = EV_list;
 161 00f4 10301BE5 		ldr	r3, [fp, #-16]
 162 00f8 08300BE5 		str	r3, [fp, #-8]
  40:BenchMarkishTopics.c **** EV_list = EV_list->EV_rest;
 164 00fc 10301BE5 		ldr	r3, [fp, #-16]
 165 0100 043093E5 		ldr	r3, [r3, #4]
 166 0104 10300BE5 		str	r3, [fp, #-16]
  41:BenchMarkishTopics.c **** free(EV_first);
 168 0108 08001BE5 		ldr	r0, [fp, #-8]
 169 010c FEFFFFEB 		bl	free
  42:BenchMarkishTopics.c **** return EV_list;
 171 0110 10301BE5 		ldr	r3, [fp, #-16]
 172              	.L9:
  43:BenchMarkishTopics.c **** }
 174 0114 0300A0E1 		mov	r0, r3
 175 0118 04D04BE2 		sub	sp, fp, #4
 177              		@ sp needed
 178 011c 0088BDE8 		pop	{fp, pc}
 180              	.LFE8:
 182              		.section	.rodata
 183              		.align	2
 184              	.LC0:
 185 0000 256400   		.ascii	"%d\000"
 186 0003 00       		.align	2
 187              	.LC1:
 188 0004 25642000 		.ascii	"%d \000"
 189              		.align	2
 190              	.LC2:
 191 0008 25640A00 		.ascii	"%d\012\000"
 192              		.text
 193              		.align	2
 194              		.global	_main
 195              		.syntax unified
 196              		.arm
 197              		.fpu vfp
 199              	_main:
 200              	.LFB9:
  44:BenchMarkishTopics.c **** int _main()
  45:BenchMarkishTopics.c **** {
 203              		@ args = 0, pretend = 0, frame = 8
 204              		@ frame_needed = 1, uses_anonymous_args = 0
 205 0120 00482DE9 		push	{fp, lr}
 209 0124 04B08DE2 		add	fp, sp, #4
 211 0128 08D04DE2 		sub	sp, sp, #8
  46:BenchMarkishTopics.c **** struct EV_intList * EV_list;
  47:BenchMarkishTopics.c **** int EV_sum;
  48:BenchMarkishTopics.c **** scanf("%d", &EV_intList);
 213 012c EC109FE5 		ldr	r1, .L16
 214 0130 EC009FE5 		ldr	r0, .L16+4
 215 0134 FEFFFFEB 		bl	__isoc99_scanf
  49:BenchMarkishTopics.c **** EV_sum = 0;
 217 0138 0030A0E3 		mov	r3, #0
 218 013c 0C300BE5 		str	r3, [fp, #-12]
  50:BenchMarkishTopics.c **** EV_list = NULL;
 220 0140 0030A0E3 		mov	r3, #0
 221 0144 08300BE5 		str	r3, [fp, #-8]
  51:BenchMarkishTopics.c **** while ((EV_intList>0))
 223 0148 0F0000EA 		b	.L11
 224              	.L12:
  52:BenchMarkishTopics.c **** {
  53:BenchMarkishTopics.c **** EV_list = _addToFront(EV_list, EV_intList);
 226 014c CC309FE5 		ldr	r3, .L16
 227 0150 003093E5 		ldr	r3, [r3]
 228 0154 0310A0E1 		mov	r1, r3
 229 0158 08001BE5 		ldr	r0, [fp, #-8]
 230 015c FEFFFFEB 		bl	_addToFront
 231 0160 08000BE5 		str	r0, [fp, #-8]
  54:BenchMarkishTopics.c **** printf("%d ", EV_list->EV_data);
 233 0164 08301BE5 		ldr	r3, [fp, #-8]
 234 0168 003093E5 		ldr	r3, [r3]
 235 016c 0310A0E1 		mov	r1, r3
 236 0170 B0009FE5 		ldr	r0, .L16+8
 237 0174 FEFFFFEB 		bl	printf
  55:BenchMarkishTopics.c **** EV_intList = (EV_intList-1);
 239 0178 A0309FE5 		ldr	r3, .L16
 240 017c 003093E5 		ldr	r3, [r3]
 241 0180 013043E2 		sub	r3, r3, #1
 243 0184 94209FE5 		ldr	r2, .L16
 244 0188 003082E5 		str	r3, [r2]
 245              	.L11:
  51:BenchMarkishTopics.c **** {
 247 018c 8C309FE5 		ldr	r3, .L16
 248 0190 003093E5 		ldr	r3, [r3]
  51:BenchMarkishTopics.c **** {
 250 0194 000053E3 		cmp	r3, #0
 251 0198 EBFFFFCA 		bgt	.L12
  56:BenchMarkishTopics.c **** }
  57:BenchMarkishTopics.c **** printf("%d ", _length(EV_list));
 253 019c 08001BE5 		ldr	r0, [fp, #-8]
 254 01a0 FEFFFFEB 		bl	_length
 255 01a4 0030A0E1 		mov	r3, r0
 256 01a8 0310A0E1 		mov	r1, r3
 257 01ac 74009FE5 		ldr	r0, .L16+8
 258 01b0 FEFFFFEB 		bl	printf
  58:BenchMarkishTopics.c **** while ((_length(EV_list)>0))
 260 01b4 0D0000EA 		b	.L13
 261              	.L14:
  59:BenchMarkishTopics.c **** {
  60:BenchMarkishTopics.c **** EV_sum = (EV_sum+EV_list->EV_data);
 263 01b8 08301BE5 		ldr	r3, [fp, #-8]
 264 01bc 003093E5 		ldr	r3, [r3]
 266 01c0 0C201BE5 		ldr	r2, [fp, #-12]
 267 01c4 033082E0 		add	r3, r2, r3
 268 01c8 0C300BE5 		str	r3, [fp, #-12]
  61:BenchMarkishTopics.c **** printf("%d ", _length(EV_list));
 270 01cc 08001BE5 		ldr	r0, [fp, #-8]
 271 01d0 FEFFFFEB 		bl	_length
 272 01d4 0030A0E1 		mov	r3, r0
 273 01d8 0310A0E1 		mov	r1, r3
 274 01dc 44009FE5 		ldr	r0, .L16+8
 275 01e0 FEFFFFEB 		bl	printf
  62:BenchMarkishTopics.c **** EV_list = _deleteFirst(EV_list);
 277 01e4 08001BE5 		ldr	r0, [fp, #-8]
 278 01e8 FEFFFFEB 		bl	_deleteFirst
 279 01ec 08000BE5 		str	r0, [fp, #-8]
 280              	.L13:
  58:BenchMarkishTopics.c **** {
 282 01f0 08001BE5 		ldr	r0, [fp, #-8]
 283 01f4 FEFFFFEB 		bl	_length
 284 01f8 0030A0E1 		mov	r3, r0
  58:BenchMarkishTopics.c **** {
 286 01fc 000053E3 		cmp	r3, #0
 287 0200 ECFFFFCA 		bgt	.L14
  63:BenchMarkishTopics.c **** }
  64:BenchMarkishTopics.c **** printf("%d\n", EV_sum);
 289 0204 0C101BE5 		ldr	r1, [fp, #-12]
 290 0208 1C009FE5 		ldr	r0, .L16+12
 291 020c FEFFFFEB 		bl	printf
  65:BenchMarkishTopics.c **** return 0;
 293 0210 0030A0E3 		mov	r3, #0
  66:BenchMarkishTopics.c **** }
 295 0214 0300A0E1 		mov	r0, r3
 296 0218 04D04BE2 		sub	sp, fp, #4
 298              		@ sp needed
 299 021c 0088BDE8 		pop	{fp, pc}
 300              	.L17:
 301              		.align	2
 302              	.L16:
 303 0220 00000000 		.word	EV_intList
 304 0224 00000000 		.word	.LC0
 305 0228 04000000 		.word	.LC1
 306 022c 08000000 		.word	.LC2
 308              	.LFE9:
 310              		.align	2
 311              		.global	main
 312              		.syntax unified
 313              		.arm
 314              		.fpu vfp
 316              	main:
 317              	.LFB10:
  67:BenchMarkishTopics.c **** int main(void)
  68:BenchMarkishTopics.c **** {
 320              		@ args = 0, pretend = 0, frame = 0
 321              		@ frame_needed = 1, uses_anonymous_args = 0
 322 0230 00482DE9 		push	{fp, lr}
 326 0234 04B08DE2 		add	fp, sp, #4
  69:BenchMarkishTopics.c ****    return _main();
 329 0238 FEFFFFEB 		bl	_main
 330 023c 0030A0E1 		mov	r3, r0
  70:BenchMarkishTopics.c **** }
 332 0240 0300A0E1 		mov	r0, r3
 333 0244 0088BDE8 		pop	{fp, pc}
 335              	.LFE10:
 337              	.Letext0:
