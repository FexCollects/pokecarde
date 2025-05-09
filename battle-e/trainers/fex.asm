INCLUDE "trainers/macros.asm"

	Battle_Trainer

	BT_Level MOSSDEEP
	Class COLLECTOR
	BT_Floor MOSSDEEP
        Text_EN "FEX"8
	OT_ID 00000, 00000

        Intro_EN LET_S,COLLECT,SHINE,POKEMON,TOGETHER,_EX
	Win_EN   _SPARK,BANG,_FLASH,WOW,EXCELLENT,POKEMON
	Loss_EN HUH_, BUT, WEIRD, COLOR, POKEMON, _QU_EX 

        Pokemon CORSOLA
        Holds SITRUS_BERRY
        Moves CALM_MIND, SURF, RECOVER, ICE_BEAM
        Level 100
        PP_Ups 0,0,2,2
        EVs 252,0,252,0,4,0
        OT_ID 00000, 00000
        IVs 31,31,31,31,31,31, CORSOLA_NATURAL_CURE
        PV SHINY_BOLD_MALE
        Text_EN "CORSOLA"11
        Friendship 255

	Pokemon ALTARIA
	Holds SHELL_BELL
	Moves TOXIC, FLAMETHROWER, HAZE, REST
	Level 100
	PP_Ups 0,3,0,2
	EVs 248,0,44,0,0,216
	OT_ID 00000, 00000
        IVs 31,31,31,31,31,31, ALTARIA_NATURAL_CURE
	PV SHINY_CALM_FEMALE
	Text_EN "ALTARIA"11
	Friendship 255

	Pokemon GRUMPIG
	Holds LEFTOVERS
	Moves CALM_MIND, PSYCHIC, ICE_PUNCH, SUBSTITUTE
	Level 100
	PP_Ups 0,0,0,0
	EVs 200,0,0,220,0,88
	OT_ID 00000, 00000
        IVs 31,31,31,31,31,31, GRUMPIG_THICK_FAT
	PV SHINY_MODEST_MALE
	Text_EN "GRUMPIG"11
	Friendship 255

	End_Trainer
