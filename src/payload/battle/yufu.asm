SECTION "payload/battle/yufu", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Battle_Trainer

	BT_Level 100
	Class COOLTRAINER_F
	BT_Floor 5
	db "ADELE@  "
	; Text_JP "ユフ"8
	OT_ID 00000, 00000

	Intro_JP $0e0e, $0a02, $0c01, $0603, $161a, $102a
	Win_JP $1e10, $0e0c, $100b, $201e, $103e, $ffff
	Loss_JP $0c0e, $0c01, $0a46, $0603, $122d, $1239

	Intro_EN HEY, YOU, _EX_EX, GET, READY, _EX_EX
	Win_EN LOOKS, LIKE, YOU, WEREN_T, READY, _EX
	Loss_EN URGH, _EX_EX, SEEMS, I, WASN_T, READY

	Pokemon GARDEVOIR
	Holds BRIGHTPOWDER
	Moves PSYCHIC, THUNDERBOLT, LIGHT_SCREEN, SHADOW_BALL
	Level 100
	PP_Ups 0,0,0,0
	EVs 6,0,0,252,252,0
	OT_ID 00000, 00000
	IVs 20,20,20,31,31,20, 0
	PV $0000000F
	db "GARDEVOIR@ "
	; Text_JP "サーナイト"11
	Friendship 255

	Pokemon HERACROSS
	Holds KING_S_ROCK
	Moves MEGAHORN, COUNTER, BRICK_BREAK, REVERSAL
	Level 100
	PP_Ups 0,0,0,0
	EVs 6,252,0,252,0,0
	OT_ID 00000, 00000
	IVs 20,31,20,31,20,20, 1
	PV $0000008A
	db "HERACROSS@ "
	; Text_JP "ヘラクロス"11
	Friendship 255

	Pokemon SALAMENCE
	Holds LUM_BERRY
	Moves DRAGON_CLAW, FLAMETHROWER, EARTHQUAKE, PROTECT
	Level 100
	PP_Ups 0,0,0,0
	EVs 0,6,0,252,252,0
	OT_ID 00000, 00000
	IVs 20,20,20,31,31,20, 0
	PV $0000008B
	db "SALAMENCE@ "
	; Text_JP "ボーマンダ"11
	Friendship 255

	End_Trainer

        ds 44 ; Pad to 256

POPC
