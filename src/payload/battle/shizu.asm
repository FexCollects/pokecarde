SECTION "payload/battle/shizu", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Battle_Trainer

	BT_Level 50
	db COOLTRAINER_F
	BT_Floor 19
	db "KRISTEN@"
	; Text_JP "シズ"8
	OT_ID 00000, 00000

	Intro_EN FUFUFU, _ELIP_EX, LOOK, AT, MY, MOVE	
	Win_EN ANY, TYPE, OF, MOVE, WORKS, _EX	
	Loss_EN HUH_, MY, ATTACK, DIDN_T, WORK, _QU

	Intro_JP $0c13, $0c04, $063e, $140c, $1642, $1602
	Win_JP $1e21, $0432, $1034, $063e, $0e1f, $0e2a
	Loss_JP $0c0c, $1234, $0c00, $063e, $062e, $1024

	Pokemon STARMIE
	Holds SCOPE_LENS
	Moves PSYCHIC, SURF, ICE_BEAM, THUNDERBOLT
	Level 50
	PP_Ups 0,0,0,0
	EVs 6,0,0,252,252,0
	OT_ID 00000, 00000
	IVs 15,15,15,31,31,15, 1
	PV $0000000F
	db "STARMIE@   "
	; Text_JP "スターミー"11
	Friendship 255

	Pokemon BRELOOM
	Holds BRIGHTPOWDER
	Moves FOCUS_PUNCH, SLUDGE_BOMB, IRON_TAIL, SPORE
	Level 50
	PP_Ups 0,0,0,0
	EVs 6,252,0,252,0,0
	OT_ID 00000, 00000
	IVs 15,31,15,31,15,15, 0
	PV $0000008A
	db "BRELOOM@   "
	; Text_JP "キノガッサ"11
	Friendship 255

	Pokemon SLAKING
	Holds LEFTOVERS
	Moves HYPER_BEAM, SHADOW_BALL, EARTHQUAKE, AERIAL_ACE
	Level 50
	PP_Ups 0,0,0,0
	EVs 252,252,0,6,0,0
	OT_ID 00000, 00000
	IVs 31,31,15,15,15,15, 0
	PV $0000000D
	db "SLAKING@   "
	; Text_JP "ケッキング"11
	Friendship 255

	End_Trainer

        ds 44 ; Pad to 256

POPC
