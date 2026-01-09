SECTION "payload/battle/teruko", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 0
    Class PSYCHIC_F
    BT_Floor 0
    db "NADINE@ "
    ; Text_JP "テルコ"8
    OT_ID 00000, 00000

    Intro_JP $246d, $0c01, $ffff, $0c13, $2006, $103e
    Win_JP $2006, $1628, $0e1d, $122f, $1041, $0c01
    Loss_JP $0a46, $2006, $1009, $102b, $1032, $0c06

    Intro_EN _CONFUSE_RAY, WILL, MAKE, YOU, CONFUSED, _EX
    Win_EN BEING, CONFUSED, REALLY, IS, TERRIBLE, _EX_EX
    Loss_EN SEEMS, I, WAS, CONFUSED, INSTEAD, _ELIP

    Pokemon GRUMPIG
    Holds WHITE_HERB
    Moves CONFUSE_RAY, PSYCHIC, BOUNCE, SHADOW_BALL
    Level 78
    PP_Ups 0,0,0,0
    EVs 6,0,0,252,252,0
    OT_ID 00000, 00000
    IVs 15,15,15,31,31,15, 1
    PV $0000000D
    db "GRUMPIG@   "
    ; Text_JP "ブーピッグ"11
    Friendship 255

    Pokemon XATU
    Holds LUM_BERRY
    Moves CONFUSE_RAY, PSYCHIC, GIGA_DRAIN, DRILL_PECK
    Level 80
    PP_Ups 0,0,0,0
    EVs 0,0,0,252,252,6
    OT_ID 00000, 00000
    IVs 15,15,15,31,31,15, 0
    PV $000000E0
    db "XATU@      "
    ; Text_JP "ネイティオ"11
    Friendship 255

    Pokemon STARMIE
    Holds SALAC_BERRY
    Moves CONFUSE_RAY, THUNDERBOLT, ICE_BEAM, SURF
    Level 82
    PP_Ups 0,0,0,0
    EVs 6,0,0,252,252,0
    OT_ID 00000, 00000
    IVs 15,15,15,31,31,15, 1
    PV $0000000F
    db "STARMIE@   "
    ; Text_JP "スターミー"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
