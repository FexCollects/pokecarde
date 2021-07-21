INCLUDE "trainers/macros.asm"

	Battle_Trainer

	BT_Level 0
	db GUITARIST
	BT_Floor 0
	Text_EN "DAIKI"8
	Text_JP "ダイキチ"8
	OT_ID 00000, 00000

	Intro_ $0a14, $1034, $020e, $2017, $242c, $100e
	Win_EN $0801, $0c00, $ffff, $2017, $0607, $100e
	Loss_EN $0811, $0c00, $ffff, $1400, $0628, $1014

	Intro_JP $0a14, $1034, $020e, $2017, $242c, $100e
	Win_JP $0801, $0c00, $ffff, $2017, $0607, $100e
	Loss_JP $0811, $0c00, $ffff, $1400, $0628, $1014

	Pokemon SEVIPER
	Holds BLACKGLASSES
	Moves CRUNCH, HAZE, DOUBLE_TEAM, GLARE
	Level 70
	PP_Ups 0,0,0,0
	EVs 252,0,6,0,252,0
	OT_ID 00000, 00000
	IVs 31,15,15,15,31,15, 0
	PV $0000008C
	Text_EN "SEVIPER"11
	Text_JP "ハブネーク"11
	Friendship 255

	Pokemon SHARPEDO
	Holds BLACKGLASSES
	Moves CRUNCH, SLASH, SURF, SWAGGER
	Level 71
	PP_Ups 0,0,0,0
	EVs 252,0,0,6,252,0
	OT_ID 00000, 00000
	IVs 31,15,15,15,31,15, 0
	PV $0000000F
	Text_EN "SHARPEDO"11
	Text_JP "サメハダー"11
	Friendship 255

	Pokemon GIRAFARIG
	Holds BLACKGLASSES
	Moves CRUNCH, DOUBLE_TEAM, REST, CALM_MIND
	Level 72
	PP_Ups 0,0,0,0
	EVs 252,0,0,252,6,0
	OT_ID 00000, 00000
	IVs 31,15,15,31,15,15, 0
	PV $0000000F
	Text_EN "GIRAFARIG"11
	Text_JP "キリンリキ"11
	Friendship 255

	End_Trainer