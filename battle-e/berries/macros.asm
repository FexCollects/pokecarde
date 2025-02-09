INCLUDE "../macros.asm"

MACRO Enigma_Berry
	Section "berry",ROM0[$100]
	db $01
	dd $02000000
	db REGION,0,REGION,0,0,0,$04,0,$80,$01,0,0
	db $07
	dd $02000018
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

MACRO End_Berry
	dd 0 ; placeholder for checksum
	EOF
	ENDM
