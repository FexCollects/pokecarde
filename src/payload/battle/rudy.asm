SECTION "payload/battle/rudy", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Battle_Trainer

	BT_Level MOSSDEEP
	Class YOUNGSTER
	BT_Floor MOSSDEEP
	db "RUDY@   "
	; Text_JP "ケンジロウ"8
	OT_ID 00000, 00000

	Intro_EN YEAH,_EX,GO,_EX,_TACKLE,_EX_EX
	Win_EN   I,SOMEHOW,WON,THE,BATTLE,_EX_EX
	Loss_EN  I_AM,NOT,HOPELESS,BUT,I,GIVE_UP

	Intro_JP $2007, $2009, $ffff, $2621, $0c01, $ffff
	Win_JP $200f, $2013, $0c06, $0e26, $0607, $103f
	Loss_JP $2019, $201c, $0c06, $0c0f, $062d, $0c06

	Pokemon CASCOON
	Holds EVERSTONE
	Moves TACKLE, HARDEN, STRING_SHOT, POISON_STING
	Level 98
	PP_Ups 0,0,0,0
	EVs 252,252,6,0,0,0
	OT_ID 00000, 00000
	IVs 31,31,15,15,15,15, CASCOON_SHED_SKIN
	PV $00000083 ; ♂ Docile
	db "CASCOON@   "
	; Text_JP "マユルド"11
	Friendship 255

	Pokemon SILCOON
	Holds EVERSTONE
	Moves TACKLE, HARDEN, STRING_SHOT, POISON_STING
	Level 99
	PP_Ups 0,0,0,0
	EVs 252,252,6,0,0,0
	OT_ID 00000, 00000
	IVs 31,31,15,15,15,15, SILCOON_SHED_SKIN
	PV $00000012 ; ♀ Bashful
	db "SILCOON@   "
	; Text_JP "カラサリス"11
	Friendship 255

	Pokemon MAGIKARP
	Holds EVERSTONE
	Moves TACKLE, SPLASH, FLAIL, 0
	Level 100
	PP_Ups 0,0,0,0
	EVs 252,252,6,0,0,0
	OT_ID 00000, 00000
	IVs 31,31,15,15,15,15, MAGIKARP_SWIFT_SWIM
	PV $00000095 ; ♂ Quirky
	db "MAGIKARP@  "
	; Text_JP "コイキング"11
	Friendship 255

	End_Trainer

        ds 44 ; Pad to 256

POPC
