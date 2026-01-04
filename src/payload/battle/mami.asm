SECTION "payload/battle/mami", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Battle_Trainer

	BT_Level 50
	db PKMN_BREEDER_F
	BT_Floor 5
	db "JANI@   "
	; Text_JP "マミ"8
	OT_ID 00000, 00000

	Intro_EN IT_S, NOT, JUST, ABOUT, BEAUTY, _EX	
	Win_EN _A, POKEMON, BATTLE, IS, EXCITING, HUH_	
	Loss_EN I, WILL, TRAIN, _AND, GET, BETTER

	Intro_JP $040c, $0e16, $100b, $142f, $1044, $ffff
	Win_JP $0c32, $1032, $0c03, $0a3d, $0620, $1021
	Loss_JP $040b, $0c06, $0e1f, $062e, $1004, $0c06

	Pokemon GARDEVOIR
	Holds SITRUS_BERRY
	Moves PSYCHIC, THUNDERBOLT, WILL_O_WISP, CALM_MIND
	Level 50
	PP_Ups 0,0,0,0
	EVs 6,0,0,252,252,0
	OT_ID 00000, 00000
	IVs 15,15,15,31,31,15, 0
	PV $0000000F
	db "GARDEVOIR@ "
	; Text_JP "サーナイト"11
	Friendship 255

	Pokemon NINETALES
	Holds LUM_BERRY
	Moves FLAMETHROWER, CONFUSE_RAY, SAFEGUARD, GRUDGE
	Level 50
	PP_Ups 0,0,0,0
	EVs 6,0,0,252,252,0
	OT_ID 00000, 00000
	IVs 31,15,15,15,31,15, 0
	PV $0000000F
	db "NINETALES@ "
	; Text_JP "キュウコン"11
	Friendship 255

	Pokemon MILOTIC
	Holds LEFTOVERS
	Moves TOXIC, DIVE, PROTECT, RECOVER
	Level 50
	PP_Ups 0,0,0,0
	EVs 252,0,252,0,0,6
	OT_ID 00000, 00000
	IVs 31,15,31,15,15,15, 0
	PV $0000000F
	db "MILOTIC@   "
	; Text_JP "ミロカロス"11
	Friendship 255

	End_Trainer

        ds 44 ; Pad to 256

POPC
