SECTION "payload/battle/yasuo", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 0
    Class NINJA_BOY
    BT_Floor 0
    db "YASUO@  "
    ; Text_JP "コウヘイ"8
    OT_ID 00000, 00000

    Intro_JP $0812, $0c01, $ffff, $0c2b, $0618, $0c01
    Win_JP $1205, $0e08, $ffff, $140b, $2699, $0c01
    Loss_JP $1217, $0e08, $ffff, $0a1f, $26c2, $0c01

    Intro_EN HERE_I_COME, _EX_EX, TIME, _FOR, BATTLE, _EX_EX
    Win_EN DID, YOU, SEE, THAT, _EXPLOSION, _QU_EX
    Loss_EN ALWAYS, _DESTINY_BOND, WITH, MY, POKEMON, _ELIP

    Pokemon NOSEPASS
    Holds PERSIM_BERRY
    Moves THUNDER_WAVE, SANDSTORM, PROTECT, EXPLOSION
    Level 65
    PP_Ups 0,0,0,0
    EVs 252,252,6,0,0,0
    OT_ID 00000, 00000
    IVs 31,31,15,15,15,15, 1
    PV $000000E4
    db "NOSEPASS@  "
    ; Text_JP "ノズパス"11
    Friendship 255

    Pokemon WOBBUFFET
    Holds LEFTOVERS
    Moves COUNTER, MIRROR_COAT, SAFEGUARD, DESTINY_BOND
    Level 68
    PP_Ups 0,0,0,0
    EVs 0,0,255,0,0,255
    OT_ID 00000, 00000
    IVs 15,15,31,15,15,15, 0
    PV $0000001E
    db "WOBBUFFET@ "
    ; Text_JP "ソーナンス"11
    Friendship 255

    Pokemon WEEZING
    Holds QUICK_CLAW
    Moves SLUDGE_BOMB, SHADOW_BALL, DESTINY_BOND, EXPLOSION
    Level 70
    PP_Ups 0,0,0,0
    EVs 0,255,0,255,0,0
    OT_ID 00000, 00000
    IVs 15,31,15,31,15,15, 0
    PV $000000E4
    db "WEEZING@   "
    ; Text_JP "マタドガス"11
    Friendship 255

    End_Trainer


        ds 44 ; Pad to 256

POPC
