SECTION "payload/battle/tyler", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level MOSSDEEP
    Class POKEMANIAC
    BT_Floor MOSSDEEP
    db "TYLER@  "
    ; Text_JP "トモタカ"8
    OT_ID 00000, 00000

    Intro_EN WHOAH,OVERWHELMING,MEGA,BLANK,ATTACK,_EX
    Win_EN   WAHAHAHA,_EX,THAT,WAS,SERIOUS,_1_HIT_KO_
    Loss_EN  TOO_STRONG,_EX,GO_EASY,ON,ME,_EX

    Intro_JP $0c10, $1422, $0c00, $2806, $0612, $0c01
    Win_JP $0c3e, $1421, $1021, $0e2d, $2807, $0c00
    Loss_JP $0c16, $0621, $0c00, $0622, $1621, $103e

    Pokemon WALREIN
    Holds LAX_INCENSE
    Moves SHEER_COLD, REST, SNORE, ICE_BEAM
    Level 62
    PP_Ups 0,0,0,0
    EVs 252,0,6,0,0,252
    OT_ID 00000, 00000
    IVs 15,15,31,15,15,31, WALREIN_THICK_FAT
    PV $00000013 ; ♀ Rash
    db "WALREIN@   "
    ; Text_JP "トドゼルガ"11
    Friendship 255

    Pokemon PINSIR
    Holds BRIGHTPOWDER
    Moves GUILLOTINE, SUBMISSION, EARTHQUAKE, ROCK_TOMB
    Level 64
    PP_Ups 0,0,0,0
    EVs 252,6,0,252,0,0
    OT_ID 00000, 00000
    IVs 31,15,15,31,15,15, PINSIR_HYPER_CUTTER
    PV $0000008A ; ♂ Jolly
    db "PINSIR@    "
    ; Text_JP "カイロス"11
    Friendship 255

    Pokemon RHYDON
    Holds QUICK_CLAW
    Moves HORN_DRILL, ROCK_SLIDE, EARTHQUAKE, MEGAHORN
    Level 66
    PP_Ups 0,0,0,0
    EVs 252,252,0,0,0,6
    OT_ID 00000, 00000
    IVs 31,31,15,15,15,15, RHYDON_ROCK_HEAD
    PV $00000016 ; ♀ Sassy
    db "RHYDON@    "
    ; Text_JP "サイドン"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
