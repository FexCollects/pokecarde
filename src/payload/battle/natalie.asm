SECTION "payload/battle/natalie", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Battle_Trainer

	BT_Level MOSSDEEP
	Class BATTLE_GIRL
	BT_Floor MOSSDEEP
	db "NATALIE@"
	; Text_JP "ノリコ"8
	OT_ID 00000, 00000

	Intro_EN GET,READY,TO,START,THE,BATTLE
	Win_EN   ALTHOUGH,I_AM,SMALL,I,BEAT,YOU
	Loss_EN  NEXT,BATTLE,I,WILL,BE,BETTER

	Intro_JP $0e0e, $0c00, $0804, $020e, $0628, $0c01
	Win_JP $201e, $1428, $0e0a, $0a1c, $0607, $0c3d
	Loss_JP $201e, $1428, $0e0a, $1c1c, $1210, $0c3d

	Pokemon MAGIKARP
	Holds CHOICE_BAND
	Moves SPLASH, TACKLE, FLAIL, 0
	Level 50
	PP_Ups 0,0,0,0
	EVs 0,255,0,255,0,0
	OT_ID 00000, 00000
	IVs 15,31,15,31,15,15, MAGIKARP_SWIFT_SWIM
	PV $000000E4 ; ♂ Adamant
	db "MAGIKARP@  "
	; Text_JP "コイキング"11
	Friendship 255

	Pokemon LAIRON
	Holds METAL_COAT
	Moves HEADBUTT, IRON_TAIL, ROAR, IRON_DEFENSE
	Level 52
	PP_Ups 0,0,0,0
	EVs 255,255,0,0,0,0
	OT_ID 00000, 00000
	IVs 31,31,15,15,15,15, LAIRON_STURDY
	PV $000000E4 ; ♂ Adamant
	db "LAIRON@    "
	; Text_JP "コドラ"11
	Friendship 255

	Pokemon SHELGON
	Holds SITRUS_BERRY
	Moves DRAGONBREATH, EMBER, BITE, THRASH
	Level 50
	PP_Ups 0,0,0,0
	EVs 255,0,0,0,0,255
	OT_ID 00000, 00000
	IVs 31,15,15,15,15,31, SHELGON_ROCK_HEAD
	PV $0000001C ; ♀ Adamant
	db "SHELGON@   "
	; Text_JP "コモルー"11
	Friendship 255

	End_Trainer

        ds 44 ; Pad to 256

POPC
