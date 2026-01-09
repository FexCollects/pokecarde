SECTION "payload/battle/fiennes", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 0
    db GENTLEMAN
    BT_Floor 0
    db "RANULF@ "
    ; Text_JP "ファインズ"8
    OT_ID 00000, 00000

    Intro_EN I, HAVE, RARE, POKEMON, _EX, $ffff
    Win_EN HAHAHA, DID, I, SURPRISE, YOU, _QU    
    Loss_EN EVEN_SO_, I, GOT, TO, SHOW, OFF

    Intro_JP $0a49, $123a, $020e, $1646, $140f, $103e
    Win_JP $1234, $1e11, $1005, $0c28, $0c00, $ffff
    Loss_JP $0465, $1642, $1238, $1c27, $1613, $0c06

    Pokemon GIRAFARIG
    Holds SITRUS_BERRY
    Moves PSYCHIC, DOUBLE_TEAM, CRUNCH, TOXIC
    Level 70
    PP_Ups 0,0,0,0
    EVs 6,0,0,252,252,0
    OT_ID 00000, 00000
    IVs 15,15,15,31,31,15, 1
    PV $00000087
    db "GIRAFARIG@ "
    ; Text_JP "キリンリキ"11
    Friendship 255

    Pokemon WOBBUFFET
    Holds FOCUS_BAND
    Moves COUNTER, MIRROR_COAT, SAFEGUARD, DESTINY_BOND
    Level 72
    PP_Ups 0,0,0,0
    EVs 252,0,252,0,0,6
    OT_ID 00000, 00000
    IVs 31,15,15,15,15,31, 0
    PV $00000084
    db "WOBBUFFET@ "
    ; Text_JP "ソーナンス"11
    Friendship 255

    Pokemon TYPHLOSION
    Holds LUM_BERRY
    Moves DOUBLE_TEAM, OVERHEAT, EARTHQUAKE, ATTRACT
    Level 74
    PP_Ups 0,48,0,0
    EVs 6,252,0,252,0,0
    OT_ID 00000, 00000
    IVs 31,15,15,31,15,15, 0
    PV $0000000F
    db "TYPHLOSION@"
    ; Text_JP "バクフーン"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
