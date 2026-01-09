SECTION "payload/battle/mattegoDEMO", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 0
    db COOLTRAINER_M
    BT_Floor 0
    db "MATTEGO@"
    ; Text_JP "カノウ"8
    OT_ID 00000, 00000

    Intro_JP $0204, $1621, $142f, $0e0a, $0620, $100f
    Win_JP $020e, $0618, $0e1d, $122a, $1032, $0c01
    Loss_JP $244a, $1621, $0e08, $061f, $1628, $100e

    Intro_EN ALTHOUGH, WITHOUT, EVOLUTION, THEY_RE, STRONG, _EX
    Win_EN _A, POKEMON, BATTLE, IS, EXCITING, HUH_
    Loss_EN I, WILL, TRAIN, _AND, GET, BETTER    

    Pokemon TREECKO
    Holds MIRACLE_SEED
    Moves SOLARBEAM, SLAM, LEECH_SEED, DETECT
    Level 68
    PP_Ups 0,0,0,0
    EVs 6,0,0,252,252,0
    OT_ID 00000, 00000
    IVs 15,15,15,31,31,15, 0
    PV $0000000F
    db "TREECKO@   "
    ; Text_JP "キモリ"11
    Friendship 255

    Pokemon TORCHIC
    Holds CHARCOAL
    Moves FLAMETHROWER, ENDURE, REVERSAL, MIRROR_MOVE
    Level 70
    PP_Ups 0,0,0,0
    EVs 0,252,0,252,6,0
    OT_ID 00000, 00000
    IVs 15,31,15,31,15,15, 0
    PV $000000D5
    db "TORCHIC@   "
    ; Text_JP "アチャモ"11
    Friendship 255

    Pokemon MUDKIP
    Holds MYSTIC_WATER
    Moves SURF, TAKE_DOWN, ICE_BEAM, PROTECT
    Level 72
    PP_Ups 0,0,0,0
    EVs 0,0,252,0,252,6
    OT_ID 00000, 00000
    IVs 15,15,31,15,31,15, 0
    PV $000000E1
    db "MUDKIP@    "
    ; Text_JP "ミズゴロウ"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
