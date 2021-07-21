INCLUDE "trainers/macros.asm"

	Battle_Trainer

	BT_Level 50
	db NINJA_BOY
	BT_Floor 5
	Text_EN "RUIZO"8
	Text_JP "ルイゾウ"8
	OT_ID 00000, 00000

	Intro_EN $2805, $0c00, $ffff, $180f, $1621, $1037
	Win_EN $0632, $162d, $1022, $2732, $1422, $0c00
	Loss_EN $0c09, $0c06, $ffff, $120d, $2732, $0c04

	Intro_JP $2805, $0c00, $ffff, $180f, $1621, $1037
	Win_JP $0632, $162d, $1022, $2732, $1422, $0c00
	Loss_JP $0c09, $0c06, $ffff, $120d, $2732, $0c04

	Pokemon SANDSLASH
	Holds QUICK_CLAW
	Moves CRUSH_CLAW, ROCK_TOMB, ATTRACT, SWORDS_DANCE
	Level 50
	PP_Ups 0,0,0,0
	EVs 0,252,0,6,0,252
	OT_ID 00000, 00000
	IVs 15,31,15,15,15,31, 0
	PV $0000001C
	Text_EN "SANDSLASH"11
	Text_JP "サンドパン"11
	Friendship 255

	Pokemon VIGOROTH
	Holds SCOPE_LENS
	Moves CRUSH_CLAW, BRICK_BREAK, BULK_UP, COUNTER
	Level 50
	PP_Ups 0,0,0,0
	EVs 6,252,0,252,0,0
	OT_ID 00000, 00000
	IVs 15,31,15,31,15,15, 0
	PV $000000E4
	Text_EN "VIGOROTH"11
	Text_JP "ヤルキモノ"11
	Friendship 255

	Pokemon ZANGOOSE
	Holds FOCUS_BAND
	Moves CRUSH_CLAW, AERIAL_ACE, SWORDS_DANCE, FLAIL
	Level 50
	PP_Ups 0,0,0,0
	EVs 6,252,0,252,0,0
	OT_ID 00000, 00000
	IVs 15,31,15,31,15,15, 0
	PV $000000E4
	Text_EN "ZANGOOSE"11
	Text_JP "ザングース"11
	Friendship 255

	End_Trainer