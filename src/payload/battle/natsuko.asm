SECTION "payload/battle/natsuko", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Battle_Trainer

	BT_Level 0
	db TRIATHLETE_F_SWIM
	BT_Floor 0
	db "AUTUMN@ "
	; Text_JP "ナツコ"8
	OT_ID 00000, 00000

	Intro_EN ALWAYS, DIVE, WITH, GOOD, SPIRIT, _EX	
	Win_EN YOU, CAN, SEE, A_LOT, OF, POKEMON
	Loss_EN IT, WAS, _A, RARE, COLOR, _ELIP

	Intro_JP $2723, $1628, $0e29, $141b, $0e0b, $1225
	Win_JP $2723, $1621, $ffff, $0408, $0408, $020f
	Loss_JP $123a, $0408, $1014, $1034, $0c06, $121b

	Pokemon LANTURN
	Holds MYSTIC_WATER
	Moves CONFUSE_RAY, SURF, THUNDERBOLT, TAKE_DOWN
	Level 70
	PP_Ups 0,0,0,0
	EVs 252,0,6,0,252,0
	OT_ID 00000, 00000
	IVs 31,15,15,15,31,15, 0
	PV $0000000F
	db "LANTURN@   "
	; Text_JP "ランターン"11
	Friendship 255

	Pokemon HUNTAIL
	Holds MYSTIC_WATER
	Moves CONFUSE_RAY, CRUNCH, SURF, MUD_SPORT
	Level 72
	PP_Ups 0,0,0,0
	EVs 252,0,0,0,252,6
	OT_ID 00000, 00000
	IVs 31,15,15,15,31,15, 0
	PV $00000095
	db "HUNTAIL@   "
	; Text_JP "ハンテール"11
	Friendship 255

	Pokemon RELICANTH
	Holds LEFTOVERS
	Moves SURF, ROCK_SLIDE, EARTHQUAKE, ROCK_TOMB
	Level 74
	PP_Ups 0,0,0,0
	EVs 252,0,6,0,0,252
	OT_ID 00008, 00000
	IVs 31,15,31,15,15,31, 0
	PV $00000080
	db "RELICANTH@ "
	; Text_JP "ジーランス"11
	Friendship 255

	End_Trainer

        ds 44 ; Pad to 256

POPC
