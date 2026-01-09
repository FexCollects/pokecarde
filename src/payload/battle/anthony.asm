SECTION "payload/battle/anthony", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 0
    db GENTLEMAN
    BT_Floor 0
    db "GREGORY@"
    ; Text_JP "アンソニー"8
    OT_ID 00000, 00000

    Intro_EN MY, NEED, TO, WIN, IS, OVERWHELMING    
    Win_EN I, MUST_BE, THE, WINNER, _EX, $ffff
    Loss_EN THIS, FEELING, WON_T, GO, AWAY, _ELIP

    Intro_JP $0a43, $1e0b, $0408, $1228, $102b, $100b
    Win_JP $0a43, $1034, $020e, $1405, $0408, $100b
    Loss_JP $0a1a, $1034, $020e, $1405, $0408, $100b

    Pokemon ALAKAZAM
    Holds LUM_BERRY
    Moves CALM_MIND, PSYCHIC, REFLECT, THUNDERPUNCH
    Level 50
    PP_Ups 0,0,0,0
    EVs 6,0,0,252,252,0
    OT_ID 00000, 00000
    IVs 15,15,15,31,31,15, 0
    PV $0000000F
    db "ALAKAZAM@  "
    ; Text_JP "フーディン"11
    Friendship 255

    Pokemon HARIYAMA
    Holds FOCUS_BAND
    Moves REVENGE, EARTHQUAKE, FAKE_OUT, REVERSAL
    Level 53
    PP_Ups 0,0,0,0
    EVs 252,252,0,0,0,6
    OT_ID 00000, 00000
    IVs 31,31,15,15,15,15, 0
    PV $00000080
    db "HARIMYAMA@ "
    ; Text_JP "ハリテヤマ"11
    Friendship 255

    Pokemon SHEDINJA
    Holds SPELL_TAG
    Moves CONFUSE_RAY, SHADOW_BALL, TOXIC, PROTECT
    Level 56
    PP_Ups 0,0,0,0
    EVs 0,252,6,252,0,0
    OT_ID 00000, 00000
    IVs 15,31,15,31,15,15, 0
    PV $0000001C
    db "SHEDINJA@  "
    ; Text_JP "ヌケニン"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
