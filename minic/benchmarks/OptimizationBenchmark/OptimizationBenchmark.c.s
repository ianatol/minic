   1              		.arch armv6
  13              		.text
  14              	.Ltext0:
  16              		.comm	EV_global1,4,4
  17              		.comm	EV_global2,4,4
  18              		.comm	EV_global3,4,4
  19              		.align	2
  20              		.global	_constantFolding
  21              		.arch armv6
  22              		.syntax unified
  23              		.arm
  24              		.fpu vfp
  26              	_constantFolding:
  27              	.LFB6:
   1:OptimizationBenchmark.c **** #include<stdio.h>
   2:OptimizationBenchmark.c **** #include<stdlib.h>
   3:OptimizationBenchmark.c **** int EV_global1;
   4:OptimizationBenchmark.c **** int EV_global2;
   5:OptimizationBenchmark.c **** int EV_global3;
   6:OptimizationBenchmark.c **** int _constantFolding()
   7:OptimizationBenchmark.c **** {
  31              		@ args = 0, pretend = 0, frame = 8
  32              		@ frame_needed = 1, uses_anonymous_args = 0
  33              		@ link register save eliminated.
  34 0000 04B02DE5 		str	fp, [sp, #-4]!
  37 0004 00B08DE2 		add	fp, sp, #0
  39 0008 0CD04DE2 		sub	sp, sp, #12
   8:OptimizationBenchmark.c **** int EV_a;
   9:OptimizationBenchmark.c **** EV_a = ((((((((((8*9)/4)+2)-(5*8))+9)-12)+6)-9)-18)+(((23*3)/23)*90));
  41 000c E230A0E3 		mov	r3, #226
  42 0010 08300BE5 		str	r3, [fp, #-8]
  10:OptimizationBenchmark.c **** return EV_a;
  44 0014 08301BE5 		ldr	r3, [fp, #-8]
  11:OptimizationBenchmark.c **** }
  46 0018 0300A0E1 		mov	r0, r3
  47 001c 00D08BE2 		add	sp, fp, #0
  49              		@ sp needed
  50 0020 04B09DE4 		ldr	fp, [sp], #4
  53 0024 1EFF2FE1 		bx	lr
  55              	.LFE6:
  58              		.align	2
  59              		.global	_constantPropagation
  60              		.syntax unified
  61              		.arm
  62              		.fpu vfp
  64              	_constantPropagation:
  65              	.LFB7:
  12:OptimizationBenchmark.c **** int _constantPropagation()
  13:OptimizationBenchmark.c **** {
  68              		@ args = 0, pretend = 0, frame = 104
  69              		@ frame_needed = 1, uses_anonymous_args = 0
  70 0028 10482DE9 		push	{r4, fp, lr}
  75 002c 08B08DE2 		add	fp, sp, #8
  77 0030 6CD04DE2 		sub	sp, sp, #108
  14:OptimizationBenchmark.c **** int EV_a;
  15:OptimizationBenchmark.c **** int EV_b;
  16:OptimizationBenchmark.c **** int EV_c;
  17:OptimizationBenchmark.c **** int EV_d;
  18:OptimizationBenchmark.c **** int EV_e;
  19:OptimizationBenchmark.c **** int EV_f;
  20:OptimizationBenchmark.c **** int EV_g;
  21:OptimizationBenchmark.c **** int EV_h;
  22:OptimizationBenchmark.c **** int EV_i;
  23:OptimizationBenchmark.c **** int EV_j;
  24:OptimizationBenchmark.c **** int EV_k;
  25:OptimizationBenchmark.c **** int EV_l;
  26:OptimizationBenchmark.c **** int EV_m;
  27:OptimizationBenchmark.c **** int EV_n;
  28:OptimizationBenchmark.c **** int EV_o;
  29:OptimizationBenchmark.c **** int EV_p;
  30:OptimizationBenchmark.c **** int EV_q;
  31:OptimizationBenchmark.c **** int EV_r;
  32:OptimizationBenchmark.c **** int EV_s;
  33:OptimizationBenchmark.c **** int EV_t;
  34:OptimizationBenchmark.c **** int EV_u;
  35:OptimizationBenchmark.c **** int EV_v;
  36:OptimizationBenchmark.c **** int EV_w;
  37:OptimizationBenchmark.c **** int EV_x;
  38:OptimizationBenchmark.c **** int EV_y;
  39:OptimizationBenchmark.c **** int EV_z;
  40:OptimizationBenchmark.c **** EV_a = 4;
  79 0034 0430A0E3 		mov	r3, #4
  80 0038 10300BE5 		str	r3, [fp, #-16]
  41:OptimizationBenchmark.c **** EV_b = 7;
  82 003c 0730A0E3 		mov	r3, #7
  83 0040 14300BE5 		str	r3, [fp, #-20]
  42:OptimizationBenchmark.c **** EV_c = 8;
  85 0044 0830A0E3 		mov	r3, #8
  86 0048 18300BE5 		str	r3, [fp, #-24]
  43:OptimizationBenchmark.c **** EV_d = 5;
  88 004c 0530A0E3 		mov	r3, #5
  89 0050 1C300BE5 		str	r3, [fp, #-28]
  44:OptimizationBenchmark.c **** EV_e = 11;
  91 0054 0B30A0E3 		mov	r3, #11
  92 0058 20300BE5 		str	r3, [fp, #-32]
  45:OptimizationBenchmark.c **** EV_f = 21;
  94 005c 1530A0E3 		mov	r3, #21
  95 0060 24300BE5 		str	r3, [fp, #-36]
  46:OptimizationBenchmark.c **** EV_g = (EV_a+EV_b);
  97 0064 10201BE5 		ldr	r2, [fp, #-16]
  98 0068 14301BE5 		ldr	r3, [fp, #-20]
  99 006c 033082E0 		add	r3, r2, r3
 100 0070 28300BE5 		str	r3, [fp, #-40]
  47:OptimizationBenchmark.c **** EV_h = (EV_c+EV_d);
 102 0074 18201BE5 		ldr	r2, [fp, #-24]
 103 0078 1C301BE5 		ldr	r3, [fp, #-28]
 104 007c 033082E0 		add	r3, r2, r3
 105 0080 2C300BE5 		str	r3, [fp, #-44]
  48:OptimizationBenchmark.c **** EV_i = (EV_e+EV_f);
 107 0084 20201BE5 		ldr	r2, [fp, #-32]
 108 0088 24301BE5 		ldr	r3, [fp, #-36]
 109 008c 033082E0 		add	r3, r2, r3
 110 0090 30300BE5 		str	r3, [fp, #-48]
  49:OptimizationBenchmark.c **** EV_j = (EV_g+EV_h);
 112 0094 28201BE5 		ldr	r2, [fp, #-40]
 113 0098 2C301BE5 		ldr	r3, [fp, #-44]
 114 009c 033082E0 		add	r3, r2, r3
 115 00a0 34300BE5 		str	r3, [fp, #-52]
  50:OptimizationBenchmark.c **** EV_k = (EV_i*EV_j);
 117 00a4 30301BE5 		ldr	r3, [fp, #-48]
 118 00a8 34201BE5 		ldr	r2, [fp, #-52]
 119 00ac 920303E0 		mul	r3, r2, r3
 120 00b0 38300BE5 		str	r3, [fp, #-56]
  51:OptimizationBenchmark.c **** EV_l = ((EV_e+(EV_h*EV_i))-EV_k);
 122 00b4 2C301BE5 		ldr	r3, [fp, #-44]
 123 00b8 30201BE5 		ldr	r2, [fp, #-48]
 124 00bc 920302E0 		mul	r2, r2, r3
 126 00c0 20301BE5 		ldr	r3, [fp, #-32]
 127 00c4 032082E0 		add	r2, r2, r3
 129 00c8 38301BE5 		ldr	r3, [fp, #-56]
 130 00cc 033042E0 		sub	r3, r2, r3
 131 00d0 3C300BE5 		str	r3, [fp, #-60]
  52:OptimizationBenchmark.c **** EV_m = ((EV_h-(EV_i*EV_j))+(EV_k/EV_l));
 133 00d4 30301BE5 		ldr	r3, [fp, #-48]
 134 00d8 34201BE5 		ldr	r2, [fp, #-52]
 135 00dc 920303E0 		mul	r3, r2, r3
 137 00e0 2C201BE5 		ldr	r2, [fp, #-44]
 138 00e4 034042E0 		sub	r4, r2, r3
 140 00e8 3C101BE5 		ldr	r1, [fp, #-60]
 141 00ec 38001BE5 		ldr	r0, [fp, #-56]
 143              	.LVL0:
 144 00f4 0030A0E1 		mov	r3, r0
 146 00f8 033084E0 		add	r3, r4, r3
 147 00fc 40300BE5 		str	r3, [fp, #-64]
  53:OptimizationBenchmark.c **** EV_n = (((((EV_e+EV_f)+EV_g)+EV_h)+EV_i)-EV_j);
 149 0100 20201BE5 		ldr	r2, [fp, #-32]
 150 0104 24301BE5 		ldr	r3, [fp, #-36]
 151 0108 032082E0 		add	r2, r2, r3
 153 010c 28301BE5 		ldr	r3, [fp, #-40]
 154 0110 032082E0 		add	r2, r2, r3
 156 0114 2C301BE5 		ldr	r3, [fp, #-44]
 157 0118 032082E0 		add	r2, r2, r3
 159 011c 30301BE5 		ldr	r3, [fp, #-48]
 160 0120 032082E0 		add	r2, r2, r3
 162 0124 34301BE5 		ldr	r3, [fp, #-52]
 163 0128 033042E0 		sub	r3, r2, r3
 164 012c 44300BE5 		str	r3, [fp, #-68]
  54:OptimizationBenchmark.c **** EV_o = ((((EV_n-EV_m)+EV_h)-EV_a)-EV_b);
 166 0130 44201BE5 		ldr	r2, [fp, #-68]
 167 0134 40301BE5 		ldr	r3, [fp, #-64]
 168 0138 032042E0 		sub	r2, r2, r3
 170 013c 2C301BE5 		ldr	r3, [fp, #-44]
 171 0140 032082E0 		add	r2, r2, r3
 173 0144 10301BE5 		ldr	r3, [fp, #-16]
 174 0148 032042E0 		sub	r2, r2, r3
 176 014c 14301BE5 		ldr	r3, [fp, #-20]
 177 0150 033042E0 		sub	r3, r2, r3
 178 0154 48300BE5 		str	r3, [fp, #-72]
  55:OptimizationBenchmark.c **** EV_p = (((EV_k+EV_l)-EV_g)-EV_h);
 180 0158 38201BE5 		ldr	r2, [fp, #-56]
 181 015c 3C301BE5 		ldr	r3, [fp, #-60]
 182 0160 032082E0 		add	r2, r2, r3
 184 0164 28301BE5 		ldr	r3, [fp, #-40]
 185 0168 032042E0 		sub	r2, r2, r3
 187 016c 2C301BE5 		ldr	r3, [fp, #-44]
 188 0170 033042E0 		sub	r3, r2, r3
 189 0174 4C300BE5 		str	r3, [fp, #-76]
  56:OptimizationBenchmark.c **** EV_q = (((EV_b-EV_a)*EV_d)-EV_i);
 191 0178 14201BE5 		ldr	r2, [fp, #-20]
 192 017c 10301BE5 		ldr	r3, [fp, #-16]
 193 0180 033042E0 		sub	r3, r2, r3
 195 0184 1C201BE5 		ldr	r2, [fp, #-28]
 196 0188 920302E0 		mul	r2, r2, r3
 198 018c 30301BE5 		ldr	r3, [fp, #-48]
 199 0190 033042E0 		sub	r3, r2, r3
 200 0194 50300BE5 		str	r3, [fp, #-80]
  57:OptimizationBenchmark.c **** EV_r = (((EV_l*EV_c)*EV_d)+EV_o);
 202 0198 3C301BE5 		ldr	r3, [fp, #-60]
 203 019c 18201BE5 		ldr	r2, [fp, #-24]
 204 01a0 920303E0 		mul	r3, r2, r3
 206 01a4 1C201BE5 		ldr	r2, [fp, #-28]
 207 01a8 920303E0 		mul	r3, r2, r3
 209 01ac 48201BE5 		ldr	r2, [fp, #-72]
 210 01b0 033082E0 		add	r3, r2, r3
 211 01b4 54300BE5 		str	r3, [fp, #-84]
  58:OptimizationBenchmark.c **** EV_s = ((((EV_b*EV_a)*EV_c)/EV_e)-EV_o);
 213 01b8 14301BE5 		ldr	r3, [fp, #-20]
 214 01bc 10201BE5 		ldr	r2, [fp, #-16]
 215 01c0 920303E0 		mul	r3, r2, r3
 217 01c4 18201BE5 		ldr	r2, [fp, #-24]
 218 01c8 920303E0 		mul	r3, r2, r3
 220 01cc 20101BE5 		ldr	r1, [fp, #-32]
 221 01d0 0300A0E1 		mov	r0, r3
 223              	.LVL1:
 224 01d8 0030A0E1 		mov	r3, r0
 225 01dc 0320A0E1 		mov	r2, r3
 227 01e0 48301BE5 		ldr	r3, [fp, #-72]
 228 01e4 033042E0 		sub	r3, r2, r3
 229 01e8 58300BE5 		str	r3, [fp, #-88]
  59:OptimizationBenchmark.c **** EV_t = (((EV_i+EV_k)+EV_c)-EV_p);
 231 01ec 30201BE5 		ldr	r2, [fp, #-48]
 232 01f0 38301BE5 		ldr	r3, [fp, #-56]
 233 01f4 032082E0 		add	r2, r2, r3
 235 01f8 18301BE5 		ldr	r3, [fp, #-24]
 236 01fc 032082E0 		add	r2, r2, r3
 238 0200 4C301BE5 		ldr	r3, [fp, #-76]
 239 0204 033042E0 		sub	r3, r2, r3
 240 0208 5C300BE5 		str	r3, [fp, #-92]
  60:OptimizationBenchmark.c **** EV_u = ((EV_n+EV_o)-(EV_f*EV_a));
 242 020c 44201BE5 		ldr	r2, [fp, #-68]
 243 0210 48301BE5 		ldr	r3, [fp, #-72]
 244 0214 032082E0 		add	r2, r2, r3
 246 0218 24301BE5 		ldr	r3, [fp, #-36]
 247 021c 10101BE5 		ldr	r1, [fp, #-16]
 248 0220 910303E0 		mul	r3, r1, r3
 250 0224 033042E0 		sub	r3, r2, r3
 251 0228 60300BE5 		str	r3, [fp, #-96]
  61:OptimizationBenchmark.c **** EV_v = (((EV_a*EV_b)-EV_k)-EV_l);
 253 022c 10301BE5 		ldr	r3, [fp, #-16]
 254 0230 14201BE5 		ldr	r2, [fp, #-20]
 255 0234 920302E0 		mul	r2, r2, r3
 257 0238 38301BE5 		ldr	r3, [fp, #-56]
 258 023c 032042E0 		sub	r2, r2, r3
 260 0240 3C301BE5 		ldr	r3, [fp, #-60]
 261 0244 033042E0 		sub	r3, r2, r3
 262 0248 64300BE5 		str	r3, [fp, #-100]
  62:OptimizationBenchmark.c **** EV_w = ((EV_v-EV_s)-(EV_r*EV_d));
 264 024c 64201BE5 		ldr	r2, [fp, #-100]
 265 0250 58301BE5 		ldr	r3, [fp, #-88]
 266 0254 032042E0 		sub	r2, r2, r3
 268 0258 54301BE5 		ldr	r3, [fp, #-84]
 269 025c 1C101BE5 		ldr	r1, [fp, #-28]
 270 0260 910303E0 		mul	r3, r1, r3
 272 0264 033042E0 		sub	r3, r2, r3
 273 0268 68300BE5 		str	r3, [fp, #-104]
  63:OptimizationBenchmark.c **** EV_x = (((EV_o-EV_w)-EV_v)-EV_n);
 275 026c 48201BE5 		ldr	r2, [fp, #-72]
 276 0270 68301BE5 		ldr	r3, [fp, #-104]
 277 0274 032042E0 		sub	r2, r2, r3
 279 0278 64301BE5 		ldr	r3, [fp, #-100]
 280 027c 032042E0 		sub	r2, r2, r3
 282 0280 44301BE5 		ldr	r3, [fp, #-68]
 283 0284 033042E0 		sub	r3, r2, r3
 284 0288 6C300BE5 		str	r3, [fp, #-108]
  64:OptimizationBenchmark.c **** EV_y = (((EV_p*EV_x)+EV_t)-EV_w);
 286 028c 4C301BE5 		ldr	r3, [fp, #-76]
 287 0290 6C201BE5 		ldr	r2, [fp, #-108]
 288 0294 920302E0 		mul	r2, r2, r3
 290 0298 5C301BE5 		ldr	r3, [fp, #-92]
 291 029c 032082E0 		add	r2, r2, r3
 293 02a0 68301BE5 		ldr	r3, [fp, #-104]
 294 02a4 033042E0 		sub	r3, r2, r3
 295 02a8 70300BE5 		str	r3, [fp, #-112]
  65:OptimizationBenchmark.c **** EV_z = ((EV_w-EV_x+EV_y)+EV_k);
 297 02ac 68201BE5 		ldr	r2, [fp, #-104]
 298 02b0 6C301BE5 		ldr	r3, [fp, #-108]
 299 02b4 032042E0 		sub	r2, r2, r3
 301 02b8 70301BE5 		ldr	r3, [fp, #-112]
 302 02bc 033082E0 		add	r3, r2, r3
 304 02c0 38201BE5 		ldr	r2, [fp, #-56]
 305 02c4 033082E0 		add	r3, r2, r3
 306 02c8 74300BE5 		str	r3, [fp, #-116]
  66:OptimizationBenchmark.c **** return EV_z;
 308 02cc 74301BE5 		ldr	r3, [fp, #-116]
  67:OptimizationBenchmark.c **** }
 310 02d0 0300A0E1 		mov	r0, r3
 311 02d4 08D04BE2 		sub	sp, fp, #8
 313              		@ sp needed
 314 02d8 1088BDE8 		pop	{r4, fp, pc}
 316              	.LFE7:
 318              		.align	2
 319              		.global	_deadCodeElimination
 320              		.syntax unified
 321              		.arm
 322              		.fpu vfp
 324              	_deadCodeElimination:
 325              	.LFB8:
  68:OptimizationBenchmark.c **** int _deadCodeElimination()
  69:OptimizationBenchmark.c **** {
 328              		@ args = 0, pretend = 0, frame = 24
 329              		@ frame_needed = 1, uses_anonymous_args = 0
 330              		@ link register save eliminated.
 331 02dc 04B02DE5 		str	fp, [sp, #-4]!
 334 02e0 00B08DE2 		add	fp, sp, #0
 336 02e4 1CD04DE2 		sub	sp, sp, #28
  70:OptimizationBenchmark.c **** int EV_a;
  71:OptimizationBenchmark.c **** int EV_b;
  72:OptimizationBenchmark.c **** int EV_c;
  73:OptimizationBenchmark.c **** int EV_d;
  74:OptimizationBenchmark.c **** int EV_e;
  75:OptimizationBenchmark.c **** EV_a = 4;
 338 02e8 0430A0E3 		mov	r3, #4
 339 02ec 08300BE5 		str	r3, [fp, #-8]
  76:OptimizationBenchmark.c **** EV_a = 5;
 341 02f0 0530A0E3 		mov	r3, #5
 342 02f4 08300BE5 		str	r3, [fp, #-8]
  77:OptimizationBenchmark.c **** EV_a = 7;
 344 02f8 0730A0E3 		mov	r3, #7
 345 02fc 08300BE5 		str	r3, [fp, #-8]
  78:OptimizationBenchmark.c **** EV_a = 8;
 347 0300 0830A0E3 		mov	r3, #8
 348 0304 08300BE5 		str	r3, [fp, #-8]
  79:OptimizationBenchmark.c **** EV_b = 6;
 350 0308 0630A0E3 		mov	r3, #6
 351 030c 0C300BE5 		str	r3, [fp, #-12]
  80:OptimizationBenchmark.c **** EV_b = 9;
 353 0310 0930A0E3 		mov	r3, #9
 354 0314 0C300BE5 		str	r3, [fp, #-12]
  81:OptimizationBenchmark.c **** EV_b = 12;
 356 0318 0C30A0E3 		mov	r3, #12
 357 031c 0C300BE5 		str	r3, [fp, #-12]
  82:OptimizationBenchmark.c **** EV_b = 8;
 359 0320 0830A0E3 		mov	r3, #8
 360 0324 0C300BE5 		str	r3, [fp, #-12]
  83:OptimizationBenchmark.c **** EV_c = 10;
 362 0328 0A30A0E3 		mov	r3, #10
 363 032c 10300BE5 		str	r3, [fp, #-16]
  84:OptimizationBenchmark.c **** EV_c = 13;
 365 0330 0D30A0E3 		mov	r3, #13
 366 0334 10300BE5 		str	r3, [fp, #-16]
  85:OptimizationBenchmark.c **** EV_c = 9;
 368 0338 0930A0E3 		mov	r3, #9
 369 033c 10300BE5 		str	r3, [fp, #-16]
  86:OptimizationBenchmark.c **** EV_d = 45;
 371 0340 2D30A0E3 		mov	r3, #45
 372 0344 14300BE5 		str	r3, [fp, #-20]
  87:OptimizationBenchmark.c **** EV_d = 12;
 374 0348 0C30A0E3 		mov	r3, #12
 375 034c 14300BE5 		str	r3, [fp, #-20]
  88:OptimizationBenchmark.c **** EV_d = 3;
 377 0350 0330A0E3 		mov	r3, #3
 378 0354 14300BE5 		str	r3, [fp, #-20]
  89:OptimizationBenchmark.c **** EV_e = 23;
 380 0358 1730A0E3 		mov	r3, #23
 381 035c 18300BE5 		str	r3, [fp, #-24]
  90:OptimizationBenchmark.c **** EV_e = 10;
 383 0360 0A30A0E3 		mov	r3, #10
 384 0364 18300BE5 		str	r3, [fp, #-24]
  91:OptimizationBenchmark.c **** EV_global1 = 11;
 386 0368 50309FE5 		ldr	r3, .L7
 387 036c 0B20A0E3 		mov	r2, #11
 388 0370 002083E5 		str	r2, [r3]
  92:OptimizationBenchmark.c **** EV_global1 = 5;
 390 0374 44309FE5 		ldr	r3, .L7
 391 0378 0520A0E3 		mov	r2, #5
 392 037c 002083E5 		str	r2, [r3]
  93:OptimizationBenchmark.c **** EV_global1 = 9;
 394 0380 38309FE5 		ldr	r3, .L7
 395 0384 0920A0E3 		mov	r2, #9
 396 0388 002083E5 		str	r2, [r3]
  94:OptimizationBenchmark.c **** return ((((EV_a+EV_b)+EV_c)+EV_d)+EV_e);
 398 038c 08201BE5 		ldr	r2, [fp, #-8]
 399 0390 0C301BE5 		ldr	r3, [fp, #-12]
 400 0394 032082E0 		add	r2, r2, r3
 402 0398 10301BE5 		ldr	r3, [fp, #-16]
 403 039c 032082E0 		add	r2, r2, r3
 405 03a0 14301BE5 		ldr	r3, [fp, #-20]
 406 03a4 032082E0 		add	r2, r2, r3
 408 03a8 18301BE5 		ldr	r3, [fp, #-24]
 409 03ac 033082E0 		add	r3, r2, r3
  95:OptimizationBenchmark.c **** }
 411 03b0 0300A0E1 		mov	r0, r3
 412 03b4 00D08BE2 		add	sp, fp, #0
 414              		@ sp needed
 415 03b8 04B09DE4 		ldr	fp, [sp], #4
 418 03bc 1EFF2FE1 		bx	lr
 419              	.L8:
 420              		.align	2
 421              	.L7:
 422 03c0 00000000 		.word	EV_global1
 424              	.LFE8:
 426              		.align	2
 427              		.global	_sum
 428              		.syntax unified
 429              		.arm
 430              		.fpu vfp
 432              	_sum:
 433              	.LFB9:
  96:OptimizationBenchmark.c **** int _sum(int EV_number)
  97:OptimizationBenchmark.c **** {
 436              		@ args = 0, pretend = 0, frame = 16
 437              		@ frame_needed = 1, uses_anonymous_args = 0
 438              		@ link register save eliminated.
 439 03c4 04B02DE5 		str	fp, [sp, #-4]!
 442 03c8 00B08DE2 		add	fp, sp, #0
 444 03cc 14D04DE2 		sub	sp, sp, #20
 445 03d0 10000BE5 		str	r0, [fp, #-16]
  98:OptimizationBenchmark.c **** int EV_total;
  99:OptimizationBenchmark.c **** EV_total = 0;
 447 03d4 0030A0E3 		mov	r3, #0
 448 03d8 08300BE5 		str	r3, [fp, #-8]
 100:OptimizationBenchmark.c **** while ((EV_number>0))
 450 03dc 060000EA 		b	.L10
 451              	.L11:
 101:OptimizationBenchmark.c **** {
 102:OptimizationBenchmark.c **** EV_total = (EV_total+EV_number);
 453 03e0 08201BE5 		ldr	r2, [fp, #-8]
 454 03e4 10301BE5 		ldr	r3, [fp, #-16]
 455 03e8 033082E0 		add	r3, r2, r3
 456 03ec 08300BE5 		str	r3, [fp, #-8]
 103:OptimizationBenchmark.c **** EV_number = (EV_number-1);
 458 03f0 10301BE5 		ldr	r3, [fp, #-16]
 459 03f4 013043E2 		sub	r3, r3, #1
 460 03f8 10300BE5 		str	r3, [fp, #-16]
 461              	.L10:
 100:OptimizationBenchmark.c **** while ((EV_number>0))
 463 03fc 10301BE5 		ldr	r3, [fp, #-16]
 464 0400 000053E3 		cmp	r3, #0
 465 0404 F5FFFFCA 		bgt	.L11
 104:OptimizationBenchmark.c **** }
 105:OptimizationBenchmark.c **** return EV_total;
 467 0408 08301BE5 		ldr	r3, [fp, #-8]
 106:OptimizationBenchmark.c **** }
 469 040c 0300A0E1 		mov	r0, r3
 470 0410 00D08BE2 		add	sp, fp, #0
 472              		@ sp needed
 473 0414 04B09DE4 		ldr	fp, [sp], #4
 476 0418 1EFF2FE1 		bx	lr
 478              	.LFE9:
 480              		.align	2
 481              		.global	_doesntModifyGlobals
 482              		.syntax unified
 483              		.arm
 484              		.fpu vfp
 486              	_doesntModifyGlobals:
 487              	.LFB10:
 107:OptimizationBenchmark.c **** int _doesntModifyGlobals()
 108:OptimizationBenchmark.c **** {
 490              		@ args = 0, pretend = 0, frame = 8
 491              		@ frame_needed = 1, uses_anonymous_args = 0
 492              		@ link register save eliminated.
 493 041c 04B02DE5 		str	fp, [sp, #-4]!
 496 0420 00B08DE2 		add	fp, sp, #0
 498 0424 0CD04DE2 		sub	sp, sp, #12
 109:OptimizationBenchmark.c **** int EV_a;
 110:OptimizationBenchmark.c **** int EV_b;
 111:OptimizationBenchmark.c **** EV_a = 1;
 500 0428 0130A0E3 		mov	r3, #1
 501 042c 08300BE5 		str	r3, [fp, #-8]
 112:OptimizationBenchmark.c **** EV_b = 2;
 503 0430 0230A0E3 		mov	r3, #2
 504 0434 0C300BE5 		str	r3, [fp, #-12]
 113:OptimizationBenchmark.c **** return (EV_a+EV_b);
 506 0438 08201BE5 		ldr	r2, [fp, #-8]
 507 043c 0C301BE5 		ldr	r3, [fp, #-12]
 508 0440 033082E0 		add	r3, r2, r3
 114:OptimizationBenchmark.c **** }
 510 0444 0300A0E1 		mov	r0, r3
 511 0448 00D08BE2 		add	sp, fp, #0
 513              		@ sp needed
 514 044c 04B09DE4 		ldr	fp, [sp], #4
 517 0450 1EFF2FE1 		bx	lr
 519              	.LFE10:
 521              		.align	2
 522              		.global	_interProceduralOptimization
 523              		.syntax unified
 524              		.arm
 525              		.fpu vfp
 527              	_interProceduralOptimization:
 528              	.LFB11:
 115:OptimizationBenchmark.c **** int _interProceduralOptimization()
 116:OptimizationBenchmark.c **** {
 531              		@ args = 0, pretend = 0, frame = 8
 532              		@ frame_needed = 1, uses_anonymous_args = 0
 533 0454 00482DE9 		push	{fp, lr}
 537 0458 04B08DE2 		add	fp, sp, #4
 539 045c 08D04DE2 		sub	sp, sp, #8
 117:OptimizationBenchmark.c **** int EV_a;
 118:OptimizationBenchmark.c **** EV_global1 = 1;
 541 0460 90309FE5 		ldr	r3, .L20
 542 0464 0120A0E3 		mov	r2, #1
 543 0468 002083E5 		str	r2, [r3]
 119:OptimizationBenchmark.c **** EV_global2 = 0;
 545 046c 88309FE5 		ldr	r3, .L20+4
 546 0470 0020A0E3 		mov	r2, #0
 547 0474 002083E5 		str	r2, [r3]
 120:OptimizationBenchmark.c **** EV_global3 = 0;
 549 0478 80309FE5 		ldr	r3, .L20+8
 550 047c 0020A0E3 		mov	r2, #0
 551 0480 002083E5 		str	r2, [r3]
 121:OptimizationBenchmark.c **** EV_a = _sum(100);
 553 0484 6400A0E3 		mov	r0, #100
 554 0488 FEFFFFEB 		bl	_sum
 555 048c 08000BE5 		str	r0, [fp, #-8]
 122:OptimizationBenchmark.c **** if ((EV_global1==1))
 557 0490 60309FE5 		ldr	r3, .L20
 558 0494 003093E5 		ldr	r3, [r3]
 560 0498 010053E3 		cmp	r3, #1
 561 049c 0300001A 		bne	.L16
 123:OptimizationBenchmark.c **** {
 124:OptimizationBenchmark.c **** EV_a = _sum(10000);
 563 04a0 5C009FE5 		ldr	r0, .L20+12
 564 04a4 FEFFFFEB 		bl	_sum
 565 04a8 08000BE5 		str	r0, [fp, #-8]
 566 04ac 0D0000EA 		b	.L17
 567              	.L16:
 125:OptimizationBenchmark.c **** }
 126:OptimizationBenchmark.c **** else
 127:OptimizationBenchmark.c **** {
 128:OptimizationBenchmark.c **** if ((EV_global2==2))
 569 04b0 44309FE5 		ldr	r3, .L20+4
 570 04b4 003093E5 		ldr	r3, [r3]
 572 04b8 020053E3 		cmp	r3, #2
 573 04bc 0200001A 		bne	.L18
 129:OptimizationBenchmark.c **** {
 130:OptimizationBenchmark.c **** EV_a = _sum(20000);
 575 04c0 40009FE5 		ldr	r0, .L20+16
 576 04c4 FEFFFFEB 		bl	_sum
 577 04c8 08000BE5 		str	r0, [fp, #-8]
 578              	.L18:
 131:OptimizationBenchmark.c **** }
 132:OptimizationBenchmark.c **** if ((EV_global3==3))
 580 04cc 2C309FE5 		ldr	r3, .L20+8
 581 04d0 003093E5 		ldr	r3, [r3]
 583 04d4 030053E3 		cmp	r3, #3
 584 04d8 0200001A 		bne	.L17
 133:OptimizationBenchmark.c **** {
 134:OptimizationBenchmark.c **** EV_a = _sum(30000);
 586 04dc 28009FE5 		ldr	r0, .L20+20
 587 04e0 FEFFFFEB 		bl	_sum
 588 04e4 08000BE5 		str	r0, [fp, #-8]
 589              	.L17:
 135:OptimizationBenchmark.c **** }
 136:OptimizationBenchmark.c **** }
 137:OptimizationBenchmark.c **** return EV_a;
 591 04e8 08301BE5 		ldr	r3, [fp, #-8]
 138:OptimizationBenchmark.c **** }
 593 04ec 0300A0E1 		mov	r0, r3
 594 04f0 04D04BE2 		sub	sp, fp, #4
 596              		@ sp needed
 597 04f4 0088BDE8 		pop	{fp, pc}
 598              	.L21:
 599              		.align	2
 600              	.L20:
 601 04f8 00000000 		.word	EV_global1
 602 04fc 00000000 		.word	EV_global2
 603 0500 00000000 		.word	EV_global3
 604 0504 10270000 		.word	10000
 605 0508 204E0000 		.word	20000
 606 050c 30750000 		.word	30000
 608              	.LFE11:
 610              		.align	2
 611              		.global	_commonSubexpressionElimination
 612              		.syntax unified
 613              		.arm
 614              		.fpu vfp
 616              	_commonSubexpressionElimination:
 617              	.LFB12:
 139:OptimizationBenchmark.c **** int _commonSubexpressionElimination()
 140:OptimizationBenchmark.c **** {
 620              		@ args = 0, pretend = 0, frame = 104
 621              		@ frame_needed = 1, uses_anonymous_args = 0
 622 0510 10482DE9 		push	{r4, fp, lr}
 627 0514 08B08DE2 		add	fp, sp, #8
 629 0518 6CD04DE2 		sub	sp, sp, #108
 141:OptimizationBenchmark.c **** int EV_a;
 142:OptimizationBenchmark.c **** int EV_b;
 143:OptimizationBenchmark.c **** int EV_c;
 144:OptimizationBenchmark.c **** int EV_d;
 145:OptimizationBenchmark.c **** int EV_e;
 146:OptimizationBenchmark.c **** int EV_f;
 147:OptimizationBenchmark.c **** int EV_g;
 148:OptimizationBenchmark.c **** int EV_h;
 149:OptimizationBenchmark.c **** int EV_i;
 150:OptimizationBenchmark.c **** int EV_j;
 151:OptimizationBenchmark.c **** int EV_k;
 152:OptimizationBenchmark.c **** int EV_l;
 153:OptimizationBenchmark.c **** int EV_m;
 154:OptimizationBenchmark.c **** int EV_n;
 155:OptimizationBenchmark.c **** int EV_o;
 156:OptimizationBenchmark.c **** int EV_p;
 157:OptimizationBenchmark.c **** int EV_q;
 158:OptimizationBenchmark.c **** int EV_r;
 159:OptimizationBenchmark.c **** int EV_s;
 160:OptimizationBenchmark.c **** int EV_t;
 161:OptimizationBenchmark.c **** int EV_u;
 162:OptimizationBenchmark.c **** int EV_v;
 163:OptimizationBenchmark.c **** int EV_w;
 164:OptimizationBenchmark.c **** int EV_x;
 165:OptimizationBenchmark.c **** int EV_y;
 166:OptimizationBenchmark.c **** int EV_z;
 167:OptimizationBenchmark.c **** EV_a = 11;
 631 051c 0B30A0E3 		mov	r3, #11
 632 0520 10300BE5 		str	r3, [fp, #-16]
 168:OptimizationBenchmark.c **** EV_b = 22;
 634 0524 1630A0E3 		mov	r3, #22
 635 0528 14300BE5 		str	r3, [fp, #-20]
 169:OptimizationBenchmark.c **** EV_c = 33;
 637 052c 2130A0E3 		mov	r3, #33
 638 0530 18300BE5 		str	r3, [fp, #-24]
 170:OptimizationBenchmark.c **** EV_d = 44;
 640 0534 2C30A0E3 		mov	r3, #44
 641 0538 1C300BE5 		str	r3, [fp, #-28]
 171:OptimizationBenchmark.c **** EV_e = 55;
 643 053c 3730A0E3 		mov	r3, #55
 644 0540 20300BE5 		str	r3, [fp, #-32]
 172:OptimizationBenchmark.c **** EV_f = 66;
 646 0544 4230A0E3 		mov	r3, #66
 647 0548 24300BE5 		str	r3, [fp, #-36]
 173:OptimizationBenchmark.c **** EV_g = 77;
 649 054c 4D30A0E3 		mov	r3, #77
 650 0550 28300BE5 		str	r3, [fp, #-40]
 174:OptimizationBenchmark.c **** EV_h = (EV_a*EV_b);
 652 0554 10301BE5 		ldr	r3, [fp, #-16]
 653 0558 14201BE5 		ldr	r2, [fp, #-20]
 654 055c 920303E0 		mul	r3, r2, r3
 655 0560 2C300BE5 		str	r3, [fp, #-44]
 175:OptimizationBenchmark.c **** EV_i = (EV_c/EV_d);
 657 0564 1C101BE5 		ldr	r1, [fp, #-28]
 658 0568 18001BE5 		ldr	r0, [fp, #-24]
 660              	.LVL2:
 661 0570 0030A0E1 		mov	r3, r0
 662 0574 30300BE5 		str	r3, [fp, #-48]
 176:OptimizationBenchmark.c **** EV_j = (EV_e*EV_f);
 664 0578 20301BE5 		ldr	r3, [fp, #-32]
 665 057c 24201BE5 		ldr	r2, [fp, #-36]
 666 0580 920303E0 		mul	r3, r2, r3
 667 0584 34300BE5 		str	r3, [fp, #-52]
 177:OptimizationBenchmark.c **** EV_k = ((((EV_a*EV_b)+(EV_c/EV_d))-(EV_e*EV_f))+EV_g);
 669 0588 10301BE5 		ldr	r3, [fp, #-16]
 670 058c 14201BE5 		ldr	r2, [fp, #-20]
 671 0590 920304E0 		mul	r4, r2, r3
 673 0594 1C101BE5 		ldr	r1, [fp, #-28]
 674 0598 18001BE5 		ldr	r0, [fp, #-24]
 676              	.LVL3:
 677 05a0 0030A0E1 		mov	r3, r0
 679 05a4 032084E0 		add	r2, r4, r3
 681 05a8 20301BE5 		ldr	r3, [fp, #-32]
 682 05ac 24101BE5 		ldr	r1, [fp, #-36]
 683 05b0 910303E0 		mul	r3, r1, r3
 685 05b4 033042E0 		sub	r3, r2, r3
 687 05b8 28201BE5 		ldr	r2, [fp, #-40]
 688 05bc 033082E0 		add	r3, r2, r3
 689 05c0 38300BE5 		str	r3, [fp, #-56]
 178:OptimizationBenchmark.c **** EV_l = ((((EV_a*EV_b)+(EV_c/EV_d))-(EV_e*EV_f))+EV_g);
 691 05c4 10301BE5 		ldr	r3, [fp, #-16]
 692 05c8 14201BE5 		ldr	r2, [fp, #-20]
 693 05cc 920304E0 		mul	r4, r2, r3
 695 05d0 1C101BE5 		ldr	r1, [fp, #-28]
 696 05d4 18001BE5 		ldr	r0, [fp, #-24]
 698              	.LVL4:
 699 05dc 0030A0E1 		mov	r3, r0
 701 05e0 032084E0 		add	r2, r4, r3
 703 05e4 20301BE5 		ldr	r3, [fp, #-32]
 704 05e8 24101BE5 		ldr	r1, [fp, #-36]
 705 05ec 910303E0 		mul	r3, r1, r3
 707 05f0 033042E0 		sub	r3, r2, r3
 709 05f4 28201BE5 		ldr	r2, [fp, #-40]
 710 05f8 033082E0 		add	r3, r2, r3
 711 05fc 3C300BE5 		str	r3, [fp, #-60]
 179:OptimizationBenchmark.c **** EV_m = ((((EV_a*EV_b)+(EV_c/EV_d))-(EV_e*EV_f))+EV_g);
 713 0600 10301BE5 		ldr	r3, [fp, #-16]
 714 0604 14201BE5 		ldr	r2, [fp, #-20]
 715 0608 920304E0 		mul	r4, r2, r3
 717 060c 1C101BE5 		ldr	r1, [fp, #-28]
 718 0610 18001BE5 		ldr	r0, [fp, #-24]
 720              	.LVL5:
 721 0618 0030A0E1 		mov	r3, r0
 723 061c 032084E0 		add	r2, r4, r3
 725 0620 20301BE5 		ldr	r3, [fp, #-32]
 726 0624 24101BE5 		ldr	r1, [fp, #-36]
 727 0628 910303E0 		mul	r3, r1, r3
 729 062c 033042E0 		sub	r3, r2, r3
 731 0630 28201BE5 		ldr	r2, [fp, #-40]
 732 0634 033082E0 		add	r3, r2, r3
 733 0638 40300BE5 		str	r3, [fp, #-64]
 180:OptimizationBenchmark.c **** EV_n = ((((EV_a*EV_b)+(EV_c/EV_d))-(EV_e*EV_f))+EV_g);
 735 063c 10301BE5 		ldr	r3, [fp, #-16]
 736 0640 14201BE5 		ldr	r2, [fp, #-20]
 737 0644 920304E0 		mul	r4, r2, r3
 739 0648 1C101BE5 		ldr	r1, [fp, #-28]
 740 064c 18001BE5 		ldr	r0, [fp, #-24]
 742              	.LVL6:
 743 0654 0030A0E1 		mov	r3, r0
 745 0658 032084E0 		add	r2, r4, r3
 747 065c 20301BE5 		ldr	r3, [fp, #-32]
 748 0660 24101BE5 		ldr	r1, [fp, #-36]
 749 0664 910303E0 		mul	r3, r1, r3
 751 0668 033042E0 		sub	r3, r2, r3
 753 066c 28201BE5 		ldr	r2, [fp, #-40]
 754 0670 033082E0 		add	r3, r2, r3
 755 0674 44300BE5 		str	r3, [fp, #-68]
 181:OptimizationBenchmark.c **** EV_o = ((((EV_a*EV_b)+(EV_c/EV_d))-(EV_e*EV_f))+EV_g);
 757 0678 10301BE5 		ldr	r3, [fp, #-16]
 758 067c 14201BE5 		ldr	r2, [fp, #-20]
 759 0680 920304E0 		mul	r4, r2, r3
 761 0684 1C101BE5 		ldr	r1, [fp, #-28]
 762 0688 18001BE5 		ldr	r0, [fp, #-24]
 764              	.LVL7:
 765 0690 0030A0E1 		mov	r3, r0
 767 0694 032084E0 		add	r2, r4, r3
 769 0698 20301BE5 		ldr	r3, [fp, #-32]
 770 069c 24101BE5 		ldr	r1, [fp, #-36]
 771 06a0 910303E0 		mul	r3, r1, r3
 773 06a4 033042E0 		sub	r3, r2, r3
 775 06a8 28201BE5 		ldr	r2, [fp, #-40]
 776 06ac 033082E0 		add	r3, r2, r3
 777 06b0 48300BE5 		str	r3, [fp, #-72]
 182:OptimizationBenchmark.c **** EV_p = ((((EV_a*EV_b)+(EV_c/EV_d))-(EV_e*EV_f))+EV_g);
 779 06b4 10301BE5 		ldr	r3, [fp, #-16]
 780 06b8 14201BE5 		ldr	r2, [fp, #-20]
 781 06bc 920304E0 		mul	r4, r2, r3
 783 06c0 1C101BE5 		ldr	r1, [fp, #-28]
 784 06c4 18001BE5 		ldr	r0, [fp, #-24]
 786              	.LVL8:
 787 06cc 0030A0E1 		mov	r3, r0
 789 06d0 032084E0 		add	r2, r4, r3
 791 06d4 20301BE5 		ldr	r3, [fp, #-32]
 792 06d8 24101BE5 		ldr	r1, [fp, #-36]
 793 06dc 910303E0 		mul	r3, r1, r3
 795 06e0 033042E0 		sub	r3, r2, r3
 797 06e4 28201BE5 		ldr	r2, [fp, #-40]
 798 06e8 033082E0 		add	r3, r2, r3
 799 06ec 4C300BE5 		str	r3, [fp, #-76]
 183:OptimizationBenchmark.c **** EV_q = ((((EV_a*EV_b)+(EV_c/EV_d))-(EV_e*EV_f))+EV_g);
 801 06f0 10301BE5 		ldr	r3, [fp, #-16]
 802 06f4 14201BE5 		ldr	r2, [fp, #-20]
 803 06f8 920304E0 		mul	r4, r2, r3
 805 06fc 1C101BE5 		ldr	r1, [fp, #-28]
 806 0700 18001BE5 		ldr	r0, [fp, #-24]
 808              	.LVL9:
 809 0708 0030A0E1 		mov	r3, r0
 811 070c 032084E0 		add	r2, r4, r3
 813 0710 20301BE5 		ldr	r3, [fp, #-32]
 814 0714 24101BE5 		ldr	r1, [fp, #-36]
 815 0718 910303E0 		mul	r3, r1, r3
 817 071c 033042E0 		sub	r3, r2, r3
 819 0720 28201BE5 		ldr	r2, [fp, #-40]
 820 0724 033082E0 		add	r3, r2, r3
 821 0728 50300BE5 		str	r3, [fp, #-80]
 184:OptimizationBenchmark.c **** EV_r = ((((EV_a*EV_b)+(EV_c/EV_d))-(EV_e*EV_f))+EV_g);
 823 072c 10301BE5 		ldr	r3, [fp, #-16]
 824 0730 14201BE5 		ldr	r2, [fp, #-20]
 825 0734 920304E0 		mul	r4, r2, r3
 827 0738 1C101BE5 		ldr	r1, [fp, #-28]
 828 073c 18001BE5 		ldr	r0, [fp, #-24]
 830              	.LVL10:
 831 0744 0030A0E1 		mov	r3, r0
 833 0748 032084E0 		add	r2, r4, r3
 835 074c 20301BE5 		ldr	r3, [fp, #-32]
 836 0750 24101BE5 		ldr	r1, [fp, #-36]
 837 0754 910303E0 		mul	r3, r1, r3
 839 0758 033042E0 		sub	r3, r2, r3
 841 075c 28201BE5 		ldr	r2, [fp, #-40]
 842 0760 033082E0 		add	r3, r2, r3
 843 0764 54300BE5 		str	r3, [fp, #-84]
 185:OptimizationBenchmark.c **** EV_s = ((((EV_a*EV_b)+(EV_c/EV_d))-(EV_e*EV_f))+EV_g);
 845 0768 10301BE5 		ldr	r3, [fp, #-16]
 846 076c 14201BE5 		ldr	r2, [fp, #-20]
 847 0770 920304E0 		mul	r4, r2, r3
 849 0774 1C101BE5 		ldr	r1, [fp, #-28]
 850 0778 18001BE5 		ldr	r0, [fp, #-24]
 852              	.LVL11:
 853 0780 0030A0E1 		mov	r3, r0
 855 0784 032084E0 		add	r2, r4, r3
 857 0788 20301BE5 		ldr	r3, [fp, #-32]
 858 078c 24101BE5 		ldr	r1, [fp, #-36]
 859 0790 910303E0 		mul	r3, r1, r3
 861 0794 033042E0 		sub	r3, r2, r3
 863 0798 28201BE5 		ldr	r2, [fp, #-40]
 864 079c 033082E0 		add	r3, r2, r3
 865 07a0 58300BE5 		str	r3, [fp, #-88]
 186:OptimizationBenchmark.c **** EV_t = ((((EV_a*EV_b)+(EV_c/EV_d))-(EV_e*EV_f))+EV_g);
 867 07a4 10301BE5 		ldr	r3, [fp, #-16]
 868 07a8 14201BE5 		ldr	r2, [fp, #-20]
 869 07ac 920304E0 		mul	r4, r2, r3
 871 07b0 1C101BE5 		ldr	r1, [fp, #-28]
 872 07b4 18001BE5 		ldr	r0, [fp, #-24]
 874              	.LVL12:
 875 07bc 0030A0E1 		mov	r3, r0
 877 07c0 032084E0 		add	r2, r4, r3
 879 07c4 20301BE5 		ldr	r3, [fp, #-32]
 880 07c8 24101BE5 		ldr	r1, [fp, #-36]
 881 07cc 910303E0 		mul	r3, r1, r3
 883 07d0 033042E0 		sub	r3, r2, r3
 885 07d4 28201BE5 		ldr	r2, [fp, #-40]
 886 07d8 033082E0 		add	r3, r2, r3
 887 07dc 5C300BE5 		str	r3, [fp, #-92]
 187:OptimizationBenchmark.c **** EV_u = ((((EV_a*EV_b)+(EV_c/EV_d))-(EV_e*EV_f))+EV_g);
 889 07e0 10301BE5 		ldr	r3, [fp, #-16]
 890 07e4 14201BE5 		ldr	r2, [fp, #-20]
 891 07e8 920304E0 		mul	r4, r2, r3
 893 07ec 1C101BE5 		ldr	r1, [fp, #-28]
 894 07f0 18001BE5 		ldr	r0, [fp, #-24]
 896              	.LVL13:
 897 07f8 0030A0E1 		mov	r3, r0
 899 07fc 032084E0 		add	r2, r4, r3
 901 0800 20301BE5 		ldr	r3, [fp, #-32]
 902 0804 24101BE5 		ldr	r1, [fp, #-36]
 903 0808 910303E0 		mul	r3, r1, r3
 905 080c 033042E0 		sub	r3, r2, r3
 907 0810 28201BE5 		ldr	r2, [fp, #-40]
 908 0814 033082E0 		add	r3, r2, r3
 909 0818 60300BE5 		str	r3, [fp, #-96]
 188:OptimizationBenchmark.c **** EV_v = ((((EV_b*EV_a)+(EV_c/EV_d))-(EV_e*EV_f))+EV_g);
 911 081c 14301BE5 		ldr	r3, [fp, #-20]
 912 0820 10201BE5 		ldr	r2, [fp, #-16]
 913 0824 920304E0 		mul	r4, r2, r3
 915 0828 1C101BE5 		ldr	r1, [fp, #-28]
 916 082c 18001BE5 		ldr	r0, [fp, #-24]
 918              	.LVL14:
 919 0834 0030A0E1 		mov	r3, r0
 921 0838 032084E0 		add	r2, r4, r3
 923 083c 20301BE5 		ldr	r3, [fp, #-32]
 924 0840 24101BE5 		ldr	r1, [fp, #-36]
 925 0844 910303E0 		mul	r3, r1, r3
 927 0848 033042E0 		sub	r3, r2, r3
 929 084c 28201BE5 		ldr	r2, [fp, #-40]
 930 0850 033082E0 		add	r3, r2, r3
 931 0854 64300BE5 		str	r3, [fp, #-100]
 189:OptimizationBenchmark.c **** EV_w = ((((EV_a*EV_b)+(EV_c/EV_d))-(EV_f*EV_e))+EV_g);
 933 0858 10301BE5 		ldr	r3, [fp, #-16]
 934 085c 14201BE5 		ldr	r2, [fp, #-20]
 935 0860 920304E0 		mul	r4, r2, r3
 937 0864 1C101BE5 		ldr	r1, [fp, #-28]
 938 0868 18001BE5 		ldr	r0, [fp, #-24]
 940              	.LVL15:
 941 0870 0030A0E1 		mov	r3, r0
 943 0874 032084E0 		add	r2, r4, r3
 945 0878 24301BE5 		ldr	r3, [fp, #-36]
 946 087c 20101BE5 		ldr	r1, [fp, #-32]
 947 0880 910303E0 		mul	r3, r1, r3
 949 0884 033042E0 		sub	r3, r2, r3
 951 0888 28201BE5 		ldr	r2, [fp, #-40]
 952 088c 033082E0 		add	r3, r2, r3
 953 0890 68300BE5 		str	r3, [fp, #-104]
 190:OptimizationBenchmark.c **** EV_x = (((EV_g+(EV_a*EV_b))+(EV_c/EV_d))-(EV_e*EV_f));
 955 0894 10301BE5 		ldr	r3, [fp, #-16]
 956 0898 14201BE5 		ldr	r2, [fp, #-20]
 957 089c 920302E0 		mul	r2, r2, r3
 959 08a0 28301BE5 		ldr	r3, [fp, #-40]
 960 08a4 034082E0 		add	r4, r2, r3
 962 08a8 1C101BE5 		ldr	r1, [fp, #-28]
 963 08ac 18001BE5 		ldr	r0, [fp, #-24]
 965              	.LVL16:
 966 08b4 0030A0E1 		mov	r3, r0
 968 08b8 032084E0 		add	r2, r4, r3
 970 08bc 20301BE5 		ldr	r3, [fp, #-32]
 971 08c0 24101BE5 		ldr	r1, [fp, #-36]
 972 08c4 910303E0 		mul	r3, r1, r3
 974 08c8 033042E0 		sub	r3, r2, r3
 975 08cc 6C300BE5 		str	r3, [fp, #-108]
 191:OptimizationBenchmark.c **** EV_y = ((((EV_a*EV_b)+(EV_c/EV_d))-(EV_e*EV_f))+EV_g);
 977 08d0 10301BE5 		ldr	r3, [fp, #-16]
 978 08d4 14201BE5 		ldr	r2, [fp, #-20]
 979 08d8 920304E0 		mul	r4, r2, r3
 981 08dc 1C101BE5 		ldr	r1, [fp, #-28]
 982 08e0 18001BE5 		ldr	r0, [fp, #-24]
 984              	.LVL17:
 985 08e8 0030A0E1 		mov	r3, r0
 987 08ec 032084E0 		add	r2, r4, r3
 989 08f0 20301BE5 		ldr	r3, [fp, #-32]
 990 08f4 24101BE5 		ldr	r1, [fp, #-36]
 991 08f8 910303E0 		mul	r3, r1, r3
 993 08fc 033042E0 		sub	r3, r2, r3
 995 0900 28201BE5 		ldr	r2, [fp, #-40]
 996 0904 033082E0 		add	r3, r2, r3
 997 0908 70300BE5 		str	r3, [fp, #-112]
 192:OptimizationBenchmark.c **** EV_z = ((((EV_c/EV_d)+(EV_a*EV_b))-(EV_e*EV_f))+EV_g);
 999 090c 1C101BE5 		ldr	r1, [fp, #-28]
 1000 0910 18001BE5 		ldr	r0, [fp, #-24]
 1002              	.LVL18:
 1003 0918 0030A0E1 		mov	r3, r0
 1004 091c 0310A0E1 		mov	r1, r3
 1006 0920 10301BE5 		ldr	r3, [fp, #-16]
 1007 0924 14201BE5 		ldr	r2, [fp, #-20]
 1008 0928 920303E0 		mul	r3, r2, r3
 1010 092c 032081E0 		add	r2, r1, r3
 1012 0930 20301BE5 		ldr	r3, [fp, #-32]
 1013 0934 24101BE5 		ldr	r1, [fp, #-36]
 1014 0938 910303E0 		mul	r3, r1, r3
 1016 093c 033042E0 		sub	r3, r2, r3
 1018 0940 28201BE5 		ldr	r2, [fp, #-40]
 1019 0944 033082E0 		add	r3, r2, r3
 1020 0948 74300BE5 		str	r3, [fp, #-116]
 193:OptimizationBenchmark.c **** return (((((((((((((((((((((((((EV_a+EV_b)+EV_c)+EV_d)+EV_e)+EV_f)+EV_g)+EV_h)+EV_i)+EV_j)+EV_k)+EV
 1022 094c 10201BE5 		ldr	r2, [fp, #-16]
 1023 0950 14301BE5 		ldr	r3, [fp, #-20]
 1024 0954 032082E0 		add	r2, r2, r3
 1026 0958 18301BE5 		ldr	r3, [fp, #-24]
 1027 095c 032082E0 		add	r2, r2, r3
 1029 0960 1C301BE5 		ldr	r3, [fp, #-28]
 1030 0964 032082E0 		add	r2, r2, r3
 1032 0968 20301BE5 		ldr	r3, [fp, #-32]
 1033 096c 032082E0 		add	r2, r2, r3
 1035 0970 24301BE5 		ldr	r3, [fp, #-36]
 1036 0974 032082E0 		add	r2, r2, r3
 1038 0978 28301BE5 		ldr	r3, [fp, #-40]
 1039 097c 032082E0 		add	r2, r2, r3
 1041 0980 2C301BE5 		ldr	r3, [fp, #-44]
 1042 0984 032082E0 		add	r2, r2, r3
 1044 0988 30301BE5 		ldr	r3, [fp, #-48]
 1045 098c 032082E0 		add	r2, r2, r3
 1047 0990 34301BE5 		ldr	r3, [fp, #-52]
 1048 0994 032082E0 		add	r2, r2, r3
 1050 0998 38301BE5 		ldr	r3, [fp, #-56]
 1051 099c 032082E0 		add	r2, r2, r3
 1053 09a0 3C301BE5 		ldr	r3, [fp, #-60]
 1054 09a4 032082E0 		add	r2, r2, r3
 1056 09a8 40301BE5 		ldr	r3, [fp, #-64]
 1057 09ac 032082E0 		add	r2, r2, r3
 1059 09b0 44301BE5 		ldr	r3, [fp, #-68]
 1060 09b4 032082E0 		add	r2, r2, r3
 1062 09b8 48301BE5 		ldr	r3, [fp, #-72]
 1063 09bc 032082E0 		add	r2, r2, r3
 1065 09c0 4C301BE5 		ldr	r3, [fp, #-76]
 1066 09c4 032082E0 		add	r2, r2, r3
 1068 09c8 50301BE5 		ldr	r3, [fp, #-80]
 1069 09cc 032082E0 		add	r2, r2, r3
 1071 09d0 54301BE5 		ldr	r3, [fp, #-84]
 1072 09d4 032082E0 		add	r2, r2, r3
 1074 09d8 58301BE5 		ldr	r3, [fp, #-88]
 1075 09dc 032082E0 		add	r2, r2, r3
 1077 09e0 5C301BE5 		ldr	r3, [fp, #-92]
 1078 09e4 032082E0 		add	r2, r2, r3
 1080 09e8 60301BE5 		ldr	r3, [fp, #-96]
 1081 09ec 032082E0 		add	r2, r2, r3
 1083 09f0 64301BE5 		ldr	r3, [fp, #-100]
 1084 09f4 032082E0 		add	r2, r2, r3
 1086 09f8 68301BE5 		ldr	r3, [fp, #-104]
 1087 09fc 032082E0 		add	r2, r2, r3
 1089 0a00 6C301BE5 		ldr	r3, [fp, #-108]
 1090 0a04 032082E0 		add	r2, r2, r3
 1092 0a08 70301BE5 		ldr	r3, [fp, #-112]
 1093 0a0c 032082E0 		add	r2, r2, r3
 1095 0a10 74301BE5 		ldr	r3, [fp, #-116]
 1096 0a14 033082E0 		add	r3, r2, r3
 194:OptimizationBenchmark.c **** }
 1098 0a18 0300A0E1 		mov	r0, r3
 1099 0a1c 08D04BE2 		sub	sp, fp, #8
 1101              		@ sp needed
 1102 0a20 1088BDE8 		pop	{r4, fp, pc}
 1104              	.LFE12:
 1106              		.align	2
 1107              		.global	_hoisting
 1108              		.syntax unified
 1109              		.arm
 1110              		.fpu vfp
 1112              	_hoisting:
 1113              	.LFB13:
 195:OptimizationBenchmark.c **** int _hoisting()
 196:OptimizationBenchmark.c **** {
 1116              		@ args = 0, pretend = 0, frame = 32
 1117              		@ frame_needed = 1, uses_anonymous_args = 0
 1118              		@ link register save eliminated.
 1119 0a24 04B02DE5 		str	fp, [sp, #-4]!
 1122 0a28 00B08DE2 		add	fp, sp, #0
 1124 0a2c 24D04DE2 		sub	sp, sp, #36
 197:OptimizationBenchmark.c **** int EV_a;
 198:OptimizationBenchmark.c **** int EV_b;
 199:OptimizationBenchmark.c **** int EV_c;
 200:OptimizationBenchmark.c **** int EV_d;
 201:OptimizationBenchmark.c **** int EV_e;
 202:OptimizationBenchmark.c **** int EV_f;
 203:OptimizationBenchmark.c **** int EV_g;
 204:OptimizationBenchmark.c **** int EV_h;
 205:OptimizationBenchmark.c **** int EV_i;
 206:OptimizationBenchmark.c **** EV_a = 1;
 1126 0a30 0130A0E3 		mov	r3, #1
 1127 0a34 0C300BE5 		str	r3, [fp, #-12]
 207:OptimizationBenchmark.c **** EV_b = 2;
 1129 0a38 0230A0E3 		mov	r3, #2
 1130 0a3c 10300BE5 		str	r3, [fp, #-16]
 208:OptimizationBenchmark.c **** EV_c = 3;
 1132 0a40 0330A0E3 		mov	r3, #3
 1133 0a44 14300BE5 		str	r3, [fp, #-20]
 209:OptimizationBenchmark.c **** EV_d = 4;
 1135 0a48 0430A0E3 		mov	r3, #4
 1136 0a4c 18300BE5 		str	r3, [fp, #-24]
 210:OptimizationBenchmark.c **** EV_i = 0;
 1138 0a50 0030A0E3 		mov	r3, #0
 1139 0a54 08300BE5 		str	r3, [fp, #-8]
 211:OptimizationBenchmark.c **** while ((EV_i<1000000))
 1141 0a58 100000EA 		b	.L25
 1142              	.L26:
 212:OptimizationBenchmark.c **** {
 213:OptimizationBenchmark.c **** EV_e = 5;
 1144 0a5c 0530A0E3 		mov	r3, #5
 1145 0a60 1C300BE5 		str	r3, [fp, #-28]
 214:OptimizationBenchmark.c **** EV_g = ((EV_a+EV_b)+EV_c);
 1147 0a64 0C201BE5 		ldr	r2, [fp, #-12]
 1148 0a68 10301BE5 		ldr	r3, [fp, #-16]
 1149 0a6c 033082E0 		add	r3, r2, r3
 1151 0a70 14201BE5 		ldr	r2, [fp, #-20]
 1152 0a74 033082E0 		add	r3, r2, r3
 1153 0a78 20300BE5 		str	r3, [fp, #-32]
 215:OptimizationBenchmark.c **** EV_h = ((EV_c+EV_d)+EV_g);
 1155 0a7c 14201BE5 		ldr	r2, [fp, #-20]
 1156 0a80 18301BE5 		ldr	r3, [fp, #-24]
 1157 0a84 033082E0 		add	r3, r2, r3
 1159 0a88 20201BE5 		ldr	r2, [fp, #-32]
 1160 0a8c 033082E0 		add	r3, r2, r3
 1161 0a90 24300BE5 		str	r3, [fp, #-36]
 216:OptimizationBenchmark.c **** EV_i = (EV_i+1);
 1163 0a94 08301BE5 		ldr	r3, [fp, #-8]
 1164 0a98 013083E2 		add	r3, r3, #1
 1165 0a9c 08300BE5 		str	r3, [fp, #-8]
 1166              	.L25:
 211:OptimizationBenchmark.c **** {
 1168 0aa0 08301BE5 		ldr	r3, [fp, #-8]
 1169 0aa4 18209FE5 		ldr	r2, .L28
 1170 0aa8 020053E1 		cmp	r3, r2
 1171 0aac EAFFFFDA 		ble	.L26
 217:OptimizationBenchmark.c **** }
 218:OptimizationBenchmark.c **** return EV_b;
 1173 0ab0 10301BE5 		ldr	r3, [fp, #-16]
 219:OptimizationBenchmark.c **** }
 1175 0ab4 0300A0E1 		mov	r0, r3
 1176 0ab8 00D08BE2 		add	sp, fp, #0
 1178              		@ sp needed
 1179 0abc 04B09DE4 		ldr	fp, [sp], #4
 1182 0ac0 1EFF2FE1 		bx	lr
 1183              	.L29:
 1184              		.align	2
 1185              	.L28:
 1186 0ac4 3F420F00 		.word	999999
 1188              	.LFE13:
 1190              		.align	2
 1191              		.global	_doubleIf
 1192              		.syntax unified
 1193              		.arm
 1194              		.fpu vfp
 1196              	_doubleIf:
 1197              	.LFB14:
 220:OptimizationBenchmark.c **** int _doubleIf()
 221:OptimizationBenchmark.c **** {
 1200              		@ args = 0, pretend = 0, frame = 16
 1201              		@ frame_needed = 1, uses_anonymous_args = 0
 1202              		@ link register save eliminated.
 1203 0ac8 04B02DE5 		str	fp, [sp, #-4]!
 1206 0acc 00B08DE2 		add	fp, sp, #0
 1208 0ad0 14D04DE2 		sub	sp, sp, #20
 222:OptimizationBenchmark.c **** int EV_a;
 223:OptimizationBenchmark.c **** int EV_b;
 224:OptimizationBenchmark.c **** int EV_c;
 225:OptimizationBenchmark.c **** int EV_d;
 226:OptimizationBenchmark.c **** EV_a = 1;
 1210 0ad4 0130A0E3 		mov	r3, #1
 1211 0ad8 0C300BE5 		str	r3, [fp, #-12]
 227:OptimizationBenchmark.c **** EV_b = 2;
 1213 0adc 0230A0E3 		mov	r3, #2
 1214 0ae0 10300BE5 		str	r3, [fp, #-16]
 228:OptimizationBenchmark.c **** EV_c = 3;
 1216 0ae4 0330A0E3 		mov	r3, #3
 1217 0ae8 14300BE5 		str	r3, [fp, #-20]
 229:OptimizationBenchmark.c **** EV_d = 0;
 1219 0aec 0030A0E3 		mov	r3, #0
 1220 0af0 08300BE5 		str	r3, [fp, #-8]
 230:OptimizationBenchmark.c **** if ((EV_a==1))
 1222 0af4 0C301BE5 		ldr	r3, [fp, #-12]
 1223 0af8 010053E3 		cmp	r3, #1
 1224 0afc 1100001A 		bne	.L31
 231:OptimizationBenchmark.c **** {
 232:OptimizationBenchmark.c **** EV_b = 20;
 1226 0b00 1430A0E3 		mov	r3, #20
 1227 0b04 10300BE5 		str	r3, [fp, #-16]
 233:OptimizationBenchmark.c **** if ((EV_a==1))
 1229 0b08 0C301BE5 		ldr	r3, [fp, #-12]
 1230 0b0c 010053E3 		cmp	r3, #1
 1231 0b10 0400001A 		bne	.L32
 234:OptimizationBenchmark.c **** {
 235:OptimizationBenchmark.c **** EV_b = 200;
 1233 0b14 C830A0E3 		mov	r3, #200
 1234 0b18 10300BE5 		str	r3, [fp, #-16]
 236:OptimizationBenchmark.c **** EV_c = 300;
 1236 0b1c 4B3FA0E3 		mov	r3, #300
 1237 0b20 14300BE5 		str	r3, [fp, #-20]
 1238 0b24 050000EA 		b	.L33
 1239              	.L32:
 237:OptimizationBenchmark.c **** }
 238:OptimizationBenchmark.c **** else
 239:OptimizationBenchmark.c **** {
 240:OptimizationBenchmark.c **** EV_a = 1;
 1241 0b28 0130A0E3 		mov	r3, #1
 1242 0b2c 0C300BE5 		str	r3, [fp, #-12]
 241:OptimizationBenchmark.c **** EV_b = 2;
 1244 0b30 0230A0E3 		mov	r3, #2
 1245 0b34 10300BE5 		str	r3, [fp, #-16]
 242:OptimizationBenchmark.c **** EV_c = 3;
 1247 0b38 0330A0E3 		mov	r3, #3
 1248 0b3c 14300BE5 		str	r3, [fp, #-20]
 1249              	.L33:
 243:OptimizationBenchmark.c **** }
 244:OptimizationBenchmark.c **** EV_d = 50;
 1251 0b40 3230A0E3 		mov	r3, #50
 1252 0b44 08300BE5 		str	r3, [fp, #-8]
 1253              	.L31:
 245:OptimizationBenchmark.c **** }
 246:OptimizationBenchmark.c **** return EV_d;
 1255 0b48 08301BE5 		ldr	r3, [fp, #-8]
 247:OptimizationBenchmark.c **** }
 1257 0b4c 0300A0E1 		mov	r0, r3
 1258 0b50 00D08BE2 		add	sp, fp, #0
 1260              		@ sp needed
 1261 0b54 04B09DE4 		ldr	fp, [sp], #4
 1264 0b58 1EFF2FE1 		bx	lr
 1266              	.LFE14:
 1268              		.align	2
 1269              		.global	_integerDivide
 1270              		.syntax unified
 1271              		.arm
 1272              		.fpu vfp
 1274              	_integerDivide:
 1275              	.LFB15:
 248:OptimizationBenchmark.c **** int _integerDivide()
 249:OptimizationBenchmark.c **** {
 1278              		@ args = 0, pretend = 0, frame = 8
 1279              		@ frame_needed = 1, uses_anonymous_args = 0
 1280              		@ link register save eliminated.
 1281 0b5c 04B02DE5 		str	fp, [sp, #-4]!
 1284 0b60 00B08DE2 		add	fp, sp, #0
 1286 0b64 0CD04DE2 		sub	sp, sp, #12
 250:OptimizationBenchmark.c **** int EV_a;
 251:OptimizationBenchmark.c **** EV_a = 3000;
 1288 0b68 BC309FE5 		ldr	r3, .L37
 1289 0b6c 08300BE5 		str	r3, [fp, #-8]
 252:OptimizationBenchmark.c **** EV_a = (EV_a/2);
 1291 0b70 08301BE5 		ldr	r3, [fp, #-8]
 1292 0b74 A32FA0E1 		lsr	r2, r3, #31
 1293 0b78 033082E0 		add	r3, r2, r3
 1294 0b7c C330A0E1 		asr	r3, r3, #1
 1295 0b80 08300BE5 		str	r3, [fp, #-8]
 253:OptimizationBenchmark.c **** EV_a = (EV_a*4);
 1297 0b84 08301BE5 		ldr	r3, [fp, #-8]
 1298 0b88 0331A0E1 		lsl	r3, r3, #2
 1299 0b8c 08300BE5 		str	r3, [fp, #-8]
 254:OptimizationBenchmark.c **** EV_a = (EV_a/8);
 1301 0b90 08301BE5 		ldr	r3, [fp, #-8]
 1302 0b94 072083E2 		add	r2, r3, #7
 1303 0b98 000053E3 		cmp	r3, #0
 1304 0b9c 0230A0B1 		movlt	r3, r2
 1305 0ba0 0330A0A1 		movge	r3, r3
 1306 0ba4 C331A0E1 		asr	r3, r3, #3
 1307 0ba8 08300BE5 		str	r3, [fp, #-8]
 255:OptimizationBenchmark.c **** EV_a = (EV_a/16);
 1309 0bac 08301BE5 		ldr	r3, [fp, #-8]
 1310 0bb0 0F2083E2 		add	r2, r3, #15
 1311 0bb4 000053E3 		cmp	r3, #0
 1312 0bb8 0230A0B1 		movlt	r3, r2
 1313 0bbc 0330A0A1 		movge	r3, r3
 1314 0bc0 4332A0E1 		asr	r3, r3, #4
 1315 0bc4 08300BE5 		str	r3, [fp, #-8]
 256:OptimizationBenchmark.c **** EV_a = (EV_a*32);
 1317 0bc8 08301BE5 		ldr	r3, [fp, #-8]
 1318 0bcc 8332A0E1 		lsl	r3, r3, #5
 1319 0bd0 08300BE5 		str	r3, [fp, #-8]
 257:OptimizationBenchmark.c **** EV_a = (EV_a/64);
 1321 0bd4 08301BE5 		ldr	r3, [fp, #-8]
 1322 0bd8 3F2083E2 		add	r2, r3, #63
 1323 0bdc 000053E3 		cmp	r3, #0
 1324 0be0 0230A0B1 		movlt	r3, r2
 1325 0be4 0330A0A1 		movge	r3, r3
 1326 0be8 4333A0E1 		asr	r3, r3, #6
 1327 0bec 08300BE5 		str	r3, [fp, #-8]
 258:OptimizationBenchmark.c **** EV_a = (EV_a*128);
 1329 0bf0 08301BE5 		ldr	r3, [fp, #-8]
 1330 0bf4 8333A0E1 		lsl	r3, r3, #7
 1331 0bf8 08300BE5 		str	r3, [fp, #-8]
 259:OptimizationBenchmark.c **** EV_a = (EV_a/4);
 1333 0bfc 08301BE5 		ldr	r3, [fp, #-8]
 1334 0c00 032083E2 		add	r2, r3, #3
 1335 0c04 000053E3 		cmp	r3, #0
 1336 0c08 0230A0B1 		movlt	r3, r2
 1337 0c0c 0330A0A1 		movge	r3, r3
 1338 0c10 4331A0E1 		asr	r3, r3, #2
 1339 0c14 08300BE5 		str	r3, [fp, #-8]
 260:OptimizationBenchmark.c **** return EV_a;
 1341 0c18 08301BE5 		ldr	r3, [fp, #-8]
 261:OptimizationBenchmark.c **** }
 1343 0c1c 0300A0E1 		mov	r0, r3
 1344 0c20 00D08BE2 		add	sp, fp, #0
 1346              		@ sp needed
 1347 0c24 04B09DE4 		ldr	fp, [sp], #4
 1350 0c28 1EFF2FE1 		bx	lr
 1351              	.L38:
 1352              		.align	2
 1353              	.L37:
 1354 0c2c B80B0000 		.word	3000
 1356              	.LFE15:
 1358              		.align	2
 1359              		.global	_association
 1360              		.syntax unified
 1361              		.arm
 1362              		.fpu vfp
 1364              	_association:
 1365              	.LFB16:
 262:OptimizationBenchmark.c **** int _association()
 263:OptimizationBenchmark.c **** {
 1368              		@ args = 0, pretend = 0, frame = 8
 1369              		@ frame_needed = 1, uses_anonymous_args = 0
 1370              		@ link register save eliminated.
 1371 0c30 04B02DE5 		str	fp, [sp, #-4]!
 1374 0c34 00B08DE2 		add	fp, sp, #0
 1376 0c38 0CD04DE2 		sub	sp, sp, #12
 264:OptimizationBenchmark.c **** int EV_a;
 265:OptimizationBenchmark.c **** EV_a = 10;
 1378 0c3c 0A30A0E3 		mov	r3, #10
 1379 0c40 08300BE5 		str	r3, [fp, #-8]
 266:OptimizationBenchmark.c **** EV_a = (EV_a*2);
 1381 0c44 08301BE5 		ldr	r3, [fp, #-8]
 1382 0c48 8330A0E1 		lsl	r3, r3, #1
 1383 0c4c 08300BE5 		str	r3, [fp, #-8]
 267:OptimizationBenchmark.c **** EV_a = (EV_a/2);
 1385 0c50 08301BE5 		ldr	r3, [fp, #-8]
 1386 0c54 A32FA0E1 		lsr	r2, r3, #31
 1387 0c58 033082E0 		add	r3, r2, r3
 1388 0c5c C330A0E1 		asr	r3, r3, #1
 1389 0c60 08300BE5 		str	r3, [fp, #-8]
 268:OptimizationBenchmark.c **** EV_a = (3*EV_a);
 1391 0c64 08201BE5 		ldr	r2, [fp, #-8]
 1392 0c68 0230A0E1 		mov	r3, r2
 1393 0c6c 8330A0E1 		lsl	r3, r3, #1
 1394 0c70 023083E0 		add	r3, r3, r2
 1395 0c74 08300BE5 		str	r3, [fp, #-8]
 269:OptimizationBenchmark.c **** EV_a = (EV_a/3);
 1397 0c78 08301BE5 		ldr	r3, [fp, #-8]
 1398 0c7c 9C209FE5 		ldr	r2, .L41
 1399 0c80 9213C2E0 		smull	r1, r2, r2, r3
 1400 0c84 C33FA0E1 		asr	r3, r3, #31
 1401 0c88 033042E0 		sub	r3, r2, r3
 1402 0c8c 08300BE5 		str	r3, [fp, #-8]
 270:OptimizationBenchmark.c **** EV_a = (EV_a*4);
 1404 0c90 08301BE5 		ldr	r3, [fp, #-8]
 1405 0c94 0331A0E1 		lsl	r3, r3, #2
 1406 0c98 08300BE5 		str	r3, [fp, #-8]
 271:OptimizationBenchmark.c **** EV_a = (EV_a/4);
 1408 0c9c 08301BE5 		ldr	r3, [fp, #-8]
 1409 0ca0 032083E2 		add	r2, r3, #3
 1410 0ca4 000053E3 		cmp	r3, #0
 1411 0ca8 0230A0B1 		movlt	r3, r2
 1412 0cac 0330A0A1 		movge	r3, r3
 1413 0cb0 4331A0E1 		asr	r3, r3, #2
 1414 0cb4 08300BE5 		str	r3, [fp, #-8]
 272:OptimizationBenchmark.c **** EV_a = (EV_a+4);
 1416 0cb8 08301BE5 		ldr	r3, [fp, #-8]
 1417 0cbc 043083E2 		add	r3, r3, #4
 1418 0cc0 08300BE5 		str	r3, [fp, #-8]
 273:OptimizationBenchmark.c **** EV_a = (EV_a-4);
 1420 0cc4 08301BE5 		ldr	r3, [fp, #-8]
 1421 0cc8 043043E2 		sub	r3, r3, #4
 1422 0ccc 08300BE5 		str	r3, [fp, #-8]
 274:OptimizationBenchmark.c **** EV_a = (EV_a*50);
 1424 0cd0 08201BE5 		ldr	r2, [fp, #-8]
 1425 0cd4 0230A0E1 		mov	r3, r2
 1426 0cd8 0331A0E1 		lsl	r3, r3, #2
 1427 0cdc 023083E0 		add	r3, r3, r2
 1428 0ce0 0321A0E1 		lsl	r2, r3, #2
 1429 0ce4 023083E0 		add	r3, r3, r2
 1430 0ce8 8330A0E1 		lsl	r3, r3, #1
 1431 0cec 08300BE5 		str	r3, [fp, #-8]
 275:OptimizationBenchmark.c **** EV_a = (EV_a/50);
 1433 0cf0 08301BE5 		ldr	r3, [fp, #-8]
 1434 0cf4 28209FE5 		ldr	r2, .L41+4
 1435 0cf8 9213C2E0 		smull	r1, r2, r2, r3
 1436 0cfc 4222A0E1 		asr	r2, r2, #4
 1437 0d00 C33FA0E1 		asr	r3, r3, #31
 1438 0d04 033042E0 		sub	r3, r2, r3
 1439 0d08 08300BE5 		str	r3, [fp, #-8]
 276:OptimizationBenchmark.c **** return EV_a;
 1441 0d0c 08301BE5 		ldr	r3, [fp, #-8]
 277:OptimizationBenchmark.c **** }
 1443 0d10 0300A0E1 		mov	r0, r3
 1444 0d14 00D08BE2 		add	sp, fp, #0
 1446              		@ sp needed
 1447 0d18 04B09DE4 		ldr	fp, [sp], #4
 1450 0d1c 1EFF2FE1 		bx	lr
 1451              	.L42:
 1452              		.align	2
 1453              	.L41:
 1454 0d20 56555555 		.word	1431655766
 1455 0d24 1F85EB51 		.word	1374389535
 1457              	.LFE16:
 1459              		.align	2
 1460              		.global	_tailRecursionHelper
 1461              		.syntax unified
 1462              		.arm
 1463              		.fpu vfp
 1465              	_tailRecursionHelper:
 1466              	.LFB17:
 278:OptimizationBenchmark.c **** int _tailRecursionHelper(int EV_value,int EV_sum)
 279:OptimizationBenchmark.c **** {
 1469              		@ args = 0, pretend = 0, frame = 8
 1470              		@ frame_needed = 1, uses_anonymous_args = 0
 1471 0d28 00482DE9 		push	{fp, lr}
 1475 0d2c 04B08DE2 		add	fp, sp, #4
 1477 0d30 08D04DE2 		sub	sp, sp, #8
 1478 0d34 08000BE5 		str	r0, [fp, #-8]
 1479 0d38 0C100BE5 		str	r1, [fp, #-12]
 280:OptimizationBenchmark.c **** if ((EV_value==0))
 1481 0d3c 08301BE5 		ldr	r3, [fp, #-8]
 1482 0d40 000053E3 		cmp	r3, #0
 1483 0d44 0100001A 		bne	.L44
 281:OptimizationBenchmark.c **** {
 282:OptimizationBenchmark.c **** return EV_sum;
 1485 0d48 0C301BE5 		ldr	r3, [fp, #-12]
 1486 0d4c 070000EA 		b	.L45
 1487              	.L44:
 283:OptimizationBenchmark.c **** }
 284:OptimizationBenchmark.c **** else
 285:OptimizationBenchmark.c **** {
 286:OptimizationBenchmark.c **** return _tailRecursionHelper((EV_value-1), (EV_sum+EV_value));
 1489 0d50 08301BE5 		ldr	r3, [fp, #-8]
 1490 0d54 010043E2 		sub	r0, r3, #1
 1491 0d58 0C201BE5 		ldr	r2, [fp, #-12]
 1492 0d5c 08301BE5 		ldr	r3, [fp, #-8]
 1493 0d60 033082E0 		add	r3, r2, r3
 1494 0d64 0310A0E1 		mov	r1, r3
 1495 0d68 FEFFFFEB 		bl	_tailRecursionHelper
 1496 0d6c 0030A0E1 		mov	r3, r0
 1497              	.L45:
 287:OptimizationBenchmark.c **** }
 288:OptimizationBenchmark.c **** }
 1499 0d70 0300A0E1 		mov	r0, r3
 1500 0d74 04D04BE2 		sub	sp, fp, #4
 1502              		@ sp needed
 1503 0d78 0088BDE8 		pop	{fp, pc}
 1505              	.LFE17:
 1507              		.align	2
 1508              		.global	_tailRecursion
 1509              		.syntax unified
 1510              		.arm
 1511              		.fpu vfp
 1513              	_tailRecursion:
 1514              	.LFB18:
 289:OptimizationBenchmark.c **** int _tailRecursion(int EV_value)
 290:OptimizationBenchmark.c **** {
 1517              		@ args = 0, pretend = 0, frame = 8
 1518              		@ frame_needed = 1, uses_anonymous_args = 0
 1519 0d7c 00482DE9 		push	{fp, lr}
 1523 0d80 04B08DE2 		add	fp, sp, #4
 1525 0d84 08D04DE2 		sub	sp, sp, #8
 1526 0d88 08000BE5 		str	r0, [fp, #-8]
 291:OptimizationBenchmark.c **** return _tailRecursionHelper(EV_value, 0);
 1528 0d8c 0010A0E3 		mov	r1, #0
 1529 0d90 08001BE5 		ldr	r0, [fp, #-8]
 1530 0d94 FEFFFFEB 		bl	_tailRecursionHelper
 1531 0d98 0030A0E1 		mov	r3, r0
 292:OptimizationBenchmark.c **** }
 1533 0d9c 0300A0E1 		mov	r0, r3
 1534 0da0 04D04BE2 		sub	sp, fp, #4
 1536              		@ sp needed
 1537 0da4 0088BDE8 		pop	{fp, pc}
 1539              	.LFE18:
 1541              		.align	2
 1542              		.global	_unswitching
 1543              		.syntax unified
 1544              		.arm
 1545              		.fpu vfp
 1547              	_unswitching:
 1548              	.LFB19:
 293:OptimizationBenchmark.c **** int _unswitching()
 294:OptimizationBenchmark.c **** {
 1551              		@ args = 0, pretend = 0, frame = 8
 1552              		@ frame_needed = 1, uses_anonymous_args = 0
 1553              		@ link register save eliminated.
 1554 0da8 04B02DE5 		str	fp, [sp, #-4]!
 1557 0dac 00B08DE2 		add	fp, sp, #0
 1559 0db0 0CD04DE2 		sub	sp, sp, #12
 295:OptimizationBenchmark.c **** int EV_a;
 296:OptimizationBenchmark.c **** int EV_b;
 297:OptimizationBenchmark.c **** EV_a = 1;
 1561 0db4 0130A0E3 		mov	r3, #1
 1562 0db8 08300BE5 		str	r3, [fp, #-8]
 298:OptimizationBenchmark.c **** EV_b = 2;
 1564 0dbc 0230A0E3 		mov	r3, #2
 1565 0dc0 0C300BE5 		str	r3, [fp, #-12]
 299:OptimizationBenchmark.c **** while ((EV_a<1000000))
 1567 0dc4 090000EA 		b	.L49
 1568              	.L51:
 300:OptimizationBenchmark.c **** {
 301:OptimizationBenchmark.c **** if ((EV_b==2))
 1570 0dc8 0C301BE5 		ldr	r3, [fp, #-12]
 1571 0dcc 020053E3 		cmp	r3, #2
 1572 0dd0 0300001A 		bne	.L50
 302:OptimizationBenchmark.c **** {
 303:OptimizationBenchmark.c **** EV_a = (EV_a+1);
 1574 0dd4 08301BE5 		ldr	r3, [fp, #-8]
 1575 0dd8 013083E2 		add	r3, r3, #1
 1576 0ddc 08300BE5 		str	r3, [fp, #-8]
 1577 0de0 020000EA 		b	.L49
 1578              	.L50:
 304:OptimizationBenchmark.c **** }
 305:OptimizationBenchmark.c **** else
 306:OptimizationBenchmark.c **** {
 307:OptimizationBenchmark.c **** EV_a = (EV_a+2);
 1580 0de4 08301BE5 		ldr	r3, [fp, #-8]
 1581 0de8 023083E2 		add	r3, r3, #2
 1582 0dec 08300BE5 		str	r3, [fp, #-8]
 1583              	.L49:
 299:OptimizationBenchmark.c **** {
 1585 0df0 08301BE5 		ldr	r3, [fp, #-8]
 1586 0df4 18209FE5 		ldr	r2, .L53
 1587 0df8 020053E1 		cmp	r3, r2
 1588 0dfc F1FFFFDA 		ble	.L51
 308:OptimizationBenchmark.c **** }
 309:OptimizationBenchmark.c **** }
 310:OptimizationBenchmark.c **** return EV_a;
 1590 0e00 08301BE5 		ldr	r3, [fp, #-8]
 311:OptimizationBenchmark.c **** }
 1592 0e04 0300A0E1 		mov	r0, r3
 1593 0e08 00D08BE2 		add	sp, fp, #0
 1595              		@ sp needed
 1596 0e0c 04B09DE4 		ldr	fp, [sp], #4
 1599 0e10 1EFF2FE1 		bx	lr
 1600              	.L54:
 1601              		.align	2
 1602              	.L53:
 1603 0e14 3F420F00 		.word	999999
 1605              	.LFE19:
 1607              		.align	2
 1608              		.global	_randomCalculation
 1609              		.syntax unified
 1610              		.arm
 1611              		.fpu vfp
 1613              	_randomCalculation:
 1614              	.LFB20:
 312:OptimizationBenchmark.c **** int _randomCalculation(int EV_number)
 313:OptimizationBenchmark.c **** {
 1617              		@ args = 0, pretend = 0, frame = 40
 1618              		@ frame_needed = 1, uses_anonymous_args = 0
 1619              		@ link register save eliminated.
 1620 0e18 04B02DE5 		str	fp, [sp, #-4]!
 1623 0e1c 00B08DE2 		add	fp, sp, #0
 1625 0e20 2CD04DE2 		sub	sp, sp, #44
 1626 0e24 28000BE5 		str	r0, [fp, #-40]
 314:OptimizationBenchmark.c **** int EV_a;
 315:OptimizationBenchmark.c **** int EV_b;
 316:OptimizationBenchmark.c **** int EV_c;
 317:OptimizationBenchmark.c **** int EV_d;
 318:OptimizationBenchmark.c **** int EV_e;
 319:OptimizationBenchmark.c **** int EV_i;
 320:OptimizationBenchmark.c **** int EV_sum;
 321:OptimizationBenchmark.c **** EV_i = 0;
 1628 0e28 0030A0E3 		mov	r3, #0
 1629 0e2c 08300BE5 		str	r3, [fp, #-8]
 322:OptimizationBenchmark.c **** EV_sum = 0;
 1631 0e30 0030A0E3 		mov	r3, #0
 1632 0e34 0C300BE5 		str	r3, [fp, #-12]
 323:OptimizationBenchmark.c **** while ((EV_i<EV_number))
 1634 0e38 310000EA 		b	.L56
 1635              	.L57:
 324:OptimizationBenchmark.c **** {
 325:OptimizationBenchmark.c **** EV_a = 4;
 1637 0e3c 0430A0E3 		mov	r3, #4
 1638 0e40 10300BE5 		str	r3, [fp, #-16]
 326:OptimizationBenchmark.c **** EV_b = 7;
 1640 0e44 0730A0E3 		mov	r3, #7
 1641 0e48 14300BE5 		str	r3, [fp, #-20]
 327:OptimizationBenchmark.c **** EV_c = 8;
 1643 0e4c 0830A0E3 		mov	r3, #8
 1644 0e50 18300BE5 		str	r3, [fp, #-24]
 328:OptimizationBenchmark.c **** EV_d = (EV_a+EV_b);
 1646 0e54 10201BE5 		ldr	r2, [fp, #-16]
 1647 0e58 14301BE5 		ldr	r3, [fp, #-20]
 1648 0e5c 033082E0 		add	r3, r2, r3
 1649 0e60 1C300BE5 		str	r3, [fp, #-28]
 329:OptimizationBenchmark.c **** EV_e = (EV_d+EV_c);
 1651 0e64 1C201BE5 		ldr	r2, [fp, #-28]
 1652 0e68 18301BE5 		ldr	r3, [fp, #-24]
 1653 0e6c 033082E0 		add	r3, r2, r3
 1654 0e70 20300BE5 		str	r3, [fp, #-32]
 330:OptimizationBenchmark.c **** EV_sum = (EV_sum+EV_e);
 1656 0e74 0C201BE5 		ldr	r2, [fp, #-12]
 1657 0e78 20301BE5 		ldr	r3, [fp, #-32]
 1658 0e7c 033082E0 		add	r3, r2, r3
 1659 0e80 0C300BE5 		str	r3, [fp, #-12]
 331:OptimizationBenchmark.c **** EV_i = (EV_i*2);
 1661 0e84 08301BE5 		ldr	r3, [fp, #-8]
 1662 0e88 8330A0E1 		lsl	r3, r3, #1
 1663 0e8c 08300BE5 		str	r3, [fp, #-8]
 332:OptimizationBenchmark.c **** EV_i = (EV_i/2);
 1665 0e90 08301BE5 		ldr	r3, [fp, #-8]
 1666 0e94 A32FA0E1 		lsr	r2, r3, #31
 1667 0e98 033082E0 		add	r3, r2, r3
 1668 0e9c C330A0E1 		asr	r3, r3, #1
 1669 0ea0 08300BE5 		str	r3, [fp, #-8]
 333:OptimizationBenchmark.c **** EV_i = (3*EV_i);
 1671 0ea4 08201BE5 		ldr	r2, [fp, #-8]
 1672 0ea8 0230A0E1 		mov	r3, r2
 1673 0eac 8330A0E1 		lsl	r3, r3, #1
 1674 0eb0 023083E0 		add	r3, r3, r2
 1675 0eb4 08300BE5 		str	r3, [fp, #-8]
 334:OptimizationBenchmark.c **** EV_i = (EV_i/3);
 1677 0eb8 08301BE5 		ldr	r3, [fp, #-8]
 1678 0ebc 64209FE5 		ldr	r2, .L59
 1679 0ec0 9213C2E0 		smull	r1, r2, r2, r3
 1680 0ec4 C33FA0E1 		asr	r3, r3, #31
 1681 0ec8 033042E0 		sub	r3, r2, r3
 1682 0ecc 08300BE5 		str	r3, [fp, #-8]
 335:OptimizationBenchmark.c **** EV_i = (EV_i*4);
 1684 0ed0 08301BE5 		ldr	r3, [fp, #-8]
 1685 0ed4 0331A0E1 		lsl	r3, r3, #2
 1686 0ed8 08300BE5 		str	r3, [fp, #-8]
 336:OptimizationBenchmark.c **** EV_i = (EV_i/4);
 1688 0edc 08301BE5 		ldr	r3, [fp, #-8]
 1689 0ee0 032083E2 		add	r2, r3, #3
 1690 0ee4 000053E3 		cmp	r3, #0
 1691 0ee8 0230A0B1 		movlt	r3, r2
 1692 0eec 0330A0A1 		movge	r3, r3
 1693 0ef0 4331A0E1 		asr	r3, r3, #2
 1694 0ef4 08300BE5 		str	r3, [fp, #-8]
 337:OptimizationBenchmark.c **** EV_i = (EV_i+1);
 1696 0ef8 08301BE5 		ldr	r3, [fp, #-8]
 1697 0efc 013083E2 		add	r3, r3, #1
 1698 0f00 08300BE5 		str	r3, [fp, #-8]
 1699              	.L56:
 323:OptimizationBenchmark.c **** {
 1701 0f04 08201BE5 		ldr	r2, [fp, #-8]
 1702 0f08 28301BE5 		ldr	r3, [fp, #-40]
 1703 0f0c 030052E1 		cmp	r2, r3
 1704 0f10 C9FFFFBA 		blt	.L57
 338:OptimizationBenchmark.c **** }
 339:OptimizationBenchmark.c **** return EV_sum;
 1706 0f14 0C301BE5 		ldr	r3, [fp, #-12]
 340:OptimizationBenchmark.c **** }
 1708 0f18 0300A0E1 		mov	r0, r3
 1709 0f1c 00D08BE2 		add	sp, fp, #0
 1711              		@ sp needed
 1712 0f20 04B09DE4 		ldr	fp, [sp], #4
 1715 0f24 1EFF2FE1 		bx	lr
 1716              	.L60:
 1717              		.align	2
 1718              	.L59:
 1719 0f28 56555555 		.word	1431655766
 1721              	.LFE20:
 1723              		.align	2
 1724              		.global	_iterativeFibonacci
 1725              		.syntax unified
 1726              		.arm
 1727              		.fpu vfp
 1729              	_iterativeFibonacci:
 1730              	.LFB21:
 341:OptimizationBenchmark.c **** int _iterativeFibonacci(int EV_number)
 342:OptimizationBenchmark.c **** {
 1733              		@ args = 0, pretend = 0, frame = 24
 1734              		@ frame_needed = 1, uses_anonymous_args = 0
 1735              		@ link register save eliminated.
 1736 0f2c 04B02DE5 		str	fp, [sp, #-4]!
 1739 0f30 00B08DE2 		add	fp, sp, #0
 1741 0f34 1CD04DE2 		sub	sp, sp, #28
 1742 0f38 18000BE5 		str	r0, [fp, #-24]
 343:OptimizationBenchmark.c **** int EV_previous;
 344:OptimizationBenchmark.c **** int EV_result;
 345:OptimizationBenchmark.c **** int EV_count;
 346:OptimizationBenchmark.c **** int EV_i;
 347:OptimizationBenchmark.c **** int EV_sum;
 348:OptimizationBenchmark.c **** EV_previous = (-1);
 1744 0f3c 0030E0E3 		mvn	r3, #0
 1745 0f40 08300BE5 		str	r3, [fp, #-8]
 349:OptimizationBenchmark.c **** EV_result = 1;
 1747 0f44 0130A0E3 		mov	r3, #1
 1748 0f48 0C300BE5 		str	r3, [fp, #-12]
 350:OptimizationBenchmark.c **** EV_i = 0;
 1750 0f4c 0030A0E3 		mov	r3, #0
 1751 0f50 10300BE5 		str	r3, [fp, #-16]
 351:OptimizationBenchmark.c **** while ((EV_i<EV_number))
 1753 0f54 0A0000EA 		b	.L62
 1754              	.L63:
 352:OptimizationBenchmark.c **** {
 353:OptimizationBenchmark.c **** EV_sum = (EV_result+EV_previous);
 1756 0f58 0C201BE5 		ldr	r2, [fp, #-12]
 1757 0f5c 08301BE5 		ldr	r3, [fp, #-8]
 1758 0f60 033082E0 		add	r3, r2, r3
 1759 0f64 14300BE5 		str	r3, [fp, #-20]
 354:OptimizationBenchmark.c **** EV_previous = EV_result;
 1761 0f68 0C301BE5 		ldr	r3, [fp, #-12]
 1762 0f6c 08300BE5 		str	r3, [fp, #-8]
 355:OptimizationBenchmark.c **** EV_result = EV_sum;
 1764 0f70 14301BE5 		ldr	r3, [fp, #-20]
 1765 0f74 0C300BE5 		str	r3, [fp, #-12]
 356:OptimizationBenchmark.c **** EV_i = (EV_i+1);
 1767 0f78 10301BE5 		ldr	r3, [fp, #-16]
 1768 0f7c 013083E2 		add	r3, r3, #1
 1769 0f80 10300BE5 		str	r3, [fp, #-16]
 1770              	.L62:
 351:OptimizationBenchmark.c **** {
 1772 0f84 10201BE5 		ldr	r2, [fp, #-16]
 1773 0f88 18301BE5 		ldr	r3, [fp, #-24]
 1774 0f8c 030052E1 		cmp	r2, r3
 1775 0f90 F0FFFFBA 		blt	.L63
 357:OptimizationBenchmark.c **** }
 358:OptimizationBenchmark.c **** return EV_result;
 1777 0f94 0C301BE5 		ldr	r3, [fp, #-12]
 359:OptimizationBenchmark.c **** }
 1779 0f98 0300A0E1 		mov	r0, r3
 1780 0f9c 00D08BE2 		add	sp, fp, #0
 1782              		@ sp needed
 1783 0fa0 04B09DE4 		ldr	fp, [sp], #4
 1786 0fa4 1EFF2FE1 		bx	lr
 1788              	.LFE21:
 1790              		.align	2
 1791              		.global	_recursiveFibonacci
 1792              		.syntax unified
 1793              		.arm
 1794              		.fpu vfp
 1796              	_recursiveFibonacci:
 1797              	.LFB22:
 360:OptimizationBenchmark.c **** int _recursiveFibonacci(int EV_number)
 361:OptimizationBenchmark.c **** {
 1800              		@ args = 0, pretend = 0, frame = 8
 1801              		@ frame_needed = 1, uses_anonymous_args = 0
 1802 0fa8 10482DE9 		push	{r4, fp, lr}
 1807 0fac 08B08DE2 		add	fp, sp, #8
 1809 0fb0 0CD04DE2 		sub	sp, sp, #12
 1810 0fb4 10000BE5 		str	r0, [fp, #-16]
 362:OptimizationBenchmark.c **** if (((EV_number<=0)||(EV_number==1)))
 1812 0fb8 10301BE5 		ldr	r3, [fp, #-16]
 1813 0fbc 000053E3 		cmp	r3, #0
 1814 0fc0 020000DA 		ble	.L66
 1816 0fc4 10301BE5 		ldr	r3, [fp, #-16]
 1817 0fc8 010053E3 		cmp	r3, #1
 1818 0fcc 0100001A 		bne	.L67
 1819              	.L66:
 363:OptimizationBenchmark.c **** {
 364:OptimizationBenchmark.c **** return EV_number;
 1821 0fd0 10301BE5 		ldr	r3, [fp, #-16]
 1822 0fd4 0A0000EA 		b	.L68
 1823              	.L67:
 365:OptimizationBenchmark.c **** }
 366:OptimizationBenchmark.c **** else
 367:OptimizationBenchmark.c **** {
 368:OptimizationBenchmark.c **** return (_recursiveFibonacci((EV_number-1))+_recursiveFibonacci((EV_number-2)));
 1825 0fd8 10301BE5 		ldr	r3, [fp, #-16]
 1826 0fdc 013043E2 		sub	r3, r3, #1
 1827 0fe0 0300A0E1 		mov	r0, r3
 1828 0fe4 FEFFFFEB 		bl	_recursiveFibonacci
 1829 0fe8 0040A0E1 		mov	r4, r0
 1831 0fec 10301BE5 		ldr	r3, [fp, #-16]
 1832 0ff0 023043E2 		sub	r3, r3, #2
 1833 0ff4 0300A0E1 		mov	r0, r3
 1834 0ff8 FEFFFFEB 		bl	_recursiveFibonacci
 1835 0ffc 0030A0E1 		mov	r3, r0
 1837 1000 033084E0 		add	r3, r4, r3
 1838              	.L68:
 369:OptimizationBenchmark.c **** }
 370:OptimizationBenchmark.c **** }
 1840 1004 0300A0E1 		mov	r0, r3
 1841 1008 08D04BE2 		sub	sp, fp, #8
 1843              		@ sp needed
 1844 100c 1088BDE8 		pop	{r4, fp, pc}
 1846              	.LFE22:
 1848              		.section	.rodata
 1849              		.align	2
 1850              	.LC0:
 1851 0000 256400   		.ascii	"%d\000"
 1852 0003 00       		.align	2
 1853              	.LC1:
 1854 0004 25640A00 		.ascii	"%d\012\000"
 1855              		.text
 1856              		.align	2
 1857              		.global	_main
 1858              		.syntax unified
 1859              		.arm
 1860              		.fpu vfp
 1862              	_main:
 1863              	.LFB23:
 371:OptimizationBenchmark.c **** int _main()
 372:OptimizationBenchmark.c **** {
 1866              		@ args = 0, pretend = 0, frame = 16
 1867              		@ frame_needed = 1, uses_anonymous_args = 0
 1868 1010 00482DE9 		push	{fp, lr}
 1872 1014 04B08DE2 		add	fp, sp, #4
 1874 1018 10D04DE2 		sub	sp, sp, #16
 373:OptimizationBenchmark.c **** int EV_input;
 374:OptimizationBenchmark.c **** int EV_result;
 375:OptimizationBenchmark.c **** int EV_i;
 376:OptimizationBenchmark.c **** scanf("%d", &EV_input);
 1876 101c 10304BE2 		sub	r3, fp, #16
 1877 1020 0310A0E1 		mov	r1, r3
 1878 1024 B8019FE5 		ldr	r0, .L73
 1879 1028 FEFFFFEB 		bl	__isoc99_scanf
 377:OptimizationBenchmark.c **** EV_i = 1;
 1881 102c 0130A0E3 		mov	r3, #1
 1882 1030 08300BE5 		str	r3, [fp, #-8]
 378:OptimizationBenchmark.c **** while ((EV_i<EV_input))
 1884 1034 5F0000EA 		b	.L70
 1885              	.L71:
 379:OptimizationBenchmark.c **** {
 380:OptimizationBenchmark.c **** EV_result = _constantFolding();
 1887 1038 FEFFFFEB 		bl	_constantFolding
 1888 103c 0C000BE5 		str	r0, [fp, #-12]
 381:OptimizationBenchmark.c **** printf("%d\n", EV_result);
 1890 1040 0C101BE5 		ldr	r1, [fp, #-12]
 1891 1044 9C019FE5 		ldr	r0, .L73+4
 1892 1048 FEFFFFEB 		bl	printf
 382:OptimizationBenchmark.c **** EV_result = _constantPropagation();
 1894 104c FEFFFFEB 		bl	_constantPropagation
 1895 1050 0C000BE5 		str	r0, [fp, #-12]
 383:OptimizationBenchmark.c **** printf("%d\n", EV_result);
 1897 1054 0C101BE5 		ldr	r1, [fp, #-12]
 1898 1058 88019FE5 		ldr	r0, .L73+4
 1899 105c FEFFFFEB 		bl	printf
 384:OptimizationBenchmark.c **** EV_result = _deadCodeElimination();
 1901 1060 FEFFFFEB 		bl	_deadCodeElimination
 1902 1064 0C000BE5 		str	r0, [fp, #-12]
 385:OptimizationBenchmark.c **** printf("%d\n", EV_result);
 1904 1068 0C101BE5 		ldr	r1, [fp, #-12]
 1905 106c 74019FE5 		ldr	r0, .L73+4
 1906 1070 FEFFFFEB 		bl	printf
 386:OptimizationBenchmark.c **** EV_result = _interProceduralOptimization();
 1908 1074 FEFFFFEB 		bl	_interProceduralOptimization
 1909 1078 0C000BE5 		str	r0, [fp, #-12]
 387:OptimizationBenchmark.c **** printf("%d\n", EV_result);
 1911 107c 0C101BE5 		ldr	r1, [fp, #-12]
 1912 1080 60019FE5 		ldr	r0, .L73+4
 1913 1084 FEFFFFEB 		bl	printf
 388:OptimizationBenchmark.c **** EV_result = _commonSubexpressionElimination();
 1915 1088 FEFFFFEB 		bl	_commonSubexpressionElimination
 1916 108c 0C000BE5 		str	r0, [fp, #-12]
 389:OptimizationBenchmark.c **** printf("%d\n", EV_result);
 1918 1090 0C101BE5 		ldr	r1, [fp, #-12]
 1919 1094 4C019FE5 		ldr	r0, .L73+4
 1920 1098 FEFFFFEB 		bl	printf
 390:OptimizationBenchmark.c **** EV_result = _hoisting();
 1922 109c FEFFFFEB 		bl	_hoisting
 1923 10a0 0C000BE5 		str	r0, [fp, #-12]
 391:OptimizationBenchmark.c **** printf("%d\n", EV_result);
 1925 10a4 0C101BE5 		ldr	r1, [fp, #-12]
 1926 10a8 38019FE5 		ldr	r0, .L73+4
 1927 10ac FEFFFFEB 		bl	printf
 392:OptimizationBenchmark.c **** EV_result = _doubleIf();
 1929 10b0 FEFFFFEB 		bl	_doubleIf
 1930 10b4 0C000BE5 		str	r0, [fp, #-12]
 393:OptimizationBenchmark.c **** printf("%d\n", EV_result);
 1932 10b8 0C101BE5 		ldr	r1, [fp, #-12]
 1933 10bc 24019FE5 		ldr	r0, .L73+4
 1934 10c0 FEFFFFEB 		bl	printf
 394:OptimizationBenchmark.c **** EV_result = _integerDivide();
 1936 10c4 FEFFFFEB 		bl	_integerDivide
 1937 10c8 0C000BE5 		str	r0, [fp, #-12]
 395:OptimizationBenchmark.c **** printf("%d\n", EV_result);
 1939 10cc 0C101BE5 		ldr	r1, [fp, #-12]
 1940 10d0 10019FE5 		ldr	r0, .L73+4
 1941 10d4 FEFFFFEB 		bl	printf
 396:OptimizationBenchmark.c **** EV_result = _association();
 1943 10d8 FEFFFFEB 		bl	_association
 1944 10dc 0C000BE5 		str	r0, [fp, #-12]
 397:OptimizationBenchmark.c **** printf("%d\n", EV_result);
 1946 10e0 0C101BE5 		ldr	r1, [fp, #-12]
 1947 10e4 FC009FE5 		ldr	r0, .L73+4
 1948 10e8 FEFFFFEB 		bl	printf
 398:OptimizationBenchmark.c **** EV_result = _tailRecursion((EV_input/1000));
 1950 10ec 10301BE5 		ldr	r3, [fp, #-16]
 1951 10f0 F4209FE5 		ldr	r2, .L73+8
 1952 10f4 9213C2E0 		smull	r1, r2, r2, r3
 1953 10f8 4223A0E1 		asr	r2, r2, #6
 1954 10fc C33FA0E1 		asr	r3, r3, #31
 1955 1100 033042E0 		sub	r3, r2, r3
 1956 1104 0300A0E1 		mov	r0, r3
 1957 1108 FEFFFFEB 		bl	_tailRecursion
 1958 110c 0C000BE5 		str	r0, [fp, #-12]
 399:OptimizationBenchmark.c **** printf("%d\n", EV_result);
 1960 1110 0C101BE5 		ldr	r1, [fp, #-12]
 1961 1114 CC009FE5 		ldr	r0, .L73+4
 1962 1118 FEFFFFEB 		bl	printf
 400:OptimizationBenchmark.c **** EV_result = _unswitching();
 1964 111c FEFFFFEB 		bl	_unswitching
 1965 1120 0C000BE5 		str	r0, [fp, #-12]
 401:OptimizationBenchmark.c **** printf("%d\n", EV_result);
 1967 1124 0C101BE5 		ldr	r1, [fp, #-12]
 1968 1128 B8009FE5 		ldr	r0, .L73+4
 1969 112c FEFFFFEB 		bl	printf
 402:OptimizationBenchmark.c **** EV_result = _randomCalculation(EV_input);
 1971 1130 10301BE5 		ldr	r3, [fp, #-16]
 1972 1134 0300A0E1 		mov	r0, r3
 1973 1138 FEFFFFEB 		bl	_randomCalculation
 1974 113c 0C000BE5 		str	r0, [fp, #-12]
 403:OptimizationBenchmark.c **** printf("%d\n", EV_result);
 1976 1140 0C101BE5 		ldr	r1, [fp, #-12]
 1977 1144 9C009FE5 		ldr	r0, .L73+4
 1978 1148 FEFFFFEB 		bl	printf
 404:OptimizationBenchmark.c **** EV_result = _iterativeFibonacci((EV_input/5));
 1980 114c 10301BE5 		ldr	r3, [fp, #-16]
 1981 1150 98209FE5 		ldr	r2, .L73+12
 1982 1154 9213C2E0 		smull	r1, r2, r2, r3
 1983 1158 C220A0E1 		asr	r2, r2, #1
 1984 115c C33FA0E1 		asr	r3, r3, #31
 1985 1160 033042E0 		sub	r3, r2, r3
 1986 1164 0300A0E1 		mov	r0, r3
 1987 1168 FEFFFFEB 		bl	_iterativeFibonacci
 1988 116c 0C000BE5 		str	r0, [fp, #-12]
 405:OptimizationBenchmark.c **** printf("%d\n", EV_result);
 1990 1170 0C101BE5 		ldr	r1, [fp, #-12]
 1991 1174 6C009FE5 		ldr	r0, .L73+4
 1992 1178 FEFFFFEB 		bl	printf
 406:OptimizationBenchmark.c **** EV_result = _recursiveFibonacci((EV_input/1000));
 1994 117c 10301BE5 		ldr	r3, [fp, #-16]
 1995 1180 64209FE5 		ldr	r2, .L73+8
 1996 1184 9213C2E0 		smull	r1, r2, r2, r3
 1997 1188 4223A0E1 		asr	r2, r2, #6
 1998 118c C33FA0E1 		asr	r3, r3, #31
 1999 1190 033042E0 		sub	r3, r2, r3
 2000 1194 0300A0E1 		mov	r0, r3
 2001 1198 FEFFFFEB 		bl	_recursiveFibonacci
 2002 119c 0C000BE5 		str	r0, [fp, #-12]
 407:OptimizationBenchmark.c **** printf("%d\n", EV_result);
 2004 11a0 0C101BE5 		ldr	r1, [fp, #-12]
 2005 11a4 3C009FE5 		ldr	r0, .L73+4
 2006 11a8 FEFFFFEB 		bl	printf
 408:OptimizationBenchmark.c **** EV_i = (EV_i+1);
 2008 11ac 08301BE5 		ldr	r3, [fp, #-8]
 2009 11b0 013083E2 		add	r3, r3, #1
 2010 11b4 08300BE5 		str	r3, [fp, #-8]
 2011              	.L70:
 378:OptimizationBenchmark.c **** {
 2013 11b8 10301BE5 		ldr	r3, [fp, #-16]
 378:OptimizationBenchmark.c **** {
 2015 11bc 08201BE5 		ldr	r2, [fp, #-8]
 2016 11c0 030052E1 		cmp	r2, r3
 2017 11c4 9BFFFFBA 		blt	.L71
 409:OptimizationBenchmark.c **** }
 410:OptimizationBenchmark.c **** printf("%d\n", 9999);
 2019 11c8 24109FE5 		ldr	r1, .L73+16
 2020 11cc 14009FE5 		ldr	r0, .L73+4
 2021 11d0 FEFFFFEB 		bl	printf
 411:OptimizationBenchmark.c **** return 0;
 2023 11d4 0030A0E3 		mov	r3, #0
 412:OptimizationBenchmark.c **** }
 2025 11d8 0300A0E1 		mov	r0, r3
 2026 11dc 04D04BE2 		sub	sp, fp, #4
 2028              		@ sp needed
 2029 11e0 0088BDE8 		pop	{fp, pc}
 2030              	.L74:
 2031              		.align	2
 2032              	.L73:
 2033 11e4 00000000 		.word	.LC0
 2034 11e8 04000000 		.word	.LC1
 2035 11ec D34D6210 		.word	274877907
 2036 11f0 67666666 		.word	1717986919
 2037 11f4 0F270000 		.word	9999
 2039              	.LFE23:
 2041              		.align	2
 2042              		.global	main
 2043              		.syntax unified
 2044              		.arm
 2045              		.fpu vfp
 2047              	main:
 2048              	.LFB24:
 413:OptimizationBenchmark.c **** int main(void)
 414:OptimizationBenchmark.c **** {
 2051              		@ args = 0, pretend = 0, frame = 0
 2052              		@ frame_needed = 1, uses_anonymous_args = 0
 2053 11f8 00482DE9 		push	{fp, lr}
 2057 11fc 04B08DE2 		add	fp, sp, #4
 415:OptimizationBenchmark.c ****    return _main();
 2060 1200 FEFFFFEB 		bl	_main
 2061 1204 0030A0E1 		mov	r3, r0
 416:OptimizationBenchmark.c **** }
 2063 1208 0300A0E1 		mov	r0, r3
 2064 120c 0088BDE8 		pop	{fp, pc}
 2066              	.LFE24:
 2068              	.Letext0:
