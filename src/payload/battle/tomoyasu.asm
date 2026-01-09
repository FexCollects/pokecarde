SECTION "payload/battle/tomoyasu", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 50
    db SCHOOL_KID_M
    BT_Floor 5
    db "EDDY@   "
    ; Text_JP "トモヤス"8
    OT_ID 00000, 00000

    Intro_EN THIS, MOVE, IS, ABSOLUTELY, GENIUS, _EX    
    Win_EN _TOXIC, _EX, PRETTY, GOOD, RIGHT, _QU    
    Loss_EN I, CAN_T, BEAT, YOU, _ELIP, $ffff

    Intro_JP $0a05, $020e, $ffff, $1643, $1602, $0c00
    Win_JP $0a1d, $020e, $ffff, $1409, $1403, $0c00
    Loss_JP $0a1d, $020e, $ffff, $1409, $1431, $0c00

    Pokemon BRELOOM
    Holds QUICK_CLAW
    Moves SPORE, FOCUS_PUNCH, LEECH_SEED, HIDDEN_POWER
    Level 50
    PP_Ups 0,0,0,0
    EVs 6,252,0,252,0,0
    OT_ID 00000, 00000
    IVs 15,31,15,31,14,14, 0
    PV $0000000D
    db "BRELOOM@   "
    ; Text_JP "キノガッサ"11
    Friendship 255

    Pokemon MANECTRIC
    Holds SCOPE_LENS
    Moves THUNDER_WAVE, THUNDER, RAIN_DANCE, CRUNCH
    Level 50
    PP_Ups 0,0,0,0
    EVs 6,0,0,252,252,0
    OT_ID 00140, 00000
    IVs 15,15,15,31,31,15, 0
    PV $000000D7
    db "MANETRIC@  "
    ; Text_JP "ライボルト"11
    Friendship 255

    Pokemon DUSCLOPS
    Holds LEFTOVERS
    Moves WILL_O_WISP, PROTECT, SHADOW_BALL, TOXIC
    Level 50
    PP_Ups 0,0,0,0
    EVs 252,0,252,0,0,6
    OT_ID 00000, 00000
    IVs 31,15,31,15,15,15, 0
    PV $00000020
    db "DUSCLOPS@  "
    ; Text_JP "サマヨール"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
