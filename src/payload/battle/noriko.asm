SECTION "payload/battle/noriko", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Battle_Trainer

	BT_Level 0
	db BATTLE_GIRL
	BT_Floor 0
	db "NATALIE@"
	; Text_JP "ノリコ"8
	OT_ID 00000, 00000

	Intro_EN HOW, ABOUT, _A, POKEMON, BATTLE, _QU_EX	
	Win_EN I, WON, ALTHOUGH, I_AM, YOUNG, _EX	
	Loss_EN I_AM, WORKING, HARD, TO, GET, BETTER

	Intro_JP $1e10, $0c1c, $1618, $244a, $1e11, $1044
	Win_JP $0c32, $0a48, $020e, $0e12, $1413, $1021
	Loss_JP $0e36, $1413, $020e, $1034, $1a32, $1020

	Pokemon GYARADOS
	Holds CHESTO_BERRY
	Moves HYPER_BEAM, DRAGON_DANCE, EARTHQUAKE, REST
	Level 92
	PP_Ups 0,0,0,0
	EVs 0,255,0,255,0,0
	OT_ID 00000, 00000
	IVs 15,31,31,15,15,15, 0
	PV $000000E4
	db "GYARADOS@  "
	; Text_JP "ギャラドス"11
	Friendship 255

	Pokemon AGGRON
	Holds BRIGHTPOWDER
	Moves HYPER_BEAM, AERIAL_ACE, EARTHQUAKE, ROCK_TOMB
	Level 94
	PP_Ups 0,0,0,0
	EVs 0,255,0,0,0,255
	OT_ID 00000, 00000
	IVs 15,31,15,15,15,31, 0
	PV $000000E4
	db "AGGRON@    "
	; Text_JP "ボスゴドラ"11
	Friendship 255

	Pokemon SALAMENCE
	Holds KING_S_ROCK
	Moves HYPER_BEAM, DRAGON_CLAW, EARTHQUAKE, CRUNCH
	Level 96
	PP_Ups 0,0,0,0
	EVs 0,255,0,0,255,0
	OT_ID 00000, 00000
	IVs 15,31,15,31,15,15, 0
	PV $0000001C
	db "SALAMENCE@ "
	; Text_JP "ボーマンダ"11
	Friendship 255

	End_Trainer

        ds 44 ; Pad to 256

POPC
