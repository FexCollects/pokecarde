INCLUDE "../region.asm"
INCLUDE "../constants/abilities.asm"
INCLUDE "../constants/easychat.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/moves.asm"
INCLUDE "../constants/natures.asm"
INCLUDE "../constants/pokemon.asm"
INCLUDE "../constants/trainerclasses.asm"

DEF MOSSDEEP EQU 0

MACRO Battle_Trainer
	db $01
	dl $02000000
	db CREGION,0,CREGION,0,0,0,$04,0,$80,$01,0,0
	db $0D
	dl $02000018
	db $02,$00
	ENDM

DEF BT_Level EQUS "db"
DEF Class EQUS "db"
DEF BT_Floor EQUS "dw" ; the byte after it is 00, but apparently means something…
MACRO Intro_EN
	IF CREGION == REGION_EN
	dw \1, \2, \3, \4, \5, \6
	ENDC
	ENDM
MACRO Win_EN
	IF CREGION == REGION_EN
	dw \1, \2, \3, \4, \5, \6
	ENDC
	ENDM
MACRO Loss_EN
	IF CREGION == REGION_EN
	dw \1, \2, \3, \4, \5, \6
	ENDC
	ENDM
MACRO Intro_JP
	IF CREGION == REGION_JP
	dw \1, \2, \3, \4, \5, \6
	ENDC
	ENDM
MACRO Win_JP
	IF CREGION == REGION_JP
	dw \1, \2, \3, \4, \5, \6
	ENDC
	ENDM
MACRO Loss_JP
	IF CREGION == REGION_JP
	dw \1, \2, \3, \4, \5, \6
	ENDC
	ENDM
DEF Pokemon EQUS "dw"
DEF Holds EQUS "dw"
DEF Moves EQUS "dw"
DEF Level EQUS "db"
MACRO PP_Ups
	db (\1) + (\2 << 2) + (\3 << 4) + (\4 << 6)
	ENDM
DEF EVs EQUS "db"
DEF OT_ID EQUS "dw"
MACRO IVs
	dw \1 + (\2 << 5) + (\3 << 10) + ((\4 & 1) << 15)
	dw (\4 >> 1) + (\5 << 4) + (\6 << 9) + (\7 << 15)
	ENDM
MACRO PV
	dw (\1 & $FFFF), (\1 >> 16)
	ENDM
DEF Friendship EQUS "db"

DEF End_Trainer EQUS "dl"
