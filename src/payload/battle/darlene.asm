SECTION "payload/battle/darlene", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 0
    Class POKEFAN_F
    BT_Floor 0
    db "DARLENE@"
    ; Text_JP "ノブエ"8
    OT_ID 00000, 00000

    Intro_JP $2021, $26d5, $0c00, $0a01, $1034, $020e
    Win_JP $0e36, $1616, $0c00, $2021, $26d5, $0c01
    Loss_JP $0e03, $0e03, $0c00, $140e, $140e, $0c01

    Intro_EN WHY, ARE, POKEMON, SO, PRETTY, _QU_EX    
    Win_EN LOVEY_DOVEY, _EX, POKEMON, AREN_T, ONLY, CUTE
    Loss_EN NO, _EX, NO, _EX, WE, LOST

    Pokemon LUVDISC
    Holds SITRUS_BERRY
    Moves ATTRACT, SWEET_KISS, RAIN_DANCE, DIVE
    Level 90
    PP_Ups 0,0,0,0
    EVs 255,0,0,255,0,0
    OT_ID 00000, 00000
    IVs 31,15,15,31,15,15, 0
    PV $0000000A
    db "LUVDISC@   "
    ; Text_JP "ラブカス"11
    Friendship 255

    Pokemon SKITTY
    Holds BRIGHTPOWDER
    Moves ATTRACT, SING, THUNDER, DOUBLE_EDGE
    Level 90
    PP_Ups 0,0,0,0
    EVs 255,0,0,255,0,0
    OT_ID 00000, 00000
    IVs 31,15,15,31,15,15, 0
    PV $0000000A
    db "SKITTY@    "
    ; Text_JP "エネコ"11
    Friendship 255

    Pokemon PIKACHU
    Holds LIGHT_BALL
    Moves ATTRACT, THUNDER_WAVE, THUNDER, QUICK_ATTACK
    Level 90
    PP_Ups 0,0,0,0
    EVs 0,0,255,0,255,0
    OT_ID 00000, 00000
    IVs 15,15,31,15,31,15, 0
    PV $000000D7
    db "PIKACHU@   "
    ; Text_JP "ピカチュウ"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
