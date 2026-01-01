SECTION "payload/battle/hozumi", ROM0
INCLUDE "include/trainer.asm"

DataPacket::
	Battle_Trainer

	BT_Level 50
	Class BATTLE_GIRL
	BT_Floor 5
	Text_EN "LULU"8
	Text_JP "ホヅミ"8
	OT_ID 00000, 00000

	Intro_JP $1421, $063e, $0c05, $161a, $1042, $0c01
	Win_JP $040b, $2444, $0c05, $1e0d, $1017, $ffff
	Loss_JP $0e2f, $2444, $0c05, $161a, $164a, $0c04

	Intro_EN LOOK, AT, MY, AWESOME, STRATEGY, _EX_EX
	Win_EN THAT_S, THE, BEAUTY, OF, THE, _COUNTER, _EX
	Loss_EN MY, _COUNTER, ATTACK, DIDN_T, WORK, _ELIP

	Pokemon VIGOROTH
	Holds FOCUS_BAND
	Moves SLASH, ENCORE, TAUNT, COUNTER
	Level 50
	PP_Ups 0,0,0,0
	EVs 6,0,252,0,0,252
	OT_ID 00000, 00000
	IVs 15,15,31,15,15,31, 0
	PV $000000E9
	Text_EN "VIGOROTH"11
	Text_JP "ヤルキモノ"11
	Friendship 255

	Pokemon ZANGOOSE
	Holds SCOPE_LENS
	Moves CRUSH_CLAW, BRICK_BREAK, SHADOW_BALL, COUNTER
	Level 50
	PP_Ups 0,0,0,0
	EVs 0,6,252,0,0,252
	OT_ID 00000, 00000
	IVs 15,15,31,15,15,31, 0
	PV $0000001C
	Text_EN "ZANGOOSE"11
	Text_JP "ザングース"11
	Friendship 255

	Pokemon HERACROSS
	Holds LUM_BERRY
	Moves MEGAHORN, EARTHQUAKE, ROCK_TOMB, COUNTER
	Level 50
	PP_Ups 0,0,0,0
	EVs 0,252,252,0,0,6
	OT_ID 00000, 00000
	IVs 15,31,31,15,15,15, 0
	PV $000000E4
	Text_EN "HERACROSS"11
	Text_JP "ヘラクロス"11
	Friendship 255

	End_Trainer

        ds 44 ; Pad to 256
