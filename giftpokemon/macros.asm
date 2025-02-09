INCLUDE "../macros.asm"
INCLUDE "../constants/abilities.asm"
INCLUDE "../constants/easychat.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/moves.asm"
INCLUDE "../constants/natures.asm"
INCLUDE "../constants/pokemon.asm"
INCLUDE "../constants/trainerclasses.asm"

MOSSDEEP EQU 0

MACRO Battle_Trainer
	Section "battle",ROM0[$100]
	db $01
	dd $02000000
	db REGION,0,REGION,0,0,0,$04,0,$80,$01,0,0
	db $0D
	dd $02000018
	db $02,$00
	ENDM

BT_Level EQUS "db"
Class EQUS "db"
BT_Floor EQUS "dw" ; the byte after it is 00, but apparently means something…
MACRO Intro_EN
	IF REGION == REGION_EN
	dw \1, \2, \3, \4, \5, \6
	ENDC
	ENDM
MACRO Win_EN
	IF REGION == REGION_EN
	dw \1, \2, \3, \4, \5, \6
	ENDC
	ENDM
MACRO Loss_EN
	IF REGION == REGION_EN
	dw \1, \2, \3, \4, \5, \6
	ENDC
	ENDM
MACRO Intro_JP
	IF REGION == REGION_JP
	dw \1, \2, \3, \4, \5, \6
	ENDC
	ENDM
MACRO Win_JP
	IF REGION == REGION_JP
	dw \1, \2, \3, \4, \5, \6
	ENDC
	ENDM
MACRO Loss_JP
	IF REGION == REGION_JP
	dw \1, \2, \3, \4, \5, \6
	ENDC
	ENDM
Pokemon EQUS "dw"
Holds EQUS "dw"
Moves EQUS "dw"
Level EQUS "db"
MACRO PP_Ups
	db (\1) + (\2 << 2) + (\3 << 4) + (\4 << 6)
	ENDM
EVs EQUS "db"
OT_ID EQUS "dw"
MACRO IVs
	dw \1 + (\2 << 5) + (\3 << 10) + ((\4 & 1) << 15)
	dw (\4 >> 1) + (\5 << 4) + (\6 << 9) + (\7 << 15)
	ENDM
MACRO PV
	dw (\1 & $FFFF), (\1 >> 16)
	ENDM
Friendship EQUS "db"
Pokeball EQUS "dw"
Language EQUS "dw"
Markings EQUS "db"
PP EQUS "db"
Condition EQUS "db"
PokerusStatus EQUS "db"
MetLocation EQUS "db"
MACRO Origins
	dw \1 + (\2 << 7) + (\3 << 11) + (\4 << 15)
	ENDM
Ribbons EQUS "dd"
MACRO Ability
	dd (\1 << 28)
	ENDM
MACRO End_GiftPokemon
	db $01,$00,$02,$00,$03,$00,$04,$00,$05,$00,$06,$00,$07,$00,$08,$00,$09,$00,$BF,$C8,$C1,$C6,$C3,$CD,$C2,$FF,$0F,$27,$00,$00,$4A,$75,$82,$00,$00,$03
	ENDM

MACRO End_GiftEgg
	db $00,$31,$00,$03,$49,$6A,$00,$03,$30,$06,$00,$00,$00,$31,$00,$03,$DF,$8F,$00,$08,$F0,$17,$00,$03,$A3,$07,$00,$08,$17,$00,$00,$00,$8C,$1D,$00,$03
	ENDM
