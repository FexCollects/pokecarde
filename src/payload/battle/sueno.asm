SECTION "payload/battle/sueno", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 0
    db HEX_MANIAC
    BT_Floor 0
    db "ANABEL@ "
    ; Text_JP "スエノ"8
    OT_ID 00000, 00000

    Intro_EN YOU, SHOULD, RUN_AWAY, NOW, _EX, $ffff
    Win_EN I, SAID, YOU, SHOULD, RUN_AWAY, _EX    
    Loss_EN YOU, DIDN_T, RUN_AWAY, YOU, WON, _ELIP

    Intro_JP $1c07, $0e16, $103e, $0626, $102a, $0c00
    Win_JP $0626, $102a, $0e1d, $1610, $1430, $0c03
    Loss_JP $0626, $1430, $0a05, $0605, $1018, $0c04

    Pokemon WOBBUFFET
    Holds SALAC_BERRY
    Moves COUNTER, MIRROR_COAT, SAFEGUARD, DESTINY_BOND
    Level 57
    PP_Ups 0,0,0,0
    EVs 255,0,100,55,0,100
    OT_ID 00000, 00000
    IVs 15,15,31,15,15,31, 0
    PV $00000021
    db "WOBBUFFET@ "
    ; Text_JP "ソーナンス"11
    Friendship 255

    Pokemon DUSCLOPS
    Holds LEFTOVERS
    Moves MEAN_LOOK, CONFUSE_RAY, TOXIC, PROTECT
    Level 55
    PP_Ups 0,0,0,0
    EVs 0,0,255,0,0,255
    OT_ID 00000, 00000
    IVs 15,15,31,15,15,31, 0
    PV $000000E6
    db "DUSCLOPS@  "
    ; Text_JP "サマヨール"11
    Friendship 255

    Pokemon NOSEPASS
    Holds CHERI_BERRY
    Moves BLOCK, THUNDER_WAVE, SANDSTORM, EXPLOSION
    Level 58
    PP_Ups 0,0,0,0
    EVs 0,255,0,0,0,255
    OT_ID 00000, 00000
    IVs 15,31,15,15,15,31, 1
    PV $000000E9
    db "NOSEPASS@  "
    ; Text_JP "ノズパス"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
