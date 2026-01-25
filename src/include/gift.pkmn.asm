INCLUDE "include/structs.inc"

rgbds_structs_version 4.1.0
def STRUCT_SEPARATOR equs "."

struct BoxPokemon
    longs 1, Personality
    words 1, OTTID
    words 1, OTSID
    bytes 10, Name
    bytes 1, Language
    bytes 1, Flags
    bytes 7, OTName
    bytes 1, Markings
    words 1, Checksum
    words 1, Unknown
; Substruct1
    words 1, Species
    words 1, HeldItem
    longs 1, Experience
    bytes 1, PPUps ; Fill with a macro?
    bytes 1, Friendship
    words 1, Unknown2
; Substruct2
    words 4, Moves
    bytes 4, PP
; Substruct3
    bytes 1, HPEV
    bytes 1, AttackEV
    bytes 1, DefenseEV
    bytes 1, SpeedEV
    bytes 1, SpAttackEV
    bytes 1, SpDefenseEV
    bytes 1, Cool
    bytes 1, Beauty
    bytes 1, Cute
    bytes 1, Smart
    bytes 1, Tough
    bytes 1, Sheen
; Substruct4
    bytes 1, Pokerus
    bytes 1, MetLocation
    words 1, Origins ; TODO: split this
    longs 1, IVs ; TODO: split this
    longs 1, Ribbons
; Party Pokemon?
    longs 1, Status
    bytes 1, Level
    bytes 1, Mail ; or pokerus remaining ?
    words 1, CurrentHP
    words 1, MaxHP
    words 1, Attack
    words 1, Defense
    words 1, Speed
    words 1, SpAttack
    words 1, SpDefense
end_struct

; MACRO PP_Ups
;     db (\1) + (\2 << 2) + (\3 << 4) + (\4 << 6)
;     ENDM
; MACRO IVs
;     dw \1 + (\2 << 5) + (\3 << 10) + ((\4 & 1) << 15)
;     dw (\4 >> 1) + (\5 << 4) + (\6 << 9) + (\7 << 15)
;     ENDM
; MACRO Origins
;     dw \1 + (\2 << 7) + (\3 << 11) + (\4 << 15)
;     ENDM
MACRO End_GiftPokemon
    db $01,$00,$02,$00,$03,$00,$04,$00,$05,$00,$06,$00,$07,$00,$08,$00,$09,$00,$BF,$C8,$C1,$C6,$C3,$CD,$C2,$FF,$0F,$27,$00,$00,$4A,$75,$82,$00,$00,$03
    ENDM

MACRO End_GiftEgg
    db $00,$31,$00,$03,$49,$6A,$00,$03,$30,$06,$00,$00,$00,$31,$00,$03,$DF,$8F,$00,$08,$F0,$17,$00,$03,$A3,$07,$00,$08,$17,$00,$00,$00,$8C,$1D,$00,$03
    ENDM
