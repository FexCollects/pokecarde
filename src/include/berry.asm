INCLUDE "include/gba.asm"
INCLUDE "constants/card_types.asm"
INCLUDE "constants/regions.asm"

MACRO Enigma_Berry
	CardHeader CUSTOM_BERRY
        dl $02000018 ; GBAPtr
	db $02,$00
	ENDM

; firmness
DEF Firmness EQUS "db"
DEF VERY_SOFT  EQU 1
DEF SOFT       EQU 2
DEF HARD       EQU 3
DEF VERY_HARD  EQU 4
DEF SUPER_HARD EQU 5

MACRO Yield_Range
	db \2, \1
	ENDM

MACRO Size
	dw \1 * 10 + \2
	ENDM

DEF Growth_Stage_Hours EQUS "db"
DEF Flavor EQUS "db"
DEF Smoothness EQUS "dw" ; not sure if the second byte is significant on its own

DEF End_Berry EQUS "dl"
