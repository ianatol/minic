   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.section	.rodata
  17              		.align	2
  18              	.LC0:
  19 0000 256400   		.ascii	"%d\000"
  20              		.text
  21              		.align	2
  22              		.global	_buildList
  23              		.arch armv6
  24              		.syntax unified
  25              		.arm
  26              		.fpu vfp
  28              	_buildList:
  29              	.LFB6:
   1:creativeBenchMarkName.c **** #include<stdio.h>
   2:creativeBenchMarkName.c **** #include<stdlib.h>
   3:creativeBenchMarkName.c **** struct EV_node
   4:creativeBenchMarkName.c **** {
   5:creativeBenchMarkName.c **** int EV_value;
   6:creativeBenchMarkName.c **** struct EV_node * EV_next;
   7:creativeBenchMarkName.c **** };
   8:creativeBenchMarkName.c **** struct EV_node * _buildList()
   9:creativeBenchMarkName.c **** {
  33              		@ args = 0, pretend = 0, frame = 24
  34              		@ frame_needed = 1, uses_anonymous_args = 0
  35 0000 00482DE9 		push	{fp, lr}
  39 0004 04B08DE2 		add	fp, sp, #4
  41 0008 18D04DE2 		sub	sp, sp, #24
  10:creativeBenchMarkName.c **** int EV_input;
  11:creativeBenchMarkName.c **** int EV_i;
  12:creativeBenchMarkName.c **** struct EV_node * EV_n0;
  13:creativeBenchMarkName.c **** struct EV_node * EV_n1;
  14:creativeBenchMarkName.c **** struct EV_node * EV_n2;
  15:creativeBenchMarkName.c **** struct EV_node * EV_n3;
  16:creativeBenchMarkName.c **** struct EV_node * EV_n4;
  17:creativeBenchMarkName.c **** struct EV_node * EV_n5;
  18:creativeBenchMarkName.c **** EV_n0 = (struct EV_node*)malloc(sizeof(struct EV_node));
  43 000c 0800A0E3 		mov	r0, #8
  44 0010 FEFFFFEB 		bl	malloc
  45 0014 0030A0E1 		mov	r3, r0
  46 0018 08300BE5 		str	r3, [fp, #-8]
  19:creativeBenchMarkName.c **** EV_n1 = (struct EV_node*)malloc(sizeof(struct EV_node));
  48 001c 0800A0E3 		mov	r0, #8
  49 0020 FEFFFFEB 		bl	malloc
  50 0024 0030A0E1 		mov	r3, r0
  51 0028 0C300BE5 		str	r3, [fp, #-12]
  20:creativeBenchMarkName.c **** EV_n2 = (struct EV_node*)malloc(sizeof(struct EV_node));
  53 002c 0800A0E3 		mov	r0, #8
  54 0030 FEFFFFEB 		bl	malloc
  55 0034 0030A0E1 		mov	r3, r0
  56 0038 10300BE5 		str	r3, [fp, #-16]
  21:creativeBenchMarkName.c **** EV_n3 = (struct EV_node*)malloc(sizeof(struct EV_node));
  58 003c 0800A0E3 		mov	r0, #8
  59 0040 FEFFFFEB 		bl	malloc
  60 0044 0030A0E1 		mov	r3, r0
  61 0048 14300BE5 		str	r3, [fp, #-20]
  22:creativeBenchMarkName.c **** EV_n4 = (struct EV_node*)malloc(sizeof(struct EV_node));
  63 004c 0800A0E3 		mov	r0, #8
  64 0050 FEFFFFEB 		bl	malloc
  65 0054 0030A0E1 		mov	r3, r0
  66 0058 18300BE5 		str	r3, [fp, #-24]
  23:creativeBenchMarkName.c **** EV_n5 = (struct EV_node*)malloc(sizeof(struct EV_node));
  68 005c 0800A0E3 		mov	r0, #8
  69 0060 FEFFFFEB 		bl	malloc
  70 0064 0030A0E1 		mov	r3, r0
  71 0068 1C300BE5 		str	r3, [fp, #-28]
  24:creativeBenchMarkName.c **** scanf("%d", &EV_n0->EV_value);
  73 006c 08301BE5 		ldr	r3, [fp, #-8]
  74 0070 0310A0E1 		mov	r1, r3
  75 0074 A8009FE5 		ldr	r0, .L3
  76 0078 FEFFFFEB 		bl	__isoc99_scanf
  25:creativeBenchMarkName.c **** scanf("%d", &EV_n1->EV_value);
  78 007c 0C301BE5 		ldr	r3, [fp, #-12]
  79 0080 0310A0E1 		mov	r1, r3
  80 0084 98009FE5 		ldr	r0, .L3
  81 0088 FEFFFFEB 		bl	__isoc99_scanf
  26:creativeBenchMarkName.c **** scanf("%d", &EV_n2->EV_value);
  83 008c 10301BE5 		ldr	r3, [fp, #-16]
  84 0090 0310A0E1 		mov	r1, r3
  85 0094 88009FE5 		ldr	r0, .L3
  86 0098 FEFFFFEB 		bl	__isoc99_scanf
  27:creativeBenchMarkName.c **** scanf("%d", &EV_n3->EV_value);
  88 009c 14301BE5 		ldr	r3, [fp, #-20]
  89 00a0 0310A0E1 		mov	r1, r3
  90 00a4 78009FE5 		ldr	r0, .L3
  91 00a8 FEFFFFEB 		bl	__isoc99_scanf
  28:creativeBenchMarkName.c **** scanf("%d", &EV_n4->EV_value);
  93 00ac 18301BE5 		ldr	r3, [fp, #-24]
  94 00b0 0310A0E1 		mov	r1, r3
  95 00b4 68009FE5 		ldr	r0, .L3
  96 00b8 FEFFFFEB 		bl	__isoc99_scanf
  29:creativeBenchMarkName.c **** scanf("%d", &EV_n5->EV_value);
  98 00bc 1C301BE5 		ldr	r3, [fp, #-28]
  99 00c0 0310A0E1 		mov	r1, r3
 100 00c4 58009FE5 		ldr	r0, .L3
 101 00c8 FEFFFFEB 		bl	__isoc99_scanf
  30:creativeBenchMarkName.c **** EV_n0->EV_next = EV_n1;
 103 00cc 08301BE5 		ldr	r3, [fp, #-8]
 104 00d0 0C201BE5 		ldr	r2, [fp, #-12]
 105 00d4 042083E5 		str	r2, [r3, #4]
  31:creativeBenchMarkName.c **** EV_n1->EV_next = EV_n2;
 107 00d8 0C301BE5 		ldr	r3, [fp, #-12]
 108 00dc 10201BE5 		ldr	r2, [fp, #-16]
 109 00e0 042083E5 		str	r2, [r3, #4]
  32:creativeBenchMarkName.c **** EV_n2->EV_next = EV_n3;
 111 00e4 10301BE5 		ldr	r3, [fp, #-16]
 112 00e8 14201BE5 		ldr	r2, [fp, #-20]
 113 00ec 042083E5 		str	r2, [r3, #4]
  33:creativeBenchMarkName.c **** EV_n3->EV_next = EV_n4;
 115 00f0 14301BE5 		ldr	r3, [fp, #-20]
 116 00f4 18201BE5 		ldr	r2, [fp, #-24]
 117 00f8 042083E5 		str	r2, [r3, #4]
  34:creativeBenchMarkName.c **** EV_n4->EV_next = EV_n5;
 119 00fc 18301BE5 		ldr	r3, [fp, #-24]
 120 0100 1C201BE5 		ldr	r2, [fp, #-28]
 121 0104 042083E5 		str	r2, [r3, #4]
  35:creativeBenchMarkName.c **** EV_n5->EV_next = NULL;
 123 0108 1C301BE5 		ldr	r3, [fp, #-28]
 124 010c 0020A0E3 		mov	r2, #0
 125 0110 042083E5 		str	r2, [r3, #4]
  36:creativeBenchMarkName.c **** return EV_n0;
 127 0114 08301BE5 		ldr	r3, [fp, #-8]
  37:creativeBenchMarkName.c **** }
 129 0118 0300A0E1 		mov	r0, r3
 130 011c 04D04BE2 		sub	sp, fp, #4
 132              		@ sp needed
 133 0120 0088BDE8 		pop	{fp, pc}
 134              	.L4:
 135              		.align	2
 136              	.L3:
 137 0124 00000000 		.word	.LC0
 139              	.LFE6:
 141              		.section	.rodata
 142 0003 00       		.align	2
 143              	.LC1:
 144 0004 25640A00 		.ascii	"%d\012\000"
 145              		.text
 146              		.align	2
 147              		.global	_multiple
 148              		.syntax unified
 149              		.arm
 150              		.fpu vfp
 152              	_multiple:
 153              	.LFB7:
  38:creativeBenchMarkName.c **** int _multiple(struct EV_node * EV_list)
  39:creativeBenchMarkName.c **** {
 156              		@ args = 0, pretend = 0, frame = 24
 157              		@ frame_needed = 1, uses_anonymous_args = 0
 158 0128 00482DE9 		push	{fp, lr}
 162 012c 04B08DE2 		add	fp, sp, #4
 164 0130 18D04DE2 		sub	sp, sp, #24
 165 0134 18000BE5 		str	r0, [fp, #-24]
  40:creativeBenchMarkName.c **** int EV_i;
  41:creativeBenchMarkName.c **** int EV_product;
  42:creativeBenchMarkName.c **** struct EV_node * EV_cur;
  43:creativeBenchMarkName.c **** EV_i = 0;
 167 0138 0030A0E3 		mov	r3, #0
 168 013c 08300BE5 		str	r3, [fp, #-8]
  44:creativeBenchMarkName.c **** EV_cur = EV_list;
 170 0140 18301BE5 		ldr	r3, [fp, #-24]
 171 0144 10300BE5 		str	r3, [fp, #-16]
  45:creativeBenchMarkName.c **** EV_product = EV_cur->EV_value;
 173 0148 10301BE5 		ldr	r3, [fp, #-16]
 174 014c 003093E5 		ldr	r3, [r3]
 175 0150 0C300BE5 		str	r3, [fp, #-12]
  46:creativeBenchMarkName.c **** EV_cur = EV_cur->EV_next;
 177 0154 10301BE5 		ldr	r3, [fp, #-16]
 178 0158 043093E5 		ldr	r3, [r3, #4]
 179 015c 10300BE5 		str	r3, [fp, #-16]
  47:creativeBenchMarkName.c **** while ((EV_i<5))
 181 0160 0D0000EA 		b	.L6
 182              	.L7:
  48:creativeBenchMarkName.c **** {
  49:creativeBenchMarkName.c **** EV_product = (EV_product*EV_cur->EV_value);
 184 0164 10301BE5 		ldr	r3, [fp, #-16]
 185 0168 002093E5 		ldr	r2, [r3]
 187 016c 0C301BE5 		ldr	r3, [fp, #-12]
 188 0170 920303E0 		mul	r3, r2, r3
 189 0174 0C300BE5 		str	r3, [fp, #-12]
  50:creativeBenchMarkName.c **** EV_cur = EV_cur->EV_next;
 191 0178 10301BE5 		ldr	r3, [fp, #-16]
 192 017c 043093E5 		ldr	r3, [r3, #4]
 193 0180 10300BE5 		str	r3, [fp, #-16]
  51:creativeBenchMarkName.c **** printf("%d\n", EV_product);
 195 0184 0C101BE5 		ldr	r1, [fp, #-12]
 196 0188 28009FE5 		ldr	r0, .L9
 197 018c FEFFFFEB 		bl	printf
  52:creativeBenchMarkName.c **** EV_i = (EV_i+1);
 199 0190 08301BE5 		ldr	r3, [fp, #-8]
 200 0194 013083E2 		add	r3, r3, #1
 201 0198 08300BE5 		str	r3, [fp, #-8]
 202              	.L6:
  47:creativeBenchMarkName.c **** {
 204 019c 08301BE5 		ldr	r3, [fp, #-8]
 205 01a0 040053E3 		cmp	r3, #4
 206 01a4 EEFFFFDA 		ble	.L7
  53:creativeBenchMarkName.c **** }
  54:creativeBenchMarkName.c **** return EV_product;
 208 01a8 0C301BE5 		ldr	r3, [fp, #-12]
  55:creativeBenchMarkName.c **** }
 210 01ac 0300A0E1 		mov	r0, r3
 211 01b0 04D04BE2 		sub	sp, fp, #4
 213              		@ sp needed
 214 01b4 0088BDE8 		pop	{fp, pc}
 215              	.L10:
 216              		.align	2
 217              	.L9:
 218 01b8 04000000 		.word	.LC1
 220              	.LFE7:
 222              		.align	2
 223              		.global	_add
 224              		.syntax unified
 225              		.arm
 226              		.fpu vfp
 228              	_add:
 229              	.LFB8:
  56:creativeBenchMarkName.c **** int _add(struct EV_node * EV_list)
  57:creativeBenchMarkName.c **** {
 232              		@ args = 0, pretend = 0, frame = 24
 233              		@ frame_needed = 1, uses_anonymous_args = 0
 234 01bc 00482DE9 		push	{fp, lr}
 238 01c0 04B08DE2 		add	fp, sp, #4
 240 01c4 18D04DE2 		sub	sp, sp, #24
 241 01c8 18000BE5 		str	r0, [fp, #-24]
  58:creativeBenchMarkName.c **** int EV_i;
  59:creativeBenchMarkName.c **** int EV_sum;
  60:creativeBenchMarkName.c **** struct EV_node * EV_cur;
  61:creativeBenchMarkName.c **** EV_i = 0;
 243 01cc 0030A0E3 		mov	r3, #0
 244 01d0 08300BE5 		str	r3, [fp, #-8]
  62:creativeBenchMarkName.c **** EV_cur = EV_list;
 246 01d4 18301BE5 		ldr	r3, [fp, #-24]
 247 01d8 10300BE5 		str	r3, [fp, #-16]
  63:creativeBenchMarkName.c **** EV_sum = EV_cur->EV_value;
 249 01dc 10301BE5 		ldr	r3, [fp, #-16]
 250 01e0 003093E5 		ldr	r3, [r3]
 251 01e4 0C300BE5 		str	r3, [fp, #-12]
  64:creativeBenchMarkName.c **** EV_cur = EV_cur->EV_next;
 253 01e8 10301BE5 		ldr	r3, [fp, #-16]
 254 01ec 043093E5 		ldr	r3, [r3, #4]
 255 01f0 10300BE5 		str	r3, [fp, #-16]
  65:creativeBenchMarkName.c **** while ((EV_i<5))
 257 01f4 0D0000EA 		b	.L12
 258              	.L13:
  66:creativeBenchMarkName.c **** {
  67:creativeBenchMarkName.c **** EV_sum = (EV_sum+EV_cur->EV_value);
 260 01f8 10301BE5 		ldr	r3, [fp, #-16]
 261 01fc 003093E5 		ldr	r3, [r3]
 263 0200 0C201BE5 		ldr	r2, [fp, #-12]
 264 0204 033082E0 		add	r3, r2, r3
 265 0208 0C300BE5 		str	r3, [fp, #-12]
  68:creativeBenchMarkName.c **** EV_cur = EV_cur->EV_next;
 267 020c 10301BE5 		ldr	r3, [fp, #-16]
 268 0210 043093E5 		ldr	r3, [r3, #4]
 269 0214 10300BE5 		str	r3, [fp, #-16]
  69:creativeBenchMarkName.c **** printf("%d\n", EV_sum);
 271 0218 0C101BE5 		ldr	r1, [fp, #-12]
 272 021c 28009FE5 		ldr	r0, .L15
 273 0220 FEFFFFEB 		bl	printf
  70:creativeBenchMarkName.c **** EV_i = (EV_i+1);
 275 0224 08301BE5 		ldr	r3, [fp, #-8]
 276 0228 013083E2 		add	r3, r3, #1
 277 022c 08300BE5 		str	r3, [fp, #-8]
 278              	.L12:
  65:creativeBenchMarkName.c **** {
 280 0230 08301BE5 		ldr	r3, [fp, #-8]
 281 0234 040053E3 		cmp	r3, #4
 282 0238 EEFFFFDA 		ble	.L13
  71:creativeBenchMarkName.c **** }
  72:creativeBenchMarkName.c **** return EV_sum;
 284 023c 0C301BE5 		ldr	r3, [fp, #-12]
  73:creativeBenchMarkName.c **** }
 286 0240 0300A0E1 		mov	r0, r3
 287 0244 04D04BE2 		sub	sp, fp, #4
 289              		@ sp needed
 290 0248 0088BDE8 		pop	{fp, pc}
 291              	.L16:
 292              		.align	2
 293              	.L15:
 294 024c 04000000 		.word	.LC1
 296              	.LFE8:
 298              		.align	2
 299              		.global	_recurseList
 300              		.syntax unified
 301              		.arm
 302              		.fpu vfp
 304              	_recurseList:
 305              	.LFB9:
  74:creativeBenchMarkName.c **** int _recurseList(struct EV_node * EV_list)
  75:creativeBenchMarkName.c **** {
 308              		@ args = 0, pretend = 0, frame = 8
 309              		@ frame_needed = 1, uses_anonymous_args = 0
 310 0250 10482DE9 		push	{r4, fp, lr}
 315 0254 08B08DE2 		add	fp, sp, #8
 317 0258 0CD04DE2 		sub	sp, sp, #12
 318 025c 10000BE5 		str	r0, [fp, #-16]
  76:creativeBenchMarkName.c **** if ((EV_list->EV_next==NULL))
 320 0260 10301BE5 		ldr	r3, [fp, #-16]
 321 0264 043093E5 		ldr	r3, [r3, #4]
 323 0268 000053E3 		cmp	r3, #0
 324 026c 0200001A 		bne	.L18
  77:creativeBenchMarkName.c **** {
  78:creativeBenchMarkName.c **** return EV_list->EV_value;
 326 0270 10301BE5 		ldr	r3, [fp, #-16]
 327 0274 003093E5 		ldr	r3, [r3]
 328 0278 070000EA 		b	.L19
 329              	.L18:
  79:creativeBenchMarkName.c **** }
  80:creativeBenchMarkName.c **** else
  81:creativeBenchMarkName.c **** {
  82:creativeBenchMarkName.c **** return (EV_list->EV_value*_recurseList(EV_list->EV_next));
 331 027c 10301BE5 		ldr	r3, [fp, #-16]
 332 0280 004093E5 		ldr	r4, [r3]
 334 0284 10301BE5 		ldr	r3, [fp, #-16]
 335 0288 043093E5 		ldr	r3, [r3, #4]
 336 028c 0300A0E1 		mov	r0, r3
 337 0290 FEFFFFEB 		bl	_recurseList
 338 0294 0030A0E1 		mov	r3, r0
 340 0298 930403E0 		mul	r3, r3, r4
 341              	.L19:
  83:creativeBenchMarkName.c **** }
  84:creativeBenchMarkName.c **** }
 343 029c 0300A0E1 		mov	r0, r3
 344 02a0 08D04BE2 		sub	sp, fp, #8
 346              		@ sp needed
 347 02a4 1088BDE8 		pop	{r4, fp, pc}
 349              	.LFE9:
 351              		.align	2
 352              		.global	_main
 353              		.syntax unified
 354              		.arm
 355              		.fpu vfp
 357              	_main:
 358              	.LFB10:
  85:creativeBenchMarkName.c **** int _main()
  86:creativeBenchMarkName.c **** {
 361              		@ args = 0, pretend = 0, frame = 24
 362              		@ frame_needed = 1, uses_anonymous_args = 0
 363 02a8 00482DE9 		push	{fp, lr}
 367 02ac 04B08DE2 		add	fp, sp, #4
 369 02b0 18D04DE2 		sub	sp, sp, #24
  87:creativeBenchMarkName.c **** struct EV_node * EV_list;
  88:creativeBenchMarkName.c **** int EV_product;
  89:creativeBenchMarkName.c **** int EV_sum;
  90:creativeBenchMarkName.c **** int EV_result;
  91:creativeBenchMarkName.c **** int EV_bigProduct;
  92:creativeBenchMarkName.c **** int EV_i;
  93:creativeBenchMarkName.c **** EV_i = 0;
 371 02b4 0030A0E3 		mov	r3, #0
 372 02b8 0C300BE5 		str	r3, [fp, #-12]
  94:creativeBenchMarkName.c **** EV_bigProduct = 0;
 374 02bc 0030A0E3 		mov	r3, #0
 375 02c0 08300BE5 		str	r3, [fp, #-8]
  95:creativeBenchMarkName.c **** EV_list = _buildList();
 377 02c4 FEFFFFEB 		bl	_buildList
 378 02c8 10000BE5 		str	r0, [fp, #-16]
  96:creativeBenchMarkName.c **** EV_product = _multiple(EV_list);
 380 02cc 10001BE5 		ldr	r0, [fp, #-16]
 381 02d0 FEFFFFEB 		bl	_multiple
 382 02d4 14000BE5 		str	r0, [fp, #-20]
  97:creativeBenchMarkName.c **** EV_sum = _add(EV_list);
 384 02d8 10001BE5 		ldr	r0, [fp, #-16]
 385 02dc FEFFFFEB 		bl	_add
 386 02e0 18000BE5 		str	r0, [fp, #-24]
  98:creativeBenchMarkName.c **** EV_result = (EV_product-(EV_sum/2));
 388 02e4 18301BE5 		ldr	r3, [fp, #-24]
 389 02e8 A32FA0E1 		lsr	r2, r3, #31
 390 02ec 033082E0 		add	r3, r2, r3
 391 02f0 C330A0E1 		asr	r3, r3, #1
 392 02f4 003063E2 		rsb	r3, r3, #0
 393 02f8 0320A0E1 		mov	r2, r3
 395 02fc 14301BE5 		ldr	r3, [fp, #-20]
 396 0300 023083E0 		add	r3, r3, r2
 397 0304 1C300BE5 		str	r3, [fp, #-28]
  99:creativeBenchMarkName.c **** while ((EV_i<2))
 399 0308 080000EA 		b	.L21
 400              	.L22:
 100:creativeBenchMarkName.c **** {
 101:creativeBenchMarkName.c **** EV_bigProduct = (EV_bigProduct+_recurseList(EV_list));
 402 030c 10001BE5 		ldr	r0, [fp, #-16]
 403 0310 FEFFFFEB 		bl	_recurseList
 404 0314 0020A0E1 		mov	r2, r0
 406 0318 08301BE5 		ldr	r3, [fp, #-8]
 407 031c 023083E0 		add	r3, r3, r2
 408 0320 08300BE5 		str	r3, [fp, #-8]
 102:creativeBenchMarkName.c **** EV_i = (EV_i+1);
 410 0324 0C301BE5 		ldr	r3, [fp, #-12]
 411 0328 013083E2 		add	r3, r3, #1
 412 032c 0C300BE5 		str	r3, [fp, #-12]
 413              	.L21:
  99:creativeBenchMarkName.c **** while ((EV_i<2))
 415 0330 0C301BE5 		ldr	r3, [fp, #-12]
 416 0334 010053E3 		cmp	r3, #1
 417 0338 F3FFFFDA 		ble	.L22
 103:creativeBenchMarkName.c **** }
 104:creativeBenchMarkName.c **** printf("%d\n", EV_bigProduct);
 419 033c 08101BE5 		ldr	r1, [fp, #-8]
 420 0340 44009FE5 		ldr	r0, .L26
 421 0344 FEFFFFEB 		bl	printf
 105:creativeBenchMarkName.c **** while ((EV_bigProduct!=0))
 423 0348 020000EA 		b	.L23
 424              	.L24:
 106:creativeBenchMarkName.c **** {
 107:creativeBenchMarkName.c **** EV_bigProduct = (EV_bigProduct-1);
 426 034c 08301BE5 		ldr	r3, [fp, #-8]
 427 0350 013043E2 		sub	r3, r3, #1
 428 0354 08300BE5 		str	r3, [fp, #-8]
 429              	.L23:
 105:creativeBenchMarkName.c **** while ((EV_bigProduct!=0))
 431 0358 08301BE5 		ldr	r3, [fp, #-8]
 432 035c 000053E3 		cmp	r3, #0
 433 0360 F9FFFF1A 		bne	.L24
 108:creativeBenchMarkName.c **** }
 109:creativeBenchMarkName.c **** printf("%d\n", EV_result);
 435 0364 1C101BE5 		ldr	r1, [fp, #-28]
 436 0368 1C009FE5 		ldr	r0, .L26
 437 036c FEFFFFEB 		bl	printf
 110:creativeBenchMarkName.c **** printf("%d\n", EV_bigProduct);
 439 0370 08101BE5 		ldr	r1, [fp, #-8]
 440 0374 10009FE5 		ldr	r0, .L26
 441 0378 FEFFFFEB 		bl	printf
 111:creativeBenchMarkName.c **** return 0;
 443 037c 0030A0E3 		mov	r3, #0
 112:creativeBenchMarkName.c **** }
 445 0380 0300A0E1 		mov	r0, r3
 446 0384 04D04BE2 		sub	sp, fp, #4
 448              		@ sp needed
 449 0388 0088BDE8 		pop	{fp, pc}
 450              	.L27:
 451              		.align	2
 452              	.L26:
 453 038c 04000000 		.word	.LC1
 455              	.LFE10:
 457              		.align	2
 458              		.global	main
 459              		.syntax unified
 460              		.arm
 461              		.fpu vfp
 463              	main:
 464              	.LFB11:
 113:creativeBenchMarkName.c **** int main(void)
 114:creativeBenchMarkName.c **** {
 467              		@ args = 0, pretend = 0, frame = 0
 468              		@ frame_needed = 1, uses_anonymous_args = 0
 469 0390 00482DE9 		push	{fp, lr}
 473 0394 04B08DE2 		add	fp, sp, #4
 115:creativeBenchMarkName.c ****    return _main();
 476 0398 FEFFFFEB 		bl	_main
 477 039c 0030A0E1 		mov	r3, r0
 116:creativeBenchMarkName.c **** }
 479 03a0 0300A0E1 		mov	r0, r3
 480 03a4 0088BDE8 		pop	{fp, pc}
 482              	.LFE11:
 484              	.Letext0:
