/* See COPYRIGHT for copyright information. */

#include <inc/mmu.h>
#include <inc/memlayout.h>
#include <inc/trap.h>

#include <kern/picirq.h>


###################################################################
# exceptions/interrupts
###################################################################

/* TRAPHANDLER defines a globally-visible function for handling a trap.
 * It pushes a trap number onto the stack, then jumps to _alltraps.
 * Use TRAPHANDLER for traps where the CPU automatically pushes an error code.
 *
 * You shouldn't call a TRAPHANDLER function from C, but you may
 * need to _declare_ one in C (for instance, to get a function pointer
 * during IDT setup).  You can declare the function with
 *   void NAME();
 * where NAME is the argument passed to TRAPHANDLER.
 */
#define TRAPHANDLER(name, num)						\
	.globl name;		/* define global symbol for 'name' */	\
	.type name, @function;	/* symbol type is function */		\
	.align 2;		/* align function definition */		\
	name:			/* function starts here */		\
	pushl $(num);							\
	jmp _alltraps

/* Use TRAPHANDLER_NOEC for traps where the CPU doesn't push an error code.
 * It pushes a 0 in place of the error code, so the trap frame has the same
 * format in either case.
 */
#define TRAPHANDLER_NOEC(name, num)					\
	.globl name;							\
	.type name, @function;						\
	.align 2;							\
	name:								\
	pushl $0;							\
	pushl $(num);							\
	jmp _alltraps

.text


/*
 * Lab 3: Your code here for generating entry points for the different traps.
 */
TRAPHANDLER_NOEC(trap_handler_0, 0)
TRAPHANDLER_NOEC(trap_handler_1, 1)
TRAPHANDLER_NOEC(trap_handler_2, 2)
TRAPHANDLER_NOEC(trap_handler_3, 3)
TRAPHANDLER_NOEC(trap_handler_4, 4)
TRAPHANDLER_NOEC(trap_handler_5, 5)
TRAPHANDLER_NOEC(trap_handler_6, 6)
TRAPHANDLER_NOEC(trap_handler_7, 7)
TRAPHANDLER(trap_handler_8, 8)
TRAPHANDLER_NOEC(trap_handler_9, 9)
TRAPHANDLER(trap_handler_10, 10)
TRAPHANDLER(trap_handler_11, 11)
TRAPHANDLER(trap_handler_12, 12)
TRAPHANDLER(trap_handler_13, 13)
TRAPHANDLER(trap_handler_14, 14)
TRAPHANDLER_NOEC(trap_handler_15, 15)
TRAPHANDLER_NOEC(trap_handler_16, 16)
TRAPHANDLER_NOEC(trap_handler_17, 17)
TRAPHANDLER_NOEC(trap_handler_18, 18)
TRAPHANDLER_NOEC(trap_handler_19, 19)
TRAPHANDLER_NOEC(trap_handler_20, 20)
TRAPHANDLER_NOEC(trap_handler_21, 21)
TRAPHANDLER_NOEC(trap_handler_22, 22)
TRAPHANDLER_NOEC(trap_handler_23, 23)
TRAPHANDLER_NOEC(trap_handler_24, 24)
TRAPHANDLER_NOEC(trap_handler_25, 25)
TRAPHANDLER_NOEC(trap_handler_26, 26)
TRAPHANDLER_NOEC(trap_handler_27, 27)
TRAPHANDLER_NOEC(trap_handler_28, 28)
TRAPHANDLER_NOEC(trap_handler_29, 29)
TRAPHANDLER_NOEC(trap_handler_30, 30)
TRAPHANDLER_NOEC(trap_handler_31, 31)
TRAPHANDLER_NOEC(trap_handler_32, 32)
TRAPHANDLER_NOEC(trap_handler_33, 33)
TRAPHANDLER_NOEC(trap_handler_34, 34)
TRAPHANDLER_NOEC(trap_handler_35, 35)
TRAPHANDLER_NOEC(trap_handler_36, 36)
TRAPHANDLER_NOEC(trap_handler_37, 37)
TRAPHANDLER_NOEC(trap_handler_38, 38)
TRAPHANDLER_NOEC(trap_handler_39, 39)
TRAPHANDLER_NOEC(trap_handler_40, 40)
TRAPHANDLER_NOEC(trap_handler_41, 41)
TRAPHANDLER_NOEC(trap_handler_42, 42)
TRAPHANDLER_NOEC(trap_handler_43, 43)
TRAPHANDLER_NOEC(trap_handler_44, 44)
TRAPHANDLER_NOEC(trap_handler_45, 45)
TRAPHANDLER_NOEC(trap_handler_46, 46)
TRAPHANDLER_NOEC(trap_handler_47, 47)
TRAPHANDLER_NOEC(trap_handler_48, 48)
TRAPHANDLER_NOEC(trap_handler_49, 49)
TRAPHANDLER_NOEC(trap_handler_50, 50)
TRAPHANDLER_NOEC(trap_handler_51, 51)
TRAPHANDLER_NOEC(trap_handler_52, 52)
TRAPHANDLER_NOEC(trap_handler_53, 53)
TRAPHANDLER_NOEC(trap_handler_54, 54)
TRAPHANDLER_NOEC(trap_handler_55, 55)
TRAPHANDLER_NOEC(trap_handler_56, 56)
TRAPHANDLER_NOEC(trap_handler_57, 57)
TRAPHANDLER_NOEC(trap_handler_58, 58)
TRAPHANDLER_NOEC(trap_handler_59, 59)
TRAPHANDLER_NOEC(trap_handler_60, 60)
TRAPHANDLER_NOEC(trap_handler_61, 61)
TRAPHANDLER_NOEC(trap_handler_62, 62)
TRAPHANDLER_NOEC(trap_handler_63, 63)
TRAPHANDLER_NOEC(trap_handler_64, 64)
TRAPHANDLER_NOEC(trap_handler_65, 65)
TRAPHANDLER_NOEC(trap_handler_66, 66)
TRAPHANDLER_NOEC(trap_handler_67, 67)
TRAPHANDLER_NOEC(trap_handler_68, 68)
TRAPHANDLER_NOEC(trap_handler_69, 69)
TRAPHANDLER_NOEC(trap_handler_70, 70)
TRAPHANDLER_NOEC(trap_handler_71, 71)
TRAPHANDLER_NOEC(trap_handler_72, 72)
TRAPHANDLER_NOEC(trap_handler_73, 73)
TRAPHANDLER_NOEC(trap_handler_74, 74)
TRAPHANDLER_NOEC(trap_handler_75, 75)
TRAPHANDLER_NOEC(trap_handler_76, 76)
TRAPHANDLER_NOEC(trap_handler_77, 77)
TRAPHANDLER_NOEC(trap_handler_78, 78)
TRAPHANDLER_NOEC(trap_handler_79, 79)
TRAPHANDLER_NOEC(trap_handler_80, 80)
TRAPHANDLER_NOEC(trap_handler_81, 81)
TRAPHANDLER_NOEC(trap_handler_82, 82)
TRAPHANDLER_NOEC(trap_handler_83, 83)
TRAPHANDLER_NOEC(trap_handler_84, 84)
TRAPHANDLER_NOEC(trap_handler_85, 85)
TRAPHANDLER_NOEC(trap_handler_86, 86)
TRAPHANDLER_NOEC(trap_handler_87, 87)
TRAPHANDLER_NOEC(trap_handler_88, 88)
TRAPHANDLER_NOEC(trap_handler_89, 89)
TRAPHANDLER_NOEC(trap_handler_90, 90)
TRAPHANDLER_NOEC(trap_handler_91, 91)
TRAPHANDLER_NOEC(trap_handler_92, 92)
TRAPHANDLER_NOEC(trap_handler_93, 93)
TRAPHANDLER_NOEC(trap_handler_94, 94)
TRAPHANDLER_NOEC(trap_handler_95, 95)
TRAPHANDLER_NOEC(trap_handler_96, 96)
TRAPHANDLER_NOEC(trap_handler_97, 97)
TRAPHANDLER_NOEC(trap_handler_98, 98)
TRAPHANDLER_NOEC(trap_handler_99, 99)
TRAPHANDLER_NOEC(trap_handler_100, 100)
TRAPHANDLER_NOEC(trap_handler_101, 101)
TRAPHANDLER_NOEC(trap_handler_102, 102)
TRAPHANDLER_NOEC(trap_handler_103, 103)
TRAPHANDLER_NOEC(trap_handler_104, 104)
TRAPHANDLER_NOEC(trap_handler_105, 105)
TRAPHANDLER_NOEC(trap_handler_106, 106)
TRAPHANDLER_NOEC(trap_handler_107, 107)
TRAPHANDLER_NOEC(trap_handler_108, 108)
TRAPHANDLER_NOEC(trap_handler_109, 109)
TRAPHANDLER_NOEC(trap_handler_110, 110)
TRAPHANDLER_NOEC(trap_handler_111, 111)
TRAPHANDLER_NOEC(trap_handler_112, 112)
TRAPHANDLER_NOEC(trap_handler_113, 113)
TRAPHANDLER_NOEC(trap_handler_114, 114)
TRAPHANDLER_NOEC(trap_handler_115, 115)
TRAPHANDLER_NOEC(trap_handler_116, 116)
TRAPHANDLER_NOEC(trap_handler_117, 117)
TRAPHANDLER_NOEC(trap_handler_118, 118)
TRAPHANDLER_NOEC(trap_handler_119, 119)
TRAPHANDLER_NOEC(trap_handler_120, 120)
TRAPHANDLER_NOEC(trap_handler_121, 121)
TRAPHANDLER_NOEC(trap_handler_122, 122)
TRAPHANDLER_NOEC(trap_handler_123, 123)
TRAPHANDLER_NOEC(trap_handler_124, 124)
TRAPHANDLER_NOEC(trap_handler_125, 125)
TRAPHANDLER_NOEC(trap_handler_126, 126)
TRAPHANDLER_NOEC(trap_handler_127, 127)
TRAPHANDLER_NOEC(trap_handler_128, 128)
TRAPHANDLER_NOEC(trap_handler_129, 129)
TRAPHANDLER_NOEC(trap_handler_130, 130)
TRAPHANDLER_NOEC(trap_handler_131, 131)
TRAPHANDLER_NOEC(trap_handler_132, 132)
TRAPHANDLER_NOEC(trap_handler_133, 133)
TRAPHANDLER_NOEC(trap_handler_134, 134)
TRAPHANDLER_NOEC(trap_handler_135, 135)
TRAPHANDLER_NOEC(trap_handler_136, 136)
TRAPHANDLER_NOEC(trap_handler_137, 137)
TRAPHANDLER_NOEC(trap_handler_138, 138)
TRAPHANDLER_NOEC(trap_handler_139, 139)
TRAPHANDLER_NOEC(trap_handler_140, 140)
TRAPHANDLER_NOEC(trap_handler_141, 141)
TRAPHANDLER_NOEC(trap_handler_142, 142)
TRAPHANDLER_NOEC(trap_handler_143, 143)
TRAPHANDLER_NOEC(trap_handler_144, 144)
TRAPHANDLER_NOEC(trap_handler_145, 145)
TRAPHANDLER_NOEC(trap_handler_146, 146)
TRAPHANDLER_NOEC(trap_handler_147, 147)
TRAPHANDLER_NOEC(trap_handler_148, 148)
TRAPHANDLER_NOEC(trap_handler_149, 149)
TRAPHANDLER_NOEC(trap_handler_150, 150)
TRAPHANDLER_NOEC(trap_handler_151, 151)
TRAPHANDLER_NOEC(trap_handler_152, 152)
TRAPHANDLER_NOEC(trap_handler_153, 153)
TRAPHANDLER_NOEC(trap_handler_154, 154)
TRAPHANDLER_NOEC(trap_handler_155, 155)
TRAPHANDLER_NOEC(trap_handler_156, 156)
TRAPHANDLER_NOEC(trap_handler_157, 157)
TRAPHANDLER_NOEC(trap_handler_158, 158)
TRAPHANDLER_NOEC(trap_handler_159, 159)
TRAPHANDLER_NOEC(trap_handler_160, 160)
TRAPHANDLER_NOEC(trap_handler_161, 161)
TRAPHANDLER_NOEC(trap_handler_162, 162)
TRAPHANDLER_NOEC(trap_handler_163, 163)
TRAPHANDLER_NOEC(trap_handler_164, 164)
TRAPHANDLER_NOEC(trap_handler_165, 165)
TRAPHANDLER_NOEC(trap_handler_166, 166)
TRAPHANDLER_NOEC(trap_handler_167, 167)
TRAPHANDLER_NOEC(trap_handler_168, 168)
TRAPHANDLER_NOEC(trap_handler_169, 169)
TRAPHANDLER_NOEC(trap_handler_170, 170)
TRAPHANDLER_NOEC(trap_handler_171, 171)
TRAPHANDLER_NOEC(trap_handler_172, 172)
TRAPHANDLER_NOEC(trap_handler_173, 173)
TRAPHANDLER_NOEC(trap_handler_174, 174)
TRAPHANDLER_NOEC(trap_handler_175, 175)
TRAPHANDLER_NOEC(trap_handler_176, 176)
TRAPHANDLER_NOEC(trap_handler_177, 177)
TRAPHANDLER_NOEC(trap_handler_178, 178)
TRAPHANDLER_NOEC(trap_handler_179, 179)
TRAPHANDLER_NOEC(trap_handler_180, 180)
TRAPHANDLER_NOEC(trap_handler_181, 181)
TRAPHANDLER_NOEC(trap_handler_182, 182)
TRAPHANDLER_NOEC(trap_handler_183, 183)
TRAPHANDLER_NOEC(trap_handler_184, 184)
TRAPHANDLER_NOEC(trap_handler_185, 185)
TRAPHANDLER_NOEC(trap_handler_186, 186)
TRAPHANDLER_NOEC(trap_handler_187, 187)
TRAPHANDLER_NOEC(trap_handler_188, 188)
TRAPHANDLER_NOEC(trap_handler_189, 189)
TRAPHANDLER_NOEC(trap_handler_190, 190)
TRAPHANDLER_NOEC(trap_handler_191, 191)
TRAPHANDLER_NOEC(trap_handler_192, 192)
TRAPHANDLER_NOEC(trap_handler_193, 193)
TRAPHANDLER_NOEC(trap_handler_194, 194)
TRAPHANDLER_NOEC(trap_handler_195, 195)
TRAPHANDLER_NOEC(trap_handler_196, 196)
TRAPHANDLER_NOEC(trap_handler_197, 197)
TRAPHANDLER_NOEC(trap_handler_198, 198)
TRAPHANDLER_NOEC(trap_handler_199, 199)
TRAPHANDLER_NOEC(trap_handler_200, 200)
TRAPHANDLER_NOEC(trap_handler_201, 201)
TRAPHANDLER_NOEC(trap_handler_202, 202)
TRAPHANDLER_NOEC(trap_handler_203, 203)
TRAPHANDLER_NOEC(trap_handler_204, 204)
TRAPHANDLER_NOEC(trap_handler_205, 205)
TRAPHANDLER_NOEC(trap_handler_206, 206)
TRAPHANDLER_NOEC(trap_handler_207, 207)
TRAPHANDLER_NOEC(trap_handler_208, 208)
TRAPHANDLER_NOEC(trap_handler_209, 209)
TRAPHANDLER_NOEC(trap_handler_210, 210)
TRAPHANDLER_NOEC(trap_handler_211, 211)
TRAPHANDLER_NOEC(trap_handler_212, 212)
TRAPHANDLER_NOEC(trap_handler_213, 213)
TRAPHANDLER_NOEC(trap_handler_214, 214)
TRAPHANDLER_NOEC(trap_handler_215, 215)
TRAPHANDLER_NOEC(trap_handler_216, 216)
TRAPHANDLER_NOEC(trap_handler_217, 217)
TRAPHANDLER_NOEC(trap_handler_218, 218)
TRAPHANDLER_NOEC(trap_handler_219, 219)
TRAPHANDLER_NOEC(trap_handler_220, 220)
TRAPHANDLER_NOEC(trap_handler_221, 221)
TRAPHANDLER_NOEC(trap_handler_222, 222)
TRAPHANDLER_NOEC(trap_handler_223, 223)
TRAPHANDLER_NOEC(trap_handler_224, 224)
TRAPHANDLER_NOEC(trap_handler_225, 225)
TRAPHANDLER_NOEC(trap_handler_226, 226)
TRAPHANDLER_NOEC(trap_handler_227, 227)
TRAPHANDLER_NOEC(trap_handler_228, 228)
TRAPHANDLER_NOEC(trap_handler_229, 229)
TRAPHANDLER_NOEC(trap_handler_230, 230)
TRAPHANDLER_NOEC(trap_handler_231, 231)
TRAPHANDLER_NOEC(trap_handler_232, 232)
TRAPHANDLER_NOEC(trap_handler_233, 233)
TRAPHANDLER_NOEC(trap_handler_234, 234)
TRAPHANDLER_NOEC(trap_handler_235, 235)
TRAPHANDLER_NOEC(trap_handler_236, 236)
TRAPHANDLER_NOEC(trap_handler_237, 237)
TRAPHANDLER_NOEC(trap_handler_238, 238)
TRAPHANDLER_NOEC(trap_handler_239, 239)
TRAPHANDLER_NOEC(trap_handler_240, 240)
TRAPHANDLER_NOEC(trap_handler_241, 241)
TRAPHANDLER_NOEC(trap_handler_242, 242)
TRAPHANDLER_NOEC(trap_handler_243, 243)
TRAPHANDLER_NOEC(trap_handler_244, 244)
TRAPHANDLER_NOEC(trap_handler_245, 245)
TRAPHANDLER_NOEC(trap_handler_246, 246)
TRAPHANDLER_NOEC(trap_handler_247, 247)
TRAPHANDLER_NOEC(trap_handler_248, 248)
TRAPHANDLER_NOEC(trap_handler_249, 249)
TRAPHANDLER_NOEC(trap_handler_250, 250)
TRAPHANDLER_NOEC(trap_handler_251, 251)
TRAPHANDLER_NOEC(trap_handler_252, 252)
TRAPHANDLER_NOEC(trap_handler_253, 253)
TRAPHANDLER_NOEC(trap_handler_254, 254)
TRAPHANDLER_NOEC(trap_handler_255, 255)


/*
 * Lab 3: Your code here for _alltraps
 */
_alltraps:
	push %ds
	push %es
	pushal

	mov $GD_KD, %ax
	mov %ax, %ds
	mov %ax, %es

	# trap(Trapframe *tf)
	pushl %esp
	call trap

.data
.globl trap_handlers
trap_handlers:
	.long trap_handler_0
	.long trap_handler_1
	.long trap_handler_2
	.long trap_handler_3
	.long trap_handler_4
	.long trap_handler_5
	.long trap_handler_6
	.long trap_handler_7
	.long trap_handler_8
	.long trap_handler_9
	.long trap_handler_10
	.long trap_handler_11
	.long trap_handler_12
	.long trap_handler_13
	.long trap_handler_14
	.long trap_handler_15
	.long trap_handler_16
	.long trap_handler_17
	.long trap_handler_18
	.long trap_handler_19
	.long trap_handler_20
	.long trap_handler_21
	.long trap_handler_22
	.long trap_handler_23
	.long trap_handler_24
	.long trap_handler_25
	.long trap_handler_26
	.long trap_handler_27
	.long trap_handler_28
	.long trap_handler_29
	.long trap_handler_30
	.long trap_handler_31
	.long trap_handler_32
	.long trap_handler_33
	.long trap_handler_34
	.long trap_handler_35
	.long trap_handler_36
	.long trap_handler_37
	.long trap_handler_38
	.long trap_handler_39
	.long trap_handler_40
	.long trap_handler_41
	.long trap_handler_42
	.long trap_handler_43
	.long trap_handler_44
	.long trap_handler_45
	.long trap_handler_46
	.long trap_handler_47
	.long trap_handler_48
	.long trap_handler_49
	.long trap_handler_50
	.long trap_handler_51
	.long trap_handler_52
	.long trap_handler_53
	.long trap_handler_54
	.long trap_handler_55
	.long trap_handler_56
	.long trap_handler_57
	.long trap_handler_58
	.long trap_handler_59
	.long trap_handler_60
	.long trap_handler_61
	.long trap_handler_62
	.long trap_handler_63
	.long trap_handler_64
	.long trap_handler_65
	.long trap_handler_66
	.long trap_handler_67
	.long trap_handler_68
	.long trap_handler_69
	.long trap_handler_70
	.long trap_handler_71
	.long trap_handler_72
	.long trap_handler_73
	.long trap_handler_74
	.long trap_handler_75
	.long trap_handler_76
	.long trap_handler_77
	.long trap_handler_78
	.long trap_handler_79
	.long trap_handler_80
	.long trap_handler_81
	.long trap_handler_82
	.long trap_handler_83
	.long trap_handler_84
	.long trap_handler_85
	.long trap_handler_86
	.long trap_handler_87
	.long trap_handler_88
	.long trap_handler_89
	.long trap_handler_90
	.long trap_handler_91
	.long trap_handler_92
	.long trap_handler_93
	.long trap_handler_94
	.long trap_handler_95
	.long trap_handler_96
	.long trap_handler_97
	.long trap_handler_98
	.long trap_handler_99
	.long trap_handler_100
	.long trap_handler_101
	.long trap_handler_102
	.long trap_handler_103
	.long trap_handler_104
	.long trap_handler_105
	.long trap_handler_106
	.long trap_handler_107
	.long trap_handler_108
	.long trap_handler_109
	.long trap_handler_110
	.long trap_handler_111
	.long trap_handler_112
	.long trap_handler_113
	.long trap_handler_114
	.long trap_handler_115
	.long trap_handler_116
	.long trap_handler_117
	.long trap_handler_118
	.long trap_handler_119
	.long trap_handler_120
	.long trap_handler_121
	.long trap_handler_122
	.long trap_handler_123
	.long trap_handler_124
	.long trap_handler_125
	.long trap_handler_126
	.long trap_handler_127
	.long trap_handler_128
	.long trap_handler_129
	.long trap_handler_130
	.long trap_handler_131
	.long trap_handler_132
	.long trap_handler_133
	.long trap_handler_134
	.long trap_handler_135
	.long trap_handler_136
	.long trap_handler_137
	.long trap_handler_138
	.long trap_handler_139
	.long trap_handler_140
	.long trap_handler_141
	.long trap_handler_142
	.long trap_handler_143
	.long trap_handler_144
	.long trap_handler_145
	.long trap_handler_146
	.long trap_handler_147
	.long trap_handler_148
	.long trap_handler_149
	.long trap_handler_150
	.long trap_handler_151
	.long trap_handler_152
	.long trap_handler_153
	.long trap_handler_154
	.long trap_handler_155
	.long trap_handler_156
	.long trap_handler_157
	.long trap_handler_158
	.long trap_handler_159
	.long trap_handler_160
	.long trap_handler_161
	.long trap_handler_162
	.long trap_handler_163
	.long trap_handler_164
	.long trap_handler_165
	.long trap_handler_166
	.long trap_handler_167
	.long trap_handler_168
	.long trap_handler_169
	.long trap_handler_170
	.long trap_handler_171
	.long trap_handler_172
	.long trap_handler_173
	.long trap_handler_174
	.long trap_handler_175
	.long trap_handler_176
	.long trap_handler_177
	.long trap_handler_178
	.long trap_handler_179
	.long trap_handler_180
	.long trap_handler_181
	.long trap_handler_182
	.long trap_handler_183
	.long trap_handler_184
	.long trap_handler_185
	.long trap_handler_186
	.long trap_handler_187
	.long trap_handler_188
	.long trap_handler_189
	.long trap_handler_190
	.long trap_handler_191
	.long trap_handler_192
	.long trap_handler_193
	.long trap_handler_194
	.long trap_handler_195
	.long trap_handler_196
	.long trap_handler_197
	.long trap_handler_198
	.long trap_handler_199
	.long trap_handler_200
	.long trap_handler_201
	.long trap_handler_202
	.long trap_handler_203
	.long trap_handler_204
	.long trap_handler_205
	.long trap_handler_206
	.long trap_handler_207
	.long trap_handler_208
	.long trap_handler_209
	.long trap_handler_210
	.long trap_handler_211
	.long trap_handler_212
	.long trap_handler_213
	.long trap_handler_214
	.long trap_handler_215
	.long trap_handler_216
	.long trap_handler_217
	.long trap_handler_218
	.long trap_handler_219
	.long trap_handler_220
	.long trap_handler_221
	.long trap_handler_222
	.long trap_handler_223
	.long trap_handler_224
	.long trap_handler_225
	.long trap_handler_226
	.long trap_handler_227
	.long trap_handler_228
	.long trap_handler_229
	.long trap_handler_230
	.long trap_handler_231
	.long trap_handler_232
	.long trap_handler_233
	.long trap_handler_234
	.long trap_handler_235
	.long trap_handler_236
	.long trap_handler_237
	.long trap_handler_238
	.long trap_handler_239
	.long trap_handler_240
	.long trap_handler_241
	.long trap_handler_242
	.long trap_handler_243
	.long trap_handler_244
	.long trap_handler_245
	.long trap_handler_246
	.long trap_handler_247
	.long trap_handler_248
	.long trap_handler_249
	.long trap_handler_250
	.long trap_handler_251
	.long trap_handler_252
	.long trap_handler_253
	.long trap_handler_254
	.long trap_handler_255
