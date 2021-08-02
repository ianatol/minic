   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.align	2
  17              		.global	_cleanBoard
  18              		.arch armv6
  19              		.syntax unified
  20              		.arm
  21              		.fpu vfp
  23              	_cleanBoard:
  24              	.LFB6:
   1:TicTac.c      **** #include<stdio.h>
   2:TicTac.c      **** #include<stdlib.h>
   3:TicTac.c      **** struct EV_gameBoard
   4:TicTac.c      **** {
   5:TicTac.c      **** int EV_a;
   6:TicTac.c      **** int EV_b;
   7:TicTac.c      **** int EV_c;
   8:TicTac.c      **** int EV_d;
   9:TicTac.c      **** int EV_e;
  10:TicTac.c      **** int EV_f;
  11:TicTac.c      **** int EV_g;
  12:TicTac.c      **** int EV_h;
  13:TicTac.c      **** int EV_i;
  14:TicTac.c      **** };
  15:TicTac.c      **** void _cleanBoard(struct EV_gameBoard * EV_board)
  16:TicTac.c      **** {
  28              		@ args = 0, pretend = 0, frame = 8
  29              		@ frame_needed = 1, uses_anonymous_args = 0
  30              		@ link register save eliminated.
  31 0000 04B02DE5 		str	fp, [sp, #-4]!
  34 0004 00B08DE2 		add	fp, sp, #0
  36 0008 0CD04DE2 		sub	sp, sp, #12
  37 000c 08000BE5 		str	r0, [fp, #-8]
  17:TicTac.c      **** EV_board->EV_a = 0;
  39 0010 08301BE5 		ldr	r3, [fp, #-8]
  40 0014 0020A0E3 		mov	r2, #0
  41 0018 002083E5 		str	r2, [r3]
  18:TicTac.c      **** EV_board->EV_b = 0;
  43 001c 08301BE5 		ldr	r3, [fp, #-8]
  44 0020 0020A0E3 		mov	r2, #0
  45 0024 042083E5 		str	r2, [r3, #4]
  19:TicTac.c      **** EV_board->EV_c = 0;
  47 0028 08301BE5 		ldr	r3, [fp, #-8]
  48 002c 0020A0E3 		mov	r2, #0
  49 0030 082083E5 		str	r2, [r3, #8]
  20:TicTac.c      **** EV_board->EV_d = 0;
  51 0034 08301BE5 		ldr	r3, [fp, #-8]
  52 0038 0020A0E3 		mov	r2, #0
  53 003c 0C2083E5 		str	r2, [r3, #12]
  21:TicTac.c      **** EV_board->EV_e = 0;
  55 0040 08301BE5 		ldr	r3, [fp, #-8]
  56 0044 0020A0E3 		mov	r2, #0
  57 0048 102083E5 		str	r2, [r3, #16]
  22:TicTac.c      **** EV_board->EV_f = 0;
  59 004c 08301BE5 		ldr	r3, [fp, #-8]
  60 0050 0020A0E3 		mov	r2, #0
  61 0054 142083E5 		str	r2, [r3, #20]
  23:TicTac.c      **** EV_board->EV_g = 0;
  63 0058 08301BE5 		ldr	r3, [fp, #-8]
  64 005c 0020A0E3 		mov	r2, #0
  65 0060 182083E5 		str	r2, [r3, #24]
  24:TicTac.c      **** EV_board->EV_h = 0;
  67 0064 08301BE5 		ldr	r3, [fp, #-8]
  68 0068 0020A0E3 		mov	r2, #0
  69 006c 1C2083E5 		str	r2, [r3, #28]
  25:TicTac.c      **** EV_board->EV_i = 0;
  71 0070 08301BE5 		ldr	r3, [fp, #-8]
  72 0074 0020A0E3 		mov	r2, #0
  73 0078 202083E5 		str	r2, [r3, #32]
  26:TicTac.c      **** }
  75 007c 0000A0E1 		nop
  76 0080 00D08BE2 		add	sp, fp, #0
  78              		@ sp needed
  79 0084 04B09DE4 		ldr	fp, [sp], #4
  82 0088 1EFF2FE1 		bx	lr
  84              	.LFE6:
  86              		.section	.rodata
  87              		.align	2
  88              	.LC0:
  89 0000 25642000 		.ascii	"%d \000"
  90              		.align	2
  91              	.LC1:
  92 0004 25640A00 		.ascii	"%d\012\000"
  93              		.text
  94              		.align	2
  95              		.global	_printBoard
  96              		.syntax unified
  97              		.arm
  98              		.fpu vfp
 100              	_printBoard:
 101              	.LFB7:
  27:TicTac.c      **** void _printBoard(struct EV_gameBoard * EV_board)
  28:TicTac.c      **** {
 104              		@ args = 0, pretend = 0, frame = 8
 105              		@ frame_needed = 1, uses_anonymous_args = 0
 106 008c 00482DE9 		push	{fp, lr}
 110 0090 04B08DE2 		add	fp, sp, #4
 112 0094 08D04DE2 		sub	sp, sp, #8
 113 0098 08000BE5 		str	r0, [fp, #-8]
  29:TicTac.c      **** printf("%d ", EV_board->EV_a);
 115 009c 08301BE5 		ldr	r3, [fp, #-8]
 116 00a0 003093E5 		ldr	r3, [r3]
 117 00a4 0310A0E1 		mov	r1, r3
 118 00a8 AC009FE5 		ldr	r0, .L3
 119 00ac FEFFFFEB 		bl	printf
  30:TicTac.c      **** printf("%d ", EV_board->EV_b);
 121 00b0 08301BE5 		ldr	r3, [fp, #-8]
 122 00b4 043093E5 		ldr	r3, [r3, #4]
 123 00b8 0310A0E1 		mov	r1, r3
 124 00bc 98009FE5 		ldr	r0, .L3
 125 00c0 FEFFFFEB 		bl	printf
  31:TicTac.c      **** printf("%d\n", EV_board->EV_c);
 127 00c4 08301BE5 		ldr	r3, [fp, #-8]
 128 00c8 083093E5 		ldr	r3, [r3, #8]
 129 00cc 0310A0E1 		mov	r1, r3
 130 00d0 88009FE5 		ldr	r0, .L3+4
 131 00d4 FEFFFFEB 		bl	printf
  32:TicTac.c      **** printf("%d ", EV_board->EV_d);
 133 00d8 08301BE5 		ldr	r3, [fp, #-8]
 134 00dc 0C3093E5 		ldr	r3, [r3, #12]
 135 00e0 0310A0E1 		mov	r1, r3
 136 00e4 70009FE5 		ldr	r0, .L3
 137 00e8 FEFFFFEB 		bl	printf
  33:TicTac.c      **** printf("%d ", EV_board->EV_e);
 139 00ec 08301BE5 		ldr	r3, [fp, #-8]
 140 00f0 103093E5 		ldr	r3, [r3, #16]
 141 00f4 0310A0E1 		mov	r1, r3
 142 00f8 5C009FE5 		ldr	r0, .L3
 143 00fc FEFFFFEB 		bl	printf
  34:TicTac.c      **** printf("%d\n", EV_board->EV_f);
 145 0100 08301BE5 		ldr	r3, [fp, #-8]
 146 0104 143093E5 		ldr	r3, [r3, #20]
 147 0108 0310A0E1 		mov	r1, r3
 148 010c 4C009FE5 		ldr	r0, .L3+4
 149 0110 FEFFFFEB 		bl	printf
  35:TicTac.c      **** printf("%d ", EV_board->EV_g);
 151 0114 08301BE5 		ldr	r3, [fp, #-8]
 152 0118 183093E5 		ldr	r3, [r3, #24]
 153 011c 0310A0E1 		mov	r1, r3
 154 0120 34009FE5 		ldr	r0, .L3
 155 0124 FEFFFFEB 		bl	printf
  36:TicTac.c      **** printf("%d ", EV_board->EV_h);
 157 0128 08301BE5 		ldr	r3, [fp, #-8]
 158 012c 1C3093E5 		ldr	r3, [r3, #28]
 159 0130 0310A0E1 		mov	r1, r3
 160 0134 20009FE5 		ldr	r0, .L3
 161 0138 FEFFFFEB 		bl	printf
  37:TicTac.c      **** printf("%d\n", EV_board->EV_i);
 163 013c 08301BE5 		ldr	r3, [fp, #-8]
 164 0140 203093E5 		ldr	r3, [r3, #32]
 165 0144 0310A0E1 		mov	r1, r3
 166 0148 10009FE5 		ldr	r0, .L3+4
 167 014c FEFFFFEB 		bl	printf
  38:TicTac.c      **** }
 169 0150 0000A0E1 		nop
 170 0154 04D04BE2 		sub	sp, fp, #4
 172              		@ sp needed
 173 0158 0088BDE8 		pop	{fp, pc}
 174              	.L4:
 175              		.align	2
 176              	.L3:
 177 015c 00000000 		.word	.LC0
 178 0160 04000000 		.word	.LC1
 180              	.LFE7:
 182              		.align	2
 183              		.global	_printMoveBoard
 184              		.syntax unified
 185              		.arm
 186              		.fpu vfp
 188              	_printMoveBoard:
 189              	.LFB8:
  39:TicTac.c      **** void _printMoveBoard()
  40:TicTac.c      **** {
 192              		@ args = 0, pretend = 0, frame = 0
 193              		@ frame_needed = 1, uses_anonymous_args = 0
 194 0164 00482DE9 		push	{fp, lr}
 198 0168 04B08DE2 		add	fp, sp, #4
  41:TicTac.c      **** printf("%d\n", 123);
 201 016c 7B10A0E3 		mov	r1, #123
 202 0170 20009FE5 		ldr	r0, .L6
 203 0174 FEFFFFEB 		bl	printf
  42:TicTac.c      **** printf("%d\n", 456);
 205 0178 721FA0E3 		mov	r1, #456
 206 017c 14009FE5 		ldr	r0, .L6
 207 0180 FEFFFFEB 		bl	printf
  43:TicTac.c      **** printf("%d\n", 789);
 209 0184 10109FE5 		ldr	r1, .L6+4
 210 0188 08009FE5 		ldr	r0, .L6
 211 018c FEFFFFEB 		bl	printf
  44:TicTac.c      **** }
 213 0190 0000A0E1 		nop
 214 0194 0088BDE8 		pop	{fp, pc}
 215              	.L7:
 216              		.align	2
 217              	.L6:
 218 0198 04000000 		.word	.LC1
 219 019c 15030000 		.word	789
 221              	.LFE8:
 223              		.align	2
 224              		.global	_placePiece
 225              		.syntax unified
 226              		.arm
 227              		.fpu vfp
 229              	_placePiece:
 230              	.LFB9:
  45:TicTac.c      **** void _placePiece(struct EV_gameBoard * EV_board,int EV_turn,int EV_placement)
  46:TicTac.c      **** {
 233              		@ args = 0, pretend = 0, frame = 16
 234              		@ frame_needed = 1, uses_anonymous_args = 0
 235              		@ link register save eliminated.
 236 01a0 04B02DE5 		str	fp, [sp, #-4]!
 239 01a4 00B08DE2 		add	fp, sp, #0
 241 01a8 14D04DE2 		sub	sp, sp, #20
 242 01ac 08000BE5 		str	r0, [fp, #-8]
 243 01b0 0C100BE5 		str	r1, [fp, #-12]
 244 01b4 10200BE5 		str	r2, [fp, #-16]
  47:TicTac.c      **** if ((EV_placement==1))
 246 01b8 10301BE5 		ldr	r3, [fp, #-16]
 247 01bc 010053E3 		cmp	r3, #1
 248 01c0 0300001A 		bne	.L9
  48:TicTac.c      **** {
  49:TicTac.c      **** EV_board->EV_a = EV_turn;
 250 01c4 08301BE5 		ldr	r3, [fp, #-8]
 251 01c8 0C201BE5 		ldr	r2, [fp, #-12]
 252 01cc 002083E5 		str	r2, [r3]
  50:TicTac.c      **** }
  51:TicTac.c      **** else
  52:TicTac.c      **** {
  53:TicTac.c      **** if ((EV_placement==2))
  54:TicTac.c      **** {
  55:TicTac.c      **** EV_board->EV_b = EV_turn;
  56:TicTac.c      **** }
  57:TicTac.c      **** else
  58:TicTac.c      **** {
  59:TicTac.c      **** if ((EV_placement==3))
  60:TicTac.c      **** {
  61:TicTac.c      **** EV_board->EV_c = EV_turn;
  62:TicTac.c      **** }
  63:TicTac.c      **** else
  64:TicTac.c      **** {
  65:TicTac.c      **** if ((EV_placement==4))
  66:TicTac.c      **** {
  67:TicTac.c      **** EV_board->EV_d = EV_turn;
  68:TicTac.c      **** }
  69:TicTac.c      **** else
  70:TicTac.c      **** {
  71:TicTac.c      **** if ((EV_placement==5))
  72:TicTac.c      **** {
  73:TicTac.c      **** EV_board->EV_e = EV_turn;
  74:TicTac.c      **** }
  75:TicTac.c      **** else
  76:TicTac.c      **** {
  77:TicTac.c      **** if ((EV_placement==6))
  78:TicTac.c      **** {
  79:TicTac.c      **** EV_board->EV_f = EV_turn;
  80:TicTac.c      **** }
  81:TicTac.c      **** else
  82:TicTac.c      **** {
  83:TicTac.c      **** if ((EV_placement==7))
  84:TicTac.c      **** {
  85:TicTac.c      **** EV_board->EV_g = EV_turn;
  86:TicTac.c      **** }
  87:TicTac.c      **** else
  88:TicTac.c      **** {
  89:TicTac.c      **** if ((EV_placement==8))
  90:TicTac.c      **** {
  91:TicTac.c      **** EV_board->EV_h = EV_turn;
  92:TicTac.c      **** }
  93:TicTac.c      **** else
  94:TicTac.c      **** {
  95:TicTac.c      **** if ((EV_placement==9))
  96:TicTac.c      **** {
  97:TicTac.c      **** EV_board->EV_i = EV_turn;
  98:TicTac.c      **** }
  99:TicTac.c      **** }
 100:TicTac.c      **** }
 101:TicTac.c      **** }
 102:TicTac.c      **** }
 103:TicTac.c      **** }
 104:TicTac.c      **** }
 105:TicTac.c      **** }
 106:TicTac.c      **** }
 107:TicTac.c      **** }
 254 01d0 360000EA 		b	.L18
 255              	.L9:
  53:TicTac.c      **** {
 257 01d4 10301BE5 		ldr	r3, [fp, #-16]
 258 01d8 020053E3 		cmp	r3, #2
 259 01dc 0300001A 		bne	.L11
  55:TicTac.c      **** }
 261 01e0 08301BE5 		ldr	r3, [fp, #-8]
 262 01e4 0C201BE5 		ldr	r2, [fp, #-12]
 263 01e8 042083E5 		str	r2, [r3, #4]
 265 01ec 2F0000EA 		b	.L18
 266              	.L11:
  59:TicTac.c      **** {
 268 01f0 10301BE5 		ldr	r3, [fp, #-16]
 269 01f4 030053E3 		cmp	r3, #3
 270 01f8 0300001A 		bne	.L12
  61:TicTac.c      **** }
 272 01fc 08301BE5 		ldr	r3, [fp, #-8]
 273 0200 0C201BE5 		ldr	r2, [fp, #-12]
 274 0204 082083E5 		str	r2, [r3, #8]
 276 0208 280000EA 		b	.L18
 277              	.L12:
  65:TicTac.c      **** {
 279 020c 10301BE5 		ldr	r3, [fp, #-16]
 280 0210 040053E3 		cmp	r3, #4
 281 0214 0300001A 		bne	.L13
  67:TicTac.c      **** }
 283 0218 08301BE5 		ldr	r3, [fp, #-8]
 284 021c 0C201BE5 		ldr	r2, [fp, #-12]
 285 0220 0C2083E5 		str	r2, [r3, #12]
 287 0224 210000EA 		b	.L18
 288              	.L13:
  71:TicTac.c      **** {
 290 0228 10301BE5 		ldr	r3, [fp, #-16]
 291 022c 050053E3 		cmp	r3, #5
 292 0230 0300001A 		bne	.L14
  73:TicTac.c      **** }
 294 0234 08301BE5 		ldr	r3, [fp, #-8]
 295 0238 0C201BE5 		ldr	r2, [fp, #-12]
 296 023c 102083E5 		str	r2, [r3, #16]
 298 0240 1A0000EA 		b	.L18
 299              	.L14:
  77:TicTac.c      **** {
 301 0244 10301BE5 		ldr	r3, [fp, #-16]
 302 0248 060053E3 		cmp	r3, #6
 303 024c 0300001A 		bne	.L15
  79:TicTac.c      **** }
 305 0250 08301BE5 		ldr	r3, [fp, #-8]
 306 0254 0C201BE5 		ldr	r2, [fp, #-12]
 307 0258 142083E5 		str	r2, [r3, #20]
 309 025c 130000EA 		b	.L18
 310              	.L15:
  83:TicTac.c      **** {
 312 0260 10301BE5 		ldr	r3, [fp, #-16]
 313 0264 070053E3 		cmp	r3, #7
 314 0268 0300001A 		bne	.L16
  85:TicTac.c      **** }
 316 026c 08301BE5 		ldr	r3, [fp, #-8]
 317 0270 0C201BE5 		ldr	r2, [fp, #-12]
 318 0274 182083E5 		str	r2, [r3, #24]
 320 0278 0C0000EA 		b	.L18
 321              	.L16:
  89:TicTac.c      **** {
 323 027c 10301BE5 		ldr	r3, [fp, #-16]
 324 0280 080053E3 		cmp	r3, #8
 325 0284 0300001A 		bne	.L17
  91:TicTac.c      **** }
 327 0288 08301BE5 		ldr	r3, [fp, #-8]
 328 028c 0C201BE5 		ldr	r2, [fp, #-12]
 329 0290 1C2083E5 		str	r2, [r3, #28]
 331 0294 050000EA 		b	.L18
 332              	.L17:
  95:TicTac.c      **** {
 334 0298 10301BE5 		ldr	r3, [fp, #-16]
 335 029c 090053E3 		cmp	r3, #9
 336 02a0 0200001A 		bne	.L18
  97:TicTac.c      **** }
 338 02a4 08301BE5 		ldr	r3, [fp, #-8]
 339 02a8 0C201BE5 		ldr	r2, [fp, #-12]
 340 02ac 202083E5 		str	r2, [r3, #32]
 341              	.L18:
 343 02b0 0000A0E1 		nop
 344 02b4 00D08BE2 		add	sp, fp, #0
 346              		@ sp needed
 347 02b8 04B09DE4 		ldr	fp, [sp], #4
 350 02bc 1EFF2FE1 		bx	lr
 352              	.LFE9:
 354              		.align	2
 355              		.global	_checkWinner
 356              		.syntax unified
 357              		.arm
 358              		.fpu vfp
 360              	_checkWinner:
 361              	.LFB10:
 108:TicTac.c      **** int _checkWinner(struct EV_gameBoard * EV_board)
 109:TicTac.c      **** {
 364              		@ args = 0, pretend = 0, frame = 8
 365              		@ frame_needed = 1, uses_anonymous_args = 0
 366              		@ link register save eliminated.
 367 02c0 04B02DE5 		str	fp, [sp, #-4]!
 370 02c4 00B08DE2 		add	fp, sp, #0
 372 02c8 0CD04DE2 		sub	sp, sp, #12
 373 02cc 08000BE5 		str	r0, [fp, #-8]
 110:TicTac.c      **** if ((EV_board->EV_a==1))
 375 02d0 08301BE5 		ldr	r3, [fp, #-8]
 376 02d4 003093E5 		ldr	r3, [r3]
 378 02d8 010053E3 		cmp	r3, #1
 379 02dc 0900001A 		bne	.L20
 111:TicTac.c      **** {
 112:TicTac.c      **** if ((EV_board->EV_b==1))
 381 02e0 08301BE5 		ldr	r3, [fp, #-8]
 382 02e4 043093E5 		ldr	r3, [r3, #4]
 384 02e8 010053E3 		cmp	r3, #1
 385 02ec 0500001A 		bne	.L20
 113:TicTac.c      **** {
 114:TicTac.c      **** if ((EV_board->EV_c==1))
 387 02f0 08301BE5 		ldr	r3, [fp, #-8]
 388 02f4 083093E5 		ldr	r3, [r3, #8]
 390 02f8 010053E3 		cmp	r3, #1
 391 02fc 0100001A 		bne	.L20
 115:TicTac.c      **** {
 116:TicTac.c      **** return 0;
 393 0300 0030A0E3 		mov	r3, #0
 394 0304 9A0000EA 		b	.L21
 395              	.L20:
 117:TicTac.c      **** }
 118:TicTac.c      **** }
 119:TicTac.c      **** }
 120:TicTac.c      **** if ((EV_board->EV_a==2))
 397 0308 08301BE5 		ldr	r3, [fp, #-8]
 398 030c 003093E5 		ldr	r3, [r3]
 400 0310 020053E3 		cmp	r3, #2
 401 0314 0900001A 		bne	.L22
 121:TicTac.c      **** {
 122:TicTac.c      **** if ((EV_board->EV_b==2))
 403 0318 08301BE5 		ldr	r3, [fp, #-8]
 404 031c 043093E5 		ldr	r3, [r3, #4]
 406 0320 020053E3 		cmp	r3, #2
 407 0324 0500001A 		bne	.L22
 123:TicTac.c      **** {
 124:TicTac.c      **** if ((EV_board->EV_c==2))
 409 0328 08301BE5 		ldr	r3, [fp, #-8]
 410 032c 083093E5 		ldr	r3, [r3, #8]
 412 0330 020053E3 		cmp	r3, #2
 413 0334 0100001A 		bne	.L22
 125:TicTac.c      **** {
 126:TicTac.c      **** return 1;
 415 0338 0130A0E3 		mov	r3, #1
 416 033c 8C0000EA 		b	.L21
 417              	.L22:
 127:TicTac.c      **** }
 128:TicTac.c      **** }
 129:TicTac.c      **** }
 130:TicTac.c      **** if ((EV_board->EV_d==1))
 419 0340 08301BE5 		ldr	r3, [fp, #-8]
 420 0344 0C3093E5 		ldr	r3, [r3, #12]
 422 0348 010053E3 		cmp	r3, #1
 423 034c 0900001A 		bne	.L23
 131:TicTac.c      **** {
 132:TicTac.c      **** if ((EV_board->EV_e==1))
 425 0350 08301BE5 		ldr	r3, [fp, #-8]
 426 0354 103093E5 		ldr	r3, [r3, #16]
 428 0358 010053E3 		cmp	r3, #1
 429 035c 0500001A 		bne	.L23
 133:TicTac.c      **** {
 134:TicTac.c      **** if ((EV_board->EV_f==1))
 431 0360 08301BE5 		ldr	r3, [fp, #-8]
 432 0364 143093E5 		ldr	r3, [r3, #20]
 434 0368 010053E3 		cmp	r3, #1
 435 036c 0100001A 		bne	.L23
 135:TicTac.c      **** {
 136:TicTac.c      **** return 0;
 437 0370 0030A0E3 		mov	r3, #0
 438 0374 7E0000EA 		b	.L21
 439              	.L23:
 137:TicTac.c      **** }
 138:TicTac.c      **** }
 139:TicTac.c      **** }
 140:TicTac.c      **** if ((EV_board->EV_d==2))
 441 0378 08301BE5 		ldr	r3, [fp, #-8]
 442 037c 0C3093E5 		ldr	r3, [r3, #12]
 444 0380 020053E3 		cmp	r3, #2
 445 0384 0900001A 		bne	.L24
 141:TicTac.c      **** {
 142:TicTac.c      **** if ((EV_board->EV_e==2))
 447 0388 08301BE5 		ldr	r3, [fp, #-8]
 448 038c 103093E5 		ldr	r3, [r3, #16]
 450 0390 020053E3 		cmp	r3, #2
 451 0394 0500001A 		bne	.L24
 143:TicTac.c      **** {
 144:TicTac.c      **** if ((EV_board->EV_f==2))
 453 0398 08301BE5 		ldr	r3, [fp, #-8]
 454 039c 143093E5 		ldr	r3, [r3, #20]
 456 03a0 020053E3 		cmp	r3, #2
 457 03a4 0100001A 		bne	.L24
 145:TicTac.c      **** {
 146:TicTac.c      **** return 1;
 459 03a8 0130A0E3 		mov	r3, #1
 460 03ac 700000EA 		b	.L21
 461              	.L24:
 147:TicTac.c      **** }
 148:TicTac.c      **** }
 149:TicTac.c      **** }
 150:TicTac.c      **** if ((EV_board->EV_g==1))
 463 03b0 08301BE5 		ldr	r3, [fp, #-8]
 464 03b4 183093E5 		ldr	r3, [r3, #24]
 466 03b8 010053E3 		cmp	r3, #1
 467 03bc 0900001A 		bne	.L25
 151:TicTac.c      **** {
 152:TicTac.c      **** if ((EV_board->EV_h==1))
 469 03c0 08301BE5 		ldr	r3, [fp, #-8]
 470 03c4 1C3093E5 		ldr	r3, [r3, #28]
 472 03c8 010053E3 		cmp	r3, #1
 473 03cc 0500001A 		bne	.L25
 153:TicTac.c      **** {
 154:TicTac.c      **** if ((EV_board->EV_i==1))
 475 03d0 08301BE5 		ldr	r3, [fp, #-8]
 476 03d4 203093E5 		ldr	r3, [r3, #32]
 478 03d8 010053E3 		cmp	r3, #1
 479 03dc 0100001A 		bne	.L25
 155:TicTac.c      **** {
 156:TicTac.c      **** return 0;
 481 03e0 0030A0E3 		mov	r3, #0
 482 03e4 620000EA 		b	.L21
 483              	.L25:
 157:TicTac.c      **** }
 158:TicTac.c      **** }
 159:TicTac.c      **** }
 160:TicTac.c      **** if ((EV_board->EV_g==2))
 485 03e8 08301BE5 		ldr	r3, [fp, #-8]
 486 03ec 183093E5 		ldr	r3, [r3, #24]
 488 03f0 020053E3 		cmp	r3, #2
 489 03f4 0900001A 		bne	.L26
 161:TicTac.c      **** {
 162:TicTac.c      **** if ((EV_board->EV_h==2))
 491 03f8 08301BE5 		ldr	r3, [fp, #-8]
 492 03fc 1C3093E5 		ldr	r3, [r3, #28]
 494 0400 020053E3 		cmp	r3, #2
 495 0404 0500001A 		bne	.L26
 163:TicTac.c      **** {
 164:TicTac.c      **** if ((EV_board->EV_i==2))
 497 0408 08301BE5 		ldr	r3, [fp, #-8]
 498 040c 203093E5 		ldr	r3, [r3, #32]
 500 0410 020053E3 		cmp	r3, #2
 501 0414 0100001A 		bne	.L26
 165:TicTac.c      **** {
 166:TicTac.c      **** return 1;
 503 0418 0130A0E3 		mov	r3, #1
 504 041c 540000EA 		b	.L21
 505              	.L26:
 167:TicTac.c      **** }
 168:TicTac.c      **** }
 169:TicTac.c      **** }
 170:TicTac.c      **** if ((EV_board->EV_a==1))
 507 0420 08301BE5 		ldr	r3, [fp, #-8]
 508 0424 003093E5 		ldr	r3, [r3]
 510 0428 010053E3 		cmp	r3, #1
 511 042c 0900001A 		bne	.L27
 171:TicTac.c      **** {
 172:TicTac.c      **** if ((EV_board->EV_d==1))
 513 0430 08301BE5 		ldr	r3, [fp, #-8]
 514 0434 0C3093E5 		ldr	r3, [r3, #12]
 516 0438 010053E3 		cmp	r3, #1
 517 043c 0500001A 		bne	.L27
 173:TicTac.c      **** {
 174:TicTac.c      **** if ((EV_board->EV_g==1))
 519 0440 08301BE5 		ldr	r3, [fp, #-8]
 520 0444 183093E5 		ldr	r3, [r3, #24]
 522 0448 010053E3 		cmp	r3, #1
 523 044c 0100001A 		bne	.L27
 175:TicTac.c      **** {
 176:TicTac.c      **** return 0;
 525 0450 0030A0E3 		mov	r3, #0
 526 0454 460000EA 		b	.L21
 527              	.L27:
 177:TicTac.c      **** }
 178:TicTac.c      **** }
 179:TicTac.c      **** }
 180:TicTac.c      **** if ((EV_board->EV_a==2))
 529 0458 08301BE5 		ldr	r3, [fp, #-8]
 530 045c 003093E5 		ldr	r3, [r3]
 532 0460 020053E3 		cmp	r3, #2
 533 0464 0900001A 		bne	.L28
 181:TicTac.c      **** {
 182:TicTac.c      **** if ((EV_board->EV_d==2))
 535 0468 08301BE5 		ldr	r3, [fp, #-8]
 536 046c 0C3093E5 		ldr	r3, [r3, #12]
 538 0470 020053E3 		cmp	r3, #2
 539 0474 0500001A 		bne	.L28
 183:TicTac.c      **** {
 184:TicTac.c      **** if ((EV_board->EV_g==2))
 541 0478 08301BE5 		ldr	r3, [fp, #-8]
 542 047c 183093E5 		ldr	r3, [r3, #24]
 544 0480 020053E3 		cmp	r3, #2
 545 0484 0100001A 		bne	.L28
 185:TicTac.c      **** {
 186:TicTac.c      **** return 1;
 547 0488 0130A0E3 		mov	r3, #1
 548 048c 380000EA 		b	.L21
 549              	.L28:
 187:TicTac.c      **** }
 188:TicTac.c      **** }
 189:TicTac.c      **** }
 190:TicTac.c      **** if ((EV_board->EV_b==1))
 551 0490 08301BE5 		ldr	r3, [fp, #-8]
 552 0494 043093E5 		ldr	r3, [r3, #4]
 554 0498 010053E3 		cmp	r3, #1
 555 049c 0900001A 		bne	.L29
 191:TicTac.c      **** {
 192:TicTac.c      **** if ((EV_board->EV_e==1))
 557 04a0 08301BE5 		ldr	r3, [fp, #-8]
 558 04a4 103093E5 		ldr	r3, [r3, #16]
 560 04a8 010053E3 		cmp	r3, #1
 561 04ac 0500001A 		bne	.L29
 193:TicTac.c      **** {
 194:TicTac.c      **** if ((EV_board->EV_h==1))
 563 04b0 08301BE5 		ldr	r3, [fp, #-8]
 564 04b4 1C3093E5 		ldr	r3, [r3, #28]
 566 04b8 010053E3 		cmp	r3, #1
 567 04bc 0100001A 		bne	.L29
 195:TicTac.c      **** {
 196:TicTac.c      **** return 0;
 569 04c0 0030A0E3 		mov	r3, #0
 570 04c4 2A0000EA 		b	.L21
 571              	.L29:
 197:TicTac.c      **** }
 198:TicTac.c      **** }
 199:TicTac.c      **** }
 200:TicTac.c      **** if ((EV_board->EV_b==2))
 573 04c8 08301BE5 		ldr	r3, [fp, #-8]
 574 04cc 043093E5 		ldr	r3, [r3, #4]
 576 04d0 020053E3 		cmp	r3, #2
 577 04d4 0900001A 		bne	.L30
 201:TicTac.c      **** {
 202:TicTac.c      **** if ((EV_board->EV_e==2))
 579 04d8 08301BE5 		ldr	r3, [fp, #-8]
 580 04dc 103093E5 		ldr	r3, [r3, #16]
 582 04e0 020053E3 		cmp	r3, #2
 583 04e4 0500001A 		bne	.L30
 203:TicTac.c      **** {
 204:TicTac.c      **** if ((EV_board->EV_h==2))
 585 04e8 08301BE5 		ldr	r3, [fp, #-8]
 586 04ec 1C3093E5 		ldr	r3, [r3, #28]
 588 04f0 020053E3 		cmp	r3, #2
 589 04f4 0100001A 		bne	.L30
 205:TicTac.c      **** {
 206:TicTac.c      **** return 1;
 591 04f8 0130A0E3 		mov	r3, #1
 592 04fc 1C0000EA 		b	.L21
 593              	.L30:
 207:TicTac.c      **** }
 208:TicTac.c      **** }
 209:TicTac.c      **** }
 210:TicTac.c      **** if ((EV_board->EV_c==1))
 595 0500 08301BE5 		ldr	r3, [fp, #-8]
 596 0504 083093E5 		ldr	r3, [r3, #8]
 598 0508 010053E3 		cmp	r3, #1
 599 050c 0900001A 		bne	.L31
 211:TicTac.c      **** {
 212:TicTac.c      **** if ((EV_board->EV_f==1))
 601 0510 08301BE5 		ldr	r3, [fp, #-8]
 602 0514 143093E5 		ldr	r3, [r3, #20]
 604 0518 010053E3 		cmp	r3, #1
 605 051c 0500001A 		bne	.L31
 213:TicTac.c      **** {
 214:TicTac.c      **** if ((EV_board->EV_i==1))
 607 0520 08301BE5 		ldr	r3, [fp, #-8]
 608 0524 203093E5 		ldr	r3, [r3, #32]
 610 0528 010053E3 		cmp	r3, #1
 611 052c 0100001A 		bne	.L31
 215:TicTac.c      **** {
 216:TicTac.c      **** return 0;
 613 0530 0030A0E3 		mov	r3, #0
 614 0534 0E0000EA 		b	.L21
 615              	.L31:
 217:TicTac.c      **** }
 218:TicTac.c      **** }
 219:TicTac.c      **** }
 220:TicTac.c      **** if ((EV_board->EV_c==2))
 617 0538 08301BE5 		ldr	r3, [fp, #-8]
 618 053c 083093E5 		ldr	r3, [r3, #8]
 620 0540 020053E3 		cmp	r3, #2
 621 0544 0900001A 		bne	.L32
 221:TicTac.c      **** {
 222:TicTac.c      **** if ((EV_board->EV_f==2))
 623 0548 08301BE5 		ldr	r3, [fp, #-8]
 624 054c 143093E5 		ldr	r3, [r3, #20]
 626 0550 020053E3 		cmp	r3, #2
 627 0554 0500001A 		bne	.L32
 223:TicTac.c      **** {
 224:TicTac.c      **** if ((EV_board->EV_i==2))
 629 0558 08301BE5 		ldr	r3, [fp, #-8]
 630 055c 203093E5 		ldr	r3, [r3, #32]
 632 0560 020053E3 		cmp	r3, #2
 633 0564 0100001A 		bne	.L32
 225:TicTac.c      **** {
 226:TicTac.c      **** return 1;
 635 0568 0130A0E3 		mov	r3, #1
 636 056c 000000EA 		b	.L21
 637              	.L32:
 227:TicTac.c      **** }
 228:TicTac.c      **** }
 229:TicTac.c      **** }
 230:TicTac.c      **** return (-1);
 639 0570 0030E0E3 		mvn	r3, #0
 640              	.L21:
 231:TicTac.c      **** }
 642 0574 0300A0E1 		mov	r0, r3
 643 0578 00D08BE2 		add	sp, fp, #0
 645              		@ sp needed
 646 057c 04B09DE4 		ldr	fp, [sp], #4
 649 0580 1EFF2FE1 		bx	lr
 651              	.LFE10:
 653              		.section	.rodata
 654              		.align	2
 655              	.LC2:
 656 0008 256400   		.ascii	"%d\000"
 657              		.text
 658              		.align	2
 659              		.global	_main
 660              		.syntax unified
 661              		.arm
 662              		.fpu vfp
 664              	_main:
 665              	.LFB11:
 232:TicTac.c      **** int _main()
 233:TicTac.c      **** {
 668              		@ args = 0, pretend = 0, frame = 24
 669              		@ frame_needed = 1, uses_anonymous_args = 0
 670 0584 00482DE9 		push	{fp, lr}
 674 0588 04B08DE2 		add	fp, sp, #4
 676 058c 18D04DE2 		sub	sp, sp, #24
 234:TicTac.c      **** int EV_turn;
 235:TicTac.c      **** int EV_space1;
 236:TicTac.c      **** int EV_space2;
 237:TicTac.c      **** int EV_winner;
 238:TicTac.c      **** int EV_i;
 239:TicTac.c      **** struct EV_gameBoard * EV_board;
 240:TicTac.c      **** EV_i = 0;
 678 0590 0030A0E3 		mov	r3, #0
 679 0594 10300BE5 		str	r3, [fp, #-16]
 241:TicTac.c      **** EV_turn = 0;
 681 0598 0030A0E3 		mov	r3, #0
 682 059c 08300BE5 		str	r3, [fp, #-8]
 242:TicTac.c      **** EV_space1 = 0;
 684 05a0 0030A0E3 		mov	r3, #0
 685 05a4 18300BE5 		str	r3, [fp, #-24]
 243:TicTac.c      **** EV_space2 = 0;
 687 05a8 0030A0E3 		mov	r3, #0
 688 05ac 1C300BE5 		str	r3, [fp, #-28]
 244:TicTac.c      **** EV_winner = (-1);
 690 05b0 0030E0E3 		mvn	r3, #0
 691 05b4 0C300BE5 		str	r3, [fp, #-12]
 245:TicTac.c      **** EV_board = (struct EV_gameBoard*)malloc(sizeof(struct EV_gameBoard));
 693 05b8 2400A0E3 		mov	r0, #36
 694 05bc FEFFFFEB 		bl	malloc
 695 05c0 0030A0E1 		mov	r3, r0
 696 05c4 14300BE5 		str	r3, [fp, #-20]
 246:TicTac.c      **** _cleanBoard(EV_board);
 698 05c8 14001BE5 		ldr	r0, [fp, #-20]
 699 05cc FEFFFFEB 		bl	_cleanBoard
 247:TicTac.c      **** while (((EV_winner<0)&&(EV_i!=8)))
 701 05d0 230000EA 		b	.L34
 702              	.L38:
 248:TicTac.c      **** {
 249:TicTac.c      **** _printBoard(EV_board);
 704 05d4 14001BE5 		ldr	r0, [fp, #-20]
 705 05d8 FEFFFFEB 		bl	_printBoard
 250:TicTac.c      **** if ((EV_turn==0))
 707 05dc 08301BE5 		ldr	r3, [fp, #-8]
 708 05e0 000053E3 		cmp	r3, #0
 709 05e4 0C00001A 		bne	.L35
 251:TicTac.c      **** {
 252:TicTac.c      **** EV_turn = (EV_turn+1);
 711 05e8 08301BE5 		ldr	r3, [fp, #-8]
 712 05ec 013083E2 		add	r3, r3, #1
 713 05f0 08300BE5 		str	r3, [fp, #-8]
 253:TicTac.c      **** scanf("%d", &EV_space1);
 715 05f4 18304BE2 		sub	r3, fp, #24
 716 05f8 0310A0E1 		mov	r1, r3
 717 05fc 9C009FE5 		ldr	r0, .L40
 718 0600 FEFFFFEB 		bl	__isoc99_scanf
 254:TicTac.c      **** _placePiece(EV_board, 1, EV_space1);
 720 0604 18301BE5 		ldr	r3, [fp, #-24]
 721 0608 0320A0E1 		mov	r2, r3
 722 060c 0110A0E3 		mov	r1, #1
 723 0610 14001BE5 		ldr	r0, [fp, #-20]
 724 0614 FEFFFFEB 		bl	_placePiece
 725 0618 0B0000EA 		b	.L36
 726              	.L35:
 255:TicTac.c      **** }
 256:TicTac.c      **** else
 257:TicTac.c      **** {
 258:TicTac.c      **** EV_turn = (EV_turn-1);
 728 061c 08301BE5 		ldr	r3, [fp, #-8]
 729 0620 013043E2 		sub	r3, r3, #1
 730 0624 08300BE5 		str	r3, [fp, #-8]
 259:TicTac.c      **** scanf("%d", &EV_space2);
 732 0628 1C304BE2 		sub	r3, fp, #28
 733 062c 0310A0E1 		mov	r1, r3
 734 0630 68009FE5 		ldr	r0, .L40
 735 0634 FEFFFFEB 		bl	__isoc99_scanf
 260:TicTac.c      **** _placePiece(EV_board, 2, EV_space2);
 737 0638 1C301BE5 		ldr	r3, [fp, #-28]
 738 063c 0320A0E1 		mov	r2, r3
 739 0640 0210A0E3 		mov	r1, #2
 740 0644 14001BE5 		ldr	r0, [fp, #-20]
 741 0648 FEFFFFEB 		bl	_placePiece
 742              	.L36:
 261:TicTac.c      **** }
 262:TicTac.c      **** EV_winner = _checkWinner(EV_board);
 744 064c 14001BE5 		ldr	r0, [fp, #-20]
 745 0650 FEFFFFEB 		bl	_checkWinner
 746 0654 0C000BE5 		str	r0, [fp, #-12]
 263:TicTac.c      **** EV_i = (EV_i+1);
 748 0658 10301BE5 		ldr	r3, [fp, #-16]
 749 065c 013083E2 		add	r3, r3, #1
 750 0660 10300BE5 		str	r3, [fp, #-16]
 751              	.L34:
 247:TicTac.c      **** {
 753 0664 0C301BE5 		ldr	r3, [fp, #-12]
 754 0668 000053E3 		cmp	r3, #0
 755 066c 020000AA 		bge	.L37
 247:TicTac.c      **** {
 757 0670 10301BE5 		ldr	r3, [fp, #-16]
 758 0674 080053E3 		cmp	r3, #8
 759 0678 D5FFFF1A 		bne	.L38
 760              	.L37:
 264:TicTac.c      **** }
 265:TicTac.c      **** printf("%d\n", (EV_winner+1));
 762 067c 0C301BE5 		ldr	r3, [fp, #-12]
 763 0680 013083E2 		add	r3, r3, #1
 764 0684 0310A0E1 		mov	r1, r3
 765 0688 14009FE5 		ldr	r0, .L40+4
 766 068c FEFFFFEB 		bl	printf
 266:TicTac.c      **** return 0;
 768 0690 0030A0E3 		mov	r3, #0
 267:TicTac.c      **** }
 770 0694 0300A0E1 		mov	r0, r3
 771 0698 04D04BE2 		sub	sp, fp, #4
 773              		@ sp needed
 774 069c 0088BDE8 		pop	{fp, pc}
 775              	.L41:
 776              		.align	2
 777              	.L40:
 778 06a0 08000000 		.word	.LC2
 779 06a4 04000000 		.word	.LC1
 781              	.LFE11:
 783              		.align	2
 784              		.global	main
 785              		.syntax unified
 786              		.arm
 787              		.fpu vfp
 789              	main:
 790              	.LFB12:
 268:TicTac.c      **** int main(void)
 269:TicTac.c      **** {
 793              		@ args = 0, pretend = 0, frame = 0
 794              		@ frame_needed = 1, uses_anonymous_args = 0
 795 06a8 00482DE9 		push	{fp, lr}
 799 06ac 04B08DE2 		add	fp, sp, #4
 270:TicTac.c      ****    return _main();
 802 06b0 FEFFFFEB 		bl	_main
 803 06b4 0030A0E1 		mov	r3, r0
 271:TicTac.c      **** }
 805 06b8 0300A0E1 		mov	r0, r3
 806 06bc 0088BDE8 		pop	{fp, pc}
 808              	.LFE12:
 810              	.Letext0:
