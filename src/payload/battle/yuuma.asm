SECTION "payload/battle/yuuma", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 0
    Class SCHOOL_KID_M
    BT_Floor 0
    db "DANE@   "
    ; Text_JP "ユウマ"8
    OT_ID 00000, 00000

    Intro_JP $1a01, $1239, $0e08, $1c16, $1c0a, $1016
    Win_JP $1c27, $1c0a, $0c00, $181b, $1644, $100f
    Loss_JP $0c16, $0c01, $1c27, $1c13, $142f, $103f

    Intro_EN COME_ON, _EX, MY, ANIME, IS, ON    
    Win_EN JUST, ENOUGH, TIME, TO, MAKE, IT
    Loss_EN I_AM, GOING, TO, MISS, IT, _EX

    Pokemon CACNEA
    Holds PERSIM_BERRY
    Moves PIN_MISSILE, NEEDLE_ARM, SPIKES, SAND_ATTACK
    Level 50
    PP_Ups 0,0,0,0
    EVs 0,0,0,255,0,255
    OT_ID 00000, 00000
    IVs 15,15,15,31,15,31, 0
    PV $00000017
    db "CACNEA@    "
    ; Text_JP "サボネア"11
    Friendship 255

    Pokemon SEVIPER
    Holds POISON_BARB
    Moves POISON_TAIL, CRUNCH, SWAGGER, TOXIC
    Level 52
    PP_Ups 0,0,0,0
    EVs 0,0,255,0,0,255
    OT_ID 00000, 00000
    IVs 15,15,31,15,15,31, 0
    PV $000000DA
    db "SEVIPER@   "
    ; Text_JP "ハブネーク"11
    Friendship 255

    Pokemon WOBBUFFET
    Holds LEFTOVERS
    Moves COUNTER, MIRROR_COAT, SAFEGUARD, DESTINY_BOND
    Level 56
    PP_Ups 0,0,0,0
    EVs 0,0,255,0,0,255
    OT_ID 00000, 00000
    IVs 15,15,31,15,15,31, 0
    PV $000000E6
    db "WOBBUFFET@ "
    ; Text_JP "ソーナンス"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
