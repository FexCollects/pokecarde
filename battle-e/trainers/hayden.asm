INCLUDE "macros.asm"

	BT_Level MOSSDEEP
	db GUITARIST
	BT_Floor MOSSDEEP
	OT_Name "HAYDEN"
	OT_ID 00000, 00000

	Introduction YEAH,_EX,COOL,_EXPLOSION,SONGS,_EX_EX
	After_Win    YEAH,_EX_EX,INCREDIBLE,_EXPLOSION,SONGS,_EX_EX
	After_Loss   NO,_EX,MY,SONGS,AREN_T,POPULAR

	Pokemon ELECTRODE
	Holds MAGNET
	Moves EXPLOSION, MIRROR_COAT, LIGHT_SCREEN, SWIFT
	Level 80
	PP_Ups 0,0,0,0
	EVs 252,6,252,0,0,0
	OT_ID 00000, 00000
	IVs 31,15,15,15,15,15, ELECTRODE_STATIC
	PV $00000080 ; ⚲ Adamant
	Nickname "ELECTRODE"
	Friendship 255

	Pokemon SOLROCK
	Holds HARD_STONE
	Moves EXPLOSION, COSMIC_POWER, ROCK_SLIDE, PSYCHIC
	Level 82
	PP_Ups 0,0,0,0
	EVs 252,0,6,0,0,252
	OT_ID 00000, 00000
	IVs 31,15,15,15,15,31, SOLROCK_LEVITATE
	PV $0000007F ; ⚲ Brave
	Nickname "SOLROCK"
	Friendship 255

	Pokemon SHIFTRY
	Holds FOCUS_BAND
	Moves EXPLOSION, FAINT_ATTACK, PROTECT, TOXIC
	Level 84
	PP_Ups 0,0,0,0
	EVs 252,0,0,252,6,0
	OT_ID 00000, 00000
	IVs 31,15,15,31,15,15, SHIFTRY_EARLY_BIRD
	PV $00000080 ; ♂ Adamant
	Nickname "SHIFTRY"
	Friendship 255