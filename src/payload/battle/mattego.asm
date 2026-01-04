SECTION "payload/battle/mattego", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Battle_Trainer

	BT_Level 100
	Class COOLTRAINER_M
	BT_Floor 5
	db "MATTEGO@"
	; Text_JP "カノウ"8
	OT_ID 00000, 00000

	Intro_JP $1e0b, $020e, $0a3d, $1646, $140f, $1005
	Win_JP $2010, $020e, $0202, $100d, $100e, $ffff
	Loss_JP $0e38, $1606, $1010, $020e, $0630, $121f

	Intro_EN DO, YOU, HAVE, THESE, POKEMON, _QU
	Win_EN LET_S, TRADE, MY, POKEMON, WITH, YOURS
	Loss_EN IT_S, HARD, TO, COLLECT, ALL, POKEMON

	Pokemon SCEPTILE
	Holds MIRACLE_SEED
	Moves LEAF_BLADE, DRAGON_CLAW, LEECH_SEED, DETECT
	Level 100
	PP_Ups 0,0,0,0
	EVs 6,0,0,252,252,0
	OT_ID 00000, 00000
	IVs 20,20,20,31,31,20, 0
	PV $0000000F
	db "SCEPTILE@  "
	; Text_JP "ジュカイン"11
	Friendship 255

	Pokemon BLAZIKEN
	Holds CHARCOAL
	Moves BLAZE_KICK, ENDURE, REVERSAL, EARTHQUAKE
	Level 100
	PP_Ups 0,0,0,0
	EVs 0,252,0,252,6,0
	OT_ID 00000, 00000
	IVs 20,31,20,31,20,20, 0
	PV $000000D5
	db "BLAZIKEN@  "
	; Text_JP "バシャーモ"11
	Friendship 255

	Pokemon SWAMPERT
	Holds MYSTIC_WATER
	Moves MUDDY_WATER, EARTHQUAKE, ICE_BEAM, BRICK_BREAK
	Level 100
	PP_Ups 0,0,0,0
	EVs 0,0,252,0,252,6
	OT_ID 00000, 00000
	IVs 20,20,31,20,31,20, 0
	PV $000000E1
	db "SWAMPERT@  "
	; Text_JP "ラグラージ"11
	Friendship 255

	End_Trainer

        ds 44 ; Pad to 256

POPC
