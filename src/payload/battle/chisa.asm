SECTION "payload/battle/chisa", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 0
    db SCHOOL_KID_F
    BT_Floor 0
    db "DOLLY@  "
    ; Text_JP "チサ"8
    OT_ID 00000, 00000

    Intro_EN DO, YOU, LIKE, GRASS, POKEMON, _QU    
    Win_EN AREN_T, MY, GRASS, POKEMON, STRONG, _QU    
    Loss_EN MAYBE, SOME, _AROMATHERAPY, WOULD, BE, NICE

    Intro_JP $1428, $020e, $162c, $1616, $1602, $1033
    Win_JP $1428, $0418, $0e16, $100b, $142f, $103f
    Loss_JP $0418, $0e16, $102b, $0a48, $1428, $020e

    Pokemon AZURILL
    Holds SEA_INCENSE
    Moves SING, SURF, RETURN, IRON_TAIL
    Level 94
    PP_Ups 0,0,0,0
    EVs 255,0,0,255,0,0
    OT_ID 00000, 00000
    IVs 15,15,31,15,15,31, 0
    PV $00000019
    db "AZURILL@   "
    ; Text_JP "ルリリ"11
    Friendship 255

    Pokemon WYNAUT
    Holds LAX_INCENSE
    Moves COUNTER, MIRROR_COAT, SAFEGUARD, SPLASH
    Level 94
    PP_Ups 0,0,0,0
    EVs 255,0,0,255,0,0
    OT_ID 00000, 00000
    IVs 15,15,31,15,15,31, 0
    PV $000000E0
    db "WYNAUT@    "
    ; Text_JP "ソーナノ"11
    Friendship 255

    Pokemon PICHU
    Holds CHERI_BERRY
    Moves THUNDER_WAVE, SWEET_KISS, THUNDERBOLT, REVERSAL
    Level 95
    PP_Ups 0,0,0,0
    EVs 0,0,0,255,255,0
    OT_ID 00000, 00000
    IVs 15,15,15,31,31,15, 0
    PV $000000E7
    db "PICHU@     "
    ; Text_JP "ピチュー"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
