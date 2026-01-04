SECTION "payload/battle/patrick", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Battle_Trainer

	BT_Level MOSSDEEP
	Class CAMPER
	BT_Floor MOSSDEEP
	db "PATRICK@"
	; Text_JP "ヤスヒロ"8
	OT_ID 00000, 00000

	Intro_EN WHAT,COLOR,DO,I,LIKE,_QU
	Win_EN   WASN_T,IT,_A,GOOD,COLOR,_QU
	Loss_EN  I,WILL,ALWAYS,LIKE,MY,COLOR

	Intro_JP $0a3a, $1228, $0408, $164c, $1005, $ffff
	Win_JP $0c1a, $0c06, $1e0b, $0408, $1405, $1021
	Loss_JP $0a3a, $1228, $0408, $0408, $1603, $0c06

	Pokemon XATU
	Holds CHESTO_BERRY
	Moves PSYCHIC, CONFUSE_RAY, REST, NIGHT_SHADE
	Level 50
	PP_Ups 0,0,0,0
	EVs 6,0,0,252,252,0
	OT_ID 00000, 00000
	IVs 31,15,15,31,15,15, XATU_SYNCHRONIZE
	PV $0000000F ; ♀ Modest
	db "XATU@      "
	; Text_JP "ネイティオ"11
	Friendship 255

	Pokemon LUDICOLO
	Holds LEFTOVERS
	Moves DIVE, LEECH_SEED, TOXIC, PROTECT
	Level 52
	PP_Ups 0,0,0,0
	EVs 252,0,252,0,0,6
	OT_ID 00000, 00000
	IVs 31,15,31,15,15,15, LUDICOLO_SWIFT_SWIM
	PV $00000014 ; ♀ Calm
	db "LUDICOLO@  "
	; Text_JP "ルンパッパ"11
	Friendship 255

	Pokemon FLYGON
	Holds DRAGON_FANG
	Moves EARTHQUAKE, DRAGON_CLAW, CRUNCH, FLAMETHROWER
	Level 54
	PP_Ups 0,0,0,0
	EVs 0,6,0,252,252,0
	OT_ID 00000, 00000
	IVs 15,15,15,31,31,15, FLYGON_LEVITATE
	PV $00000090 ; ♂ Rash
	db "FLYGON@    "
	; Text_JP "フライゴン"11
	Friendship 255

	End_Trainer

        ds 44 ; Pad to 256

POPC
