SECTION "payload/battle/toshitsugu", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Battle_Trainer

	BT_Level 0
	db RUIN_MANIAC
	BT_Floor 0
	db "COSMO@  "
	; Text_JP "トシツグ"8
	OT_ID 00000, 00000

	Intro_EN I, DREAM, OF, THE, OLDEN, DAYS
	Win_EN OLDEN, DAY, LIFE, SEEMS, ROMANTIC, _EX
	Loss_EN GOOD_BYE, DREAM, OF, OLDEN, DAYS, _ELIP

	Intro_JP $0c1c, $1c26, $1034, $1241, $140c, $100b
	Win_JP $1c26, $1034, $1813, $0e28, $1241, $140c
	Loss_JP $0810, $0c04, $1c26, $1034, $1827, $0c04

	Pokemon RELICANTH
	Holds SEA_INCENSE
	Moves SURF, ROCK_SLIDE, YAWN, SAFEGUARD
	Level 55
	PP_Ups 0,0,0,0
	EVs 255,255,0,0,0,0
	OT_ID 00000, 00000
	IVs 31,31,15,15,15,15, 0
	PV $000000D4
	db "RELICANTH@ "
	; Text_JP "ジーランス"11
	Friendship 255

	Pokemon ARMALDO
	Holds SCOPE_LENS
	Moves SLASH, ROCK_SLIDE, EARTHQUAKE, IRON_TAIL
	Level 54
	PP_Ups 0,0,0,0
	EVs 0,255,0,0,0,255
	OT_ID 00000, 00000
	IVs 15,31,15,15,15,31, 0
	PV $0000001C
	db "ARMALDO@   "
	; Text_JP "アーマルド"11
	Friendship 255

	Pokemon CRADILY
	Holds LEFTOVERS
	Moves GIGA_DRAIN, ANCIENTPOWER, AMNESIA, RECOVER
	Level 58
	PP_Ups 0,0,0,0
	EVs 0,0,255,0,0,255
	OT_ID 00008, 00000
	IVs 15,15,31,15,15,31, 0
	PV $00000007
	db "CRADILY@   "
	; Text_JP "ユレイドル"11
	Friendship 255

	End_Trainer

        ds 44 ; Pad to 256

POPC
