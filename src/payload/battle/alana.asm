SECTION "payload/battle/alana", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Battle_Trainer

	BT_Level MOSSDEEP
	Class POKEFAN_F
	BT_Floor MOSSDEEP
	db "ALANA@  "
	; Text_JP "チズ"8
	OT_ID 00000, 00000

	Intro_EN LET_S,START,THIS,_ELIP,BATTLE,_EX
	Win_EN   OH_,DID,I,_ELIP,WIN,_QU
	Loss_EN  OH_,DID,I,_ELIP,LOSE,_QU

	Intro_JP $0e0e, $0c06, $0c06, $061c, $0c06, $1005
	Win_JP $0c0c, $0c06, $0c06, $0607, $0c03, $ffff
	Loss_JP $0c0c, $0c06, $0c06, $062e, $0c03, $ffff

	Pokemon TORKOAL
	Holds QUICK_CLAW
	Moves OVERHEAT, BODY_SLAM, FLAIL, YAWN
	Level 82
	PP_Ups 0,0,0,0
	EVs 0,0,0,0,255,255
	OT_ID 00000, 00000
	IVs 15,15,15,15,31,31, TORKOAL_WHITE_SMOKE
	PV $000000D9 ; ♂ Quiet
	db "TORKOAL@   "
	; Text_JP "コータス"11
	Friendship 255

	Pokemon DUSCLOPS
	Holds CHESTO_BERRY
	Moves CONFUSE_RAY, WILL_O_WISP, TOXIC, REST
	Level 80
	PP_Ups 0,0,0,0
	EVs 0,0,255,0,0,255
	OT_ID 00000, 00000
	IVs 15,15,31,15,15,31, DUSCLOPS_PRESSURE
	PV $00000016 ; ♀ Sassy
	db "DUSCLOPS@  "
	; Text_JP "サマヨール"11
	Friendship 255

	Pokemon CORSOLA
	Holds MYSTIC_WATER
	Moves SURF, ROCK_TOMB, MIRROR_COAT, RECOVER
	Level 85
	PP_Ups 0,0,0,0
	EVs 0,0,0,0,255,255
	OT_ID 00000, 00000
	IVs 15,15,15,15,31,31, CORSOLA_NATURAL_CURE
	PV $0000001B ; ♀ Brave
	db "CORSOLA@   "
	; Text_JP "サニーゴ"11
	Friendship 255

	End_Trainer

        ds 44 ; Pad to 256

POPC
