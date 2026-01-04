SECTION "payload/battle/candice", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Battle_Trainer

	BT_Level MOSSDEEP
	Class PKMN_BREEDER_F
	BT_Floor MOSSDEEP
	db "CANDICE@"
	; Text_JP "モモコ"8
	OT_ID 00000, 00000

	Intro_EN WE,ARE,READY,_FOR,MORE,_GROWTH
	Win_EN   WE,WILL,TRY,MORE,_FOR,_GROWTH
	Loss_EN  SORRY,PARTNER,I,WILL,_HARDEN,MYSELF

	Intro_JP $120f, $1c25, $244a, $1621, $140f, $1034
	Win_JP $0a45, $0e36, $120f, $244a, $1628, $0c3d
	Loss_JP $080d, $0a3d, $0e36, $244a, $1628, $0e08

	Pokemon MAGIKARP
	Holds SILK_SCARF
	Moves TACKLE, SPLASH, FLAIL, 0
	Level 50
	PP_Ups 0,0,0,0
	EVs 0,0,0,0,0,0
	OT_ID 00000, 00000
	IVs 31,14,15,14,14,30, MAGIKARP_SWIFT_SWIM
	PV $00000085 ; ♂ Impish
	db "MAGIKARP@  "
	; Text_JP "コイキング"11
	Friendship 255

	Pokemon MUDKIP
	Holds MYSTIC_WATER
	Moves TACKLE, GROWL, MUD_SLAP, WATER_GUN
	Level 51
	PP_Ups 0,0,0,0
	EVs 0,0,0,0,0,0
	OT_ID 00000, 00000
	IVs 31,31,15,15,15,15, MUDKIP_TORRENT
	PV $00000083 ; ♂ Docile
	db "MUDKIP@    "
	; Text_JP "ミズゴロウ"11
	Friendship 255

	Pokemon DUSKULL
	Holds SPELL_TAG
	Moves LEER, NIGHT_SHADE, DISABLE, FORESIGHT
	Level 52
	PP_Ups 0,0,0,0
	EVs 0,0,0,0,0,0
	OT_ID 00000, 00000
	IVs 31,15,31,15,15,15, DUSKULL_LEVITATE
	PV $0000001B ; ♀ Brave
	db "DUSKULL@   "
	; Text_JP "ヨマワル"11
	Friendship 255

	End_Trainer


        ds 44 ; Pad to 256

POPC
