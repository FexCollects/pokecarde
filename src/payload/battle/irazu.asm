SECTION "payload/battle/irazu", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 100
    Class PKMN_RANGER_M
    BT_Floor 12
    db "IRAZU@  "
    ; Text_JP "コシキ"8
    OT_ID 00000, 00000

    Intro_EN MY,POKEMON,THANKS,ME,_FOR,CARE
    Win_EN   POKEMON,DON_T,TRUST,TRAINER,WITHOUT,CARE
    Loss_EN  IF_I_LOSE,MY,_FRUSTRATION,LEVEL,GOES,UP

    Intro_JP $020e, $0e08, $24d8, $0a37, $0e29, $24d8
    Win_JP $0603, $142f, $020b, $0c06, $020e, $0634
    Loss_JP $062e, $1010, $0e08, $0a27, $26da, $0c06

    Pokemon KINGDRA
    Holds CHESTO_BERRY
    Moves RETURN, DRAGON_DANCE, REST, DOUBLE_TEAM
    Level 100
    PP_Ups 3,0,0,0
    EVs 252,252,0,0,0,6
    OT_ID 00000, 00000
    IVs 31,31,20,20,20,20, KINGDRA_SWIFT_SWIM
    PV $0000001C ; ♀ Adamant
    db "KINGDRA@   "
    ; Text_JP "キングドラ"11
    Friendship 255

    Pokemon HARIYAMA
    Holds SHELL_BELL
    Moves RETURN, BELLY_DRUM, REVERSAL, EARTHQUAKE
    Level 100
    PP_Ups 3,0,0,0
    EVs 252,6,0,0,0,252
    OT_ID 00000, 00000
    IVs 31,20,20,20,20,31, HARIYAMA_THICK_FAT
    PV $00000080 ; ♂ Adamant
    db "HARIYAMA@  "
    ; Text_JP "ハリテヤマ"11
    Friendship 255

    Pokemon REGISTEEL
    Holds LEFTOVERS
    Moves RETURN, CURSE, REST, EARTHQUAKE
    Level 100
    PP_Ups 3,0,0,0
    EVs 252,6,0,0,0,252
    OT_ID 00000, 00000
    IVs 31,20,20,20,20,31, REGISTEEL_CLEAR_BODY
    PV $0000001C ; ⚲ Adamant
    db "REGISTEEL@ "
    ; Text_JP "レジスチル"11
    Friendship 255

    End_Trainer


        ds 44 ; Pad to 256

POPC
