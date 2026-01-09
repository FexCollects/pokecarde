DEF Pokemon EQUS "dw"
DEF Holds EQUS "dw"
DEF Moves EQUS "dw"
DEF Level EQUS "db"
DEF Experience EQUS "dl"
MACRO PP_Ups
    db (\1) + (\2 << 2) + (\3 << 4) + (\4 << 6)
    ENDM
DEF EVs EQUS "db"
DEF OT_ID EQUS "dw"
MACRO IVs
    dw \1 + (\2 << 5) + (\3 << 10) + ((\4 & 1) << 15)
    dw (\4 >> 1) + (\5 << 4) + (\6 << 9) + (\7 << 15)
    ENDM
MACRO PV
    dw (\1 & $FFFF), (\1 >> 16)
    ENDM
DEF Friendship EQUS "db"
DEF Pokeball EQUS "dw"
DEF Language EQUS "dw"
DEF Markings EQUS "db"
DEF PP EQUS "db"
DEF Condition EQUS "db"
DEF PokerusStatus EQUS "db"
DEF MetLocation EQUS "db"
MACRO Origins
    dw \1 + (\2 << 7) + (\3 << 11) + (\4 << 15)
    ENDM
DEF Ribbons EQUS "dl"
MACRO Ability
    dl (\1 << 28)
    ENDM
MACRO End_GiftPokemon
    db $01,$00,$02,$00,$03,$00,$04,$00,$05,$00,$06,$00,$07,$00,$08,$00,$09,$00,$BF,$C8,$C1,$C6,$C3,$CD,$C2,$FF,$0F,$27,$00,$00,$4A,$75,$82,$00,$00,$03
    ENDM

MACRO End_GiftEgg
    db $00,$31,$00,$03,$49,$6A,$00,$03,$30,$06,$00,$00,$00,$31,$00,$03,$DF,$8F,$00,$08,$F0,$17,$00,$03,$A3,$07,$00,$08,$17,$00,$00,$00,$8C,$1D,$00,$03
    ENDM
