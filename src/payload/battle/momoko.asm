SECTION "payload/battle/momoko", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Battle_Trainer

	BT_Level 0
	db PKMN_BREEDER_F
	BT_Floor 0
	db "MOMOKO@ "
	; Text_JP "モモコ"8
	OT_ID 00000, 00000

	Intro_EN MY, POKEMON, HAVE, VERY, THICK_FAT, _EX	
	Win_EN MY, POKEMON, DON_T, NEED, TO, DIET	
	Loss_EN MAYBE, MY, POKEMON, SHOULD, DIET, _QU

	Intro_JP $1c1b, $0204, $0c01, $020e, $1643, $1032
	Win_JP $0204, $1628, $0e1d, $1423, $1015, $0c01
	Loss_JP $0204, $1e11, $0e0a, $244a, $201e, $1018

	Pokemon GYARADOS
	Holds CHESTO_BERRY
	Moves SURF, DRAGON_DANCE, REST, HIDDEN_POWER
	Level 97
	PP_Ups 0,0,0,0
	EVs 252,0,6,0,0,252
	OT_ID 00000, 00000
	IVs 31,14,15,14,14,30, 0
	PV $00000085
	db "GYARADOS@  "
	; Text_JP "ギャラドス"11
	Friendship 255

	Pokemon SWAMPERT
	Holds SHELL_BELL
	Moves SURF, ICE_BEAM, EARTHQUAKE, PROTECT
	Level 98
	PP_Ups 0,0,0,0
	EVs 252,252,0,0,0,6
	OT_ID 00000, 00000
	IVs 31,31,15,15,15,15, 0
	PV $00000083
	db "SWAMPERT@  "
	; Text_JP "ラグラージ"11
	Friendship 255

	Pokemon DUSCLOPS
	Holds LEFTOVERS
	Moves ICE_BEAM, PSYCHIC, SHADOW_BALL, EARTHQUAKE
	Level 99
	PP_Ups 0,0,0,0
	EVs 252,0,252,0,0,6
	OT_ID 00000, 00000
	IVs 31,15,31,15,15,15, 0
	PV $0000001B
	db "DUSCLOPS@  "
	; Text_JP "サマヨール"11
	Friendship 255

	End_Trainer

        ds 44 ; Pad to 256

POPC
