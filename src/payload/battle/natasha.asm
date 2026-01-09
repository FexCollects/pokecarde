SECTION "payload/battle/natasha", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 50
    Class PSYCHIC_F
    BT_Floor 12
    db "NATASHA@"
    ; Text_JP "ユキエ"8
    OT_ID 00000, 00000

    Intro_EN LOOK,_EX,MY,SKILLED,ATTACK,_EX_EX
    Win_EN   OH_,WHERE,WAS,YOUR,_LIGHT_SCREEN,_QU
    Loss_EN  I,WAS,NO_MATCH,_FOR,YOU,_EX_EX

    Intro_JP $1643, $0c00, $1e0b, $063e, $0617, $0c01
    Win_JP $0c0c, $0c03, $2671, $142f, $1034, $0c03
    Loss_JP $0c0c, $0c03, $ffff, $0a02, $0621, $0c01

    Pokemon STARMIE
    Holds SCOPE_LENS
    Moves PSYCHIC, THUNDERBOLT, SURF, ICE_BEAM
    Level 50
    PP_Ups 0,0,0,0
    EVs 6,0,6,252,252,0 ; 516 EVs? CHEATER!
    OT_ID 00000, 00000
    IVs 15,15,15,31,31,15, STARMIE_NATURAL_CURE
    PV $0000000F ; ⚲ Modest
    db "STARMIE@   "
    ; Text_JP "スターミー"11
    Friendship 255

    Pokemon SALAMENCE
    Holds LUM_BERRY
    Moves DRAGON_CLAW, FLAMETHROWER, CRUNCH, HYDRO_PUMP
    Level 50
    PP_Ups 0,0,0,0
    EVs 6,0,0,252,252,0
    OT_ID 00000, 00000
    IVs 15,31,15,31,31,15, SALAMENCE_INTIMIDATE
    PV $0000008C ; ♂ Modest
    db "SALAMENCE@ "
    ; Text_JP "ボーマンダ"11
    Friendship 255

    Pokemon SCEPTILE
    Holds BRIGHTPOWDER
    Moves LEAF_BLADE, CRUNCH, DRAGON_CLAW, DOUBLE_TEAM
    Level 50
    PP_Ups 0,0,0,0
    EVs 6,0,0,252,252,0
    OT_ID 00000, 00000
    IVs 31,15,15,31,15,15, SCEPTILE_OVERGROW
    PV $0000000F ; ♀ Modest
    db "SCEPTILE@  "
    ; Text_JP "ジュカイン"11
    Friendship 255

    End_Trainer


        ds 44 ; Pad to 256

POPC
