SECTION "payload/battle/astrid", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Battle_Trainer

	BT_Level 50
	Class LADY
	BT_Floor 0
	db "ASTRID@ "
	OT_ID 00000, 00000

	Intro_EN TALKING,ABOUT,MY,CUTE,POKEMON,_QU
	Win_EN   YOUR,POKEMON,IS,_ELIP,CUTE,TOO
	Loss_EN  OH_,WASN_T,MY,POKEMON,CUTE,_QU

	Pokemon MAWILE
	Holds SITRUS_BERRY
	Moves IRON_DEFENSE, BITE, VICEGRIP, FAKE_TEARS
	Level 50
	PP_Ups 0,0,0,0
	EVs 255,0,255,0,0,0
	OT_ID 00000, 00000
	IVs 15,15,15,15,15,15, MAWILE_INTIMIDATE
	PV $0000001F ; ♀ Docile
	db "MAWILE@    "
	Friendship 255

	Pokemon MINUN
	Holds MAGNET
	Moves CHARM, SPARK, QUICK_ATTACK, ENCORE
	Level 50
	PP_Ups 0,0,0,0
	EVs 0,0,0,255,255,0
	OT_ID 00000, 00000
	IVs 15,15,15,15,15,15, MINUN_MINUS
	PV $000000D7 ; ♂ Modest
	db "MINUN@     "
	Friendship 255

	Pokemon SHIFTRY
	Holds LEFTOVERS
	Moves SUNNY_DAY, SOLARBEAM, SWAGGER, FAINT_ATTACK
	Level 50
	PP_Ups 0,0,0,0
	EVs 170,0,0,170,170,0
	OT_ID 00000, 00000
	IVs 15,15,15,15,15,15, SHIFTRY_EARLY_BIRD
	PV $000000D2 ; ♂ Timid
	db "SHIFTRY@   "
	Friendship 255

	End_Trainer

        ds 44 ; Pad to 256

POPC
