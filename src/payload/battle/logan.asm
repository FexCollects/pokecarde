SECTION "payload/battle/logan", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level MOSSDEEP
    Class RUIN_MANIAC
    BT_Floor MOSSDEEP
    db "LOGAN@  "
    ; Text_JP "マサユキ"8
    OT_ID 00000, 00000

    Intro_EN BEGINNING,_QU,END,_QU_EX,I_AM,CONFUSED
    Win_EN   _RELICANTH,_EX,_WAILORD,_QU_EX,CORRECT,_QU_EX
    Loss_EN  _WAILORD,_QU,_RELICANTH,_QU_EX,OPPOSITE,_QU_EX

    Intro_JP $1c21, $0c03, $1c0a, $0c02, $1209, $0c06
    Win_JP $017d, $0c00, $013a, $0c02, $1014, $0c02
    Loss_JP $013a, $0c03, $017d, $0c02, $1e1c, $1e24

    Pokemon WAILORD
    Holds MYSTIC_WATER
    Moves SURF, FISSURE, EARTHQUAKE, ICE_BEAM
    Level 58
    PP_Ups 0,0,0,0
    EVs 252,6,0,0,252,0
    OT_ID 00000, 00000
    IVs 31,15,15,15,31,15, WAILORD_OBLIVIOUS
    PV $00000011 ; ♀ Quiet
    db "WAILORD@   "
    ; Text_JP "ホエルオー"11
    Friendship 255

    Pokemon ARMALDO
    Holds SCOPE_LENS
    Moves ROCK_SLIDE, SLASH, EARTHQUAKE, AERIAL_ACE
    Level 60
    PP_Ups 0,0,0,0
    EVs 252,252,0,0,0,6
    OT_ID 00000, 00000
    IVs 31,31,15,15,15,15, ARMALDO_BATTLE_ARMOR
    PV $00000080 ; ♂ Adamant
    db "ARMALDO@   "
    ; Text_JP "アーマルド"11
    Friendship 255

    Pokemon RELICANTH
    Holds CHESTO_BERRY
    Moves DOUBLE_EDGE, REST, DIVE, AMNESIA
    Level 62
    PP_Ups 0,0,0,0
    EVs 252,252,0,0,0,6
    OT_ID 00000, 00000
    IVs 31,31,15,15,15,15, RELICANTH_ROCK_HEAD
    PV $00000076 ; ♂ Bashful
    db "RELICANTH@ "
    ; Text_JP "ジーランス"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
