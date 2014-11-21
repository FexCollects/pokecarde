INCLUDE "macros.asm"

	BT_Level MOSSDEEP
	db POKEFAN_F
	BT_Floor MOSSDEEP
	OT_Name "ALANA"
	OT_ID 00000, 00000

	Introduction LET_S,START,THIS,_ELIP,BATTLE,_EX
	After_Win    OH_,DID,I,_ELIP,WIN,_QU
	After_Loss   OH_,DID,I,_ELIP,LOSE,_QU

	Pokemon TORKOAL
	Holds QUICK_CLAW
	Moves OVERHEAT, BODY_SLAM, FLAIL, YAWN
	Level 82
	PP_Ups 0,0,0,0
	EVs 0,0,0,0,255,255
	OT_ID 00000, 00000
	IVs 15,15,15,15,31,31, TORKOAL_WHITE_SMOKE
	PV $000000D9 ; ♂ Quiet
	Nickname "TORKOAL"
	Friendship 255

	Pokemon DUSCLOPS
	dw CHESTO_BERRY
	Moves CONFUSE_RAY, WILL_O_WISP, TOXIC, REST
	Level 80
	PP_Ups 0,0,0,0
	EVs 0,0,255,0,0,255
	OT_ID 00000, 00000
	IVs 15,15,31,15,15,31, DUSCLOPS_PRESSURE
	PV $00000016 ; ♀ Sassy
	Nickname "DUSCLOPS"
	Friendship 255

	Pokemon CORSOLA
	dw MYSTIC_WATER
	Moves SURF, ROCK_TOMB, MIRROR_COAT, RECOVER
	Level 85
	PP_Ups 0,0,0,0
	EVs 0,0,0,0,255,255
	OT_ID 00000, 00000
	IVs 15,15,15,15,31,31, CORSOLA_NATURAL_CURE
	PV $0000001B ; ♀ Brave
	Nickname "CORSOLA"
	Friendship 255